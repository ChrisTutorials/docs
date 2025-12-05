---
title: "ShapeOwnerData"
description: "Shape owner data for pure C# testing"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/shapeownerdata/"
---

# ShapeOwnerData

```csharp
GridBuilding.Core.Geometry
class ShapeOwnerData
{
    // Members...
}
```

Shape owner data for pure C# testing

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/CollisionProcessor.cs`  
**Namespace:** `GridBuilding.Core.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### OwnerId

```csharp
public string OwnerId { get; set; } = string.Empty;
```

### Position

```csharp
public Vector2 Position { get; set; }
```

### Shapes

```csharp
public List<Types.ShapeData> Shapes { get; set; } = new();
```

