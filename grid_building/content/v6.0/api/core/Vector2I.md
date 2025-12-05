---
title: "Vector2I"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/vector2i/"
---

# Vector2I

```csharp
GridBuilding.Core.Types
struct Vector2I
{
    // Members...
}
```

Integer-based 2D vector for grid positions
Engine-agnostic equivalent of Godot's Vector2I

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/Vector2I.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Zero

```csharp
/// <summary>
        /// Zero vector (0, 0)
        /// </summary>
        public static Vector2I Zero => new(0, 0);
```

Zero vector (0, 0)

### One

```csharp
/// <summary>
        /// One vector (1, 1)
        /// </summary>
        public static Vector2I One => new(1, 1);
```

One vector (1, 1)

### Up

```csharp
/// <summary>
        /// Up vector (0, -1)
        /// </summary>
        public static Vector2I Up => new(0, -1);
```

Up vector (0, -1)

### Down

```csharp
/// <summary>
        /// Down vector (0, 1)
        /// </summary>
        public static Vector2I Down => new(0, 1);
```

Down vector (0, 1)

### Left

```csharp
/// <summary>
        /// Left vector (-1, 0)
        /// </summary>
        public static Vector2I Left => new(-1, 0);
```

Left vector (-1, 0)

### Right

```csharp
/// <summary>
        /// Right vector (1, 0)
        /// </summary>
        public static Vector2I Right => new(1, 0);
```

Right vector (1, 0)


## Methods

### Equals

```csharp
/// <summary>
        /// Compares this Vector2I to another for equality
        /// </summary>
        /// <param name="other">The other vector</param>
        /// <returns>True if the vectors are equal, false otherwise</returns>
        public bool Equals(Vector2I other) => X == other.X && Y == other.Y;
```

Compares this Vector2I to another for equality

**Returns:** `bool`

**Parameters:**
- `Vector2I other`

### Equals

```csharp
/// <summary>
        /// Compares this Vector2I to an object for equality
        /// </summary>
        /// <param name="obj">The object to compare to</param>
        /// <returns>True if the object is a Vector2I and is equal, false otherwise</returns>
        public override bool Equals(object obj) => obj is Vector2I other && Equals(other);
```

Compares this Vector2I to an object for equality

**Returns:** `bool`

**Parameters:**
- `object obj`

### GetHashCode

```csharp
/// <summary>
        /// Returns the hash code for this Vector2I
        /// </summary>
        /// <returns>The hash code</returns>
        public override int GetHashCode() => HashCode.Combine(X, Y);
```

Returns the hash code for this Vector2I

**Returns:** `int`

### ToString

```csharp
/// <summary>
        /// Returns a string representation of the Vector2I
        /// </summary>
        /// <returns>A string in the format "(X, Y)"</returns>
        public override string ToString() => $"({X}, {Y})";
```

Returns a string representation of the Vector2I

**Returns:** `string`

### DistanceTo

```csharp
/// <summary>
        /// Calculates the distance to another Vector2I
        /// </summary>
        public float DistanceTo(Vector2I other)
        {
            int dx = other.X - X;
            int dy = other.Y - Y;
            return (float)System.Math.Sqrt(dx * dx + dy * dy);
        }
```

Calculates the distance to another Vector2I

**Returns:** `float`

**Parameters:**
- `Vector2I other`

### DistanceSquaredTo

```csharp
/// <summary>
        /// Calculates the squared distance to another Vector2I (faster than DistanceTo)
        /// </summary>
        public int DistanceSquaredTo(Vector2I other)
        {
            int dx = other.X - X;
            int dy = other.Y - Y;
            return dx * dx + dy * dy;
        }
```

Calculates the squared distance to another Vector2I (faster than DistanceTo)

**Returns:** `int`

**Parameters:**
- `Vector2I other`

