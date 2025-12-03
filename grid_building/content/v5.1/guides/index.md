---
title: Plugin Overview
description: Flexible, data-driven workflow for placing, validating, and manipulating objects on a 2D grid in Godot 4.x
---


---

The Grid Building Plugin provides a flexible, data‑driven workflow for placing, validating, and manipulating objects on a 2D grid (orthogonal, isometric, or custom tile coordinate logic) in Godot 4.x.

{{< gb-note type="info" title="Minimum Godot version" >}}
v5.0.0 targets Godot 4.4+ as the minimum supported version.
{{< /gb-note >}}

## 🎯 Quick Start Entry Points

If you're new to Grid Building, start with these key classes:

### Core Resource Classes (Extend Godot [Resource](https://docs.godotengine.org/en/stable/classes/class_resource.html))
- **[GBCompositionContainer](../api/GBCompositionContainer/)** - Dependency injection root
- **[GBConfig](../api/GBConfig/)** - Main configuration hub, your primary entry point for settings, templates, etc that are injected into systems, UI, and other nodes that depend on the grid building plugin.
- **[Placeable](../api/Placeable/)** - Defines what can be built
- **[PlacementRule](../api/PlacementRule/)** - Base class for validation logic
- **[TileCheckRule](../api/TileCheckRule/)** - Spatial validation rules used by [RuleCheckIndicator](../api/RuleCheckIndicator/) to mark tiles as valid/invalid when they update each physics frame.

### Core Node Classes (Extend Godot [Node](https://docs.godotengine.org/en/stable/classes/class_node.html))
- **[BuildingSystem](../api/BuildingSystem/)** - Main building workflow controller
- **[ManipulationSystem](../api/ManipulationSystem/)** - Object manipulation and movement
- **[GridTargetingSystem](../api/GridTargetingSystem/)** - Cursor-to-grid conversion, snapping, and targeting state
- **[IndicatorManager](../api/IndicatorManager/)** - Visual feedback system

## Core Goals

- Fast iteration: add new placeable object types with minimal boilerplate.
- Strong validation model: prevent invalid placements via configurable rules.
- Visual clarity: real‑time indicators show why a placement is valid/invalid.
- Extensibility: systems loosely coupled through dependency injection and contexts.
- Multi‑context readiness: support multiple players/world instances via composition containers.

## Major Enhancements in v5.0.0

### 🏗️ **Architectural Overhaul**
- **Dependency Injection System**: Complete rewrite using [GBCompositionContainer](../api/GBCompositionContainer/) and [GBInjectorSystem](../api/GBInjectorSystem/)
- **Unified Configuration**: All settings consolidated in [GBConfig](../api/GBConfig/) resource
- **Godot 4.4+ Support**: Leverages typed data structures introduced in 4.4 for better performance

### 🔧 **System Improvements**
- **🆕 Automatic Validation**: [GBInjectorSystem](../api/GBInjectorSystem/) now validates configuration automatically after dependency injection - **no manual validation calls required!**
- **Issue Reporting & Validation Flow**: Use `get_runtime_issues()` at runtime and `get_editor_issues()` in the editor to collect issues. `validate()` methods return `bool` and delegate messaging to [GBLogger](../api/GBLogger/) (typically warnings). Implementations usually call `get_runtime_issues()`, log any items via the logger, and return `true` only when the issues list is empty. `validate()` never returns `Array[String]`.
- **Better Debugging**: [GBDebugSettings](../api/GBDebugSettings/) resource for centralized debug control
- **Improved UI**: Separated clear/setup tabs, better icon scaling
- **Performance Optimizations**: Reduced allocations, better caching, faster validation

### 📚 **Documentation Enhancements**
- **Process Flow Documentation**: Detailed ordered sequences for system interactions
- **Comprehensive Migration Guide**: Step-by-step upgrade path from 4.x
- **Enhanced API Documentation**: Code examples and usage patterns
- **Version Comparison Tools**: Side-by-side feature comparison

## 🚀 **Migration to v5.0.0**

**Upgrading from v4.x?** Start with our comprehensive **[Migration Guide](./migration/)**:
- ✅ **Step-by-step checklist** with code examples
- 🔧 **Breaking changes reference** with before/after comparisons  
- 🏗️ **Dependency injection setup** guide
- 📦 **Configuration consolidation** walkthrough
- 🛠️ **Troubleshooting tips** for common issues

