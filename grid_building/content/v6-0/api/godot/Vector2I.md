---
title: "Vector2I"
description: "POCS Vector2I type - mirrors Godot.Vector2I for testing
(System.Numerics doesn't have an integer Vector2)"
weight: 20
url: "/gridbuilding/v6-0/api/godot/vector2i/"
---

# Vector2I

```csharp
GridBuilding.Godot.Tests.Helpers
struct Vector2I
{
    // Members...
}
```

POCS Vector2I type - mirrors Godot.Vector2I for testing
(System.Numerics doesn't have an integer Vector2)

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GodotTypes.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### X

```csharp
public int X { get; set; }
```

### Y

```csharp
public int Y { get; set; }
```

### Zero

```csharp
public static Vector2I Zero => new(0, 0);
```

### One

```csharp
public static Vector2I One => new(1, 1);
```

### Up

```csharp
public static Vector2I Up => new(0, -1);
```

### Down

```csharp
public static Vector2I Down => new(0, 1);
```

### Left

```csharp
public static Vector2I Left => new(-1, 0);
```

### Right

```csharp
public static Vector2I Right => new(1, 0);
```


## Methods

### ToVector2

```csharp
/// <summary>
    /// Convert to System.Numerics.Vector2
    /// </summary>
    public Vector2 ToVector2() => new(X, Y);
```

Convert to System.Numerics.Vector2

**Returns:** `Vector2`

### FromVector2

```csharp
/// <summary>
    /// Create from System.Numerics.Vector2 (truncates)
    /// </summary>
    public static Vector2I FromVector2(Vector2 v) => new((int)v.X, (int)v.Y);
```

Create from System.Numerics.Vector2 (truncates)

**Returns:** `Vector2I`

**Parameters:**
- `Vector2 v`

### Equals

```csharp
public bool Equals(Vector2I other) => X == other.X && Y == other.Y;
```

**Returns:** `bool`

**Parameters:**
- `Vector2I other`

### Equals

```csharp
public override bool Equals(object? obj) => obj is Vector2I other && Equals(other);
```

**Returns:** `bool`

**Parameters:**
- `object? obj`

### GetHashCode

```csharp
public override int GetHashCode() => HashCode.Combine(X, Y);
```

**Returns:** `int`

### ToString

```csharp
public override string ToString() => $"({X}, {Y})";
```

**Returns:** `string`

