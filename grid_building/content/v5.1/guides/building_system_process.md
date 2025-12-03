---
title: Building System Process
description: End-to-end build placement workflow powered by the [BuildingSystem](../api/BuildingSystem/)
---


---


This page details the end‑to‑end build placement workflow powered by the [BuildingSystem](../api/BuildingSystem/) - a **core entry point** for any grid-based building functionality.

## 🎯 Key Entry Point

**When to use:** Essential for any grid building functionality - handles the complete placement workflow.

**Main class:** [BuildingSystem](../api/BuildingSystem/) (extends Node)  
**Configuration:** [GBConfig](../api/GBConfig/) (Resource)
**State management:** [BuildingState](../api/BuildingState/) (Resource)

This page details the end‑to‑end **build placement workflow**: from entering build mode with a selected placeable, through live rule validation with indicators, to final instantiation of the object in the game world.

## Overview

<Steps>
1. Select a placeable to enter build mode.
	- UI selection triggers [BuildingSystem](../api/BuildingSystem/) to activate a preview.
	- [IndicatorManager](../api/IndicatorManager/) is accessed via [IndicatorContext](../api/IndicatorContext/).
2. Compute candidate tiles (collision mapping).
	- Active preview shape(s) → epsilon-filtered tile set for evaluation.
3. Generate live indicators.
	- [IndicatorManager](../api/IndicatorManager/) spawns/updates [RuleCheckIndicator](../api/RuleCheckIndicator/) nodes and returns an [IndicatorSetupReport](../api/IndicatorSetupReport/).
	- Optional pre-setup validation can run here to catch hard preconditions before the live loop.
	- You see a live heatmap scaffolding for validity feedback.
4. Per-frame rule evaluation on indicators.
	- Each physics frame, [PlacementValidator](../api/PlacementValidator/) runs [TileCheckRule](../api/TileCheckRule/) subclasses and updates indicator validity (via [RuleCheckIndicator](../api/RuleCheckIndicator/)).
	- Indicators continuously reflect current validity status during preview.
5. Confirm placement.
	- Player presses confirm (e.g. `gb_select`) while preview is active; guard checks ensure preview is currently valid.
6. Run full validation.
	- Re-run (or reuse cached) tile checks; execute non‑tile/aggregate rules (costs, biome, adjacency, dependencies, slope, clearance, etc.).
	- Aggregate results into a `PlacementResult` and emit signals for build logging/reporting.
7. Commit or abort.
	- If valid: instantiate the scene, attach metadata (e.g. [PlaceableInstance](../api/PlaceableInstance/)), and register with subsystems.
	- If invalid: abort and surface feedback (indicator flash / log messages).
	- If multi‑place is enabled, remain in preview and loop back to step 2; otherwise exit preview.
</Steps>

## Major Enhancements in v5.0.0

### 🏗️ **Architectural Improvements**
- **Dependency Injection Integration**: Complete integration with [GBCompositionContainer](../api/GBCompositionContainer/) for better decoupling
- **Unified Configuration**: All building settings consolidated in [GBConfig](../api/GBConfig/) resource
- **Enhanced State Management**: Improved [BuildingState](../api/BuildingState/) with better lifecycle handling
{/* Supports 4.5 as well. Minimum 4.4+. */}

### 🔧 **Process Enhancements**
- **Comprehensive Workflow Documentation**: New detailed end-to-end build placement workflow
- **Enhanced Visual Process Flows**: Clear documentation with step-by-step explanations
- **Improved Error Handling**: Better error reporting and user feedback throughout the process
- **Performance Optimizations**: Reduced allocations and faster validation cycles

### 📊 **New Features**
- **Enhanced Preview System**: More responsive live preview with better visual indicators
- **Improved Instantiation**: Better metadata attachment and subsystem registration
- **Advanced Post-Placement Handling**: Enhanced multi-place mode and manipulation support
- **Better Edge Case Handling**: Improved handling of error scenarios and edge cases

### 🐛 **Debugging & Diagnostics**
- **Enhanced Logging**: Better tracing throughout the build placement workflow
- **Visual Debug Support**: Integration with [GBDebugSettings](../api/GBDebugSettings/) for process debugging
- **Performance Monitoring**: Built-in timing for workflow steps

{/* Detailed step breakdown moved into the Steps list above. */}

## Error & Edge Scenarios

| Scenario                                     | Handling                                                                |
| -------------------------------------------- | ----------------------------------------------------------------------- |
| Cursor leaves valid build area               | `can_place` false; indicators tinted invalid.                           |
| Placeable rule list empty                    | No tile indicators; full validation still runs but likely always valid. |
| Lost reference (placeable freed) mid-preview | Cancel preview; require reselection.                                    |
| Rotation changes geometry drastically        | Indicators regenerated; cached tiles invalidated.                       |

