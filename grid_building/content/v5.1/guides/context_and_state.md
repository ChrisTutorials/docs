---
title: Context & State
description: Context & State documentation for the Grid Building system
---


---

This page clarifies the **context objects** and **state containers** that flow through the Grid Building systems.

## Why Distinguish Context vs State?

- *Context* = relatively stable service/registry style objects (DI container, manager singletons, configuration blocks) passed around for lookups.
- *State* = ephemeral, frame or interaction scoped data (current selection, targeting position, last rule results) that mutates frequently.

Separating them helps keep rule evaluation & indicators **pure** (depend on inputs, not global singletons) and simplifies testing (inject mock contexts, build explicit state).

## Core Context Objects

| Object | Purpose | Notes |
| --- | --- | --- |
| [GBCompositionContainer](../api/GBCompositionContainer/) | Dependency Injection root; registers systems & provides lookup. | Construction‑phase only mutations. |
| [GBSystemsContext](../api/GBSystemsContext/) | Aggregates references to active systems (Building, GridTargeting, Manipulation). Emits system change signals. | Signals: `building_system_changed`, `grid_targeting_system_changed`, `manipulation_system_changed`. |
| [GBLevelContext](../api/GBLevelContext/) | World/scene level references and wiring for runtime. | Exports: `target_map`, `maps`, `objects_parent`. Applies to states: sets `GridTargetingState.target_map`, `GridTargetingState.maps`, and `BuildingState.placed_parent`. Stable across a gameplay session. |
| [GBOwnerContext](../api/GBOwnerContext/) / GBUserScope | Per-user / player centric info (user id, permissions, team). | Enables multiplayer separation later. Backed by a [GBOwner](../api/GBOwner/) node (often added as `GBUser (GBOwner)` on the player) and used by [BuildingState](../api/BuildingState/), [ManipulationState](../api/ManipulationState/), and [GridTargetingState](../api/GridTargetingState/). |
| [GBConfig](../api/GBConfig/) | Root configuration resource; groups settings classes. | Read‑mostly at runtime. |
| [GBMessages](../api/GBMessages/) | Messaging / event bus (if enabled) for decoupled notifications. | Optional injection. |

## Major Enhancements in v5.0.0

### 🏗️ **Architectural Improvements**
- **Unified Dependency Injection**: Complete rewrite using [GBCompositionContainer](../api/GBCompositionContainer/) and [GBInjectorSystem](../api/GBInjectorSystem/)
- **Enhanced Context Separation**: Better separation between stable contexts and ephemeral state
{/* Supports 4.5 as well. Minimum 4.4+. */}
- **Improved State Management**: More robust lifecycle handling for state containers

### 🔧 **Context Enhancements**
- **GBCompositionContainer**: New dependency injection root with better system registration
- **Enhanced GBSystemsContext**: Improved aggregation of active systems with better coordination
- **Unified GBConfig**: All configuration consolidated in single root resource
- **Better Context Assembly**: More efficient placement context construction and reuse

### 📊 **State Container Improvements**
- **Enhanced ManipulationState**: Better handling of preview states and validation results
- **Improved GridTargetingState**: More responsive cursor tracking and tile snapping
- **Better ModeState**: Enhanced mode transitions and state persistence
- **Optimized State Lifecycle**: Reduced allocations and faster state mutations

### 🐛 **Debugging & Testing**
- **Context Debugging**: Better support for inspecting context objects during development
- **State Tracing**: Enhanced logging for state changes and mutations
{/* Removed internal testing class reference */}

## State Containers

