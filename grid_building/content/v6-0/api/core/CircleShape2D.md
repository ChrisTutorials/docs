---
title: "CircleShape2D"
description: "Circle shape implementation"
weight: 10
url: "/gridbuilding/v6-0/api/core/circleshape2d/"
---

# CircleShape2D

```csharp
GridBuilding.Core.Geometry
class CircleShape2D
{
    // Members...
}
```

Circle shape implementation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/Shapes.cs`  
**Namespace:** `GridBuilding.Core.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ShapeType

```csharp
public string ShapeType => "Circle";
```

### Position

```csharp
public Vector2 Position { get; set; }
```

### Rotation

```csharp
public float Rotation { get; set; }
```

### Radius

```csharp
public float Radius { get; set; }
```


## Methods

### ContainsPoint

```csharp
public bool ContainsPoint(Vector2 point)
    {
        var distance = (point - Position).Length;
        return distance <= Radius;
    }
```

**Returns:** `bool`

**Parameters:**
- `Vector2 point`

### GetBounds

```csharp
public Rectangle GetBounds()
    {
        return new Rectangle(
            (int)(Position.X - Radius),
            (int)(Position.Y - Radius),
            (int)(Radius * 2),
            (int)(Radius * 2)
        );
    }
```

**Returns:** `Rectangle`

