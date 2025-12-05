---
title: "ShapeData"
description: "Shape data for collision processing"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/shapedata/"
---

# ShapeData

```csharp
GridBuilding.Core.Types
class ShapeData
{
    // Members...
}
```

Shape data for collision processing

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/ShapeTypes.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ShapeType

```csharp
public ShapeType ShapeType { get; set; }
```

### Size

```csharp
public Vector2 Size { get; set; }
```

### Radius

```csharp
public float Radius { get; set; }
```

### PolygonPoints

```csharp
public Vector2[] PolygonPoints { get; set; } = Array.Empty<Vector2>();
```

### Transform

```csharp
public Transform2D Transform { get; set; } = Transform2D.Identity;
```

