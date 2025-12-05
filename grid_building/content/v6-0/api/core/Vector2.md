---
title: "Vector2"
description: "Simple Vector2 bridge type for Core project
Provides basic vector operations without Godot dependency"
weight: 10
url: "/gridbuilding/v6-0/api/core/vector2/"
---

# Vector2

```csharp
GridBuilding.Core.Types
struct Vector2
{
    // Members...
}
```

Simple Vector2 bridge type for Core project
Provides basic vector operations without Godot dependency

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/Vector2.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### X

```csharp
/// <summary>
        /// Gets or sets the X coordinate
        /// </summary>
        public float X { get; set; }
```

Gets or sets the X coordinate

### Y

```csharp
/// <summary>
        /// Gets or sets the Y coordinate
        /// </summary>
        public float Y { get; set; }
```

Gets or sets the Y coordinate


## Methods

### Length

```csharp
/// <summary>
        /// Calculates the length (magnitude) of the vector
        /// </summary>
        /// <returns>The length of the vector</returns>
        public float Length() => (float)System.Math.Sqrt(X * X + Y * Y);
```

Calculates the length (magnitude) of the vector

**Returns:** `float`

### LengthSquared

```csharp
/// <summary>
        /// Calculates the squared length of the vector
        /// </summary>
        /// <returns>The squared length of the vector</returns>
        public float LengthSquared() => X * X + Y * Y;
```

Calculates the squared length of the vector

**Returns:** `float`

### Normalized

```csharp
/// <summary>
        /// Returns a normalized version of the vector
        /// </summary>
        /// <returns>A unit vector in the same direction</returns>
        public Vector2 Normalized()
        {
            var length = Length();
            return length > 0 ? this / length : Zero;
        }
```

Returns a normalized version of the vector

**Returns:** `Vector2`

### DistanceTo

```csharp
/// <summary>
        /// Calculates the distance to another vector
        /// </summary>
        /// <param name="other">The other vector</param>
        /// <returns>The distance between the vectors</returns>
        public float DistanceTo(Vector2 other) => (this - other).Length();
```

Calculates the distance to another vector

**Returns:** `float`

**Parameters:**
- `Vector2 other`

### IsZero

```csharp
/// <summary>
        /// Checks if the vector is zero
        /// </summary>
        /// <returns>True if both components are zero, false otherwise</returns>
        public bool IsZero() => X == 0 && Y == 0;
```

Checks if the vector is zero

**Returns:** `bool`

### IsEqualApprox

```csharp
/// <summary>
        /// Checks if the vector is approximately equal to another vector
        /// </summary>
        /// <param name="other">The other vector</param>
        /// <param name="tolerance">The tolerance for comparison</param>
        /// <returns>True if the vectors are approximately equal, false otherwise</returns>
        public bool IsEqualApprox(Vector2 other, float tolerance = 0.00001f) =>
            System.Math.Abs(X - other.X) < tolerance && System.Math.Abs(Y - other.Y) < tolerance;
```

Checks if the vector is approximately equal to another vector

**Returns:** `bool`

**Parameters:**
- `Vector2 other`
- `float tolerance`

### Equals

```csharp
/// <summary>
        /// Compares this vector to another vector for equality
        /// </summary>
        /// <param name="other">The other vector</param>
        /// <returns>True if the vectors are equal, false otherwise</returns>
        public bool Equals(Vector2 other) => X == other.X && Y == other.Y;
```

Compares this vector to another vector for equality

**Returns:** `bool`

**Parameters:**
- `Vector2 other`

### Equals

```csharp
/// <summary>
        /// Compares this vector to an object for equality
        /// </summary>
        /// <param name="obj">The object to compare to</param>
        /// <returns>True if the object is a Vector2 and is equal, false otherwise</returns>
        public override bool Equals(object obj) => obj is Vector2 other && Equals(other);
```

Compares this vector to an object for equality

**Returns:** `bool`

**Parameters:**
- `object obj`

### GetHashCode

```csharp
/// <summary>
        /// Returns the hash code for this vector
        /// </summary>
        /// <returns>The hash code</returns>
        public override int GetHashCode() => HashCode.Combine(X, Y);
```

Returns the hash code for this vector

**Returns:** `int`

### ToString

```csharp
/// <summary>
        /// Returns a string representation of the vector
        /// </summary>
        /// <returns>A string in the format "(X, Y)"</returns>
        public override string ToString() => $"({X}, {Y})";
```

Returns a string representation of the vector

**Returns:** `string`

