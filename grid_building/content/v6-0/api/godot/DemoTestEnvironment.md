---
title: "DemoTestEnvironment"
description: "C# implementation of demo test environment utilities to match GDScript functionality"
weight: 20
url: "/gridbuilding/v6-0/api/godot/demotestenvironment/"
---

# DemoTestEnvironment

```csharp
GridBuilding.Godot.Tests.Demo
class DemoTestEnvironment
{
    // Members...
}
```

C# implementation of demo test environment utilities to match GDScript functionality

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/DemoTestEnvironmentTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Demo`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DemoScene

```csharp
// Demo scene and runtime components
    public PackedScene DemoScene { get; private set; }
```

### Runner

```csharp
public GdUnitSceneRunner Runner { get; private set; }
```

### Demo

```csharp
public Node Demo { get; private set; }
```

### IsSetup

```csharp
// Environment state
    public bool IsSetup { get; private set; }
```


## Methods

### Setup

```csharp
public async Task Setup()
    {
        if (DemoScene == null)
            throw new ArgumentNullException(nameof(DemoScene));

        if (IsSetup)
            return; // Already setup

        // Create scene runner
        Runner = new GdUnitSceneRunner(DemoScene.ResourcePath);
        Demo = Runner.Scene();

        // Initialize components
        await InitializeComponents();

        IsSetup = true;
    }
```

**Returns:** `Task`

### GetWorld

```csharp
public World GetWorld()
    {
        if (!IsSetup)
            throw new InvalidOperationException("Environment not setup");
        return _world;
    }
```

**Returns:** `World`

### GetLevel

```csharp
public Level GetLevel()
    {
        if (!IsSetup)
            throw new InvalidOperationException("Environment not setup");
        return _level;
    }
```

**Returns:** `Level`

### GetTileMapLayers

```csharp
public Godot.Collections.Array<TileMapLayer> GetTileMapLayers()
    {
        if (!IsSetup)
            throw new InvalidOperationException("Environment not setup");

        var layers = new Godot.Collections.Array<TileMapLayer>();
        if (_groundLayer != null)
            layers.Add(_groundLayer);
        return layers;
    }
```

**Returns:** `Godot.Collections.Array<TileMapLayer>`

### GetGridPositioner

```csharp
public Node2D GetGridPositioner()
    {
        if (!IsSetup)
            throw new InvalidOperationException("Environment not setup");
        return _gridPositioner;
    }
```

**Returns:** `Node2D`

### GetInjectorSystem

```csharp
public InjectorSystem GetInjectorSystem()
    {
        if (!IsSetup)
            throw new InvalidOperationException("Environment not setup");
        return _injector;
    }
```

**Returns:** `InjectorSystem`

### GetGridTargetingState

```csharp
public GridTargetingState GetGridTargetingState()
    {
        if (!IsSetup)
            throw new InvalidOperationException("Environment not setup");
        return _gts;
    }
```

**Returns:** `GridTargetingState`

### GetIndicatorManager

```csharp
public IndicatorManager GetIndicatorManager()
    {
        if (!IsSetup)
            throw new InvalidOperationException("Environment not setup");
        return _indicatorManager;
    }
```

**Returns:** `IndicatorManager`

### GetTileCenterGlobal

```csharp
public Vector2 GetTileCenterGlobal()
    {
        if (!IsSetup)
            throw new InvalidOperationException("Environment not setup");
        return _tileCenterGlobal;
    }
```

**Returns:** `Vector2`

### GetObjectsLayer

```csharp
public Node2D GetObjectsLayer()
    {
        if (!IsSetup)
            throw new InvalidOperationException("Environment not setup");
        return _objectsLayer;
    }
```

**Returns:** `Node2D`

### SimulateFrames

```csharp
public void SimulateFrames(int frameCount)
    {
        if (!IsSetup)
            throw new InvalidOperationException("Environment not setup");
        if (Runner == null)
            throw new InvalidOperationException("Scene runner not initialized");

        Runner.SimulateFrames(frameCount);
    }
```

**Returns:** `void`

**Parameters:**
- `int frameCount`

### Teardown

```csharp
public void Teardown()
    {
        if (!IsSetup)
            return;

        // Cleanup components
        _world = null;
        _level = null;
        _groundLayer = null;
        _objectsLayer = null;
        _gridPositioner = null;
        _injector = null;
        _container = null;
        _gts = null;
        _indicatorManager = null;

        // Cleanup demo scene
        Demo?.QueueFree();
        Demo = null;
        Runner = null;

        IsSetup = false;
    }
```

**Returns:** `void`

