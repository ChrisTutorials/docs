---
title: "BuildingTestConfig"
description: "Configuration for the building test environment"
weight: 20
url: "/gridbuilding/v6-0/api/godot/buildingtestconfig/"
---

# BuildingTestConfig

```csharp
GridBuilding.Godot.Tests.Environments
class BuildingTestConfig
{
    // Members...
}
```

Configuration for the building test environment

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/BuildingTestEnvironment.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Environments`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### GridSize

```csharp
public Vector2I GridSize { get; set; } = new Vector2I(15, 15);
```

### TileSize

```csharp
public Vector2 TileSize { get; set; } = new Vector2(32, 32);
```

### EnableCollisionChecking

```csharp
public bool EnableCollisionChecking { get; set; } = true;
```

### MaxBuildings

```csharp
public int MaxBuildings { get; set; } = 50;
```

