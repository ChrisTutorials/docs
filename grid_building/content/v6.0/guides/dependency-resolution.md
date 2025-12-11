---
title: "Dependency Resolution in GridBuilding v6.0 (Godot)"
description: "How GridBuilding systems and services resolve their dependencies using ServiceCompositionRoot, ServiceRegistry, and CompositionContainer."
weight: 40
url: "/gridbuilding/v6.0-public/guides/dependency-resolution/"
---

> **Note:** The v6.0 documentation tracks the in-progress **Grid Placement 6.0 (C#)** line.
> It is an internal roadmap/preview and should not be treated as a promised public release or timeline.
> The current GDScript release line is **v5.1**.

# Dependency Resolution in GridBuilding v6.0 (Godot)

This guide explains, in practical terms, **how GridBuilding objects find their dependencies** in v6.0: where services come from, how Godot nodes are wired, and what role `CompositionContainer` still plays.

The short version:

- **ServiceCompositionRoot** builds a **ServiceRegistry**.
- **Core services** (pure C#) are registered in that registry.
- **Godot systems** (nodes) ask the registry for services instead of creating them directly.
- **CompositionContainer** is a compatibility wrapper used where older APIs still expect a "container" object.

---

## 1. Core Concepts

### 1.1 ServiceCompositionRoot (Godot bootstrap)

`Godot/Bootstrap/ServiceCompositionRoot.cs` is the **entry point** for dependency wiring in v6.0.

It is a Godot `Node` you add to your scene. When it enters the tree, it:

1. Creates a `ServiceRegistry` instance.
2. Registers **infrastructure** services (logging, validation, etc.).
3. Registers **Core services** (pure C#):
   - `IPlacementValidator`, `ICollisionCalculator`
   - `IGridTargetingState` (POCS state wrapper)
   - `IPlacementService`, `IManipulationService`, `IGridTargetingService`
   - `IPlacementCommands`, `IManipulationCommands` (high-level command facades)
4. Registers **Godot services**:
   - `ISceneService` for scene/node operations
   - `IndicatorService` for placement indicators
5. Exposes the registry globally via:
   - `GetServiceRegistry()` on the node instance
   - `static ServiceCompositionRoot.GetGlobalRegistry()` helper
   - `static ServiceCompositionRoot.GetGlobalService<T>()` helper

### 1.2 ServiceRegistry (Core.Services.DI)

`ServiceRegistry` is a **simple dependency injection container** used by the root:

- Keeps track of **singletons** and **factories** for services.
- Provides `GetService<T>()` and `GetService(Type)` methods.
- Handles **lifetime**:
  - Singletons (one per registry)
  - Factories (created on demand)

Godot systems never need to know *how* a service is created—only that they can ask the registry for it.

### 1.3 CompositionContainer (Godot.Services.DI)

`GridBuilding.Godot.Services.DI.CompositionContainer` is a **compatibility wrapper** around newer DI infrastructure.

- It wraps a `ServiceRegistry` and keeps some of the old, Godot-friendly API:
  - `GetLogger()`
  - `GetSystemsContext()`
  - `GetTargetingState()`
  - `GetPlacementRules()`
  - `GetVisualSettings()`, `GetTemplates()`
- It can be initialized from a `.tres` resource via `InitializeFromTresFile`, preserving old workflows.
- It is used by older/legacy-style APIs like:
  - `IndicatorService.CreateWithInjection(CompositionContainer, Node)`
  - `PlacementValidator.CreateWithInjection(CompositionContainer)`
  - `PlacementSystem.Legacy.CreateWithInjection(CompositionContainer)`

You should treat `CompositionContainer` as:

> "A bridge for older container-based code, implemented on top of the new ServiceRegistry."

Newer code should prefer **direct access** to `ServiceRegistry` via `ServiceCompositionRoot`.

---

## 2. How Godot Nodes Resolve Dependencies

### 2.1 New pattern: ask ServiceCompositionRoot / ServiceRegistry

Modern systems (e.g. the v6.0 `PlacementSystem`) resolve dependencies like this:

```csharp
public override void _Ready() {
  GD.Print("Initializing PlacementSystem with Enhanced Service Registry...");

  // Locate ServiceCompositionRoot
  var serviceRoot = FindServiceCompositionRoot();
  if (serviceRoot == null) {
    GD.PrintErr("ServiceCompositionRoot not found.");
    return;
  }

  var registry = serviceRoot.GetServiceRegistry();

  // Resolve Core + Godot services
  _placementService = serviceRoot.GetService<IPlacementService>();
  _sceneService     = serviceRoot.GetService<ISceneService>();
  _indicatorService = serviceRoot.GetService<IndicatorService>();
}
```

Key points:

- The system **does not new up** its own services.
- It **finds the nearest `ServiceCompositionRoot`**, then asks for services.
- The **Pure C# logic** stays in Core services (`IPlacementService`, `IGridTargetingService`), while the node orchestrates Godot-specific behavior.

### 2.1.1 Key runtime services (what they do and consume)

At runtime, a small set of services are central to placement flows:

- **`IPlacementService` (Core.Services.Placement)**
  - **Role:** Pure C# placement engine (validate + execute placement, remove/move objects, query occupancy).
  - **Consumes:**
    - `IPlacementValidator` (rule checks: bounds, collisions, tile policies).
    - `ICollisionCalculator` (geometry/collision math in Core).
    - `IGridTargetingState` (current grid, tile, and owner context).
  - **Produces:**
    - `PlacementReport` (detailed validation results).
    - `PlacementResult` (success flag, errors, and placed-instance metadata for the Godot layer to consume).

- **`IPlacementCommands` / `IManipulationCommands` (Core.Interfaces)**
  - **Role:** High-level, user-scoped command facades over `IPlacementService` and `IManipulationService`.
  - **Consumes:**
    - `IPlacementService` / `IManipulationService` from the service registry.
  - **Produces:**
    - `PlacementResult` / `ManipulationResult` for controllers and UI.
  - Controllers and session/owner roots call these interfaces first, instead of
    directly invoking the lower-level services.

- **`PlacementSystem` (Godot.Systems.Placement)**
  - **Role:** Lightweight Godot `Node` that orchestrates placement using the Enhanced Service Registry pattern.
  - **Consumes:**
    - `IPlacementService` from `ServiceCompositionRoot`.
    - `ISceneService` (instantiates scenes, sets positions, attaches to tree).
    - `IndicatorService` (drives rule-check indicators after validation).
  - **Produces:**
    - Final `PlacementReport` for callers (UI, behaviors, tests).
    - Instantiated Godot nodes for successful placements (via `ISceneService`).

- **`IndicatorService` (Godot.Systems.Placement.Managers)**
  - **Role:** Manages `RuleCheckIndicator` nodes for visual feedback during placement.
  - **Consumes:**
    - `GridTargetingState` (to know where indicators should be placed).
    - Indicator templates from `CompositionContainer` / templates resources.
    - `CollisionMapper` and placement utilities for geometry and contact points.
    - `Logger` for diagnostics.
  - **Produces:**
    - Indicator nodes under a given parent.
    - Diagnostic reports via `IndicatorSetupReport` and logs.

> **Note:** Older building-centric services like `BuildingService`, `IBuildingService`, and `BuildingBehavior` are now marked as obsolete. New code should drive placement via `PlacementSystem` + `IPlacementService` and, where needed, a placement-focused behavior that talks to those services.

### 2.2 Legacy pattern: pass a CompositionContainer in

Some older systems and helpers still expose `CreateWithInjection` or `ResolveGBDependencies` methods that take a container:

```csharp
// IndicatorService
public static IndicatorService CreateWithInjection(CompositionContainer container, Node parent) {
  var targetingState = container.GetTargetingState();
  var logger         = container.GetLogger();
  var template       = container.GetTemplates().RuleCheckIndicator;

  var service = new IndicatorService(parent, targetingState, template, logger);

  // Optional additional injection / validation
  service.ResolveGbDependencies(container);
  var issues = service.GetRuntimeIssues();
  if (issues.Count > 0) {
    logger?.LogWarnings(issues);
  }

  return service;
}
```

In this pattern:

- Your **bootstrap code** (or tests) create a `CompositionContainer` and initialize it.
- That container is then passed into any object that still uses container-based injection.
- Inside those methods, the container simply **forwards to the underlying ServiceRegistry**.

### 2.3 Example: TargetInformer UI component

`TargetInformer` is a UI control that displays **what the player is currently interacting with** (manipulation, building preview, or targeting):

```csharp
public void ResolveGBDependencies(CompositionContainer container) {
  _DisconnectAllSignals();

  var states = container.GetStates();
  _buildingState     = states.Building;
  _manipulationState = states.Manipulation;
  _targetingState    = states.Targeting;
  ModeState          = states.Mode;

  _settings = container.GetVisualSettings().TargetInfo;

  // Hook into state change events to refresh the display
  // (wiring omitted here for brevity)
}
```

Where does `container` come from?

- In your **game bootstrap** or **test setup**, you:
  - Construct and initialize a `CompositionContainer`.
  - Pass it into `TargetInformer.ResolveGBDependencies(container)` after adding the node to the tree.

---

## 3. How Tests Resolve Dependencies

### 3.1 Core tests (pure C#)

Core xUnit tests **never touch Godot** and do not use `CompositionContainer`. Instead, they:

- New up **Core services** directly (or via a small test-only registry).
- Assert behavior of:
  - `IPlacementService`
  - `GridTargetingService`
  - `PlacementReport`, `PlacementResult`
  - Rule validation helpers

### 3.2 Godot tests (GoDotTest / Chickensoft)

Godot integration tests follow the same patterns as runtime code, but in a test environment:

- Use a minimal scene with **ServiceCompositionRoot** wired.
- Or create/initialize a **test CompositionContainer** and call `CreateWithInjection` helpers.
- Use GoDotTest to **spin up nodes, call methods, and assert on Godot behavior**.

Example for placement validation in a test:

```csharp
var container = new CompositionContainer();
container.Initialize();

var parent = new Node();
var indicatorService = IndicatorService.CreateWithInjection(container, parent);
var validator        = PlacementValidator.CreateWithInjection(container);

// Run placement validation and assert on results
```

---

## 4. When Should I Use Which Pattern?

### Prefer **ServiceCompositionRoot + ServiceRegistry** when:

- You are building **new systems** in v6.0.
- You want **clean separation** between Core logic and Godot nodes.
- You want easier **testing of Core services** without Godot.

### Use **CompositionContainer** when:

- You are working with **legacy systems** that still expect a container object.
- You are porting GDScript/GdUnit tests or scenes that use `GBCompositionContainer.tres`.
- You need to bridge older `.tres` configuration into the new service world.

Over time, more APIs will move to the **ServiceCompositionRoot + ServiceRegistry** pattern, and `CompositionContainer` will remain mainly as a compatibility layer for existing content.

---

## 5. Summary

- `ServiceCompositionRoot` builds and owns the **ServiceRegistry**.
- Core services (`IPlacementService`, `IGridTargetingService`, etc.) are registered there.
- Godot systems either:
  - Resolve services directly from `ServiceCompositionRoot` **(new pattern)**, or
  - Accept a `CompositionContainer` that wraps those services **(legacy pattern)**.
- Tests can use the same mechanisms: Core tests construct services directly; Godot tests use the root or a test `CompositionContainer`.

This is the v6.0-supported way GridBuilding resolves dependencies and keeps Core logic engine-agnostic.


---

## 6. Owners and Multi-Tenant Dependency Resolution (Design Direction)

Status: This section documents the intended architecture for multi-owner and multiplayer setups in v6.x. Some elements are still in progress and tracked in internal docs.

### 6.1 What is an Owner

In GridBuilding, an Owner is any participant that can control or own buildings and actions in a session:

- Human local player
- AI controller
- Special or system side such as neutral or environment

Owners are not limited to human players. The API and dependency lifetimes are designed around this generic owner concept.

### 6.2 Lifetimes: Process, Session, Owner

To support multiple sessions and multiple owners per session, GridBuilding uses three layers of lifetime:

- Process lifetime
  - Lives for the lifetime of the game process
  - Holds shared infrastructure such as logging, configuration, factories, serialization
  - Knows which modules or plugins are available

- Session lifetime
  - One session scope per game session, match, or world
  - Shared across all owners in that session
  - Holds session state such as world or grid state, rules, shared services

- Owner lifetime
  - One owner scope per combination of session and owner
  - Holds per-owner state such as selection and preview state, build queues, and owner UI or controllers

A simple way to visualize this is:

  Process services
    Session services per session
      Owner services per owner in a session

ServiceCompositionRoot and ServiceRegistry remain the core mechanisms, but are extended to support session and owner scopes instead of a single global registry.

### 6.3 Plugin modules and registration

Plugins, including the GridBuilding plugin itself, do not create their own composition roots. Instead, each plugin exposes a module that can register services at the appropriate lifetimes.

At startup and during session or owner creation, the framework:

1. Discovers all module implementations
2. Calls registration methods such as:
   - Register process services once at process bootstrap
   - Register session services once per new session
   - Register owner services once per new owner in that session

This keeps plugin wiring centralized and consistent while still allowing each plugin to define what it needs per lifetime.

### 6.4 Owner registration flow

To participate in GridBuilding, a game or higher-level framework creates owners through a single canonical API. Conceptually the flow is:

1. Create a session for a world or match using a session manager
2. Create an owner in that session using an owner configuration
3. Internally, the owner creation
   - Creates an owner scope under the session scope
   - Invokes all plugin modules so they can register owner services
   - Returns an owner handle or identifier for later use

On the Godot side, this is paired with a SessionRoot and OwnerRoot node pattern.

- A SessionRoot node represents the session in the scene tree
- Under SessionRoot, there is one OwnerRoot node per owner
- Each OwnerRoot marks a subtree as belonging to a specific owner
- Nodes under an OwnerRoot do not create services directly, they ask the framework to inject dependencies from their owner scope

### 6.5 Quickstart: GridBuildingCompositionRoot

For simple single-owner setups such as tutorials or standalone prototypes, you can still use an optional GridBuildingCompositionRoot node.

This node:

- Creates a minimal session and owner on its own
- Registers GridBuilding session and owner services
- Wires a basic scene for a single controlling side

This should be treated as a convenience bootstrap for GridBuilding only scenes. For multi-plugin or advanced multiplayer scenarios, prefer the central session and owner APIs described above.

### 6.7 Game-owned UserId and plugin integration (public guidance)

In v6.x, **user identity is game-owned**, and GridBuilding treats `UserId` as an opaque handle that answers:

> *“Which user/owner is this command or UI element acting on behalf of?”*

There are two practical integration patterns for plugin consumers:

#### 6.7.1 Simple setup – single local user

Use this for prototypes or games with a single local player.

- **Scene wiring**
  - Add `ServiceCompositionRoot` to your main scene so the **ServiceRegistry** exists.
  - Add the GridBuilding nodes you need (targeting, placement, manipulation, HUD).
- **Create a single `UserId` in your game code**
  - Your game allocates a `UserId` for the local player (for example via a constructor or helper in your own code).
  - You then always pass that `UserId` into GridBuilding’s **command facades**:
    - `IPlacementCommands.TryPlace(userId, ...)`
    - `IPlacementCommands.TryDemolish(userId, ...)`
    - `IManipulationCommands.TryMove(userId, ...)`, etc.
  - For UI that has been made user-aware (e.g. v6 `TargetInformer`, `ActionLog`), you initialize them with:
    - `TargetInformer.InitializeForUser(userId, ...)`
    - `ActionLog.InitializeForUser(userId, ...)`.
- **What lives where**
  - GridBuilding owns **services and systems** via `ServiceCompositionRoot` and `ServiceRegistry`.
  - Your game owns **who the user is** and which `UserId` to use.

This keeps setup straightforward while matching the v6 owner/session design.

#### 6.7.2 Advanced setup – multi-owner and multiplayer

For splitscreen, networked games, AI, or tools, you typically move to a
**game-owned session/owner model** that coordinates all `UserId`s.

- **Game/session model owns identity**
  - Define game-side types such as `PlayerSession` or `GameUserSession` that store:
    - Engine or network identifiers (controller index, peer ID, account ID, etc.).
    - The corresponding GridBuilding `UserId`.
  - Maintain a small registry (e.g. `PlayerSessionManager`) that maps from engine/network IDs to `UserId`.
- **Bootstrap + services**
  - Continue to use `ServiceCompositionRoot` (or a central game bootstrap) to register GridBuilding services.
  - During session/owner creation your game:
    - Creates the required `UserId`s for each owner.
    - Resolves `IPlacementCommands`, `IManipulationCommands`, and other services from the registry.
    - Wires controllers and HUD by passing in the correct `UserId`.
- **Per-owner controllers and UI**
  - Owner-level controllers (per player or per character) read input and consult the game’s owner/session model to obtain the right `UserId`.
  - They call the shared systems/commands with that `UserId` and targeting data.
  - Per-owner HUD (target info, action log, etc.) is initialized with `InitializeForUser(userId, ...)` so that each HUD clearly represents a specific user.

GridBuilding remains **engine/network agnostic**: it never derives users from scene tree names, peer IDs, or controllers. It only sees `UserId` and relies on your game to decide what that means.

#### 6.7.3 CompositionContainer and legacy scope nodes

`CompositionContainer` and older scope-style helpers are still available, but primarily as
**migration and test scaffolding**:

- They provide a convenient way to stand up services and state for older projects or tests that expect a container object.
- Internally, they forward to the same `ServiceRegistry` built by `ServiceCompositionRoot`.
- They should **not** be the primary owner of user/session identity in new games.

For new or actively maintained projects:

- Prefer **game-owned `UserId` + ServiceCompositionRoot** and the session/owner patterns described above.
- Use `CompositionContainer` in tests and legacy content where refactoring to the new pattern is not yet complete.

#### 6.7.4 TargetingShapeCast2D and per-user targeting

`TargetingShapeCast2D` is the Godot-side physics component that drives **what the user is looking at on the grid**. It does **not** know about `UserId` directly. Instead, it updates an owner-scoped `GridTargetingState`, and the service layer associates that state with a specific `UserId`.

At a high level:

- The **game** owns `UserId` and a session/owner model.
- GridBuilding creates an **owner scope per (session, UserId)** that includes:
  - `IGridTargetingState` (Core)
  - A Godot `GridTargetingState` / `GBCompositionContainer` bound to that owner.
- `TargetingShapeCast2D` is wired to the **owner’s targeting state** via dependency resolution.

##### Node layout (not parented under the player)

Per owner, a typical scene layout is:

- `SessionRoot` (represents the game session)
  - `OwnerRoot` (represents one owner/user)
    - `Character` (optional: player character / pawn)
    - `GridBuildingCursorRoot` (cursor / targeting stack)
      - `TargetingShapeCast2D`
      - Optional cursor visuals

`TargetingShapeCast2D` is **not** a child of the player character. Its transform is driven by input:

- Mouse input: move `GridBuildingCursorRoot` to the mouse world position.
- Keyboard / gamepad: move in discrete grid steps.
- AI: move according to AI decisions.

The ShapeCast only cares about **where** it is in the world, not who moved it.

##### How TargetingShapeCast2D becomes per-user

Per owner:

1. The game creates a `UserId` and an owner scope (see sections 6.4–6.7).
2. During bootstrap, GridBuilding registers:
   - An `IGridTargetingState` for that owner.
   - A Godot `GridTargetingState` / `GBCompositionContainer` bound to the same owner.
3. In Godot, a per-owner cursor/controller node:
   - Knows which `UserId` it represents (from the game’s session model).
   - Resolves `ServiceCompositionRoot` and the owner’s container/state using that `UserId`.
   - Calls something conceptually like:

     ```gdscript
     # Pseudocode
     var container_for_owner = OwnerService.resolve_container_for_user(user_id)
     targeting_shape_cast.resolve_gb_dependencies(container_for_owner)
     ```

4. From this point on:
   - `TargetingShapeCast2D` updates **that owner’s** `GridTargetingState`.
   - Core commands (`IPlacementCommands`, `IManipulationCommands`) use the same owner-scoped targeting state when called with that `UserId`.

The ShapeCast does not store or export a `UserId`. Its effective identity is derived entirely from **which targeting state it is bound to**, and that targeting state is owner-scoped in the service layer.

##### Human, AI, and multi-player

This pattern works the same way regardless of input source:

- **Human local player**: controller reads input, looks up the correct `UserId`, and moves the cursor root.
- **AI controller**: AI logic decides a desired grid position and moves the cursor root programmatically.
- **Multiplayer / splitscreen**: each owner has its own:
  - `UserId`
  - Owner scope in the service layer
  - `GridBuildingCursorRoot` + `TargetingShapeCast2D` bound to that owner’s targeting state

GridBuilding itself remains **user-id-centric and engine-agnostic**:

- It never inspects scene paths or node names to figure out "which player".
- It sees `UserId` at the command/service layer.
- Godot-side components like `TargetingShapeCast2D` become per-user by being wired to the correct **owner-scoped targeting state**, not by their position in the node hierarchy.

#### 6.7.5 Per-user runtime state objects and orchestrator services

In the owner-scoped model, **each user has its own copy of the key runtime “state” objects**, and **services/command facades orchestrate across all users**:

- **Per-user state (one instance per (session, UserId))**
  - `GridTargetingState` – what this user is currently pointing at, which map(s) they are targeting, tile size, collision exclusions.
  - `ManipulationState` – what this user is currently manipulating (move/rotate/flip), current operation state.
  - `ModeState` – this user’s current building/mode (build, move, demolish, info, etc.).
  - (Deprecated) `BuildingState` – per-building runtime state, not per-user; kept for legacy visualizers and will be replaced by newer placement-centric state.

- **Orchestrator services (multi-user aware)**
  - `IPlacementCommands` / `IManipulationCommands` take `UserId` and route work to the **correct per-user state** and core services.
  - `IGridTargetingService` and other core services operate over grid/navigation data and **consume per-user state via session/owner scopes** rather than Godot nodes.

The intent for v6.x is that:

- **Controllers and UI are per-user** and always call command facades with a `UserId`.
- **Session/owner scopes** hold the per-user state instances (targeting, manipulation, mode) for that `UserId`.
- **Services/commands** act as **orchestrators over all users** by accepting `UserId` and resolving the appropriate owner scope, instead of being tied to a single global targeting/mode state.
