---
title: "CapsuleShape2D"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/capsuleshape2d/"
---

# CapsuleShape2D

```csharp
GridBuilding.Core.Geometry
class CapsuleShape2D
{
    // Members...
}
```

Capsule shape implementation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/Shapes.cs`  
**Namespace:** `GridBuilding.Core.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ShapeType

```csharp
public string ShapeType => "Capsule";
```

### Position

```csharp
public Vector2 Position { get; set; }
```

### Rotation

```csharp
public float Rotation { get; set; }
```

### Height

```csharp
public float Height { get; set; }
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
        // Simplified capsule check (axis-aligned)
        var localPoint = point - Position;
        var halfHeight = Height / 2 - Radius;
        
        // Check if point is in middle rectangle
        if (System.Math.Abs(localPoint.X) <= Radius && System.Math.Abs(localPoint.Y) <= halfHeight)
            return true;
        
        // Check if point is in top or bottom circle
        var topCenter = new Vector2(0, halfHeight);
        var bottomCenter = new Vector2(0, -halfHeight);
        
        return (localPoint - topCenter).Length <= Radius ||
               (localPoint - bottomCenter).Length <= Radius;
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
            (int)(Position.Y - Height / 2),
            (int)(Radius * 2),
            (int)Height
        );
    }
```

**Returns:** `Rectangle`

