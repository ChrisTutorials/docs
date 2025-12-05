---
title: "GridHelperMethods"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/gridhelpermethods/"
---

# GridHelperMethods

```csharp
GridBuilding.Core.Constants
class GridHelperMethods
{
    // Members...
}
```

Helper methods for grid calculations and tolerance checks

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Common/Constants/GridHelperMethods.cs`  
**Namespace:** `GridBuilding.Core.Constants`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### IsWithinTolerance

```csharp
/// <summary>
    /// Small helper for numeric tolerance in tests
    /// </summary>
    /// <param name="a">First value</param>
    /// <param name="b">Second value</param>
    /// <param name="tolerance">Tolerance amount</param>
    /// <returns>True if values are within tolerance</returns>
    public static bool IsWithinTolerance(float a, float b, float tolerance = 0.001f)
    {
        return System.Math.Abs(a - b) <= tolerance;
    }
```

Small helper for numeric tolerance in tests

**Returns:** `bool`

**Parameters:**
- `float a`
- `float b`
- `float tolerance`

### IsWithinTolerance

```csharp
/// <summary>
    /// Helper for vector tolerance in tests
    /// </summary>
    /// <param name="a">First vector</param>
    /// <param name="b">Second vector</param>
    /// <param name="tolerance">Tolerance amount</param>
    /// <returns>True if vectors are within tolerance</returns>
    public static bool IsWithinTolerance(Vector2 a, Vector2 b, float tolerance = 0.001f)
    {
        return a.DistanceTo(b) <= tolerance;
    }
```

Helper for vector tolerance in tests

**Returns:** `bool`

**Parameters:**
- `Vector2 a`
- `Vector2 b`
- `float tolerance`

### DegreesToRadians

```csharp
/// <summary>
    /// Converts rotation degrees to radians
    /// </summary>
    /// <param name="degrees">Rotation in degrees</param>
    /// <returns>Rotation in radians</returns>
    public static float DegreesToRadians(float degrees)
    {
        return degrees * (float)System.Math.PI / 180.0f;
    }
```

Converts rotation degrees to radians

**Returns:** `float`

**Parameters:**
- `float degrees`

### RadiansToDegrees

```csharp
/// <summary>
    /// Converts rotation radians to degrees
    /// </summary>
    /// <param name="radians">Rotation in radians</param>
    /// <returns>Rotation in degrees</returns>
    public static float RadiansToDegrees(float radians)
    {
        return radians * 180.0f / (float)System.Math.PI;
    }
```

Converts rotation radians to degrees

**Returns:** `float`

**Parameters:**
- `float radians`

