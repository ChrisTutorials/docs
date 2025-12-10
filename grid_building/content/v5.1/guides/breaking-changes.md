---
title: Breaking Changes
description: Important breaking changes and migration notes for v5.0.0 and v5.1.0
---


## v5.1.0 Breaking Changes - ManipulationData API Improvements

{{< gb-note type="caution" title="Breaking Change in v5.1.0" >}}
**Released:** October 2025  
**Impact:** Medium - affects code directly accessing `ManipulationData.target` property
{{< /gb-note >}}

### What Changed

The [ManipulationData](../api/ManipulationData/) API was refactored to eliminate semantic confusion between targeting and manipulation:

**Property Renamed:**
- ❌ **OLD:** `ManipulationData.target` (confusing - which "target"?)
- ✅ **NEW:** `ManipulationData.move_copy` (clear - the temporary manipulation preview)

**Helper Method Added:**
- ✅ **NEW:** `ManipulationData.get_move_copy_root()` - Safe null-check access to the root node

**Related Changes:**
- ❌ **REMOVED:** `ManipulationState.active_target_node` property (redundant with `GridTargetingState.target`)
- ✅ **ADDED:** `ManipulationState.get_active_root()` helper method

### Why This Change?

**Problem:** Semantic confusion between two "target" properties:
- `GridTargetingState.target` = What is being aimed at (collision detection target)
- `ManipulationData.target` = Temporary manipulation preview (NOT the target being aimed at)

**Solution:** Rename to `move_copy` to clearly indicate it's the temporary manipulation preview object.

### Migration Guide

#### Pattern 1: Direct Property Access

```gdscript
# ❌ OLD (v5.0.x)
var preview_pos = manipulation_data.target.root.global_position
if manipulation_data.target != null:
    manipulation_data.target.root.rotation = 45.0

# ✅ NEW (v5.1.0+)
var preview_pos = manipulation_data.move_copy.root.global_position
if manipulation_data.move_copy != null:
    manipulation_data.move_copy.root.rotation = 45.0
```

#### Pattern 2: Using Helper Method (Recommended)

```gdscript
# ❌ OLD (v5.0.x) - nested null checks
if manipulation_data != null and manipulation_data.target != null and manipulation_data.target.root != null:
    var root = manipulation_data.target.root

# ✅ NEW (v5.1.0+) - clean helper method
var root = manipulation_data.get_move_copy_root()
if root != null:
    root.global_position = target_position
```

#### Pattern 3: ManipulationState Access

```gdscript
# ❌ OLD (v5.0.x) - removed property
var active_node = manipulation_state.active_target_node

# ✅ NEW (v5.1.0+) - use helper method
var active_root = manipulation_state.get_active_root()
```

### Architecture Benefits

1. **Semantic Clarity**: Clear distinction between `move_copy` (preview) and `GridTargetingState.target` (actual target)
2. **Single Source of Truth**: Reinforces [GridTargetingState](../api/GridTargetingState/) as authoritative for targeting
3. **Null Safety**: Helper methods eliminate error-prone nested null checks
4. **Self-Documenting**: Code reads as "move the copy" not "move the target"

### Files to Update

Search your project for these patterns and update:
- `manipulation_data.target` → `manipulation_data.move_copy`
- `manipulation_state.active_target_node` → `manipulation_state.get_active_root()`
- Nested null checks → Use `get_move_copy_root()` helper

### Related Documentation

- See [ManipulationData API](../api/ManipulationData/) for complete API reference
- See [ManipulationState API](../api/ManipulationState/) for state management details
- See [Manipulation System Guide](./manipulation_system/) for architectural overview

---

## Summary of major breaking changes (4.3.1 → 5.0.0)
- **🏗️ Node Hierarchy Architecture:** Well-defined hierarchy with specific class names ([GridPositioner2D](../api/GridPositioner2D/) → [TargetingShapeCast2D](../api/TargetingShapeCast2D/) → [ManipulationParent](../api/ManipulationParent/) → [IndicatorManager](../api/IndicatorManager/)). Major functionality relocated from high-level coordinators to individual components.
- Dependency Injection / Composition Container is now the primary integration pattern. See [GBCompositionContainer](../api/GBCompositionContainer/) and [GBInjectorSystem](../api/GBInjectorSystem/).
- Configuration consolidated into the [GBConfig](../api/GBConfig/) resource.
- **🆕 Automatic validation:** [GBInjectorSystem](../api/GBInjectorSystem/) now handles validation automatically - no manual validation calls required!
- **🔄 Functionality redistribution:** [GridTargetingSystem](../api/GridTargetingSystem/) and [ManipulationSystem](../api/ManipulationSystem/) simplified to coordination roles; core functionality moved to specific component classes.
- Validation contract standardized: `validate()` results are represented as boolean success + diagnostic collections via `get_runtime_issues()` / `get_editor_issues()` (multiple files expose these methods).
- Godot API change: migrate any `TileMap` usage to `TileMapLayer` for 2D tile placement/queries.
- Important signature/rename breaks (examples): `GBOwnerContext.set_owner(...)` now requires a [GBOwner](../api/GBOwner/) (5.1 bridge name: `GBUser`); `DragBuildManager` was renamed to [DragManager](../api/DragManager/) and exposes `is_dragging()`.

The sections below expand each item with concrete before/after examples and file references.

---

## 1) Dependency Injection (DI) and Composition Container

What changed
- The plugin moved from ad-hoc, direct node/system instantiation to a composition-based approach. New public resources/classes include [GBCompositionContainer](../api/GBCompositionContainer/), [GBInjectorSystem](../api/GBInjectorSystem/), and [GBSystemsContext](../api/GBSystemsContext/).

Impact
- Callsites that previously created systems directly (e.g., `BuildingSystem.new()`) should now obtain systems via the injector/composition pattern.
- For most end users the recommended integration is:
	1. Add a [GBInjectorSystem](../api/GBInjectorSystem/) node to your gameplay (runtime) scene where grid-building features are used — this keeps injection local to the gameplay context rather than embedding injector state in level resources.
	2. Create or use a [GBCompositionContainer](../api/GBCompositionContainer/) resource and assign it to the [GBInjectorSystem](../api/GBInjectorSystem/) using its exported `composition_container` property. You can use the supplied composition container templates or create your own [GBCompositionContainer](../api/GBCompositionContainer/) resource file (`.tres`).