## Data Flow Overview

**Primary Build Flow:**
- Selection UI (placeable chosen) → [BuildingSystem](../api/BuildingSystem/) → IndicatorManager → [IndicatorContext](../api/IndicatorContext/)
- [IndicatorContext](../api/IndicatorContext/) → Collision Mapping → Live Indicators → Per-frame Tile Rules (on indicators)
- [BuildingSystem](../api/BuildingSystem/) (Confirm) → Full Validation + Signals → PlacementResult → Instantiation (if valid)

**Post-Placement Manipulation Flow:**
- Mode Toggle/Actions → [ManipulationSystem](../api/ManipulationSystem/) → Manipulatable Nodes
- [ManipulationSystem](../api/ManipulationSystem/) → [IndicatorContext](../api/IndicatorContext/) (move) → Manipulatable Nodes
- MOVE operation builds temporary context for manipulation

### Build Type System (v5.0.0+)

**New in v5.0.0**: The building system now uses a `BuildType` enum to differentiate between different build operation modes:

```gdscript
enum BuildType {
    SINGLE,  ## Single click/confirmation build
    DRAG,    ## Continuous drag-building across multiple tiles
    AREA     ## Future: Build across a defined area (e.g., fence line from point A to B)
}
```

**How it flows through the system:**

1. **DragManager** calls `building_system.try_build(GBEnums.BuildType.DRAG)` during drag operations
2. **BuildingSystem** accepts `build_type` parameter in `try_build()`, `report_built()`, and `report_failure()`
3. **BuildActionData** stores the build type and passes it through signals
4. **GBActionLog** checks build type to suppress drag/area build messages when `print_on_drag_build=false`
5. **GBAudioInstancer** (in demos) skips sounds and throttles failure audio based on build type

**Benefits:**
- Clean separation between single-click and drag-building operations
- Action log can properly suppress drag build spam
- Audio system can throttle failure sounds during rapid drag attempts
- Future-ready for area building features (fence lines, walls)

**Example usage:**
```gdscript
# Single build (default)
var report = building_system.try_build()  # Defaults to BuildType.SINGLE

# Drag building
var report = building_system.try_build(GBEnums.BuildType.DRAG)

# Future area building
var report = building_system.try_build(GBEnums.BuildType.AREA)
```

### Signals

| Signal                                                     | Emitted By                              | Purpose                                                     |
| ---------------------------------------------------------- | --------------------------------------- | ----------------------------------------------------------- |
| `preview_changed(preview: Node)`                           | [BuildingState](../api/BuildingState/)  | Preview instance changed; UI reacts (tooltips, ghost model).|
| `success(build_action_data: `[BuildActionData](../api/BuildActionData/)`)` | [BuildingState](../api/BuildingState/)  | Placement committed; downstream indexing & save registration. [BuildActionData](../api/BuildActionData/) contains `build_type` to differentiate SINGLE/DRAG/AREA builds.|
| `failed(build_action_data: `[BuildActionData](../api/BuildActionData/)`)`  | [BuildingState](../api/BuildingState/)  | Build failed; feedback to player (HUD/log), indicator flash. [BuildActionData](../api/BuildActionData/) contains `build_type` for conditional handling.|
| `placed_parent_changed(placed_parent: Node)`               | [BuildingState](../api/BuildingState/)  | Parent for placed objects changed.                          |
| `system_changed(system: `[BuildingSystem](../api/BuildingSystem/)`)`       | [BuildingState](../api/BuildingState/)  | Connected building system changed.                          |

{/* Testing Strategy moved to internal/testing_strategy.md */}

## Cross‑References

- [Placement Chain](/v5-0/guides/placement_chain/): Placement processing chain documentation
- [Manipulation System](/v5-0/guides/manipulation_system/): Object manipulation system overview
- [Placement Rules Pipeline](/v5-0/guides/placement_rules/): Placement rules system documentation
- [Collision Mapping](/v5-0/guides/collision_mapping/): Collision mapping system overview
- [Context & State](/v5-0/guides/context_and_state/): Context and state management
- [Configuration & Settings](/v5-0/guides/configuration_and_settings/): System configuration options

Last updated: 2025-09-07 (converted to Steps list; refactor: `PlacementManager` → [IndicatorManager](../api/IndicatorManager/); clarified Selection UI boundaries)

______________________________________________________________________

Community & Purchase Hub: **[Linktree – All Grid Builder Links](https://linktr.ee/gridbuilder)**