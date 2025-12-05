---
title: "RectangleShape2D"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/rectangleshape2d/"
---

# RectangleShape2D

```csharp
GridBuilding.Core.Geometry
class RectangleShape2D
{
    // Members...
}
```

Rectangle shape implementation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/Shapes.cs`  
**Namespace:** `GridBuilding.Core.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ShapeType

```csharp
public string ShapeType => "Rectangle";
```

### Position

```csharp
public Vector2 Position { get; set; }
```

### Rotation

```csharp
public float Rotation { get; set; }
```

### Size

```csharp
public Vector2 Size { get; set; }
```


## Methods

### ContainsPoint

```csharp
public bool ContainsPoint(Vector2 point)
    {
        // Simple axis-aligned rectangle check (ignoring rotation for now)
        var localPoint = point - Position;
        return localPoint.X >= 0 && localPoint.X <= Size.X &&
               localPoint.Y >= 0 && localPoint.Y <= Size.Y;
    }
```

**Returns:** `bool`

**Parameters:**
- `Vector2 point`

### GetBounds

```csharp
public Rectangle GetBounds()
    {
        return new Rectangle((int)Position.X, (int)Position.Y, (int)Size.X, (int)Size.Y);
    }
```

**Returns:** `Rectangle`

