---
title: "MathUtils"
description: "Pure C# math utilities to replace Godot's Mathf class.
Provides AOT-compatible math operations for iOS/Android."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/mathutils/"
---

# MathUtils

```csharp
GridBuilding.Core.Math
class MathUtils
{
    // Members...
}
```

Pure C# math utilities to replace Godot's Mathf class.
Provides AOT-compatible math operations for iOS/Android.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Math/MathUtils.cs`  
**Namespace:** `GridBuilding.Core.Math`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Clamp

```csharp
/// <summary>
    /// Clamps a value between min and max (inclusive).
    /// </summary>
    public static int Clamp(int value, int min, int max)
    {
        if (value < min) return min;
        if (value > max) return max;
        return value;
    }
```

Clamps a value between min and max (inclusive).

**Returns:** `int`

**Parameters:**
- `int value`
- `int min`
- `int max`

### Clamp

```csharp
/// <summary>
    /// Clamps a float value between min and max (inclusive).
    /// </summary>
    public static float Clamp(float value, float min, float max)
    {
        if (value < min) return min;
        if (value > max) return max;
        return value;
    }
```

Clamps a float value between min and max (inclusive).

**Returns:** `float`

**Parameters:**
- `float value`
- `float min`
- `float max`

### Clamp

```csharp
/// <summary>
    /// Clamps a double value between min and max (inclusive).
    /// </summary>
    public static double Clamp(double value, double min, double max)
    {
        if (value < min) return min;
        if (value > max) return max;
        return value;
    }
```

Clamps a double value between min and max (inclusive).

**Returns:** `double`

**Parameters:**
- `double value`
- `double min`
- `double max`

### Max

```csharp
/// <summary>
    /// Returns the larger of two integers.
    /// </summary>
    public static int Max(int a, int b) => a > b ? a : b;
```

Returns the larger of two integers.

**Returns:** `int`

**Parameters:**
- `int a`
- `int b`

### Max

```csharp
/// <summary>
    /// Returns the larger of two floats.
    /// </summary>
    public static float Max(float a, float b) => a > b ? a : b;
```

Returns the larger of two floats.

**Returns:** `float`

**Parameters:**
- `float a`
- `float b`

### Max

```csharp
/// <summary>
    /// Returns the larger of two doubles.
    /// </summary>
    public static double Max(double a, double b) => a > b ? a : b;
```

Returns the larger of two doubles.

**Returns:** `double`

**Parameters:**
- `double a`
- `double b`

### Min

```csharp
/// <summary>
    /// Returns the smaller of two integers.
    /// </summary>
    public static int Min(int a, int b) => a < b ? a : b;
```

Returns the smaller of two integers.

**Returns:** `int`

**Parameters:**
- `int a`
- `int b`

### Min

```csharp
/// <summary>
    /// Returns the smaller of two floats.
    /// </summary>
    public static float Min(float a, float b) => a < b ? a : b;
```

Returns the smaller of two floats.

**Returns:** `float`

**Parameters:**
- `float a`
- `float b`

### Min

```csharp
/// <summary>
    /// Returns the smaller of two doubles.
    /// </summary>
    public static double Min(double a, double b) => a < b ? a : b;
```

Returns the smaller of two doubles.

**Returns:** `double`

**Parameters:**
- `double a`
- `double b`

### Lerp

```csharp
/// <summary>
    /// Linear interpolation between two values.
    /// </summary>
    /// <param name="from">Start value</param>
    /// <param name="to">End value</param>
    /// <param name="weight">Interpolation weight (0-1)</param>
    public static float Lerp(float from, float to, float weight)
    {
        return from + (to - from) * weight;
    }
```

Linear interpolation between two values.

**Returns:** `float`

**Parameters:**
- `float from`
- `float to`
- `float weight`

### Lerp

```csharp
/// <summary>
    /// Linear interpolation between two double values.
    /// </summary>
    public static double Lerp(double from, double to, double weight)
    {
        return from + (to - from) * weight;
    }
```

Linear interpolation between two double values.

**Returns:** `double`

**Parameters:**
- `double from`
- `double to`
- `double weight`

### InverseLerp

```csharp
/// <summary>
    /// Inverse linear interpolation - returns where a value falls between two points.
    /// </summary>
    /// <param name="from">Start value</param>
    /// <param name="to">End value</param>
    /// <param name="value">The value to find the position of</param>
    /// <returns>0 if value equals from, 1 if value equals to</returns>
    public static float InverseLerp(float from, float to, float value)
    {
        if (System.Math.Abs(to - from) < float.Epsilon)
            return 0f;
        return (value - from) / (to - from);
    }
```

Inverse linear interpolation - returns where a value falls between two points.

**Returns:** `float`

**Parameters:**
- `float from`
- `float to`
- `float value`

### Abs

```csharp
/// <summary>
    /// Returns the absolute value of an integer.
    /// </summary>
    public static int Abs(int value) => value < 0 ? -value : value;
```

Returns the absolute value of an integer.

**Returns:** `int`

**Parameters:**
- `int value`

### Abs

```csharp
/// <summary>
    /// Returns the absolute value of a float.
    /// </summary>
    public static float Abs(float value) => value < 0 ? -value : value;
