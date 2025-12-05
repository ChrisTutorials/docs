---
title: "Dependency Resolution in GridBuilding v6.0 (Godot)"
description: "How GridBuilding systems and services resolve their dependencies using ServiceCompositionRoot, ServiceRegistry, and CompositionContainer."
weight: 40
url: "/v6.0/guides/dependency-resolution/"
---

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

