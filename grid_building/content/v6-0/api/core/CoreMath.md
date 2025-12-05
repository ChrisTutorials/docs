---
title: "CoreMath"
description: "Core mathematical functions for GridBuilding.
Provides pure C# implementations of common math operations
without dependencies on System.Math static class."
weight: 10
url: "/gridbuilding/v6-0/api/core/coremath/"
---

# CoreMath

```csharp
GridBuilding.Core.Math
class CoreMath
{
    // Members...
}
```

Core mathematical functions for GridBuilding.
Provides pure C# implementations of common math operations
without dependencies on System.Math static class.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/CoreMath.cs`  
**Namespace:** `GridBuilding.Core.Math`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Abs

```csharp
#endregion

    #region Basic Operations

    /// <summary>
    /// Returns the absolute value of a number
    /// </summary>
    public static int Abs(int value) => value >= 0 ? value : -value;
```

Returns the absolute value of a number

**Returns:** `int`

**Parameters:**
- `int value`

### Abs

```csharp
/// <summary>
    /// Returns the absolute value of a number
    /// </summary>
    public static float Abs(float value) => value >= 0.0f ? value : -value;
```

Returns the absolute value of a number

**Returns:** `float`

**Parameters:**
- `float value`

### Abs

```csharp
/// <summary>
    /// Returns the absolute value of a number
    /// </summary>
    public static double Abs(double value) => value >= 0.0 ? value : -value;
```

Returns the absolute value of a number

**Returns:** `double`

**Parameters:**
- `double value`

### Sign

```csharp
/// <summary>
    /// Returns the sign of a number (-1, 0, or 1)
    /// </summary>
    public static int Sign(int value) => value < 0 ? -1 : value > 0 ? 1 : 0;
```

Returns the sign of a number (-1, 0, or 1)

**Returns:** `int`

**Parameters:**
- `int value`

### Sign

```csharp
/// <summary>
    /// Returns the sign of a number (-1, 0, or 1)
    /// </summary>
    public static int Sign(float value) => value < 0.0f ? -1 : value > 0.0f ? 1 : 0;
```

Returns the sign of a number (-1, 0, or 1)

**Returns:** `int`

**Parameters:**
- `float value`

### Sign

```csharp
/// <summary>
    /// Returns the sign of a number (-1, 0, or 1)
    /// </summary>
    public static int Sign(double value) => value < 0.0 ? -1 : value > 0.0 ? 1 : 0;
```

Returns the sign of a number (-1, 0, or 1)

**Returns:** `int`

**Parameters:**
- `double value`

### Min

```csharp
/// <summary>
    /// Returns the smaller of two values
    /// </summary>
    public static int Min(int a, int b) => a < b ? a : b;
```

Returns the smaller of two values

**Returns:** `int`

**Parameters:**
- `int a`
- `int b`

### Min

```csharp
/// <summary>
    /// Returns the smaller of two values
    /// </summary>
    public static float Min(float a, float b) => a < b ? a : b;
```

Returns the smaller of two values

**Returns:** `float`

**Parameters:**
- `float a`
- `float b`

### Min

```csharp
/// <summary>
    /// Returns the smaller of two values
    /// </summary>
    public static double Min(double a, double b) => a < b ? a : b;
```

Returns the smaller of two values

**Returns:** `double`

**Parameters:**
- `double a`
- `double b`

### Max

```csharp
/// <summary>
    /// Returns the larger of two values
    /// </summary>
    public static int Max(int a, int b) => a > b ? a : b;
```

Returns the larger of two values

**Returns:** `int`

**Parameters:**
- `int a`
- `int b`

### Max

```csharp
/// <summary>
    /// Returns the larger of two values
    /// </summary>
    public static float Max(float a, float b) => a > b ? a : b;
```

Returns the larger of two values

**Returns:** `float`

**Parameters:**
- `float a`
- `float b`

### Max

```csharp
/// <summary>
    /// Returns the larger of two values
    /// </summary>
    public static double Max(double a, double b) => a > b ? a : b;
```

Returns the larger of two values

**Returns:** `double`

**Parameters:**
- `double a`
- `double b`

### Clamp

```csharp
/// <summary>
    /// Clamps a value between a minimum and maximum
    /// </summary>
    public static int Clamp(int value, int min, int max) => value < min ? min : value > max ? max : value;
```

Clamps a value between a minimum and maximum

**Returns:** `int`

**Parameters:**
- `int value`
- `int min`
- `int max`

### Clamp

```csharp
/// <summary>
    /// Clamps a value between a minimum and maximum
    /// </summary>
    public static float Clamp(float value, float min, float max) => value < min ? min : value > max ? max : value;
```

Clamps a value between a minimum and maximum

**Returns:** `float`

**Parameters:**
- `float value`
- `float min`
- `float max`

### Clamp

```csharp
/// <summary>
    /// Clamps a value between a minimum and maximum
    /// </summary>
    public static double Clamp(double value, double min, double max) => value < min ? min : value > max ? max : value;