Migration guidance (example)
Previously, systems like [GridTargetingSystem](../api/GridTargetingSystem/) might have had direct exported properties for settings (e.g., `@export var settings : GridTargetingSettings`).

Now, the workflow is:
1. Add a [GBInjectorSystem](../api/GBInjectorSystem/) node to your gameplay scene.
2. Assign a [GBCompositionContainer](../api/GBCompositionContainer/) resource to its `composition_container` exported property (use provided templates or create your own `.tres` file).
3. Optionally, set the `injection_roots` property to specify which part of the scene hierarchy to inject into (can include multiple paths if needed).
4. Systems like [GridTargetingSystem](../api/GridTargetingSystem/) will automatically have their `resolve_gb_dependencies()` method called by the injector, resolving settings from the container without manual assignment.

This avoids direct instantiation and manual wiring, letting the injector handle dependency resolution automatically for nodes in the scene that implement the required methods.

Files to review
- [GBCompositionContainer](../api/GBCompositionContainer/)
- [GBInjectorSystem](../api/GBInjectorSystem/)
- [GBSystemsContext](../api/GBSystemsContext/)

Notes
- The [GBInjectorSystem](../api/GBInjectorSystem/) listens for scene tree additions and injects dependencies automatically into nodes it manages. Prefer wiring composition via the injector's exported `composition_container` property rather than instantiating containers in gameplay code.
- Use the provided composition container templates (look under the plugin templates folder) or author a [GBCompositionContainer](../api/GBCompositionContainer/) resource and save it into your project.
-- Important: before upgrading, save any existing configuration or exported setting resources (templates, visuals, action sets, etc.) to disk as `.tres` or `.res` files in your project and then reassign them into a [GBConfig](../api/GBConfig/) resource. Many exported properties were removed in favor of DI and will not be present after upgrade; saving them ensures you don't lose configuration.

For a step-by-step migration checklist (recommended), see [Migration — v5.0.0](../migration/5-0-0/).

---

## 2) Configuration consolidated under [GBConfig](../api/GBConfig/)

What changed
- Multiple scattered exported properties were consolidated into a single [GBConfig](../api/GBConfig/) resource. See [GBConfig](../api/GBConfig/) for the API and structure.

