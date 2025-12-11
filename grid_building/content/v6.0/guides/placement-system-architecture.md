---
title: "Placement System and Architecture in GridBuilding v6.0 (Godot)"
description: "How the v6.0 PlacementSystem and IPlacementService replace the legacy GDScript BuildingSystem, and how placement flows are wired."
weight: 45
url: "/gridbuilding/v6.0/guides/placement-system-architecture/"
---

> **Note:** The v6.0 documentation tracks the in-progress **Grid Placement 6.0 (C#)** line.
> It is an internal roadmap/preview and should not be treated as a promised public release or timeline.
> The current GDScript release line is **v5.1**.

# Placement System and Architecture in v6.0 (Godot)

This guide explains **what the Placement System does in v6.0**, how it **replaces the old GDScript `BuildingSystem`**, and how it fits into the overall architecture.

It is written for plugin integrators and contributors who want to understand **where placement logic lives now**, which services it depends on, and how to wire it correctly in scenes and tests.

---

## 1. From `BuildingSystem` (GDScript) to `PlacementSystem` (C#)

In the 5.x GDScript plugin, a monolithic `BuildingSystem` node was responsible for:

- Validating whether a building could be placed.
- Emitting signals on success/failure.
- Driving preview, indicators, and collision checks.
- Owning a large amount of state about the current mode and active build.

In v6.0, this has been **split into clearer responsibilities** and moved into C#:

- **Core (pure C#)** now owns *placement rules and state* via `IPlacementService` and related Core types.
- **Godot Systems** orchestrate Core services and Godot nodes via `PlacementSystem` and `IndicatorService`.
- Legacy building-centric services (`BuildingSystem`, `BuildingService`, `IBuildingService`, `BuildingBehavior`) are marked **obsolete** and should not be used for new flows.

> **Migration intent:** When you previously called `BuildingSystem.try_build(...)` in GDScript, the new path is to drive placement through **`PlacementSystem` + `IPlacementService`** instead.

---

## 2. Core Placement Engine: `IPlacementService`

**Namespace:** `GridBuilding.Core.Services.Placement`

`IPlacementService` is the **engine-agnostic placement service**. It contains all the **business rules** for placement without any Godot dependencies.

### 2.1 Responsibilities

- **Validate placement** of a `Placeable` at a position.
- **Execute placement** (update logical state, record ownership, etc.).
- **Remove** or **move** placed objects.
- **Query** occupancy (is a position taken, what is in an area, what a player owns).
- Provide **diagnostics** and validation issues for configuration and runtime state.

### 2.2 Key API surface

- `PlacementReport ValidatePlacement(Placeable placeable, Vector2 position, IOwner? placer = null)`
- `PlacementResult ExecutePlacement(Placeable placeable, Vector2 position, IOwner? placer = null)`
- `bool RemoveObject(Vector2 position, IOwner? remover = null)`
- `bool MoveObject(Vector2 fromPosition, Vector2 toPosition, IOwner? mover = null)`
- `bool IsPositionOccupied(Vector2 position)`
- `IEnumerable<Placeable> GetObjectsInArea(Rect2I area)`
- `IEnumerable<Placeable> GetObjectsByOwner(string ownerId)`
- `IEnumerable<string> GetValidationIssues()`
- `List<string> ValidateObjectPlacement(Vector2 position, string placeableType)`
- `void Reset()`, `void ClearAllObjects()`

### 2.3 What `IPlacementService` consumes

`IPlacementService` itself is implemented in Core and depends on other **Core** abstractions:

- **`IPlacementValidator`** – evaluates placement rules (tile bounds, collisions, tile policies).
- **`ICollisionCalculator`** – performs geometry and collision math.
- **`IGridTargetingState`** – provides current grid, target tile, and owner context.
- Domain types like `Placeable`, `PlacementReport`, and `PlacementResult` from Core.

Because these are all pure C#, you can **unit test placement logic in xUnit** without loading Godot.

---

## 3. Godot Orchestrator: `PlacementSystem`

**Namespace:** `GridBuilding.Godot.Systems.Placement`

`PlacementSystem` is a **Godot `Node`** that ties the Core placement engine to the scene tree.

### 3.1 Responsibilities

- Resolve services from `ServiceCompositionRoot` / `ServiceRegistry`.
- Call `IPlacementService.ValidatePlacement` and `ExecutePlacement`.
- Use `ISceneService` to instantiate scenes, set node positions, and attach them to the tree.
- Use `IndicatorService` to manage placement indicators after validation.
- Expose a **high-level placement API** for other nodes/behaviors.

### 3.2 What `PlacementSystem` consumes

At runtime, `PlacementSystem` resolves:

- **`IPlacementService`** – Core placement logic.
- **`ISceneService`** – engine-specific scene operations (instantiate, position, parent nodes).
- **`IndicatorService`** – manages `RuleCheckIndicator` instances.
- **`ServiceRegistry`** – via `ServiceCompositionRoot.GetGlobalRegistry()`.

These dependencies are wired in `PlacementSystem._Ready()` using the v6.0 **Enhanced Service Registry** pattern.

### 3.3 Placement flow (high level)

1. A caller (e.g. UI or behavior) asks `PlacementSystem.ValidatePlacement(...)`.
2. `PlacementSystem` calls `IPlacementService.ValidatePlacement(...)`.
3. If successful, `PlacementSystem` may instruct `IndicatorService` to create/update indicators.
4. On execute, `PlacementSystem.ExecutePlacement(...)`:
   - Calls `IPlacementService.ExecutePlacement(...)`.
   - Uses `ISceneService` to:
     - Instantiate the `PackedScene` for the `Placeable`.
     - Set its position.
     - Attach it under the chosen parent/owner.
   - Returns a `PlacementReport` describing the outcome.

This is the **C# equivalent** of what the GDScript `BuildingSystem` used to do, but split cleanly into Core and Godot responsibilities.

---

## 4. Indicators and Visual Feedback: `IndicatorService`

**Namespace:** `GridBuilding.Godot.Systems.Placement.Managers`

`IndicatorService` is the **service component** responsible for placement rule indicators.

### 4.1 Responsibilities

- Create and manage `RuleCheckIndicator` nodes.
- Integrate with `CollisionMapper` for contact/collision diagnostics.
- Provide `IndicatorSetupReport` and diagnostic information.
- Handle indicator lifecycle and cleanup on reset / node deletion.

### 4.2 What `IndicatorService` consumes

- **`GridTargetingState`** – to know where indicators should appear.
- **Templates** – indicator scenes from `CompositionContainer` or other resources.
- **`CollisionMapper`** – to compute indicator contacts and debug information.
- **`Logger`** – for diagnostics and warnings.

It is typically created via helpers like:

```csharp
var container = new CompositionContainer();
container.Initialize();

var parent = new Node();
var indicatorService = IndicatorService.CreateWithInjection(container, parent);
```

---

## 5. Migration Notes: from `BuildingSystem` (GDScript) to Placement in v6.0

In legacy GDScript code, you might see patterns like:

- `BuildingSystem.enter_build_mode(placeable)`
- `BuildingSystem.try_build(placeable, position)`
- Signals like `building.success` / `building.failed`.

In v6.0:

- **Placement decisions and state** live in **Core** (`IPlacementService`).
- **Scene instantiation and visual feedback** live in **Godot** (`PlacementSystem`, `IndicatorService`, `ISceneService`).
- Legacy C# building services:
  - `BuildingSystem` (Godot)
  - `BuildingService`, `IBuildingService`
  - `BuildingBehavior`, `ComposableBuildingNode`

  are marked **`[Obsolete]`** and should not be used for new flows.

### 5.1 What to use instead

- For new placement flows:
  - Use **`PlacementSystem` + `IPlacementService`** as the primary API.
  - If you need a behavior-style component, create a **placement-focused behavior** that talks to `PlacementSystem` instead of `IBuildingService`.
- For tests:
  - **Core tests:** unit test `IPlacementService` directly (no Godot).
  - **Godot tests:** use `PlacementSystem` and `IndicatorService` with a test scene and `ServiceCompositionRoot`.

---

## 6. Summary

- The legacy GDScript `BuildingSystem` has been **superseded** by:
  - `IPlacementService` (Core placement engine), and
  - `PlacementSystem` (Godot orchestrator).
- Visual feedback is handled by **`IndicatorService`** and related placement utilities.
- Building-centric services in C# are now **obsolete** and retained only for migration compatibility.
- New v6.0 code and documentation should treat **Placement** as the primary concept for building/placing objects on the grid.

