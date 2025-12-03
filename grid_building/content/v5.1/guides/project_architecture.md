---
title: Project Architecture
description: Project Architecture documentation for the Grid Building system
---


---



The plugin architecture is layered to keep systems modular and testable while supporting flexible game integration.

## Layer Overview

| Layer                   | Contents                                                              | Notes                                                 |
| ----------------------- | --------------------------------------------------------------------- | ----------------------------------------------------- |
| Resource Configuration  | [GBConfig](../api/GBConfig/), [GBSettings](../api/GBSettings/), [GBTemplates](../api/GBTemplates/), [GBMessages](../api/GBMessages/), rule resources | Editable in inspector; serialized with project        |
| Composition & Injection | [GBCompositionContainer](../api/GBCompositionContainer/), [GBInjectorSystem](../api/GBInjectorSystem/)                          | Provides dependency injection & lazy construction         |
| Core Systems            | Placement, Targeting, Building, Manipulation, Validation, Indicator   | Each focuses on a single domain concern               |
| State Containers        | [GBStates](../api/GBStates/) (mode, targeting, building, manipulation)                  | Shared by injected nodes; supports multi-context      |
| Contexts                | [GBContexts](../api/GBContexts/) (placement, systems, owner, level)                       | Encapsulate environment dependencies                  |
| UI & Interaction        | Action bar, selection lists, info displays                            | Driven by states & actions resources                  |
| Testing Utilities       | Factories, reports, test setups                                       | Facilitate GdUnit coverage & deterministic assertions |

## Dependency Injection Model

Instead of global singletons, systems resolve dependencies from the injected composition container. Benefits:

- Multitenancy (multiple players/levels)
- Clear test seams (swap in a fresh container)
- Lazy provisioning (logger/settings only built when required)

Nodes opt‑in via `resolve_gb_dependencies` pattern. See the [Dependency Injection](/v5-0/guides/dependency_injection/) document.

## 🎯 GridTargetingState: Single Source of Truth

**v5.1.0 Architectural Principle**: [GridTargetingState](../api/GridTargetingState/) is the authoritative, centralized source for what is actively targeted in the entire Grid Building System.

**What it manages:**
- **BUILD mode**: The placement preview being positioned
- **MOVE mode**: The manipulation copy during object manipulation
- **Normal gameplay**: The node detected by TargetingShapeCast2D

**Why this matters:**
- **Consistency**: All systems query the same targeting source
- **Sync issues eliminated**: No more state divergence between different components
- **Simpler integrations**: Third-party systems can rely on a single API for targeting info
- **Clear responsibilities**: Other systems (ManipulationState, BuildingState) focus on their domains; targeting is GridTargetingState's job

**v5.1.0 API Improvement**: [ManipulationData](../api/ManipulationData/) was refactored to support this principle:
- Renamed `target` → `move_copy` to clearly distinguish the manipulation preview from GridTargetingState's target
- Removed `ManipulationState.active_target_node` (redundant with GridTargetingState)
- Added safe helper methods: `get_move_copy_root()` and `get_active_root()`

This eliminates semantic confusion and reinforces GridTargetingState as the single source of truth for targeting.

