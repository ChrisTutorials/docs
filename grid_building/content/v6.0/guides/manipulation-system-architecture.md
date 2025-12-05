---
title: "ManipulationSystemNode Architecture (Session Orchestrator)"
description: "How ManipulationSystemNode bridges Core manipulation services with Godot and orchestrates manipulation for all Owners in a session."
weight: 46
url: "/gridbuilding/v6.0-public/guides/manipulation-system-architecture/"
---

# ManipulationSystemNode Architecture (Session Orchestrator)

`ManipulationSystemNode` is the **session-level Godot node** that bridges Core manipulation services (e.g. `IManipulationService`) with the Godot engine.

- There should be **exactly one `ManipulationSystemNode` per game session**.
- It coordinates manipulation actions (move, rotate, etc.) for **all Owners** in that session.
- Per-Owner intent/state is held in **Owner-scoped services** and Owner-specific controllers.

## 1. Lifetime and Scene Placement

Recommended scene pattern:

```text
GameRoot
  └─ SessionRoot
       └─ GridBuildingSessionRoot
            └─ BuildingSystem           (legacy, session-level)
            └─ ManipulationSystemNode   (session-level)
            └─ ... other GridBuilding nodes
```

- `ManipulationSystemNode` is created when a session scene loads and cleaned up when it unloads.
- It is **not** intended to be:
  - A global autoload across all sessions.
  - Duplicated per Owner.

## 2. Interaction with Core Services

At runtime, `ManipulationSystemNode`:

- Resolves `IManipulationService` from the **Service Registry**.
- Subscribes to Core events (`ManipulationStarted`, `ManipulationCompleted`, etc.).
- Converts Core `ManipulationState` into Godot-friendly `ManipulationData` and emits signals.
- Provides convenience methods for starting/updating/completing manipulations from Godot code.

## 3. Interaction with Owners

In a multi-Owner session:

- Each Owner has:
  - An Owner scope (state + services).
  - Per-Owner controller and targeting nodes (e.g. `TargetingShapeCast2D`).
- Controllers compute **what** a given Owner wants to manipulate, then call into the shared `ManipulationSystemNode` with that intent.

Conceptually:

```csharp
// Pseudo-code
var ownerScope = ownerContext.Scope;           // per-Owner
var manipulationSystem = sessionContext.ManipulationSystemNode; // session-level

if (manipulationSystem.CanStartManipulation(mode, origin))
{
    manipulationSystem.StartManipulationForOwner(ownerScope.OwnerId, mode, origin);
}
```

The `ownerId` parameter is part of the **design direction**: today it may simply delegate to the existing session-level methods, but it gives a clear place to attach Owner-specific logic later.

## 4. Usage Guidelines

- Do **not** create a separate `ManipulationSystemNode` per Owner.
- Keep `ManipulationSystemNode` focused on:
  - Bridging Core services and Godot signals.
  - Coordinating physics and transform helpers.
- Let per-Owner controllers/targets decide:
  - When to start/stop manipulations.
  - Which objects belong to which Owner.

This keeps the manipulation pipeline **centralized per session**, while still allowing multiple Owners to act independently through their own scopes and controllers.
