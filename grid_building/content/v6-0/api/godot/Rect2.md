---
title: "Rect2"
description: "POCS Rect2 type - mirrors Godot.Rect2 for testing"
weight: 20
url: "/gridbuilding/v6-0/api/godot/rect2/"
---

# Rect2

```csharp
GridBuilding.Godot.Tests.Helpers
struct Rect2
{
    // Members...
}
```

POCS Rect2 type - mirrors Godot.Rect2 for testing

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GodotTypes.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Position

```csharp
public Vector2 Position { get; set; }
```

### Size

```csharp
public Vector2 Size { get; set; }
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
public bool HasPoint(Vector2 point) 
        => point.X >= Position.X && point.X <= End.X 
        && point.Y >= Position.Y && point.Y <= End.Y;
```

**Returns:** `bool`

**Parameters:**
- `Vector2 point`

### Intersects

```csharp
public bool Intersects(Rect2 other)
        => Position.X < other.End.X && End.X > other.Position.X
        && Position.Y < other.End.Y && End.Y > other.Position.Y;
```

**Returns:** `bool`

**Parameters:**
- `Rect2 other`

### Equals

```csharp
public bool Equals(Rect2 other) => Position == other.Position && Size == other.Size;
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
public override string ToString() => $"[P: {Position}, S: {Size}]";
```

**Returns:** `string`