The migration maintains compatibility for placeable resources while introducing powerful new architecture patterns.

## Primary Systems

| System                         | Purpose                                                             | Key Class | v5.0.0 Enhancements |
| ------------------------------ | ------------------------------------------------------------------- | --------- | ------------------- |
| [IndicatorManager](../api/IndicatorManager/) | Orchestrates validation + indicator generation | Node-based entry point | Enhanced validation reporting |
| [PlacementValidator](../api/PlacementValidator/) | Combines & executes placement rules | Validation engine | Array[String] error details |
| [IndicatorManager](../api/IndicatorManager/) | Builds rule check indicators & reports diagnostics | Visual feedback system | Better debug support |
| [BuildingSystem](../api/BuildingSystem/) | High-level interaction state & user actions | Main building node | Dependency injection |
| [ManipulationSystem](../api/ManipulationSystem/) | Move / rotate / flip / demolish placed items | Object manipulation | Enhanced mode support |
| [GridTargetingSystem](../api/GridTargetingSystem/) | Tracks cursor → grid conversion & snapping | Grid positioning | Improved responsiveness |
| [GBInjectorSystem](../api/GBInjectorSystem/) | Auto dependency wiring + automatic validation | Dependency injection | **New in v5.0.0** |

## Data & Configuration Resources

The plugin relies on exported resources to decouple content from logic:

- [GBCompositionContainer](../api/GBCompositionContainer/) – DI root, holds references to config, systems, contexts.
- [GBConfig](../api/GBConfig/) – top-level composition root (references settings, actions, templates, messages, etc.).
- [GBSettings](../api/GBSettings/) → [GBVisualSettings](../api/GBVisualSettings/), [ManipulationSettings](../api/ManipulationSettings/) (includes message strings), [ActionLogSettings](../api/ActionLogSettings/) (includes display messages), [GBDebugSettings](../api/GBDebugSettings/).
- [GBTemplates](../api/GBTemplates/) – PackedScene references for indicators, previews, UI, etc.
- Rule Resources ([PlacementRule](../api/PlacementRule/), [TileCheckRule](../api/TileCheckRule/), custom derived rules) – declarative validation units.

All of these are surfaced through [GBCompositionContainer](../api/GBCompositionContainer/) accessor methods, ensuring a stable injection contract.

## Runtime Flow (High Level)

1. Enter build mode via UI on the [BuildingSystem](../api/BuildingSystem/). This creates a preview object which becomes the current target.
1. [GridTargetingState](../api/GridTargetingState/) updates the cursor→grid position every frame; the preview snaps to the active grid.
1. The [IndicatorManager](../api/IndicatorManager/) orchestrates validation by combining global/placeable/contextual rules and delegating rule evaluation to the [PlacementValidator](../api/PlacementValidator/).
1. As part of indicator generation, the [IndicatorService](../api/IndicatorService/) creates a [RuleCheckIndicator](../api/RuleCheckIndicator/) for each [TileCheckRule](../api/TileCheckRule/) and targets its tile(s). On each physics process, these indicators refresh their valid status (the tile spaces are probed via ShapeCast2D nodes).
1. Non‑tile rules (regular [PlacementRule](../api/PlacementRule/)) validate non‑collision constraints (e.g., resource requirements via [GBOwnerContext](../api/GBOwnerContext/)).
1. When the player confirms the build action, a final validation runs: all tile indicators must be valid and all placement rules must pass for the placement to succeed. If successful, the [BuildingSystem](../api/BuildingSystem/) instantiates the committed object (typically from a [Placeable](../api/Placeable/) template).
1. After placement, the [ManipulationSystem](../api/ManipulationSystem/) allows move/rotate/flip/demolish operations while continuing to respect rules.

For a step-by-step breakdown see [Building System Process](./building_system_process/).

## Dependency Injection

Nodes opt‑in by implementing:

```gdscript
func resolve_gb_dependencies(p_config: GBCompositionContainer) -> void:
    # Acquire only what is needed
    _logger = p_config.get_logger()
    _targeting_state = p_config.get_targeting_state()
```

