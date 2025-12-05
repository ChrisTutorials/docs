---
title: "Vector2TypeSafe"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/vector2typesafe/"
---

# Vector2TypeSafe

```csharp
GridBuilding.Godot.Tests.Manipulation.Types
struct Vector2TypeSafe
{
    // Members...
}
```

Type-safe Vector2 wrapper with validation - mirrors GDScript Vector2TypeSafe
Provides compile-time type checking and runtime validation for vector operations.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Integration/Manipulation/Types/Vector2TypeSafe.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Manipulation.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### X

```csharp
public float X { get; }
```

### Y

```csharp
public float Y { get; }
```


## Methods

### Zero

```csharp
#region Static Constructors

    public static Vector2TypeSafe Zero() => new(0.0f, 0.0f);
```

**Returns:** `Vector2TypeSafe`

### One

```csharp
public static Vector2TypeSafe One() => new(1.0f, 1.0f);
```

**Returns:** `Vector2TypeSafe`

### FromInt

```csharp
public static Vector2TypeSafe FromInt(int x, int y) => new(x, y);
```

**Returns:** `Vector2TypeSafe`

**Parameters:**
- `int x`
- `int y`

### Add

```csharp
#endregion

    #region Operations

    public Vector2TypeSafe Add(Vector2TypeSafe other) => new(X + other.X, Y + other.Y);
```

**Returns:** `Vector2TypeSafe`

**Parameters:**
- `Vector2TypeSafe other`

### Subtract

```csharp
public Vector2TypeSafe Subtract(Vector2TypeSafe other) => new(X - other.X, Y - other.Y);
```

**Returns:** `Vector2TypeSafe`

**Parameters:**
- `Vector2TypeSafe other`

### Multiply

```csharp
public Vector2TypeSafe Multiply(float scalar) => new(X * scalar, Y * scalar);
```

**Returns:** `Vector2TypeSafe`

**Parameters:**
- `float scalar`

### Divide

```csharp
public Vector2TypeSafe Divide(float scalar) => new(X / scalar, Y / scalar);
```

**Returns:** `Vector2TypeSafe`

**Parameters:**
- `float scalar`

### Length

```csharp
public float Length() => MathF.Sqrt(X * X + Y * Y);
```

**Returns:** `float`

### LengthSquared

```csharp
public float LengthSquared() => X * X + Y * Y;
```

**Returns:** `float`

### Normalized

```csharp
public Vector2TypeSafe Normalized()
    {
        var length = Length();
        if (length == 0) return Zero();
        return new Vector2TypeSafe(X / length, Y / length);
    }
```

**Returns:** `Vector2TypeSafe`

### Dot

```csharp
public float Dot(Vector2TypeSafe other) => X * other.X + Y * other.Y;
```

**Returns:** `float`

**Parameters:**
- `Vector2TypeSafe other`

### DistanceTo

```csharp
public float DistanceTo(Vector2TypeSafe other)
    {
        var dx = X - other.X;
        var dy = Y - other.Y;
        return MathF.Sqrt(dx * dx + dy * dy);
    }
```

**Returns:** `float`

**Parameters:**
- `Vector2TypeSafe other`

### IsValid

```csharp
#endregion

    #region Validation

    public bool IsValid() => !float.IsNaN(X) && !float.IsNaN(Y) && 
                              !float.IsInfinity(X) && !float.IsInfinity(Y);
```

**Returns:** `bool`

### IsEqualTo

```csharp
public bool IsEqualTo(Vector2TypeSafe other, float tolerance = 0.0001f) =>
        MathF.Abs(X - other.X) < tolerance && MathF.Abs(Y - other.Y) < tolerance;
```

**Returns:** `bool`

**Parameters:**
- `Vector2TypeSafe other`
- `float tolerance`

### IsValidScale

```csharp
/// <summary>
    /// Checks if the vector represents a valid scale (non-zero absolute values)
    /// Negative values are valid (for flipping), but near-zero values are not.
    /// </summary>
    public bool IsValidScale(float minAbsoluteValue = 0.01f) =>
        IsValid() && MathF.Abs(X) >= minAbsoluteValue && MathF.Abs(Y) >= minAbsoluteValue;
```

Checks if the vector represents a valid scale (non-zero absolute values)
Negative values are valid (for flipping), but near-zero values are not.

**Returns:** `bool`

**Parameters:**
- `float minAbsoluteValue`

### Equals

```csharp
#endregion

    #region Equality

    public bool Equals(Vector2TypeSafe other) => X.Equals(other.X) && Y.Equals(other.Y);
```

**Returns:** `bool`

**Parameters:**
- `Vector2TypeSafe other`

### Equals

```csharp
public override bool Equals(object? obj) => obj is Vector2TypeSafe other && Equals(other);
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
#endregion

    public override string ToString() => $"({X:F2}, {Y:F2})";
```

**Returns:** `string`

