---
title: "CollisionTestConfig"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisiontestconfig/"
---

# CollisionTestConfig

```csharp
GridBuilding.Godot.Tests.Environments
class CollisionTestConfig
{
    // Members...
}
```

Configuration for the collision test environment

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/CollisionTestEnvironment.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Environments`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### GridSize

```csharp
public Vector2I GridSize { get; set; } = new Vector2I(20, 20);
```

### TileSize

```csharp
public Vector2 TileSize { get; set; } = new Vector2(32, 32);
```

### EnablePerformanceTesting

```csharp
public bool EnablePerformanceTesting { get; set; } = true;
```

### DefaultPerformanceIterations

```csharp
public int DefaultPerformanceIterations { get; set; } = 1000;
```

