---
title: "Rect2"
description: "Float-based 2D rectangle for bounds and areas.
Engine-agnostic equivalent of Godot's Rect2."
weight: 10
url: "/gridbuilding/v6-0/api/core/rect2/"
---

# Rect2

```csharp
GridBuilding.Core.Types
struct Rect2
{
    // Members...
}
```

Float-based 2D rectangle for bounds and areas.
Engine-agnostic equivalent of Godot's Rect2.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Types/Rect2.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### X

```csharp
// Properties
    public float X => Position.X;
```

### Y

```csharp
public float Y => Position.Y;
```

### Width

```csharp
public float Width => Size.X;
```

### Height

```csharp
public float Height => Size.Y;
```

### End

```csharp
public Vector2 End => Position + Size;
```

### Area

```csharp
public float Area => Size.X * Size.Y;
```


## Methods

### HasPoint

```csharp
// Common operations
    public bool HasPoint(Vector2 point) =>
        point.X >= Position.X && point.X < End.X &&
        point.Y >= Position.Y && point.Y < End.Y;
```

**Returns:** `bool`

**Parameters:**
- `Vector2 point`

### Intersects

```csharp
public bool Intersects(Rect2 other) =>
        Position.X < other.End.X && End.X > other.Position.X &&
        Position.Y < other.End.Y && End.Y > other.Position.Y;
```

**Returns:** `bool`

**Parameters:**
- `Rect2 other`

### Intersection

```csharp
public Rect2 Intersection(Rect2 other)
    {
        var newX = System.Math.Max(Position.X, other.Position.X);
        var newY = System.Math.Max(Position.Y, other.Position.Y);
        var newEndX = System.Math.Min(End.X, other.End.X);
        var newEndY = System.Math.Min(End.Y, other.End.Y);
        
        if (newEndX <= newX || newEndY <= newY)
            return new Rect2(0, 0, 0, 0);
            
        return new Rect2(newX, newY, newEndX - newX, newEndY - newY);
    }
```

**Returns:** `Rect2`

**Parameters:**
- `Rect2 other`

### Merge

```csharp
public Rect2 Merge(Rect2 other)
    {
        var newX = System.Math.Min(Position.X, other.Position.X);
        var newY = System.Math.Min(Position.Y, other.Position.Y);
        var newEndX = System.Math.Max(End.X, other.End.X);
        var newEndY = System.Math.Max(End.Y, other.End.Y);
        return new Rect2(newX, newY, newEndX - newX, newEndY - newY);
    }
```

**Returns:** `Rect2`

**Parameters:**
- `Rect2 other`

### Expand

```csharp
public Rect2 Expand(Vector2 point)
    {
        var newPos = new Vector2(
            System.Math.Min(Position.X, point.X),
            System.Math.Min(Position.Y, point.Y));
        var newEnd = new Vector2(
            System.Math.Max(End.X, point.X),
            System.Math.Max(End.Y, point.Y));
        return new Rect2(newPos, newEnd - newPos);
    }
```

**Returns:** `Rect2`

**Parameters:**
- `Vector2 point`

### Grow

```csharp
public Rect2 Grow(float amount) =>
        new(Position.X - amount, Position.Y - amount,
            Size.X + amount * 2, Size.Y + amount * 2);
```

**Returns:** `Rect2`

**Parameters:**
- `float amount`

### GrowIndividual

```csharp
public Rect2 GrowIndividual(float left, float top, float right, float bottom) =>
        new(Position.X - left, Position.Y - top,
            Size.X + left + right, Size.Y + top + bottom);
```

**Returns:** `Rect2`

**Parameters:**
- `float left`
- `float top`
- `float right`
- `float bottom`

### GetCenter

```csharp
public Vector2 GetCenter() => Position + Size / 2;
```

**Returns:** `Vector2`

### Encloses

```csharp
public bool Encloses(Rect2 other) =>
        other.Position.X >= Position.X && other.End.X <= End.X &&
        other.Position.Y >= Position.Y && other.End.Y <= End.Y;
```

**Returns:** `bool`

**Parameters:**
- `Rect2 other`

### Abs

```csharp
public Rect2 Abs() => Size.X < 0 || Size.Y < 0
        ? new Rect2(
            new Vector2(Size.X < 0 ? Position.X + Size.X : Position.X,
                        Size.Y < 0 ? Position.Y + Size.Y : Position.Y),
            Size.Abs())
        : this;
```

**Returns:** `Rect2`

### IsEqualApprox

```csharp
// Comparison with tolerance
    public bool IsEqualApprox(Rect2 other, float tolerance = 0.00001f) =>
        Position.IsEqualApprox(other.Position, tolerance) &&
        Size.IsEqualApprox(other.Size, tolerance);
```

**Returns:** `bool`

**Parameters:**
- `Rect2 other`
- `float tolerance`

### Equals

```csharp
// Equality
    public bool Equals(Rect2 other) => Position.Equals(other.Position) && Size.Equals(other.Size);
```

**Returns:** `bool`

**Parameters:**
- `Rect2 other`

### Equals

```csharp
public override bool Equals(object? obj) => obj is Rect2 other && Equals(other);
```

**Returns:** `bool`

**Parameters:**
- `object? obj`

### GetHashCode

```csharp
public override int GetHashCode() => HashCode.Combine(Position, Size);
```

**Returns:** `int`

### ToString

```csharp
public override string ToString() => $"Rect2({Position}, {Size})";
```

**Returns:** `string`

