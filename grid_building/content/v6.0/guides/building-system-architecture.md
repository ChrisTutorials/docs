---
title: "BuildingSystem Architecture (Legacy Session Orchestrator)"
description: "How the legacy BuildingSystem node behaves as a session-level orchestrator in v6.x and how it relates to Owner-scoped services."
weight: 45
url: "/gridbuilding/v6.0-public/guides/building-system-architecture/"
---

> **Note:** The v6.0 documentation tracks the in-progress **Grid Placement 6.0 (C#)** line.
> It is an internal roadmap/preview and should not be treated as a promised public release or timeline.
> The current GDScript release line is **v5.1**.

# BuildingSystem Architecture (Legacy Session Orchestrator)

> **Status:** This document describes the legacy `BuildingSystem` node in the context of the new v6.x Owner-based architecture. New code should prefer `PlacementSystem` + `IPlacementService`, but some projects may still use `BuildingSystem` as a session-level orchestrator.

## 1. Role of BuildingSystem in v6.x

`BuildingSystem` is a Godot `Node` that historically owned building logic directly. In v6.x:

- It is treated as a **session-level orchestrator** when present.
- There should be **exactly one `BuildingSystem` node per game session**.
- It coordinates building operations for **all Owners** (players, AI, environment) in that session.
- Per-Owner state (selection, preview, commands) lives in **Owner-scoped services**, not inside the node.

For new development, prefer using the **Placement System + Core services** documented in `placement-system-architecture.md`. `BuildingSystem` exists primarily for backwards compatibility and transitional setups.

## 2. Lifetime and Scene Placement

- `BuildingSystem` is **session-scoped**:
  - Created when a session scene is loaded.
  - Destroyed when that session ends/unloads.
- Recommended scene pattern:

```text
GameRoot
  └─ SessionRoot
       └─ GridBuildingSessionRoot
            └─ BuildingSystem   (one per session)
            └─ ManipulationSystemNode (one per session)
            └─ ... other GridBuilding nodes
```

Avoid placing `BuildingSystem` as:

- A **project-wide autoload** that persists across sessions.
- A **per-Owner node** (e.g., one BuildingSystem per player); instead, Owners call into the single session-level system.

## 3. Interaction with Owners

In the Owner-based architecture:

- Each Owner has an **Owner scope** that holds:
  - Selection state
  - Preview/placement intent
  - Input/command state
- UI/controllers for each Owner resolve the session’s `BuildingSystem` and issue commands on behalf of that Owner.

Conceptually, calls look like:

```csharp
// Pseudo-code
var ownerScope = ownerContext.Scope; // per-Owner services
var buildingSystem = sessionContext.BuildingSystem; // session-level

// Owner issues a build action
buildingSystem.PlaceBuildingForOwner(ownerScope.OwnerId, gridPosition, placeableType);
```

In current v6.x code, the `ownerId` parameter may still be a **design placeholder**; the important part is that there is **one system per session**, and higher layers treat calls as Owner-specific.

## 4. Migration Guidance

- Prefer using `PlacementSystem` + `IPlacementService` for new functionality.
- When you must use `BuildingSystem`:
  - Ensure there is only **one instance per session**.
  - Route per-Owner decisions (what to place, where, for whom) through Owner-scoped services and pass the resulting commands into `BuildingSystem`.

Over time, projects should migrate away from `BuildingSystem` to the newer placement architecture while keeping the **session-level orchestrator** concept intact.
