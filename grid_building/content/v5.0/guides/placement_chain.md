---
title: Placement Chain
description: Placement Chain documentation for the Grid Building system
---


---



The placement chain is the coordinated sequence of systems that transform player intent (cursor position + selected placeable) into a validated, instantiated object in the game world.

## High-Level Steps

| Step | System / Component                                           | Responsibility                                                    |
| ---- | ------------------------------------------------------------ | ----------------------------------------------------------------- |
| 1    | Input / Actions ([GBActions](../api/GBActions/))                                | Map user input (select, rotate, confirm, cancel)                  |
| 2    | Targeting ([GridTargetingState](../api/GridTargetingState/) + [GridTargetingSystem](../api/GridTargetingSystem/))     | Convert raw pointer position → snapped grid coordinate / normal   |
| 3    | Placeable Selection (UI)                                     | Present selectable items ([PlaceableList](../api/PlaceableList/) / Action Bar)             |
| 4    | Rule Aggregation ([PlacementValidator](../api/PlacementValidator/)) | Merge global + placeable + contextual rules                       |
| 5    | Indicator Mapping ([IndicatorManager](../api/IndicatorManager/))                       | Generate tile indicators & diagnostics ([IndicatorSetupReport](../api/IndicatorSetupReport/))   |
| 6    | User Feedback (Indicators / Cursor / Build Log)              | Visualize valid vs invalid regions; textual reasons via build log |
| 7    | Confirmation ([BuildingSystem](../api/BuildingSystem/))                              | Spawn final instance from template (with [PlaceableInstance](../api/PlaceableInstance/))     |
| 8    | Post Actions ([ManipulationSystem](../api/ManipulationSystem/))                          | Move / rotate / flip / demolish / info-inspect existing objects   |

## Rule Combination

`PlacementValidator.get_combined_rules()` merges:

- Base/global rules (project‑wide constraints)
- Placeable-specific rules (e.g., must be on ground, cannot overlap category)
- Context rules (environment or mode driven)

The merged list is then used to produce two paths:

1. Tile checks (subclasses of [TileCheckRule](../api/TileCheckRule/)) → indicator generation.
1. Non-tile rules → logical validation gating final placement.

## Indicator Generation

The `IndicatorManager.setup_indicators()` call triggers:

1. `IndicatorManager.reset()` — clears previous indicators.
1. Mapping each tile rule across the candidate area.
1. Creating [RuleCheckIndicator](../api/RuleCheckIndicator/) scenes (template from `GBTemplates.rule_check_indicator`).
1. Building an [IndicatorSetupReport](../api/IndicatorSetupReport/) for diagnostics.

Metrics captured in the report guide debugging (counts, distinct tiles, shape owners) and are logged in verbose mode.

## Validation & Placement

When the player attempts placement:

1. `PlacementValidator.validate()` evaluates rule set.
1. If valid, [BuildingSystem](../api/BuildingSystem/) (or similar high-level system) instantiates the final object (often via factory logic or resource reference in [Placeable](../api/Placeable/)).
1. A [PlaceableInstance](../api/PlaceableInstance/) component is attached to track source metadata (for save/load & manipulation).

### User Feedback Channel (Build Log)

In addition to visual indicators and cursor state, placement success/failure and validation messages are emitted to the build log (logger output) by default. This provides a textual audit trail for rule failures (e.g., out of bounds, collision, insufficient resources) useful for debugging or surfacing in a custom UI panel. Consumers can hook into the logger or extend the [PlacementValidator](../api/PlacementValidator/) to route these messages into in‑game notification systems.

## Rotation / Orientation

Rotation or flipping input updates either the preview entity or internal parameters used by rules (for bounding box, collision queries, etc.). Indicators update on each change since the manager resets and regenerates.

## Performance Considerations

- Avoid regenerating indicators when pointer hasn't changed tile.
- Cache combined rule lists when possible (existing code derives per attempt; can optimize later).
- Use lightweight tile iteration; prefer integer grid math utilities ([GBGeometryMath](../api/GBGeometryMath/), etc.).

## Extension Points

- Add a custom [PlacementRule](../api/PlacementRule/) to inject environment logic (biome, terrain flags, resource costs).
- Provide specialized indicator templates (e.g., gradient intensity for distance falloff rules).
- Inject additional debugging lines into `IndicatorSetupReport.to_summary_string()` for profiling.

## Failure Diagnostics

Common failure sources:

| Symptom           | Likely Cause                                  | Mitigation                                    |
| ----------------- | --------------------------------------------- | --------------------------------------------- |
| No indicators     | Missing tile rules or template reference null | Ensure `GBTemplates.rule_check_indicator` set |
| All tiles invalid | Global exclusion rule triggered               | Inspect combined rule list & order            |
| Slow placement    | Large area + many tile rules                  | Reduce rule redundancy; batch queries         |

______________________________________________________________________

Last updated: 2025-08-20

## Move / Demolish / Info Commands

Beyond initial placement, the flow supports **post-placement commands** exposed through the Manipulation System.

Action column values below reference the exported property names on the [GBActions](../api/GBActions/) resource (configured in your [GBConfig](../api/GBConfig/)): `moving_mode`, `demolish_mode`, `info_mode`, `off_mode`, and the confirmation action `confirm_build` (used for BOTH building and manipulation commits). The optional `confirm_manipulation` property presently maps to the same default input (&"confirm") but the current implementation only checks `confirm_build` inside `_perform_manipulation_actions()`.

Mode toggles are *stateful*: pressing (e.g.) `moving_mode` a second time (or `off_mode`) exits back to neutral `OFF` mode. Confirm semantics differ slightly per command.

