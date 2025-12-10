---
title: "Quick Start: Game-Owned UserId & Multi-Owner Orchestrators"
description: "How to wire GridBuilding v6.0 into your game using a game-owned UserId and shared Building/Manipulation systems."
weight: 42
url: "/gridbuilding/v6.0-public/guides/userid-quickstart/"
---

# Quick Start: Game-Owned UserId & Multi-Owner Orchestrators

This guide shows how to hook the GridBuilding v6.0 architecture into **your game** using a
**game-owned `UserId`** and **shared session-level systems**:

- One **Building/Placement system** for the whole game session.
- One **Manipulation system** (`ManipulationSystemNode`) for the whole session.
- One **targeting node per user** (e.g. `TargetingShapeCast2D` for each camera/player).
- Game code owns `UserId` and passes it into command facades and UI.

It is forward-looking: some details may still be under active development in v6.x, but the
overall shape is stable and matches the dependency-resolution and multi-owner guides.

---

## 1. Architecture in One Minute

At runtime, a typical scene looks like this:

- **Session-level orchestrators (one each per game session):**
  - `BuildingSystem` / placement pipeline
  - `ManipulationSystemNode`
  - Grid/targeting services registered through `ServiceCompositionRoot`
- **Per-user / per-owner components (one set per user):**
  - A targeting node such as `TargetingShapeCast2D` aligned with that user’s camera/view.
  - Input/controller script that turns input + targeting into GridBuilding commands.
  - UI elements (HUD, target info, action log) initialized **for that user**.
- **Game-owned identity:**
  - Your game defines one `UserId` per player/owner.
  - All GridBuilding commands and user-aware UI take that `UserId` as the first argument.

The Core APIs that surface this are:

- `IPlacementCommands.TryPlace(UserId userId, Placeable placeable, Vector2 worldPosition)`
- `IPlacementCommands.TryDemolish(UserId userId, Vector2 worldPosition)`
- `IManipulationCommands.TryMove(UserId userId, Vector2I from, Vector2I to)`
- `IManipulationCommands.TryRotateLeft/Right(UserId userId, Vector2I origin)`
- `IManipulationCommands.TryFlipHorizontal/Vertical(UserId userId, Vector2I origin)`

---

## 2. Single-User Quick Start

Use this when you are prototyping or have only **one local player**.

### 2.1 Scene wiring

1. **Add `ServiceCompositionRoot`** to your main scene.
   - This node builds the **ServiceRegistry** and registers:
     - `IPlacementService`, `IManipulationService`, `IGridTargetingService`, etc.
     - `IPlacementCommands`, `IManipulationCommands` (high-level facades).
2. **Add the session systems:**
   - One `BuildingSystem` (or placement system node) for the scene.
   - One `ManipulationSystemNode` for the scene.
3. **Add the per-user targeting node:**
   - For a single user, add one `TargetingShapeCast2D` (or equivalent targeting script)
     aligned with that user’s camera or cursor.
4. **Add per-user HUD (optional but recommended):**
   - `TargetInformer` to show what is targeted.
   - `ActionLog` to show recent building/manipulation actions.

### 2.2 Game-owned `UserId` for the local player

In your **game code** (not the plugin), create a `UserId` for the local player.

Conceptually:

- You decide what a “user” means (player slot, account, peer, etc.).
- You create a `UserId` value that represents that user for GridBuilding.
- You keep that `UserId` alongside your player/session data.

> The exact construction of `UserId` is left to your game code. Treat `UserId` as a
> strongly-typed key that your game owns and the plugin just consumes.

### 2.3 Controller: converting input + targeting into commands

Create a small controller script (per user, or just one for the single-user case) that:

1. Resolves command facades from the `ServiceRegistry`:
   - `var placementCommands = ServiceCompositionRoot.GetGlobalService<IPlacementCommands>();`
   - `var manipulationCommands = ServiceCompositionRoot.GetGlobalService<IManipulationCommands>();`