See [GridTargetingState API](../api/GridTargetingState/) for detailed targeting methods, [Grid Targeting Guide](./grid_targeting/) for architectural details, and [Breaking Changes - v5.1.0](./breaking-changes/#v510-breaking-changes---manipulationdata-api-improvements) for migration guidance.

## How the Systems Work Together

Instead of a complex diagram, let's walk through how the Grid Building system works in simple steps:

### **The Basic Flow:**

1. **You pick something to build**: Click a placeable in the UI
2. **BuildingSystem wakes up**: `enter_build_mode()` gets called with your choice  
3. **GridPositioner2D handles targeting**: Processes mouse/keyboard input to track where you're pointing on the grid
4. **TargetingShapeCast2D detects collisions**: Updates collision state based on GridPositioner2D position
5. **IndicatorManager provides live feedback**: Sets up indicators that follow your cursor and show placement validity
6. **PlacementValidator checks rules**: Runs tile-based rules as you move the cursor around
7. **IndicatorManager shows visual feedback**: Colors/animations appear to show valid/invalid spots in real-time
8. **ManipulationSystem (optional)**: If enabled, lets you move/rotate the preview before placing
9. **You confirm placement**: `BuildingSystem.try_build()` runs full validation (including non-tile rules)
10. **Object gets created**: If everything checks out, your building appears in the world as a PlaceableInstance
11. **ManipulationSystem (post-placement)**: Now you can select, move, rotate, or delete the placed object

### **v5.0.0 Architectural Improvements:**

**Clean System Boundaries:**
```
GridPositioner2D          ← Pure input handling & positioning
├── TargetingShapeCast2D  ← Dedicated collision detection  
└── ManipulationParent    ← Transform handling container
    ├── IndicatorManager  ← Visual feedback & validation manager
    │   ├── RuleCheckIndicator ← Individual rule indicators
    │   └── RuleCheckIndicator ← Individual rule indicators  
    └── PreviewObject     ← Object being manipulated
```

**Benefits:**
- **Unit testable components** - Each system tested in isolation
- **Composable collision strategies** - Swap targeting implementations
- **Eliminated race conditions** - No hidden coupling between systems
- **Reliable test execution** - Consistent behavior in all environments

### **Key Points to Remember:**

- **BuildingSystem** orchestrates the entire build workflow - from mode entry to final placement
- **GridPositioner2D** handles all input processing and grid coordinate conversion
- **IndicatorManager** manages the visual feedback system (creates and parents rule indicators)
- **ManipulationParent** serves as transform container for preview objects and indicators
- **ManipulationSystem** has two jobs: preview adjustment (if enabled) and post-placement editing
- **Validation happens twice**: quick tile rules during preview, full rule validation on confirmation
- **Each component has a single responsibility** but they work together seamlessly

## Key Data Flows

1. **UI Selection** → User selects placeable from UI → `BuildingSystem.enter_build_mode(placeable)` is called
2. **Build Mode Initialization**: [BuildingSystem](../api/BuildingSystem/) prepares preview with selected placeable
3. **Input Processing**: [GridPositioner2D](../api/GridPositioner2D/) processes mouse/keyboard input and converts to grid coordinates
4. **Collision Detection**: [TargetingShapeCast2D](../api/TargetingShapeCast2D/) updates collision state based on positioner position
5. **Live Validation**: [PlacementValidator](../api/PlacementValidator/) runs tile rules, [IndicatorManager](../api/IndicatorManager/) shows live feedback via rule indicators
6. **Preview Manipulation**: If enabled in placeable settings, [ManipulationSystem](../api/ManipulationSystem/) can move/rotate preview instances during placement
7. **Confirmation**: User confirms placement, `BuildingSystem.try_build()` runs full rule validation (including non-tile rules)
8. **Instantiation**: If valid, [BuildingSystem](../api/BuildingSystem/) spawns [PlaceableInstance](../api/PlaceableInstance/) with metadata for manipulation & save/load
9. **Post-Placement**: [ManipulationSystem](../api/ManipulationSystem/) handles move/rotate/delete operations on placed instances

## Save / Load Considerations

[PlaceableInstance](../api/PlaceableInstance/) holds references back to originating [Placeable](../api/Placeable/) enabling reconstruction. Systems should avoid storing raw scene node references across sessions; rely on IDs or resource paths.

## Logging & Debug Controls

[GBDebugSettings](../api/GBDebugSettings/) gates verbosity. High verbosity surfaces:

- Injection operations
- Indicator setup summaries
- Rule validation traces (future extension)

{/* Testing Strategy moved to internal/testing_strategy.md */}

## Extensibility Guidelines

- Favor composition (create a new rule resource) over conditionals inside existing rules.
- Keep resource scripts lean; complex logic belongs in systems.
- Add new UI affordances by observing states rather than polling systems directly.

## Planned Evolutions

- Cross-context synchronization primitives (multiplayer scenarios).
- Performance profiling hooks (duration_ms in reports).
- Rule documentation tooling.

______________________________________________________________________

### Core Architecture References

- [Context & State](/v5-0/guides/context_and_state/) – Distinguishes long‑lived context objects from frequently mutating state containers; essential for understanding rule evaluation purity.
- [Placement Chain](/v5-0/guides/placement_chain/) – End‑to‑end flow from input to instantiated object.
- [Dependency Injection](/v5-0/guides/dependency_injection/) – Container pattern enabling multi‑tenant/testable setup.
- [Placement Rules Pipeline](/v5-0/guides/placement_rules/) – Validation composition & indicator generation.

### High-Level System Architecture

**Core Components:**
- **Configuration & Templates**: GBConfig, GBTemplates, GBMessages
- **Composition**: GBCompositionContainer, GBInjectorSystem  
- **Core Systems**: BuildingSystem, PlacementValidator, IndicatorManager, GridTargetingSystem, ManipulationSystem
- **State Management**: [ModeState](../api/ModeState/), [BuildingState](../api/BuildingState/), [ManipulationState](../api/ManipulationState/), [GridTargetingState](../api/GridTargetingState/)
- **UI**: Selection/Action UI

**Data Flow:**
- UI → BuildingSystem → PlacementValidator → IndicatorManager
- GridPositioner2D → TargetingShapeCast2D → GridTargetingState
- IndicatorManager → ManipulationParent (parent/child relationship)
- Configuration → CompositionContainer → InjectorSystem → All Systems
- State components manage respective system states (targeting, building, manipulation)
- ManipulationSystem handles preview objects and post-placement instances

Last updated: 2025-08-20