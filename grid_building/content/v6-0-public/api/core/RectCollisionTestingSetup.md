---
title: "RectCollisionTestingSetup"
description: "Rectangle collision testing setup for pure C# processing"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/rectcollisiontestingsetup/"
---

# RectCollisionTestingSetup

```csharp
GridBuilding.Core.Types
class RectCollisionTestingSetup
{
    // Members...
}
```

Rectangle collision testing setup for pure C# processing

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/ShapeTypes.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ShapeData

```csharp
public ShapeData ShapeData { get; set; } = new();
```

### TestingRect

```csharp
public Rect2 TestingRect { get; set; }
```

### Transform

```csharp
public Transform2D Transform { get; set; } = Transform2D.Identity;
```

### ShapeOwnerId

```csharp
public string ShapeOwnerId { get; set; } = string.Empty;
```


## Methods

### Validate

```csharp
/// <summary>
    /// Validates the setup
    /// </summary>
    public List<string> Validate()
    {
        var issues = new List<string>();

        if (ShapeData == null)
            issues.Add("ShapeData is null");

        if (ShapeData.ShapeType == ShapeType.Polygon && ShapeData.PolygonPoints.Length == 0)
            issues.Add("Polygon shape has no points");

        return issues;
    }
```

Validates the setup

**Returns:** `List<string>`