| State | Fields (Representative) | Lifecycle |
| --- | --- | --- |
| [BuildingState](../api/BuildingState/) | `placed_parent: Node`, `preview: Node`; owner from [GBOwnerContext](../api/GBOwnerContext/). Signals: `success`, `failed`, `preview_changed`, `placed_parent_changed`, `system_changed`. | Build mode session |
| [ManipulationState](../api/ManipulationState/) | `data: ManipulationData`, `active_manipulatable: Manipulatable`, `active_target_node: Node`, `parent: Node2D`. Signals: `started`, `confirmed`, `finished`, `canceled`, `failed`, plus change signals. | Active while previewing/manipulating |
| [ModeState](../api/ModeState/) | `current: GBEnums.Mode` (OFF/BUILD/DEMOLISH/INSPECT). Signal: `mode_changed`. | Changes via input/mode toggles |
| [GridTargetingState](../api/GridTargetingState/) | `ready: bool`, `target: Node2D`, `positioner: Node2D`, `target_map: TileMapLayer`, `maps: Array[TileMapLayer]`. Signals: `ready_changed`, `target_changed`, `positioner_changed`, `target_map_changed`, `maps_changed`. | Revalidated on movement/changes |

## Rule evaluation inputs (what actually gets passed)

For placement rules, the only runtime input passed into rules is the [GridTargetingState](../api/GridTargetingState/):

- The validator calls `PlacementRule.setup(p_gts: GridTargetingState)` for each rule before evaluation.
- Rules read from [GridTargetingState](../api/GridTargetingState/) (e.g., `target`, `target_map`, `maps`) and derive their validation results.

What rules do NOT receive directly:

- [BuildingState](../api/BuildingState/): used after validation for commit and signal emission; not part of rule inputs.
- [ManipulationState](../api/ManipulationState/), [ModeState](../api/ModeState/): not required for rule checks.
- [GBLevelContext](../api/GBLevelContext/): used earlier to configure states (sets `target_map`, `maps`, `placed_parent`). Not passed to rules.
- [GBSystemsContext](../api/GBSystemsContext/): available to systems, not to rules.

Implicit dependencies managed by systems (not passed to rules):

- Logger/messages/templates and indicator services are injected into managers via [GBCompositionContainer](../api/GBCompositionContainer/) and used by surrounding systems like [IndicatorManager](../api/IndicatorManager/) and the validator. Example: IndicatorManager initializes with [GridTargetingState](../api/GridTargetingState/), the rule set, messages, logger, and indicator template; rules themselves still only get the [GridTargetingState](../api/GridTargetingState/) in `setup()`.

Summary:

- Keep rules pure over [GridTargetingState](../api/GridTargetingState/). Configure the state via [GBLevelContext](../api/GBLevelContext/) and DI once, then let rules evaluate.
- Use [BuildingState](../api/BuildingState/) for post-validation signals and instantiation via `placed_parent`.
- For rules that need user/owner context (e.g., inventory spending), read the placer from [GridTargetingState](../api/GridTargetingState/):
    - `GridTargetingState.get_owner()` or `get_owner_root()` provide access to the user/owner entity/root (typically driven by a `GBUser (GBOwner)` node wired via the owner context).
	- Example: [SpendMaterialsRuleGeneric](../api/SpendMaterialsRuleGeneric/) pulls its spender via the targeting state and locates the material container from there.

## Immutability Guidelines

- Context objects: treat as *effectively immutable* once gameplay starts. If dynamic reconfiguration is required (e.g. hot‑reloading settings), expose a narrow API that emits change events—avoid direct field mutation relied on by many subsystems.
- State objects: may be mutated, but prefer wrapping mutations in clearly named system methods (`set_rotation_deg()`, `select_variant()`) to centralize side effects (cache invalidation, events).

{/* Testing Strategy moved to internal/testing_strategy.md */}

## Cross‑References

- [Manipulation System](./manipulation_system/)
- [Placement Rules](./placement_rules/)
- [Configuration & Settings](./configuration_and_settings/)

______________________________________________________________________

Support / Purchase Hub: **[Linktree – All Grid Builder Links](https://linktr.ee/gridbuilder)**

## Glossary

**Placement Context**\
Packaged *snapshot* object containing the minimal inputs required for placement rule evaluation at a given frame: targeting state, manipulation state, config, systems, level, and owner contexts. Built fresh (or partially reused) whenever cursor position, rotation, variant, or selection changes. Its purpose is to present rules with an immutable view for pure evaluation—rules should not mutate it. See assembly details above.
