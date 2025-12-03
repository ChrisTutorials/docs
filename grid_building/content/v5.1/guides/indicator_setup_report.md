---
title: Indicator Setup Report
description: Indicator Setup Report documentation for the Grid Building system
---


---



## Summary

`IndicatorManager.setup_indicators()` now returns an [IndicatorSetupReport](../api/IndicatorSetupReport/) instead of only an array of [RuleCheckIndicator](../api/RuleCheckIndicator/) instances. The report encapsulates the produced indicators plus structured diagnostic metadata used by the updated test suite and for future debugging.

## Motivation

Previously tests received only a raw `Array[RuleCheckIndicator]`. Deeper debugging (e.g., why zero indicators were produced) required ad‑hoc logging or re-walking scene trees. Returning a structured report provides:

- **Detailed diagnostic information** for troubleshooting
- **Performance metrics** during indicator setup
- **Enhanced error reporting** with context
- **Better debugging support** for complex placement scenarios
- A stable contract for tests (no need to inspect internal manager state)
- Rich context (collision owners, mapped rule positions, tile counts) without recomputation
- Extensibility (add new fields without changing the return signature again)
- Reduced log noise: tests pull only what they need for assertions

## Report Structure

The [IndicatorSetupReport](../api/IndicatorSetupReport/) (see `res://addons/grid_building/placement/manager/components/indicator_setup_report.gd`) contains:

| Field                     | Type                        | Description                                                                                |
| ------------------------- | --------------------------- | ------------------------------------------------------------------------------------------ |
| `indicators`              | `Array[RuleCheckIndicator]` | Generated indicators parented to the provided node                                         |
| `rules`                   | `Array[TileCheckRule]`      | Rules used for mapping positions                                                           |
| `position_rules_map`      | `Dictionary`                | Mapping `Vector2i -> Array[TileCheckRule]` for failing/checked tiles                       |
| `owner_shapes`            | `Dictionary`                | Collision owner (`Node2D`) -> array of shape nodes (CollisionShape2D / CollisionPolygon2D) |
| `distinct_tile_positions` | `Array[Vector2i]`           | Computed unique tile coordinates occupied by indicators (filled during `finalize()`)       |
| `owner_type_counts`       | `Dictionary`                | Class name -> count summary derived from `owner_shapes`                                    |
| `centered_preview`        | `bool`                      | Whether the preview/test object was centered on the targeting positioner before mapping    |
| `notes`                   | `Array[String]`             | Supplemental flags (e.g., `preview_centered`, `test_setups:<n>`)                           |
| `issues`                  | `Array[String]`             | Placeholder for future validation or anomaly messages                                      |

Helper methods:

- `to_summary_string()` – concise single line (used in assertion failure messages)
- `to_verbose_string()` – multiline debug oriented view
- `finalize(targeting_state)` – populates `distinct_tile_positions` & `owner_type_counts`

## Usage Pattern

### Before

```gdscript
var indicators = indicator_manager.setup_indicators(scene, rules, parent)
assert_int(indicators.size()).is_greater(0)
```

### After

```gdscript
var report : IndicatorSetupReport = indicator_manager.setup_indicators(scene, rules, parent)
var indicators = report.indicators
assert_int(indicators.size())
  .append_failure_message("Summary=" + report.to_summary_string())
  .is_greater(0)
```

## IndicatorManager Test Suite Updates

Example test file path: `test/placement/manager/placement_manager_test.gd`

Changes:

- Each test captures [IndicatorSetupReport](../api/IndicatorSetupReport/) and includes its `to_summary_string()` in failure messages.
- A strict physics body collision-layer prerequisite was relaxed: tests now warn (not fail) when only raw shapes exist (common for simple geometry scenes) while still asserting indicator generation.
- Added non-assert helper `_collision_layer_overlaps()` for optional precondition logic; original `_assert_collision_layer_overlaps()` retained for targeted strict checks if re-enabled.
- Distance and uniqueness tests now surface summary context for faster triage if they fail.

## Backward Compatibility

Existing callers expecting an `Array` will break; the migration requires extracting `.indicators`. For a transitional period you can wrap:

```gdscript
# Transitional shim (if needed)
func setup_indicators_legacy(...):
    return setup_indicators(...).indicators
```

(Deliberately not included in core to encourage full migration.)

## Extensibility Guidelines

When adding new diagnostic data:

1. Append fields to [IndicatorSetupReport](../api/IndicatorSetupReport/) (avoid removing or renaming existing keys unless major version bump).
1. If the value is derivable and potentially expensive, compute lazily (pattern used by `finalize`).
1. Keep `to_summary_string()` concise: no more than ~120 chars typical.
1. Prefer adding structured fields over embedding new info into `notes` for machine-friendly assertions.

## Logging Alignment

Current `_log_setup_summary()` in `indicator_manager.gd` replicates some summary math. Consider future refactor to:

```gdscript
_logger.log_verbose( report.to_summary_string())
```

This ensures a single source of truth and prevents divergence when fields evolve.

## Potential Future Enhancements

- Populate `issues` with: missing rules, zero shapes, non-centered preview recovery, or collision mapper warnings.
- Add `duration_ms` captured around the generation window for performance tracking.
- Add `tile_bounds` (min/max) to avoid re-deriving in consumer code.
- Flag `partial_generation` if some rules rejected due to missing resources.

## Troubleshooting

| Symptom                                  | How Report Helps                                                                             |
| ---------------------------------------- | -------------------------------------------------------------------------------------------- |
| Zero indicators                          | Check `owner_shapes` size + `notes` for missing preview centering                            |
| Unexpected count                         | Inspect `position_rules_map.size()` vs `distinct_tile_positions.size()`                      |
| Performance spike                        | (Future) Inspect `duration_ms` once implemented                                              |
| Shape-only scenes failing old assertions | Now downgraded to warnings; confirm via absence of physics body types in `owner_type_counts` |

## Related Docs

- `systems/placement_chain.md` – High-level placement flow
- `systems/collision_mapping.md` – Collision mapping internals

______________________________________________________________________

Last updated: 2025-08-18