You can also extend from various base classes like [GBNode](../api/GBNode/) or [GBSystem](../api/GBSystem/) which implement this method and provide common injected properties. 
[GBInjectable](../api/GBInjectable/) is a RefCounted base class variant that adds the resolve_gb_dependencies method. However only nodes can be auto-injected by the [GBInjectorSystem](../api/GBInjectorSystem/) at runtime.
Other objects like [GBInjectable](../api/GBInjectable/) or [Resource](https://docs.godotengine.org/en/stable/classes/class_resource.html) subclasses must be injected manually via constructor parameters or property setters.
The resolve_gb_dependencies method on GBInjectable is not called automatically but serves to keep API consistency. Eventually base classes will use abstract methods to enforce required methods but this is not yet implemented
to keep compatability with 4.4.x. Abstract base classes and methods is a Godot 4.5 feature.

This keeps most scene scripts lean, avoiding manual node path resolution.

See the dedicated [Dependency Injection](/v5-0/guides/dependency_injection/) page.

## Indicators & Validation

Validation is rule‑centric. Each [PlacementRule](../api/PlacementRule/) can:

- Filter tiles
- Test collisions / constraints
- Provide custom failure reasons

Tile‑level rules (subclasses of [TileCheckRule](../api/TileCheckRule/)) produce indicators; non‑tile rules produce logical gating results only.

[IndicatorSetupReport](../api/IndicatorSetupReport/) supplies a diagnostic snapshot (counts, mapped positions, owner shapes) for debugging & tests.

{{< gb-note type="info" title="Validation return type" >}}
`validate()` implementations return `bool` (success/failure) and do not return `Array[String]`. They typically call `get_runtime_issues()`/`get_editor_issues()`, log any items through [GBLogger](../api/GBLogger/), and consider validation successful when the issues list is empty.
{{< /gb-note >}}

## Extending the Plugin

For comprehensive game-specific feature implementation, see **[Extending the Grid Building Plugin](./extending-plugin/)** which covers:

- **Building Variants**: Multiple visual/functional variants with UI selection
- **Quantity Limits**: Maximum building counts with unlock progression
- **Building Upgrades**: Scene replacement with state transfer
- **Unlockable Recipes**: Dynamic building availability based on game progression
- **Integration Patterns**: Resource management, save/load, and best practices

### Basic Extension (Plugin Features)

Add new placeable logic by:

1. Creating a new [Placeable](../api/Placeable/) resource referencing display & behavior settings.
1. Adding any custom [PlacementRule](../api/PlacementRule/) resources to its rule list. These evaluate solely for that placeable unless saved and shared to other [Placeable](../api/Placeable/)s. Consider saving [PlacementRule](../api/PlacementRule/) resources as `.tres` files in your project for reuse.
1. Optionally implementing a specialized indicator scene if visual differentiation is needed.

Add new validation by subclassing [PlacementRule](../api/PlacementRule/) or [TileCheckRule](../api/TileCheckRule/) and ensuring your rule:

- Exposes exported properties for tuning.
- Implements a deterministic `validate()` / tile filtering contract.

## Debugging & Logging

[GBLogger](../api/GBLogger/) routes messages according to `GBDebugSettings.level` (ERROR, WARNING, DEBUG, VERBOSE). Verbose logs include injector traces and indicator setup summaries—enable during integration, disable for production builds.

## Testing Support

Grid Building 5.0.0 includes **1540 tests passing at 100%** (1410 plugin tests + 130 demo/misc tests), providing comprehensive validation coverage.

GdUnit test suites cover:

- Placement rule combinations
- Indicator mapping correctness
- Manipulation flows
- Integration workflows (complex build scenarios)
- Demo scene structure and user workflows

Factories (e.g., `GodotTestFactory` for core helpers or `EnvironmentTestFactory` / `PlaceableTestFactory` for plugin-aware environments) create injectors + containers quickly, while reports (like [IndicatorSetupReport](../api/IndicatorSetupReport/)) augment assertion contexts.

Additionally, the development project includes premade testing environments (scenes) to spin up common setups quickly. These scenes establish combinations of core nodes such as [GBSystem](../api/GBSystem/) nodes, the positioner stack, [GBLevelContext](../api/GBLevelContext/), and [GBOwner](../api/GBOwner/), so you can run focused tests without manual scene assembly.

______________________________________________________________________

Support / Purchase Hub: **[Linktree – All Grid Builder Links](https://linktr.ee/gridbuilder)**