```

Returns the absolute value of a float.

**Returns:** `float`

**Parameters:**
- `float value`

### Sign

```csharp
/// <summary>
    /// Returns the sign of a number (-1, 0, or 1).
    /// </summary>
    public static int Sign(int value)
    {
        if (value > 0) return 1;
        if (value < 0) return -1;
        return 0;
    }
```

Returns the sign of a number (-1, 0, or 1).

**Returns:** `int`

**Parameters:**
- `int value`

### Sign

```csharp
/// <summary>
    /// Returns the sign of a float (-1, 0, or 1).
    /// </summary>
    public static float Sign(float value)
    {
        if (value > 0) return 1f;
        if (value < 0) return -1f;
        return 0f;
    }
```

Returns the sign of a float (-1, 0, or 1).

**Returns:** `float`

**Parameters:**
- `float value`

### RoundToInt

```csharp
/// <summary>
    /// Rounds a float to the nearest integer.
    /// </summary>
    public static int RoundToInt(float value) => (int)System.Math.Round(value);
```

Rounds a float to the nearest integer.

**Returns:** `int`

**Parameters:**
- `float value`

### FloorToInt

```csharp
/// <summary>
    /// Floors a float to the nearest integer.
    /// </summary>
    public static int FloorToInt(float value) => (int)System.Math.Floor(value);
```

Floors a float to the nearest integer.

**Returns:** `int`

**Parameters:**
- `float value`

### CeilToInt

```csharp
/// <summary>
    /// Ceils a float to the nearest integer.
    /// </summary>
    public static int CeilToInt(float value) => (int)System.Math.Ceiling(value);
```

Ceils a float to the nearest integer.

**Returns:** `int`

**Parameters:**
- `float value`

### Approximately

```csharp
/// <summary>
    /// Checks if two floats are approximately equal within epsilon.
    /// </summary>
    public static bool Approximately(float a, float b, float epsilon = 0.00001f)
    {
        return System.Math.Abs(a - b) < epsilon;
    }
```

Checks if two floats are approximately equal within epsilon.

**Returns:** `bool`

**Parameters:**
- `float a`
- `float b`
- `float epsilon`

### Wrap

```csharp
/// <summary>
    /// Wraps a value to stay within a range [0, length).
    /// </summary>
    public static int Wrap(int value, int length)
    {
        if (length <= 0) return 0;
        int result = value % length;
        return result < 0 ? result + length : result;
    }
```

Wraps a value to stay within a range [0, length).

**Returns:** `int`

**Parameters:**
- `int value`
- `int length`

### Wrap

```csharp
/// <summary>
    /// Wraps a float value to stay within a range [0, length).
    /// </summary>
    public static float Wrap(float value, float length)
    {
        if (length <= 0) return 0;
        float result = value % length;
        return result < 0 ? result + length : result;
    }
```

Wraps a float value to stay within a range [0, length).

**Returns:** `float`

**Parameters:**
- `float value`
- `float length`

### Distance

```csharp
/// <summary>
    /// Calculates the distance between two points.
    /// </summary>
    public static float Distance(float x1, float y1, float x2, float y2)
    {
        float dx = x2 - x1;
        float dy = y2 - y1;
        return (float)System.Math.Sqrt(dx * dx + dy * dy);
    }
```

Calculates the distance between two points.

**Returns:** `float`

**Parameters:**
- `float x1`
- `float y1`
- `float x2`
- `float y2`

### DistanceSquared

```csharp
/// <summary>
    /// Calculates the squared distance between two points (faster than Distance).
    /// </summary>
    public static float DistanceSquared(float x1, float y1, float x2, float y2)
    {
        float dx = x2 - x1;
        float dy = y2 - y1;
        return dx * dx + dy * dy;
    }
```

Calculates the squared distance between two points (faster than Distance).

**Returns:** `float`

**Parameters:**
- `float x1`
- `float y1`
- `float x2`
- `float y2`

### DegToRad

```csharp
/// <summary>
    /// Converts degrees to radians.
    /// </summary>
    public static float DegToRad(float degrees)
    {
        return degrees * (float)(System.Math.PI / 180.0);
    }
```

Converts degrees to radians.

**Returns:** `float`

**Parameters:**
- `float degrees`

### RadToDeg

```csharp
/// <summary>
    /// Converts radians to degrees.
    /// </summary>
    public static float RadToDeg(float radians)
    {
        return radians * (float)(180.0 / System.Math.PI);
    }
```

Converts radians to degrees.

**Returns:** `float`

**Parameters:**
- `float radians`

### SmoothStep

```csharp
/// <summary>
    /// Smoothly interpolates between two values using cubic Hermite interpolation.
    /// </summary>
    public static float SmoothStep(float from, float to, float weight)
    {
        float t = Clamp(weight, 0f, 1f);
        t = t * t * (3f - 2f * t);
        return Lerp(from, to, t);
    }
```

Smoothly interpolates between two values using cubic Hermite interpolation.

**Returns:** `float`

**Parameters:**
- `float from`
- `float to`
- `float weight`

### MoveToward

```csharp
/// <summary>
    /// Moves a value toward a target by a maximum delta.
    /// </summary>
    public static float MoveToward(float from, float to, float delta)
    {
        if (System.Math.Abs(to - from) <= delta)
            return to;
        return from + Sign(to - from) * delta;
    }
```

Moves a value toward a target by a maximum delta.

**Returns:** `float`

**Parameters:**
- `float from`
- `float to`
- `float delta`

