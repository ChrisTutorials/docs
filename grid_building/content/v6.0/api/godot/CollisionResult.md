---
title: "CollisionResult"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionresult/"
---

# CollisionResult

```csharp
GridBuilding.Godot.Test.Environments
class CollisionResult
{
    // Members...
}
```

Result of a collision test

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Integration/Environments/CollisionTestEnvironment.cs`  
**Namespace:** `GridBuilding.Godot.Test.Environments`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Success

```csharp
public bool Success { get; set; }
```

### ErrorMessage

```csharp
public string ErrorMessage { get; set; }
```

### CollidedTiles

```csharp
public List<Vector2I> CollidedTiles { get; set; } = new();
```

### HasCollision

```csharp
public bool HasCollision { get; set; }
```

