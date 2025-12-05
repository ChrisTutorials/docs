---
title: "Rect2I"
description: "Integer-based 2D rectangle for area operations
Engine-agnostic equivalent of Godot's Rect2I"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/rect2i/"
---

# Rect2I

```csharp
GridBuilding.Core.Types
struct Rect2I
{
    // Members...
}
```

Integer-based 2D rectangle for area operations
Engine-agnostic equivalent of Godot's Rect2I

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/Rect2I.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Zero

```csharp
public static Rect2I Zero => new(Vector2I.Zero, Vector2I.Zero);
```

### Min

```csharp
public Vector2I Min => Position;
```

### Max

```csharp
public Vector2I Max => Position + Size;
```


## Methods

### Contains

```csharp
public bool Contains(Vector2I point) => 
            point.X >= Position.X && point.X < Position.X + Size.X &&
            point.Y >= Position.Y && point.Y < Position.Y + Size.Y;
```

**Returns:** `bool`

**Parameters:**
- `Vector2I point`

### Equals

```csharp
public bool Equals(Rect2I other) => Position.Equals(other.Position) && Size.Equals(other.Size);
```

**Returns:** `bool`

**Parameters:**
- `Rect2I other`

### Equals

```csharp
public override bool Equals(object obj) => obj is Rect2I other && Equals(other);
```

**Returns:** `bool`

**Parameters:**
- `object obj`

### GetHashCode

```csharp
public override int GetHashCode() => HashCode.Combine(Position, Size);
```

**Returns:** `int`

### ToString

```csharp
public override string ToString() => $"({Position}, {Size})";
```

**Returns:** `string`