2. Knows the `UserId` for this controller.
3. On input events and targeting updates:
   - Reads the current grid position from the user’s `TargetingShapeCast2D`.
   - Calls the command surfaces with `(userId, ...)`.

Examples of the flows you’ll implement in that script:

- **Place:**
  - Input: build button pressed while targeting a valid tile.
  - Controller: `placementCommands.TryPlace(userId, selectedPlaceable, worldPosition);`
- **Demolish:**
  - Input: demolish button pressed on a tile.
  - Controller: `placementCommands.TryDemolish(userId, worldPosition);`
- **Manipulate (move/rotate/flip):**
  - Input: manipulation key pressed with an active selection.
  - Controller calls the appropriate `IManipulationCommands` method for this `userId`.

### 2.4 HUD: binding TargetInformer and ActionLog to the user

If you use the v6 HUD components:

- `TargetInformer` and `ActionLog` both expose `InitializeForUser(UserId userId, ...)` helpers.
- During your scene/bootstrap code, after resolving the required Core state/services, call:
  - `targetInformer.InitializeForUser(userId, buildingState, manipulationState, targetingState, modeState, settings, modeService);`
  - `actionLog.InitializeForUser(userId, buildingState, manipulationState, modeState, actions, actionLogSettings, debugSettings, logger);`

This ensures the HUD is clearly bound to “the user this controller represents”, matching
how commands are issued.

---

## 3. Multi-User / Multiplayer Sketch

As your game grows, you will typically have:

- One **session-level** placement system and one `ManipulationSystemNode` per session.
- One **targeting node per user** (e.g. one `TargetingShapeCast2D` per camera/player).
- One **controller + HUD per user**, each with its own `UserId`.

### 3.1 Game-owned session and owner model

On the game side, introduce:

- A per-user/session object (e.g. `PlayerSession` / `GameUserSession`) storing:
  - Engine/network identifiers (controller index, peer ID, account ID, etc.).
  - The corresponding GridBuilding `UserId`.
- A small manager (e.g. `PlayerSessionManager`) that:
  - Creates `UserId`s when players join.
  - Maps from engine/network identifiers → `UserId`.

When input arrives for a given player/controller, your controller looks up the proper
`UserId` from this manager and calls the shared command surfaces with that id.

### 3.2 Per-user targeting and controllers

For each user:

- Attach a `TargetingShapeCast2D` (or equivalent targeting script) to the camera or view
  that represents that user.
- Implement a controller script that:
  - Reads input from that user (controller, keyboard, network messages, etc.).
  - Reads the current grid position / target from that user’s targeting node.
  - Calls `IPlacementCommands` / `IManipulationCommands` with that user’s `UserId`.
  - Updates that user’s HUD via the same `UserId`.

The session-level systems (`BuildingSystem`, `ManipulationSystemNode`) remain shared:

- They use the **session-scoped** services and state (world rules, grid, placement data).
- They receive `UserId` through the command facades and consult **user/owner scopes** as the
  architecture evolves.

### 3.3 Where legacy containers fit

If you are migrating from older scenes/tests that rely on `CompositionContainer` or other
scope-style nodes:

- You can still use those as **bridges** to spin up services and state for tests or legacy
  content.
- New code should **not** use them as the primary owner of user identity; instead, they
  forward to the same `ServiceRegistry` that `ServiceCompositionRoot` exposes.
- Your game’s session/owner model remains the canonical source of `UserId`s.

---

## 4. Next Steps

- Read the [Dependency Resolution](./dependency-resolution.md) guide to see how
  `ServiceCompositionRoot`, `ServiceRegistry`, and `CompositionContainer` relate.
- Read [Multi-Owner Orchestration Priorities](./multi-owner-orchestration-priorities.md)
  for the longer-term session/owner design.
- Start with the **Single-User Quick Start** above and evolve toward the
  **Multi-User / Multiplayer Sketch** as your game design demands.

