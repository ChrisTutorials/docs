---
title: "Multi-Owner Orchestration Priorities (v6.0)"
description: "Living backlog for the GridBuilding multi-owner/session orchestration layer."
weight: 45
url: "/gridbuilding/v6.0-public/guides/multi-owner-orchestration-priorities/"
---

# Multi-Owner Orchestration Priorities (v6.0)

_Status: living document_

Scope: architecture that orchestrates **one BuildingSystem**, **one Manipulation system**, and **multiple owners/users + their UI/controllers** without exported node references, using **ServiceCompositionRoot + ServiceRegistry** and session/user scopes.

## Priority Backlog

1. **P1 – Session/User API definition**  
   Define the concrete API for session and user scopes: user handle/ID type, how user scope is retrieved, and what data/surfaces it exposes to systems and controllers.

2. **P2 – Godot roots (`SessionRoot` / `OwnerRoot`)**  
   Implement Godot nodes that represent a session and owners in the scene tree and hand out the correct scoped services (no exported refs).

3. **P3 – Systems contract update**  
   Ensure session-level systems (BuildingSystem, ManipulationSystemNode) accept owner handles and targeting data instead of reading player-specific nodes directly.

4. **P4 – Mode & selection routing**  
   Centralize mode, selection, and preview state in owner scopes and remove remaining direct ModeState/BuildingMode coupling where possible.

5. **P5 – Per-owner controllers & UI**  
   Define the standard pattern for owner input controllers and UI roots that resolve services via their OwnerRoot.

6. **P6 – Targeting integration**  
   Bind targeting/positioning nodes to owner scopes while sharing session-level targeting/grid systems.

7. **P7 – Single-owner bootstrap**  
   Provide a minimal GridBuildingCompositionRoot-style entry point for simple single-owner scenes that uses the same architecture.

8. **P8 – Two-owner demo + tests**  
   Create a reference scene and GoDotTest suite with two owners sharing one session and systems.

9. **P9 – Legacy bridge notes**  
   Document how CompositionContainer-based helpers can be hosted under the new roots without exported refs.


## P1 – Session/User API (draft)

Goal: a small, stable set of Core types that all higher layers use when talking about **who** is acting in a session.

### 1. User identity

- Introduce a strongly-typed user identifier in Core, e.g.:

  ```csharp
  // Core/Types/UserId.cs (conceptual)
  public readonly record struct UserId(Guid Value);
  ```

- Properties:
  - Stable within a session.
  - Comparable and usable as dictionary key.
  - Optionally paired with human-readable metadata via an owner registry/service (not baked into the ID type).

### 2. Session and user scopes (conceptual responsibilities)

- **Session scope (IGridBuildingSession)** – one per session:
  - Knows global world/grid rules and configuration.
  - Can resolve **user scopes** given a `UserId`.
  - Exposes access to shared services already registered in the ServiceRegistry (placement, manipulation, targeting, etc.).

- **User scope (IUserScope)** – one per `(session, user)` pair:
  - Holds per-user state:
    - Mode / build mode, selection & preview state, user queues.
    - References to user-specific targeting views, if needed.
  - Provides a place for per-user services (e.g. user-focused command queues or analytics).

> Note: For v6.0, we can implement these initially as lightweight wrappers over the existing ServiceRegistry + state objects, then evolve them as needed.

### 3. How systems receive user context

- Session-level systems (e.g. BuildingSystem, ManipulationSystemNode) should:
  - Take a `UserId` parameter on all entry points that represent a user action.
  - Use the session object (or a helper/service) to pull the **user scope** for that `UserId`.
  - Never read player-specific UI nodes directly.

- Conceptual API sketch (Godot side uses this via injected services). These
- now map directly to concrete Core interfaces `IPlacementCommands` and
- `IManipulationCommands`:

  ```csharp
  public interface IPlacementCommands
  {
      PlacementResult TryPlace(UserId user, Placeable placeable, Vector2 worldPosition);
      PlacementResult TryDemolish(UserId user, Vector2 worldPosition);
  }

  public interface IManipulationCommands
  {
      ManipulationResult TryMove(UserId user, Vector2I from, Vector2I to);
      ManipulationResult TryRotateLeft(UserId user, Vector2I origin);
      ManipulationResult TryRotateRight(UserId user, Vector2I origin);
      ManipulationResult TryFlipHorizontal(UserId user, Vector2I origin);
      ManipulationResult TryFlipVertical(UserId user, Vector2I origin);
  }
  ```

- UI/controllers per user:
  - Hold a `UserId` assigned during user creation.
  - On input, build a `TargetingSnapshot` from that user’s targeting node(s) and call the appropriate command interfaces with `(UserId, snapshot, ...)`.

### 4. Next actions for P1

- [ ] Decide final naming/location for `UserId` and the session/user scope interfaces in Core.  
- [ ] Align with existing services (`IModeService`, `IPlacementService`, `IManipulationService`) so that user-scoped state composes cleanly with them.  
- [ ] Validate that the API works for single-user scenes and scales to multiple users without ambiguous responsibilities.

