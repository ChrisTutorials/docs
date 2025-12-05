---
title: "DemoSceneConfig"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/demosceneconfig/"
---

# DemoSceneConfig

```csharp
GridBuilding.Godot.Tests.Factories
class DemoSceneConfig
{
    // Members...
}
```

Configuration for demo scene creation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/DemoSceneFactory.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Factories`  
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

### EnableCollisionTesting

```csharp
public bool EnableCollisionTesting { get; set; } = true;
```

### EnablePathfinding

```csharp
public bool EnablePathfinding { get; set; } = true;
```

### EnableTargeting

```csharp
public bool EnableTargeting { get; set; } = true;
```

### CreateUIComponents

```csharp
public bool CreateUIComponents { get; set; } = true;
```