```

Clamps a value between a minimum and maximum

**Returns:** `double`

**Parameters:**
- `double value`
- `double min`
- `double max`

### Round

```csharp
#endregion

    #region Rounding

    /// <summary>
    /// Rounds a value to the nearest integer
    /// </summary>
    public static int Round(float value) => (int)System.Math.Round(value);
```

Rounds a value to the nearest integer

**Returns:** `int`

**Parameters:**
- `float value`

### Round

```csharp
/// <summary>
    /// Rounds a value to the nearest integer
    /// </summary>
    public static int Round(double value) => (int)System.Math.Round(value);
```

Rounds a value to the nearest integer

**Returns:** `int`

**Parameters:**
- `double value`

### Floor

```csharp
/// <summary>
    /// Returns the largest integer less than or equal to the specified value
    /// </summary>
    public static int Floor(float value) => (int)System.Math.Floor(value);
```

Returns the largest integer less than or equal to the specified value

**Returns:** `int`

**Parameters:**
- `float value`

### Floor

```csharp
/// <summary>
    /// Returns the largest integer less than or equal to the specified value
    /// </summary>
    public static int Floor(double value) => (int)System.Math.Floor(value);
```

Returns the largest integer less than or equal to the specified value

**Returns:** `int`

**Parameters:**
- `double value`

### Ceiling

```csharp
/// <summary>
    /// Returns the smallest integer greater than or equal to the specified value
    /// </summary>
    public static int Ceiling(float value) => (int)System.Math.Ceiling(value);
```

Returns the smallest integer greater than or equal to the specified value

**Returns:** `int`

**Parameters:**
- `float value`

### Ceiling

```csharp
/// <summary>
    /// Returns the smallest integer greater than or equal to the specified value
    /// </summary>
    public static int Ceiling(double value) => (int)System.Math.Ceiling(value);
```

Returns the smallest integer greater than or equal to the specified value

**Returns:** `int`

**Parameters:**
- `double value`

### Pow

```csharp
#endregion

    #region Powers and Roots

    /// <summary>
    /// Returns a specified number raised to the specified power
    /// </summary>
    public static double Pow(double x, double y) => System.Math.Pow(x, y);
```

Returns a specified number raised to the specified power

**Returns:** `double`

**Parameters:**
- `double x`
- `double y`

### Sqrt

```csharp
/// <summary>
    /// Returns the square root of a specified number
    /// </summary>
    public static double Sqrt(double value) => System.Math.Sqrt(value);
```

Returns the square root of a specified number

**Returns:** `double`

**Parameters:**
- `double value`

### Cos

```csharp
#endregion

    #region Trigonometry

    /// <summary>
    /// Returns the cosine of the specified angle
    /// </summary>
    public static double Cos(double angle) => System.Math.Cos(angle);
```

Returns the cosine of the specified angle

**Returns:** `double`

**Parameters:**
- `double angle`

### Sin

```csharp
/// <summary>
    /// Returns the sine of the specified angle
    /// </summary>
    public static double Sin(double angle) => System.Math.Sin(angle);
```

Returns the sine of the specified angle

**Returns:** `double`

**Parameters:**
- `double angle`

### Tan

```csharp
/// <summary>
    /// Returns the tangent of the specified angle
    /// </summary>
    public static double Tan(double angle) => Math.Tan(angle);
```

Returns the tangent of the specified angle

**Returns:** `double`

**Parameters:**
- `double angle`

### Acos

```csharp
/// <summary>
    /// Returns the angle whose cosine is the specified number
    /// </summary>
    public static double Acos(double value) => Math.Acos(value);
```

Returns the angle whose cosine is the specified number

**Returns:** `double`

**Parameters:**
- `double value`

### Asin

```csharp
/// <summary>
    /// Returns the angle whose sine is the specified number
    /// </summary>
    public static double Asin(double value) => Math.Asin(value);
```

Returns the angle whose sine is the specified number

**Returns:** `double`

**Parameters:**
- `double value`

### Atan

```csharp
/// <summary>
    /// Returns the angle whose tangent is the specified number
    /// </summary>
    public static double Atan(double value) => Math.Atan(value);
```

Returns the angle whose tangent is the specified number

**Returns:** `double`

**Parameters:**
- `double value`

### Atan2

```csharp
/// <summary>
    /// Returns the angle whose tangent is the quotient of two specified numbers
    /// </summary>
    public static double Atan2(double y, double x) => System.Math.Atan2(y, x);
```

Returns the angle whose tangent is the quotient of two specified numbers

**Returns:** `double`

**Parameters:**
- `double y`
- `double x`

### Approximately

```csharp
#endregion

    #region Comparison

    /// <summary>
    /// Determines if two floating point values are approximately equal within epsilon
    /// </summary>
    public static bool Approximately(float a, float b) => Abs(a - b) < Epsilon;
```

Determines if two floating point values are approximately equal within epsilon

**Returns:** `bool`

**Parameters:**
- `float a`
- `float b`

### Approximately

```csharp
/// <summary>
    /// Determines if two floating point values are approximately equal within epsilon
    /// </summary>
    public static bool Approximately(double a, double b) => Abs(a - b) < Epsilon;
```

Determines if two floating point values are approximately equal within epsilon

**Returns:** `bool`

**Parameters:**
- `double a`
- `double b`

