---
title: "Service-Based Architecture"
description: "Understanding the Core C# Service-Based Architecture of GridBuilding v5.1"
weight: 20
menu:
  v5_1_main:
    parent: "guides"
    weight: 20
---


GridBuilding v5.1 introduces a robust **Service-Based Architecture** implemented in pure C#. This architecture separates data (State), logic (Services), and engine integration (Godot Layers) to provide a testable, maintainable, and performant foundation.

## 🎯 Core Design Pattern

The architecture follows a strict unidirectional data flow pattern:

```text
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Godot Layer   │    │  Service Layer  │    │   State Layer   │
│                 │    │                 │    │                 │
│ User Input      │───▶│ InputService   │───▶│ UserState       │
│ (Mouse/Key)     │    │                 │    │                 │
│                 │    │                 │    │                 │
│ UI Updates      │◀───│ BuildingEvents │◀───│ BuildingState   │
│ (Visuals)       │    │                 │    │                 │
│                 │    │                 │    │                 │
│ Godot Nodes     │───▶│ BuildingService│───▶│ BuildingState   │
│ (Scene/Nodes)   │    │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Key Components

1.  **State Layer (Pure Data)**
    *   Contains only data and data-manipulation methods.
    *   Serializable and completely decoupled from the game engine.
    *   *Examples:* `BuildingState`, `UserState`, `GridState`.

2.  **Service Layer (Business Logic)**
    *   Handles all game logic and rules.
    *   Dispatches events when state changes.
    *   Accepts commands from the Engine Layer.
    *   *Examples:* `BuildingService`, `InputService`, `ValidationService`.

3.  **Engine Layer (Integration)**
    *   Handles user input, rendering, and scene management.
    *   Calls Services to perform actions.
    *   Listens to Service events to update the view.
    *   *Examples:* `BuildingSystem (Node)`, `GridVisualizer`.

## 🔄 Communication Flow

1.  **Godot → Service**: The engine calls methods on services (e.g., `BuildingService.SelectPlaceable()`).
2.  **Service → State**: The service updates the state (e.g., sets the current placeable).
3.  **Service → Godot**: The service fires an event (e.g., `OnPlaceableSelected`).
4.  **Godot Updates**: The engine listens to the event and updates the UI or visuals.

**Crucially, the Engine Layer never modifies the State directly.**

## 📂 System Structure

The Core logic is organized by **Systems**, reflecting the domain model of grid building:

```text
Core/
├── Systems/
│   ├── Building/              # Building orchestration
│   ├── Collision/             # Collision rules and detection
│   ├── Grid/                  # Grid math and management
│   ├── Input/                 # Input handling
│   ├── Manipulation/          # Moving/Rotating objects
│   ├── Placement/             # Placement validation
│   ├── State/                 # State containers
│   └── Validation/            # Rule validation logic
```

### Service Interfaces

All interaction happens through interfaces, allowing for easy mocking and testing:

*   `IBuildingService`: Manage build mode and placement.
*   `IManipulationService`: Handle object transformations.
*   `IInputService`: Process input commands.
*   `IValidationService`: Check placement rules.

## 🚀 Benefits for Developers

*   **Testability**: Logic can be tested without running Godot.
*   **Stability**: Strict separation prevents "spaghetti code" state mutations.
*   **Performance**: Pure C# logic runs independently of the engine's node overhead.
