---
title: "RotationMath"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/rotationmath/"
---

# RotationMath

```csharp
GridBuilding.Godot.Tests.Validation
class RotationMath
{
    // Members...
}
```

Pure math utilities for rotation operations.
No Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Validation/RotationMathTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### NormalizeAngle

```csharp
/// <summary>
    /// Normalize angle to [0, 360) range.
    /// </summary>
    public static float NormalizeAngle(float degrees)
    {
        float result = degrees % 360f;
        if (result < 0) result += 360f;
        return result;
    }
```

Normalize angle to [0, 360) range.

**Returns:** `float`

**Parameters:**
- `float degrees`

### DegreesToCardinal

```csharp
/// <summary>
    /// Convert degrees to cardinal direction (4-way).
    /// </summary>
    public static CardinalDirection DegreesToCardinal(float degrees)
    {
        float normalized = NormalizeAngle(degrees);
        int index = (int)MathF.Round(normalized / 90f) % 4;
        return (CardinalDirection)index;
    }
```

Convert degrees to cardinal direction (4-way).

**Returns:** `CardinalDirection`

**Parameters:**
- `float degrees`

### CardinalToDegrees

```csharp
/// <summary>
    /// Convert cardinal direction to degrees.
    /// </summary>
    public static float CardinalToDegrees(CardinalDirection direction)
    {
        return (int)direction * 90f;
    }
```

Convert cardinal direction to degrees.

**Returns:** `float`

**Parameters:**
- `CardinalDirection direction`

### RotateByStep

```csharp
/// <summary>
    /// Rotate by a step amount.
    /// </summary>
    public static float RotateByStep(float currentDegrees, float stepDegrees, bool clockwise)
    {
        float delta = clockwise ? stepDegrees : -stepDegrees;
        return NormalizeAngle(currentDegrees + delta);
    }
```

Rotate by a step amount.

**Returns:** `float`

**Parameters:**
- `float currentDegrees`
- `float stepDegrees`
- `bool clockwise`

### SnapToGrid

```csharp
/// <summary>
    /// Snap angle to nearest grid increment.
    /// </summary>
    public static float SnapToGrid(float degrees, float gridSize)
    {
        float normalized = NormalizeAngle(degrees);
        float steps = MathF.Round(normalized / gridSize);
        return NormalizeAngle(steps * gridSize);
    }
```

Snap angle to nearest grid increment.

**Returns:** `float`

**Parameters:**
- `float degrees`
- `float gridSize`

### ShortestAngleDifference

```csharp
/// <summary>
    /// Get the shortest angular difference between two angles.
    /// Returns positive for clockwise, negative for counter-clockwise.
    /// </summary>
    public static float ShortestAngleDifference(float from, float to)
    {
        float diff = NormalizeAngle(to - from);
        if (diff > 180f) diff -= 360f;
        return diff;
    }
```

Get the shortest angular difference between two angles.
Returns positive for clockwise, negative for counter-clockwise.

**Returns:** `float`

**Parameters:**
- `float from`
- `float to`

### DegreesToRadians

```csharp
/// <summary>
    /// Convert degrees to radians.
    /// </summary>
    public static float DegreesToRadians(float degrees)
    {
        return degrees * RadiansPerDegree;
    }
```

Convert degrees to radians.

**Returns:** `float`

**Parameters:**
- `float degrees`

### RadiansToDegrees

```csharp
/// <summary>
    /// Convert radians to degrees.
    /// </summary>
    public static float RadiansToDegrees(float radians)
    {
        return radians * DegreesPerRadian;
    }
```

Convert radians to degrees.

**Returns:** `float`

**Parameters:**
- `float radians`

### CountRotationSteps

```csharp
/// <summary>
    /// Count the number of rotation steps between two angles.
    /// </summary>
    public static int CountRotationSteps(float from, float to, float stepSize)
    {
        float diff = NormalizeAngle(to - from);
        return (int)MathF.Round(diff / stepSize) % (int)(360f / stepSize);
    }
```

Count the number of rotation steps between two angles.

**Returns:** `int`

**Parameters:**
- `float from`
- `float to`
- `float stepSize`

