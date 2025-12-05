---
title: "Rect2"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/rect2/"
---

# Rect2

```csharp
GridBuilding.Core.Types
struct Rect2
{
    // Members...
}
```

2D rectangle struct for POCS implementations (float coordinates)

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/Rect2.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Position

```csharp
public Vector2 Position { get; }
```

### Size

```csharp
public Vector2 Size { get; }
```

### X

```csharp
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
public Vector2 End => new(Position.X + Size.X, Position.Y + Size.Y);
```


## Methods

### Contains

```csharp
public bool Contains(Vector2 point) =>
        point.X >= Position.X && point.X < End.X &&
        point.Y >= Position.Y && point.Y < End.Y;
```

**Returns:** `bool`

**Parameters:**
- `Vector2 point`

### HasPoint

```csharp
/// <summary>Alias for Contains - matches Godot's API</summary>
    public bool HasPoint(Vector2 point) => Contains(point);
```

Alias for Contains - matches Godot's API

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

### Equals

```csharp
public bool Equals(Rect2 other) => this == other;
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