Impact
- If you previously used exported properties on different nodes for configuration, move those values into a [GBConfig](../api/GBConfig/) resource and assign it to the composition container (or via the [GBInjectorSystem](../api/GBInjectorSystem/)'s assigned composition container).

Migration example (before)
Previously, systems like [GridTargetingSystem](../api/GridTargetingSystem/) might have had direct exported properties for settings:
```gdscript
@export var grid_targeting_settings: GridTargetingSettings
```

After (example)
Create or edit a [GBConfig](../api/GBConfig/) resource in the editor inspector. The [GBConfig](../api/GBConfig/) has a nested `settings` property of type [GBSettings](../api/GBSettings/), which contains a `targeting` exported property for [GridTargetingSettings](../api/GridTargetingSettings/). Set the `targeting` property (and other configuration values) there. Save the resource as a `.tres` file and assign it to your [GBCompositionContainer](../api/GBCompositionContainer/) used by the [GBInjectorSystem](../api/GBInjectorSystem/).

Files to review: [GBConfig](../api/GBConfig/)

---

### Consolidated exports you should save before upgrading

Many exported properties that previously lived directly on systems, UI nodes, or indicator scenes have been consolidated into [GBConfig](../api/GBConfig/) (under `settings`, `templates`, or `actions`). To avoid losing values during upgrade, save any resources or exported values used in your project to `.tres`/`.res` files and reassign them into the appropriate [GBConfig](../api/GBConfig/) subresource after upgrading.

The table below lists the common exported properties you may have used, where they were commonly exported previously, and their new [GBConfig](../api/GBConfig/) location. This is intended as a practical checklist — if you see an exported property in your project that matches one below, save it as a resource and note the recommended target path in [GBConfig](../api/GBConfig/).

| Old class / location | Export/resource | New GBConfig location | Notes |
|---|---|---|---|
| [GridTargetingSystem](../api/GridTargetingSystem/) / targeting nodes | [GridTargetingSettings](../api/GridTargetingSettings/) (resource) | `GBConfig.settings.targeting` | Save your [GridTargetingSettings](../api/GridTargetingSettings/) resource as `.tres` and assign to `GBConfig.settings.targeting`.
| [BuildingSystem](../api/BuildingSystem/) / preview nodes | [BuildingSettings](../api/BuildingSettings/) (resource) | `GBConfig.settings.building` | Save your [BuildingSettings](../api/BuildingSettings/) resource as `.tres` and assign to `GBConfig.settings.building`.
| [ManipulationSystem](../api/ManipulationSystem/) / manipulation UI | [ManipulationSettings](../api/ManipulationSettings/) (resource) | `GBConfig.settings.manipulation` | Save your [ManipulationSettings](../api/ManipulationSettings/) resource as `.tres` and assign to `GBConfig.settings.manipulation`.
| [RuleCheckIndicator](../api/RuleCheckIndicator/) / indicator scenes | [IndicatorVisualSettings](../api/IndicatorVisualSettings/) (resource) | `GBConfig.templates.rule_check_indicator` (inside the saved template) | Save [IndicatorVisualSettings](../api/IndicatorVisualSettings/) and indicator PackedScene templates; store the template under `GBConfig.templates.rule_check_indicator` and reference visuals from the saved template.
| [IndicatorManager](../api/IndicatorManager/) / PlacementValidator | PackedScene templates | `GBConfig.templates.*` (e.g., `rule_check_indicator`) | Save PackedScene templates and assign them under `GBConfig.templates`.
| UI nodes (placeable lists / selection UIs) | UI PackedScene templates | `GBConfig.templates.*` | Save UI PackedScenes and assign under `GBConfig.templates`, or keep local where appropriate.
| [GBActionButton](../api/GBActionButton/) / input helpers | [GBActions](../api/GBActions/) (resource) | `GBConfig.actions` | Save a [GBActions](../api/GBActions/) resource as `.tres` and assign to `GBConfig.actions`.
| `ActionLog` / UI | [ActionLogSettings](../api/ActionLogSettings/) (resource) | `GBConfig.settings.action_log` | Save [ActionLogSettings](../api/ActionLogSettings/) as `.tres` and assign to `GBConfig.settings.action_log`.
| Various systems / messages | ~~ManipulationMessages / GBMessages~~ **(REMOVED)** | Message strings now in [ManipulationSettings](../api/ManipulationSettings/) and [ActionLogSettings](../api/ActionLogSettings/) | Message strings are now `@export` properties directly in settings resources. Configure in `GBConfig.settings.manipulation` and `GBConfig.settings.action_log`.
| Placeable / placeable sequence definitions | Placeable resource files | Assigned via Placeable Selection UI (see your project UI) | Save Placeable resource files as `.tres` and keep them centralized (for example `res://placeables/`). Placeables are assigned to the Placeable Selection UI in your scenes — they are not typically assigned directly to [GBConfig](../api/GBConfig/). At runtime the project may optionally autoload a configured folder of placeable resources; for upgrades, prefer saving and assigning `.tres` files via your Placeable Selection UI.
| Validation / placement rules | [PlacementRule](../api/PlacementRule/) (resources) | `GBConfig.settings.placement_rules` | Save [PlacementRule](../api/PlacementRule/) resources as `.tres` and assign to `GBConfig.settings.placement_rules`.
| Debug tuning / indicator debug toggles | [GBDebugSettings](../api/GBDebugSettings/) (resource) | `GBConfig.settings.debug` | Save [GBDebugSettings](../api/GBDebugSettings/) as `.tres` and assign to `GBConfig.settings.debug`.
| Cursor / visual configuration | [GBVisualSettings](../api/GBVisualSettings/) (resource) | `GBConfig.settings.visual` | Save [GBVisualSettings](../api/GBVisualSettings/) as `.tres` and assign to `GBConfig.settings.visual`.
| Input/action name resources | [GBActions](../api/GBActions/) (resource) | `GBConfig.actions` | Centralize action name identifiers into a [GBActions](../api/GBActions/) resource and assign to `GBConfig.actions`.

Notes on using this table

- If you find an exported property in your scenes or nodes that matches an entry above, save the resource or value to disk (as `.tres`/`.res`) before upgrading and record the intended [GBConfig](../api/GBConfig/) path.
- After upgrading, create or edit a [GBConfig](../api/GBConfig/) resource in the editor and populate `settings`, `templates`, and `actions` with the saved resources or values. [GBConfig](../api/GBConfig/)'s `_lazy_init_subresources()` will create sub-resources if missing.
- Template reassignment: PackedScene templates (for indicators, placeable views, lists) should be saved as separate `.tscn`/`.tscn` packed scenes in your project and referenced from `GBConfig.templates`.


## 3) Validation contract standardized + Automatic validation

What changed
- Validation flows now use a simple boolean success contract for `validate()` and explicit issue collection via `get_runtime_issues()` / `get_editor_issues()`. Many systems and resources implement these helpers.
- **🆕 Automatic validation:** [GBInjectorSystem](../api/GBInjectorSystem/) now automatically validates configuration after dependency injection completes - **no manual validation calls required!**
- **🗑️ Removed methods:** `validate_runtime_deferred()`, `_validate_after_injection()`, and similar manual validation methods have been removed from [GBCompositionContainer](../api/GBCompositionContainer/)

Migration Impact
- **Remove manual validation calls:** If you have code calling `validate_runtime_deferred()` or `_validate_after_injection()`, **you must remove these calls** - they no longer exist and validation now happens automatically.
- **Simplified setup:** Grid Building systems now validate automatically without user intervention.
- **Cleaner code:** No validation boilerplate needed in your setup code.

Before (manual validation required):
```gdscript
func _ready() -> void:
    # Setup Grid Building...
    _player_gb_container.validate_runtime_deferred()  # ❌ REMOVED - no longer exists!
```

After (automatic validation):
```gdscript  
func _ready() -> void:
    # Setup Grid Building...
    # Validation happens automatically! ✅
```

**Important:** The following methods have been **REMOVED** and are **NOT** backwards compatible:
- `GBCompositionContainer.validate_runtime_deferred()` - REMOVED
- `GBCompositionContainer._validate_after_injection()` - REMOVED  
- `validate_runtime_configuration()` - REMOVED (outdated reference)

If your code calls any of these methods, you will get runtime errors. Simply remove the calls - [GBInjectorSystem](../api/GBInjectorSystem/) handles validation automatically after dependency injection.

Two supported workflows for custom validation

- Automatic validation + logging (convenience): call `validate()` when you want the system to run its internal checks and perform any built-in logging; `validate()` returns `true` when no issues were found. This is the simple path when you only need a pass/fail result and want the system to handle logging for you.

- Manual inspection (detailed handling): call `get_runtime_issues()` to retrieve the list of issue objects/strings and handle logging, breakpoints, or special reporting yourself. `get_runtime_issues()` does not log by itself — it merely reports the collected issues.

Notes on logging
- The logger helpers (for example `container.get_logger().log_issues(...)`) will safely ignore an empty issues array, so you can call them unconditionally if that fits your flow. Alternatively, check `if issues.size() > 0:` before logging if you prefer an explicit guard.

Examples

Automatic validation vs direct issue inspection

Use `validate()` when you want the system to run its internal checks and let the system handle any built-in logging or diagnostics. `validate()` returns `true` when no issues were found and will typically log detected issues to the configured logger.

```gdscript
# Preferred: simple validation with internal logging
var ok: bool = system.validate()
if not ok:
	# If you need extra reporting (for example to aggregate across systems),
	# fetch the collected runtime issues — but do NOT call both validation
	# and then unconditionally call `get_runtime_issues()` just to re-log
	# the same issues (that would be redundant).
	var issues = system.get_runtime_issues()
	container.get_logger().log_issues(issues)
```

Use `get_runtime_issues()` or `get_editor_issues()` when you want to examine the issue collection yourself (for example to run custom reporting, break into the debugger, or filter/transform entries). Call the editor variant only when running inside editor-validation flows.

```gdscript
# Manual: inspect the collected issues and handle them yourself
var issues: Array[String] = system.get_runtime_issues()
if issues.size() > 0:
	# Perform custom handling or targeted logging
	container.get_logger().log_issues(issues)
	for issue in issues:
		push_error(str(issue))
```

Guidance summary
- During gameplay use `validate()` for a single-pass check that also performs any default logging.
- If you want full control over logging or to avoid any automatic logger output, call `get_runtime_issues()` (gameplay) or `get_editor_issues()` (editor-time) and handle the results yourself.
- Avoid calling `validate()` and then immediately calling `get_runtime_issues()` just to re-log the same issues unless you have a specific reason to aggregate or transform the results first.

Common locations of issue helpers (examples)
- `../api/GBLogger/` (has `get_runtime_issues()`)
- `../api/BuildingSystem/`
- `../api/GridTargetingSystem/`
- Many `../api/*` pages correspond to `resources/*` and `placement/*` GDScript files and expose `get_runtime_issues()` / `get_editor_issues()` in their API.

---

## 4) Godot TileMap → TileMapLayer

What changed
- Godot deprecated some `TileMap` usages for tile-layer operations. Code and exported properties that previously referenced `TileMap` should be migrated to `TileMapLayer` where appropriate.

Migration example
```gdscript
# Before
@export var tile_map: TileMap

# After
@export var tile_map_layer: TileMapLayer
```

Search and update: any script that used `TileMap` APIs for 2D placement/queries.

---

## 5) Node Hierarchy Architecture & Functionality Relocation

### What changed
v5.0.0 introduces a **well-defined node hierarchy** with specific class names and clear responsibility distribution. This represents a major architectural shift from the previous loosely-defined structure.

#### New Hierarchy Structure
The Grid Building system now follows this specific hierarchy (see [Project Architecture](../project_architecture/) for complete details):

- **[GridPositioner2D](../api/GridPositioner2D/)** - Root node handling targeting and input movement
  - **[TargetingShapeCast2D](../api/TargetingShapeCast2D/)** - Target collision detection using shape casting
  - **[ManipulationParent](../api/ManipulationParent/)** - Handles rotations and flips for objects
    - **[IndicatorManager](../api/IndicatorManager/)** - Manages visual feedback indicators
      - **[RuleCheckIndicator](../api/RuleCheckIndicator/)** nodes - Individual rule validation indicators
    - **Preview Object** - Temporary preview during build/move modes

#### Functionality Redistribution
Major system functionality has been relocated from high-level coordinators to specific component classes:

**GridTargetingSystem → Individual Components:**
- Input handling → [GridPositioner2D](../api/GridPositioner2D/)
- Collision detection → [TargetingShapeCast2D](../api/TargetingShapeCast2D/)
- Transform operations → [ManipulationParent](../api/ManipulationParent/)

**ManipulationSystem → ManipulationParent:**
- Direct input processing → [ManipulationParent](../api/ManipulationParent/)
- Transform coordination → [ManipulationParent](../api/ManipulationParent/)
- Indicator synchronization → [ManipulationParent](../api/ManipulationParent/) (via native Node2D inheritance)

### Migration Impact

#### Before (v4.x)
```gdscript
# Loose hierarchy with generic node names
some_node/
  generic_targeting_node/  # No specific class requirements
  custom_manipulation/     # User-defined structure
```

#### After (v5.0.0)
```gdscript
# Strict hierarchy with specific class names
GridPositioner2D/          # Must be GridPositioner2D class
  TargetingShapeCast2D/    # Must be TargetingShapeCast2D class
  ManipulationParent/      # Must be ManipulationParent class
    IndicatorManager/      # Must be IndicatorManager class
```

#### Code Migration Examples

**Targeting functionality relocation:**
```gdscript
# Before: GridTargetingSystem handled everything
grid_targeting_system.process_input()
grid_targeting_system.update_target()

# After: Specific components handle their responsibilities  
grid_positioner.process_input()        # Input → GridPositioner2D
targeting_shapecast.update_target()    # Collision → TargetingShapeCast2D
```

**Manipulation functionality relocation:**
```gdscript
# Before: ManipulationSystem coordinated transforms
manipulation_system.rotate_preview()
manipulation_system.flip_indicators()

# After: ManipulationParent handles transforms directly
manipulation_parent.rotate_preview()   # Direct transform control
# Indicators automatically inherit transforms via Node2D parent-child relationship
```

### Benefits
- **Clear Architecture**: Specific class names eliminate ambiguity
- **Better Performance**: Direct component communication without delegation
- **Improved Maintainability**: Each component has well-defined responsibilities
- **Automatic Synchronization**: Leverages Godot's native transform inheritance
- **Easier Testing**: Components can be tested in isolation

### Files affected
- [GridPositioner2D](../api/GridPositioner2D/): Enhanced with direct input processing
- [TargetingShapeCast2D](../api/TargetingShapeCast2D/): Dedicated collision detection
- [ManipulationParent](../api/ManipulationParent/): Direct transform and input handling
- [GridTargetingSystem](../api/GridTargetingSystem/): Simplified coordination role
- [ManipulationSystem](../api/ManipulationSystem/): High-level lifecycle management only

## 7) Legacy Manipulation System Architecture (Related Changes)

### What changed
The manipulation system has been refactored to follow the Single Responsibility Principle with clear separation between:
- **ManipulationSystem**: High-level coordination, mode management, and manipulation lifecycle
- **ManipulationParent**: Direct input handling, transform coordination, and indicator synchronization

### Impact
This architectural change primarily affects internal implementation and provides several improvements:
- **Bug Fix**: Resolves the "indicators don't rotate/flip with preview objects" issue
- **Improved Architecture**: Better separation of concerns and reduced coupling
- **Better Maintainability**: Cleaner code with elimination of delegation anti-patterns
- **Performance**: Leverages Godot's native transform inheritance for indicator synchronization

### Migration guidance
For most users, this change is **non-breaking** as the public API remains the same. The improvements happen automatically:

- ManipulationSystem continues to handle high-level manipulation coordination
- Transform operations now happen directly through ManipulationParent with automatic child synchronization
- Input processing is handled more efficiently without delegation chains

### Files affected
- [ManipulationSystem](../api/ManipulationSystem/): Simplified to focus on coordination
- [ManipulationParent](../api/ManipulationParent/): Enhanced with direct input processing and dependency injection
- [ManipulationState](../api/ManipulationState/): Updated to work with the new architecture

### Benefits
- **Automatic indicator synchronization**: Child indicators now inherit transforms automatically via Godot's Node2D system
- **Reduced complexity**: Elimination of transform input delegation between components
- **Better testability**: Components can be tested in isolation with clear responsibilities
- **Leverages Godot patterns**: Uses engine's natural parent-child transform relationships

## 8) Signature and class renames (notable breaking items)

- `GBOwnerContext.set_owner(value: GBOwner) -> void`
	- Commit note: `BREAKING: GBOwnerContext.set_owner now requires GBOwner (tests updated)`
	- Impact: Call sites that passed other types (or no type) may now fail static checks or runtime typed calls. Update callsites to pass a [GBOwner](../api/GBOwner/) instance (see `../api/GBOwnerContext/` and `../api/GBOwner/`).

- `DragBuildManager` → [DragManager](../api/DragManager/) and `is_dragging()`
	- The internal drag controller class was renamed to [DragManager](../api/DragManager/). Where code referenced `DragBuildManager` directly in older versions, update to [DragManager](../api/DragManager/). The [BuildingSystem](../api/BuildingSystem/) provides `is_drag_building()` as a compatibility delegate, but prefer `DragManager.is_dragging()` for new code. See `../api/DragManager/`.

- Logger centralization
	- Instead of creating [GBLogger](../api/GBLogger/) manually across systems, obtain the logger from the composition container assigned to your injector (e.g. the container referenced by the [GBInjectorSystem](../api/GBInjectorSystem/)), or call `composition_container.get_logger()`. See `../api/GBLogger/` and `../api/GBCompositionContainer/`.

Files & symbols to scan for updates
- `../api/GBOwnerContext/` (set_owner signature)
- `../api/DragManager/` (class & is_dragging)
- `../api/GBCompositionContainer/` (get_logger / composition usage)

---

## 9) GBInjectable / reference-count changes

What changed
- Many classes were converted to ref-counted types and unified under a [GBInjectable](../api/GBInjectable/) base so they can participate in the plugin's DI and lifecycle expectations without being Node-derived.

Important integration notes
- Injection is node-centric: the injector ([GBInjectorSystem](../api/GBInjectorSystem/)) walks the scene tree and automatically injects dependencies into Node-derived objects it manages. Ref-counted objects (Resources or plain Objects) are NOT injected automatically just because they exist as sub-objects of a Node.
- To integrate ref-counted sub-objects with DI you should:
	1. Make the owner Node (the Node that holds the ref-counted instance) a target for injection (e.g., it lives under an injection root handled by [GBInjectorSystem](../api/GBInjectorSystem/)).
	2. Implement `resolve_gb_dependencies(container)` (or the project's standard resolve method) on the Node and, inside that implementation, forward configuration and dependencies to the owned ref-counted objects. For example, call a setter or invoke a `resolve_gb_dependencies()`-like method on the resource if it implements [GBInjectable](../api/GBInjectable/).
	3. Treat the Node as the injection entry point — it is responsible for wiring its ref-counted sub-objects. Ref-counted objects do not get injected by traversing the tree on their own.

Why this matters
- Previously the project had no built-in pattern or base class specifically for non-node, ref-counted objects in the grid-building system. [GBInjectable](../api/GBInjectable/) provides a common base and optional hooks to make ref-counted objects easier to integrate, but nodes remain the primary injection unit.

Practical example (prose)
- Suppose `MyGridComponentResource` is a `Resource` that extends [GBInjectable](../api/GBInjectable/) and is owned by `MyGridNode` (a `Node` in the scene). To ensure the resource receives the necessary dependencies, `MyGridNode.resolve_gb_dependencies(container)` should obtain the resolved services/config from `container` and then call into `MyGridComponentResource` to supply them (for example `my_resource.setup(logger, settings)` or `my_resource.resolve_gb_dependencies(container)`). This explicit forwarding guarantees the ref-counted object receives configuration and services even though it is not injected directly by the scene injector.

Impact
- If you extended or relied on specific GC/lifetime behaviors, review classes inheriting [GBInjectable](../api/GBInjectable/) (search `class_name GBInjectable` and `extends GBInjectable`). See [GBInjectable](../api/GBInjectable/).

Files to review: [GBInjectable](../api/GBInjectable/), [GBInjectorSystem](../api/GBInjectorSystem/), [GBCompositionContainer](../api/GBCompositionContainer/)

## 10) Migration checklist (concrete)

For detailed step-by-step migration, see [Migration — v5.0.0](../migration/5-0-0/).

- [ ] Save any existing exported settings or resource instances to disk as `.tres`/`.res` BEFORE UPGRADING. This prevents resources from disappearing when exported properties are consolidated into the [GBCompositionContainer](../api/GBCompositionContainer/) (or moved into the [GBConfig](../api/GBConfig/) resource) — an exported property that previously lived on a system or UI node may otherwise no longer exist after upgrade.
- [ ] Upgrade assets to Godot 4.4+.
- [ ] Replace direct `*.new()` system instantiation by adding a [GBInjectorSystem](../api/GBInjectorSystem/) node to your gameplay scene and assigning a [GBCompositionContainer](../api/GBCompositionContainer/) resource (via the GBInjectorSystem exported property), or use a provided container template saved as a `.tres` resource.
- [ ] Update calls to `GBOwnerContext.set_owner(...)` to pass a [GBOwner](../api/GBOwner/) instance.
- [ ] Replace direct logger instantiation with the container-provided logger.
- [ ] Migrate any `TileMap` references to `TileMapLayer` where applicable.

---

## 11) Hide on Handled Mouse Input Dependency

**Change:** The `hide_on_handled` visibility setting now respects the `enable_mouse_input` setting, preventing unwanted hiding when mouse input is disabled.

**Reason:** Previously, `hide_on_handled` would apply even when `enable_mouse_input` was `false`, causing the positioner to hide when hovering UI elements during keyboard-only or code-driven positioning modes.

**Impact:** This is a **behavioral fix** rather than a breaking API change. Most users will see improved behavior, but if your code relied on the previous behavior where `hide_on_handled` applied regardless of mouse input state, you may need to adjust your visibility logic.

### Before (v5.0.0 and earlier)
```gdscript
# hide_on_handled always applied, even with mouse disabled
settings.enable_mouse_input = false
settings.hide_on_handled = true
# Result: Positioner could still hide when UI elements were hovered
```

### After (v5.1.0+)
```gdscript
# hide_on_handled only applies when mouse input is enabled
settings.enable_mouse_input = false
settings.hide_on_handled = true  # This setting is now ignored
# Result: Positioner stays visible as expected in mouse-disabled modes
```

### Migration
- **For mouse-enabled modes:** No changes needed, behavior is preserved
- **For keyboard/code-driven modes:** Visibility now works correctly without workarounds
- **For mixed modes:** Review your visibility logic if you were working around the previous behavior

Files to review: [GridTargetingSettings](../api/GridTargetingSettings/), [GridPositionerLogic](../api/GridPositionerLogic/)

---

## 12) Removed Message Resource Files - Messages Now in Settings

**Change:** Message resource files and their scripts have been **completely removed**. Message strings are now **exported properties directly in settings resources**.

**Architecture Change:**
- **Old approach (v4.x):** Separate [ManipulationMessages](../api/ManipulationMessages/) and [GBMessages](../api/GBMessages/) resource files
- **New approach (v5.0.0):** Message strings are `@export` properties in [ManipulationSettings](../api/ManipulationSettings/) and [ActionLogSettings](../api/ActionLogSettings/)

**Files Removed:**
- `godot/addons/grid_building/systems/manipulation/manipulation_messages.gd` - **Script removed**
- `godot/addons/grid_building/resources/messages/gb_messages.gd` - **Script removed**  
- `godot/demos/shared/settings/demo_messages.tres` - Demo resource removed
- `godot/demos/shared/settings/manipulation_messages.tres` - Demo resource removed

**Impact:** All message strings are now configured directly in the settings resources where they're used, not in separate message resource files.

### Migration

**Before (v4.x):**
```gdscript
# Separate message resource files (no longer exist)
var manipulation_messages = preload("res://path/to/manipulation_messages.tres")
var gb_messages = preload("res://path/to/gb_messages.tres")
```

**After (v5.0.0):**
```gdscript
# Messages are properties in settings resources
var manipulation_settings: ManipulationSettings = gb_config.settings.manipulation
# Access messages directly as properties:
print(manipulation_settings.demolish_success)
print(manipulation_settings.move_started)
print(manipulation_settings.failed_placement_invalid)

var action_log_settings: ActionLogSettings = gb_config.settings.action_log
# Action log display messages:
print(action_log_settings.built_message)
print(action_log_settings.fail_build_message)
```

**Where messages are now located:**

- **Manipulation operation messages** → [ManipulationSettings](../api/ManipulationSettings/) properties:
  - `demolish_success`, `demolish_already_deleted`, `failed_not_demolishable`
  - `move_started`, `move_success`, `failed_to_start_move`, `no_move_target`
  - `failed_placement_invalid`, `target_not_rotatable`, `target_not_flippable_horizontally`, etc.

- **UI/ActionLog display messages** → [ActionLogSettings](../api/ActionLogSettings/) properties:
  - `built_message`, `fail_build_message`, `mode_change_message`
  - `show_demolish`, `show_moves`, `show_mode_changes` (display toggles)

**Resource file updates:**

If you have `.tres` files that reference the old script paths, delete those resource files and configure messages directly in your [ManipulationSettings](../api/ManipulationSettings/) and [ActionLogSettings](../api/ActionLogSettings/) resources instead.

Files to review: [ManipulationSettings](../api/ManipulationSettings/), [ActionLogSettings](../api/ActionLogSettings/), [GBSettings](../api/GBSettings/)

---

## 13) Property Rename: `mouse_handled` → `ui_mouse_handled`

**Change:** The property name `mouse_handled` has been renamed to `ui_mouse_handled` for clarity.

**Location:** [GridTargetingSystem](../api/GridTargetingSystem/)

**Impact:** If your code directly accesses this property, update the property name.

### Migration

**Before (v4.x):**
```gdscript
# Old property name
if grid_targeting_system.mouse_handled:
    return
```

**After (v5.0.0):**
```gdscript
# New property name
if grid_targeting_system.ui_mouse_handled:
    return
```

**Rationale:** The new name `ui_mouse_handled` more clearly indicates that this flag tracks whether UI elements have consumed mouse input, distinguishing it from general mouse handling logic.

Files to review: [GridTargetingSystem](../api/GridTargetingSystem/)

---

## 14) GridPositioner2D Position Utility Methods Removed

**Change:** Position conversion helper methods have been removed from [GridPositioner2D](../api/GridPositioner2D/) in favor of centralized utility functions in [GBPositioning2DUtils](../api/GBPositioning2DUtils/).

**Removed Methods:**
- Direct position conversion helpers (moved to [GBPositioning2DUtils](../api/GBPositioning2DUtils/))
- Internal positioning methods (use utility functions instead)

**Impact:** If your code directly called positioning helper methods on GridPositioner2D instances, migrate to the static utility functions.

### Standard Dependency Injection (No Change)

**Important:** `resolve_gb_dependencies(container)` is the **standard method** for dependency injection and remains fully supported. This is how [GBInjectorSystem](../api/GBInjectorSystem/) injects dependencies into Grid Building components.

```gdscript
# Standard DI pattern (fully supported, recommended)
func resolve_gb_dependencies(container: GBCompositionContainer) -> void:
    # Your dependency resolution logic
    pass
```

The [GBInjectorSystem](../api/GBInjectorSystem/) automatically calls `resolve_gb_dependencies()` on all nodes under its injection roots. This is the primary integration pattern and is **not deprecated**.

### Migration

**Position utilities (removed → use static utilities):**
```gdscript
# Removed: Direct calls to GridPositioner2D positioning helpers
# (These methods no longer exist on GridPositioner2D)

# Use instead: Static utility functions
var tile = GBPositioning2DUtils.get_tile_from_global_position(world_pos, target_map)
GBPositioning2DUtils.move_to_tile_center(positioner, tile, target_map)
var world_pos = GBPositioning2DUtils.convert_screen_to_world_position(screen_pos, viewport)
```

**Rationale:** 
- Utility functions follow DRY principles and provide a single source of truth
- Static utility methods are easier to test and maintain
- Reduces coupling between components

Files to review: [GridPositioner2D](../api/GridPositioner2D/), [GBPositioning2DUtils](../api/GBPositioning2DUtils/)

---

## 15) BuildingSettings.drag_multi_build Removed

**Change:** The `drag_multi_build` setting has been **completely removed** from [BuildingSettings](../api/BuildingSettings/). This setting is now obsolete with the new [DragManager](../api/DragManager/) component architecture.

**Architectural Change:**
- **Old approach (v4.x):** Enable/disable drag building via `BuildingSettings.drag_multi_build` boolean
- **New approach (v5.0.0):** Control drag building by adding/removing [DragManager](../api/DragManager/) component or setting its `process_mode`

**Why this changed:**
- [DragManager](../api/DragManager/) is now a **separate, optional component** that can be added to any scene
- Drag building functionality is decoupled from [BuildingSystem](../api/BuildingSystem/)
- Simpler architecture: presence of [DragManager](../api/DragManager/) node = drag building enabled

**Impact:** If you have code or settings referencing `drag_multi_build`, you must update to use the new component-based approach.

### Migration

**Before (v4.x):**
```gdscript
# Old approach: configure via settings
var building_settings: BuildingSettings = load("res://settings/building_settings.tres")
building_settings.drag_multi_build = true  # Enable drag building
```

**After (v5.0.0):**
```gdscript
# New approach: add/remove DragManager component in scene
# Option 1: Add DragManager to enable drag building
var drag_manager = DragManager.new()
add_child(drag_manager)  # Drag building is now active

# Option 2: Control via process_mode
drag_manager.process_mode = Node.PROCESS_MODE_INHERIT  # Enable
drag_manager.process_mode = Node.PROCESS_MODE_DISABLED  # Disable

# Option 3: Remove DragManager to disable completely
if drag_manager:
    drag_manager.queue_free()  # Drag building disabled
```

**Scene-based approach (recommended):**
```gdscript
# Add DragManager as a child of your gameplay scene in the editor
# Grid Building Systems/
#   BuildingSystem/
#   DragManager/  ← Add this node for drag building support
#   GridTargetingSystem/
```

**Resource file cleanup:**

Remove `drag_multi_build = true` lines from all `.tres` BuildingSettings resource files:
- `godot/demos/top_down/config/settings/td_building_settings.tres`
- `godot/demos/isometric/settings/isometric_building_settings.tres`
- `godot/demos/platformer/settings/platformer_building_settings.tres`
- Any custom BuildingSettings resources in your project

**Test file updates:**

If you have test code setting `drag_multi_build`, remove those lines - the tests should work with [DragManager](../api/DragManager/) component presence instead:

```gdscript
# Remove these lines from tests:
_container.get_settings().building.drag_multi_build = true  # ❌ No longer exists
_building_system._building_settings.drag_multi_build = true  # ❌ No longer exists

# Instead: ensure DragManager is present in test environment
var drag_manager = DragManager.new()
add_child(drag_manager)  # ✅ Drag building enabled for test
```

**Benefits of new approach:**
- **Clearer architecture**: Component presence = feature enabled
- **Better separation of concerns**: Drag logic lives in dedicated component
- **Runtime flexibility**: Add/remove drag support dynamically without settings
- **Easier testing**: Test drag behavior in isolation by testing DragManager directly

Files to review: [BuildingSettings](../api/BuildingSettings/), [DragManager](../api/DragManager/), [BuildingSystem](../api/BuildingSystem/)

---

## 16) BuildType Enum Parameter System (v5.0.0)

**Change:** Build operations now use a `BuildType` enum parameter instead of a boolean `dragging` flag to differentiate between build operation modes.

{{< gb-note type="info" title="Related to Section 15" >}}
This change complements the [DragManager separation](#15-buildingsettingsdrag_multi_build-removed) from section 15. While section 15 explains **how DragManager is now a separate component**, this section explains **how build type information flows through the system** when DragManager calls BuildingSystem.
{{< /gb-note >}}

**Architectural Change:**
- **Old approach:** [BuildActionData](../api/BuildActionData/) accepted `dragging: bool` parameter (always passed as `false`, breaking drag suppression)
- **New approach:** [BuildActionData](../api/BuildActionData/) accepts `build_type: GBEnums.BuildType` parameter with SINGLE, DRAG, and AREA values

**Why this changed:**
- Boolean flag was always `false` in BuildingSystem, breaking action log drag suppression
- Enum provides clearer semantic meaning (SINGLE vs DRAG vs AREA)
- Future-proofed for area building features (fence lines, walls)
- Enables proper differentiation throughout the system (action log, audio, analytics)

**Impact:** Breaking change to [BuildActionData](../api/BuildActionData/) constructor signature and related method signatures.

### BuildType Enum

```gdscript
enum BuildType {
    SINGLE,  ## Single click/confirmation build
    DRAG,    ## Continuous drag-building across multiple tiles
    AREA     ## Future: Build across a defined area (e.g., fence line from point A to B)
}
```

### Migration

**BuildActionData Constructor:**
```gdscript
# Before (v4.x):
var data = BuildActionData.new(placeable, report, false)  # Single build
var data = BuildActionData.new(placeable, report, true)   # Drag build (never actually used)

# After (v5.0.0):
var data = BuildActionData.new(placeable, report, GBEnums.BuildType.SINGLE)
var data = BuildActionData.new(placeable, report, GBEnums.BuildType.DRAG)
```

**BuildingSystem Methods:**
```gdscript
# Before (v4.x):
func try_build() -> PlacementReport
func report_built(p_report: PlacementReport) -> void
func report_failure(p_report: PlacementReport) -> void

# After (v5.0.0):
func try_build(p_build_type: GBEnums.BuildType = GBEnums.BuildType.SINGLE) -> PlacementReport
func report_built(p_report: PlacementReport, p_build_type: GBEnums.BuildType = GBEnums.BuildType.SINGLE) -> void
func report_failure(p_report: PlacementReport, p_build_type: GBEnums.BuildType = GBEnums.BuildType.SINGLE) -> void
```

**Parameter Flow:**
1. [DragManager](../api/DragManager/) → `building_system.try_build(GBEnums.BuildType.DRAG)`
2. [BuildingSystem](../api/BuildingSystem/) → `report_built(report, build_type)` or `report_failure(report, build_type)`
3. [BuildActionData](../api/BuildActionData/) → Stores `build_type` and emits through signals
4. [GBActionLog](../api/GBActionLog/) → Checks `build_type` to suppress non-SINGLE builds
5. **GBAudioInstancer** (demos) → Checks `build_type` to skip drag sounds and throttle failures

**Benefits:**
- ✅ Action log drag suppression now works correctly (`print_on_drag_build` setting)
- ✅ Audio failure sound throttling prevents spam during drag building
- ✅ Clearer code semantics (DRAG vs `true`, SINGLE vs `false`)
- ✅ Future-ready for AREA building (fence lines, walls)

**Backward Compatibility:**
Default parameters maintain backward compatibility for basic usage, but any code directly instantiating [BuildActionData](../api/BuildActionData/) or calling report methods must be updated.

Files to review: [BuildActionData](../api/BuildActionData/), [BuildingSystem](../api/BuildingSystem/), [DragManager](../api/DragManager/), [GBActionLog](../api/GBActionLog/)

---

## Summary of major breaking changes (5.0.0 → 5.1.0)

- **🎯 Smart Target Resolution:** [GridTargetingState](../api/GridTargetingState/) now automatically resolves logical targets from collision objects using metadata and Manipulatable components, instead of always using the collision object itself as the target.

The sections below expand this change with concrete before/after examples and migration steps.

---

## 1) Target Resolution Enhancement (v5.1.0)

**What changed**
The Grid Targeting system now intelligently resolves targets through collision objects rather than treating collision objects as direct targets. This enables more flexible scene hierarchies where collision shapes can be on child nodes while targeting parent objects.

**Impact**
- Collision objects detected by [TargetingShapeCast2D](../api/TargetingShapeCast2D/) are now resolved to logical target nodes
- Code that relied on `GridTargetingState.get_target()` returning the collision object itself may need updates
- Objects without resolution metadata continue to work as before (collision object = target)

**Migration guidance (example)**

Previously, collision objects were always used directly as targets:
```gdscript
# v5.0.x - collision object was always the target
func _on_target_changed(new_target: Node2D, _old: Node2D) -> void:
    if new_target is Area2D:
        # new_target was the collision Area2D
        show_building_info(new_target)
```

Now, collision objects are resolved to logical targets:
```gdscript
# v5.1.x - collision object is resolved through metadata/Manipulatable
func _on_target_changed(new_target: Node2D, _old: Node2D) -> void:
    if new_target is MyBuilding:  # Could be parent of collision Area2D
        # new_target is now the resolved logical target
        show_building_info(new_target)
```

**Resolution Strategies**

1. **Metadata Resolution** (recommended for custom objects):
```gdscript
# Set on collision object to target parent
collision_shape.set_meta("root_node", NodePath(".."))
```

2. **Manipulatable Component** (automatic for manipulatable objects):
```gdscript
# Manipulatable components are automatically detected
var manipulatable: Manipulatable = Manipulatable.new()
manipulatable.root = self  # This node becomes the target
collision_area.add_child(manipulatable)
```

**Benefits**
- ✅ More flexible scene hierarchies
- ✅ Collision shapes can be positioned independently of logical targets
- ✅ Backward compatible for objects without metadata
- ✅ Automatic resolution for Manipulatable objects

**Files to review**
- [GridTargetingState](../api/GridTargetingState/) - `set_collider()` now resolves targets
- [GBMetadataResolver](../api/GBMetadataResolver/) - New utility for target resolution
- [Manipulatable](../api/Manipulatable/) - Components automatically participate in resolution

---

## 17) Migration checklist (concrete)

For detailed step-by-step migration, see [Migration — v5.0.0](../migration/5-0-0/).

### Critical breaking changes (will cause errors)
- [ ] **Update BuildActionData instantiation** - Replace boolean third parameter with `GBEnums.BuildType.SINGLE` or `GBEnums.BuildType.DRAG`
- [ ] **Remove manual validation calls** - `validate_runtime_deferred()`, `_validate_after_injection()`, and `validate_runtime_configuration()` have been REMOVED. Delete these calls from your code.\n- [ ] **Remove message resource file references** - Delete any `.tres` files referencing `manipulation_messages.gd` or `gb_messages.gd`. Configure message strings directly in [ManipulationSettings](../api/ManipulationSettings/) and [ActionLogSettings](../api/ActionLogSettings/) exported properties instead.\n- [ ] **Update `mouse_handled` to `ui_mouse_handled`** - Property was renamed in [GridTargetingSystem](../api/GridTargetingSystem/)\n- [ ] **Remove `drag_multi_build` references** - This setting no longer exists. Control drag building by adding/removing [DragManager](../api/DragManager/) component instead. Remove `drag_multi_build = true` from all BuildingSettings `.tres` files.
- [ ] **Review target resolution logic** - Code using `GridTargetingState.get_target()` may now receive resolved targets instead of collision objects. Update logic that assumes targets are collision objects.

### Required migrations
- [ ] Save any existing exported settings or resource instances to disk as `.tres`/`.res` BEFORE UPGRADING. This prevents resources from disappearing when exported properties are consolidated into the [GBCompositionContainer](../api/GBCompositionContainer/) (or moved into the [GBConfig](../api/GBConfig/) resource) — an exported property that previously lived on a system or UI node may otherwise no longer exist after upgrade.
- [ ] Upgrade assets to Godot 4.4+
- [ ] Replace direct `*.new()` system instantiation by adding a [GBInjectorSystem](../api/GBInjectorSystem/) node to your gameplay scene and assigning a [GBCompositionContainer](../api/GBCompositionContainer/) resource (via the GBInjectorSystem exported property), or use a provided container template saved as a `.tres` resource
- [ ] Update calls to `GBOwnerContext.set_owner(...)` to pass a [GBOwner](../api/GBOwner/) instance
- [ ] Replace direct logger instantiation with the container-provided logger
- [ ] **Add target resolution metadata** - For custom objects with collision shapes on child nodes, add `"root_node"` metadata or Manipulatable components to ensure correct targeting
- [ ] Migrate any `TileMap` references to `TileMapLayer` where applicable

### Recommended updates (backwards compatible)
- [ ] Replace direct position conversion calls on GridPositioner2D with [GBPositioning2DUtils](../api/GBPositioning2DUtils/) static methods
- [ ] Review visibility logic if relying on `hide_on_handled` behavior with `enable_mouse_input = false`

### Validation
- [ ] Build and run your project - check console for any errors about missing methods/properties
- [ ] Verify dependency injection works (no manual validation calls needed)
- [ ] Test all game modes (build/move/demolish) to ensure proper functionality
- [ ] Check that indicators rotate/flip correctly with preview objects

---

## Where to get help

- Inspect demos under `godot/demos/*` for up-to-date integration examples using the composition container and injector systems.
- Discord support: see the channel listed in the plugin README.