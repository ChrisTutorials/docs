---
title: "GeometryResult"
description: "Result of a geometry calculation test"
weight: 20
url: "/gridbuilding/v6-0/api/godot/geometryresult/"
---

# GeometryResult

```csharp
GridBuilding.Godot.Test.Environments
class GeometryResult
{
    // Members...
}
```

Result of a geometry calculation test

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

### OverlappedTiles

```csharp
public List<Vector2I> OverlappedTiles { get; set; } = new();
```

### Area

```csharp
public float Area { get; set; }
```