| Command  | Purpose                                  | Primary Action (GBActions)            | Confirmation Cycle                                                                                            | Flow Impact                                                                                                                           |
| -------- | ---------------------------------------- | ------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| Move     | Reposition an existing placed instance   | `moving_mode` (toggle)                | 1st Confirm (`confirm_build`) = start move (creates copy); 2nd Confirm = validate & commit; Off/Cancel aborts | Creates a temporary preview using the instance's data; runs full rule validation before commit; original stays until commit or cancel |
| Demolish | Remove an existing instance              | `demolish_mode` (toggle)              | Single Confirm (`confirm_build`) executes demolish immediately (no copy)                                      | Validates optional removal constraints then removes target & refreshes indicators                                                     |
| Info     | Inspect metadata (cost, type, adjacency) | `info_mode` (toggle)                  | No confirm needed (read-only)                                                                                 | Reads stored [PlaceableInstance](../api/PlaceableInstance/) data; may highlight / name display; never mutates                                                    |
| Exit     | Leave any active manipulation mode       | `off_mode` (or re‑press current mode) | Immediate                                                                                                     | Cancels active move (frees copy, re‑enables physics) or exits demolish/info state                                                     |

### Detailed Move Workflow

| Phase | User Input                                 | Internal Call / State                           | Notes                                                                                                        |
| ----- | ------------------------------------------ | ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| 1     | Target object under cursor (hover/select)  | `_states.manipulation.active_manipulatable` set | Target acquisition comes from targeting system signals.                                                      |
| 2     | Press `moving_mode`                        | `_states.mode.current = MOVE`                   | Toggles MOVE mode on. Second press (or `off_mode`) will exit.                                                |
| 3     | Press `confirm_build` (first time)         | `try_move()` → `_start_move()`                  | Clones source → move copy parented (often under positioner) → rules set up → source physics layers disabled. |
| 4     | Adjust position / rotate / flip (optional) | Indicator refresh via targeting + transform ops | `_transform_input` handles rotation/flip actions if enabled.                                                 |
| 5     | Press `confirm_build` (second time)        | `try_placement()` → validation + commit         | On success: move copy freed, original teleported to new transform, physics re‑enabled.                       |
| 6     | Exit (implicit)                            | `_finish()` / mode may auto remain in MOVE      | After commit, mode stays in MOVE; press `off_mode` to fully exit if desired.                                 |

Cancel Path: Press `off_mode` (or re‑press `moving_mode`) before second confirm → `cancel()` frees copy and restores physics; no transform applied.

### Demolish Workflow

| Phase | Input                 | Internal                                            | Result                               |
| ----- | --------------------- | --------------------------------------------------- | ------------------------------------ |
| 1     | Press `demolish_mode` | Toggle mode (OFF ↔ DEMOLISH)                        | Ready state                          |
| 2     | Press `confirm_build` | `demolish()` → validates demolishable + `_finish()` | Object removed, indicators refreshed |
| 3     | (Optional) Exit mode  | `off_mode` or re‑press `demolish_mode`              | Return to neutral                    |

### Info Workflow

| Phase | Input             | Internal                           | Result                                                        |
| ----- | ----------------- | ---------------------------------- | ------------------------------------------------------------- |
| 1     | Press `info_mode` | Toggle mode (OFF ↔ INFO)           | Enables info inspection overlay / name display (non-mutating) |
| 2     | Hover objects     | External systems surface data      | Build chain not re-run; may reuse indicators for highlight    |
| 3     | Exit              | `off_mode` or re‑press `info_mode` | Return to neutral                                             |

### Confirmation Action Notes

- `confirm_build` is used for BOTH: (a) building a new object and (b) advancing or committing MOVE / DEMOLISH flows inside `_perform_manipulation_actions()`.
- `confirm_manipulation` currently exists but is not queried; if you want a distinct key for manipulation commits, update `_perform_manipulation_actions()` to check it (or remap `confirm_build`).

### Rotation & Flip While Moving

During an active MOVE (after the first confirm created the copy):

- Rotation uses `rotate_left` / (optionally `rotate_right` if implemented in `_transform_input` — current snippet only shows `rotate_left`).
- Horizontal flip: `flip_horizontal` (requires both global enable + per-manipulatable capability flag).
- Vertical flip: `flip_vertical` (same gating rules).

Failures to flip emit a [ManipulationData](../api/ManipulationData/) failure event with specific messages (`target_not_flippable_*`).

### Edge Cases & Safeguards

- Starting a move without a valid manipulatable sets FAILED status with a diagnostic message.
- If rule setup fails during `_start_move()`, no copy persists and status is FAILED.
- Cancel always re‑enables previously disabled physics layers.
- Demolish gracefully handles already deleted targets (marks FAILED & warns).
- Active move prevents target_changed handling (ignores new hover picks until complete or cancel).

### Recommended UI Hints

Provide contextual tooltip text that changes on the first vs second confirm in MOVE mode (e.g., "Confirm to start move" → "Confirm to place"). This reduces user confusion over dual-stage confirm semantics.

Move uses the same placement chain steps (1–7) but skips selection UI; the target instance becomes the *current placeable* for the duration of the move session. Demolish bypasses indicator generation (unless showing affected area) and executes a simplified validation path. Info is read‑only: it never mutates state, but may highlight tiles using existing indicators.

See also: `systems/manipulation_system.md` for per-command state transitions.
Related detailed flow: `systems/building_system_process.md`.

______________________________________________________________________

Support / Purchase Hub: **[Linktree – All Grid Builder Links](https://linktr.ee/gridbuilder)**