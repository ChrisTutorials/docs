---
title: "Mathf"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/mathf/"
---

# Mathf

```csharp
GridBuilding.Core.Common.Types
class Mathf
{
    // Members...
}
```

Math utility class compatible with Godot's Mathf API.
Engine-agnostic implementation for unit testing.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Common/Types/GodotTypes.cs`  
**Namespace:** `GridBuilding.Core.Common.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Abs

```csharp
public static float Abs(float x) => MathF.Abs(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Abs

```csharp
public static int Abs(int x) => System.Math.Abs(x);
```

**Returns:** `int`

**Parameters:**
- `int x`

### Acos

```csharp
public static float Acos(float x) => MathF.Acos(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Asin

```csharp
public static float Asin(float x) => MathF.Asin(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Atan

```csharp
public static float Atan(float x) => MathF.Atan(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Atan2

```csharp
public static float Atan2(float y, float x) => MathF.Atan2(y, x);
```

**Returns:** `float`

**Parameters:**
- `float y`
- `float x`

### Ceil

```csharp
public static float Ceil(float x) => MathF.Ceiling(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### CeilToInt

```csharp
public static int CeilToInt(float x) => (int)MathF.Ceiling(x);
```

**Returns:** `int`

**Parameters:**
- `float x`

### Clamp

```csharp
public static float Clamp(float value, float min, float max) => System.Math.Clamp(value, min, max);
```

**Returns:** `float`

**Parameters:**
- `float value`
- `float min`
- `float max`

### Clamp

```csharp
public static int Clamp(int value, int min, int max) => System.Math.Clamp(value, min, max);
```

**Returns:** `int`

**Parameters:**
- `int value`
- `int min`
- `int max`

### Cos

```csharp
public static float Cos(float x) => MathF.Cos(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Cosh

```csharp
public static float Cosh(float x) => MathF.Cosh(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### DegToRad

```csharp
public static float DegToRad(float deg) => deg * Pi / 180f;
```

**Returns:** `float`

**Parameters:**
- `float deg`

### RadToDeg

```csharp
public static float RadToDeg(float rad) => rad * 180f / Pi;
```

**Returns:** `float`

**Parameters:**
- `float rad`

### Exp

```csharp
public static float Exp(float x) => MathF.Exp(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Floor

```csharp
public static float Floor(float x) => MathF.Floor(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### FloorToInt

```csharp
public static int FloorToInt(float x) => (int)MathF.Floor(x);
```

**Returns:** `int`

**Parameters:**
- `float x`

### IsEqualApprox

```csharp
public static bool IsEqualApprox(float a, float b, float tolerance = Epsilon) => MathF.Abs(a - b) < tolerance;
```

**Returns:** `bool`

**Parameters:**
- `float a`
- `float b`
- `float tolerance`

### IsZeroApprox

```csharp
public static bool IsZeroApprox(float x, float tolerance = Epsilon) => MathF.Abs(x) < tolerance;
```

**Returns:** `bool`

**Parameters:**
- `float x`
- `float tolerance`

### IsFinite

```csharp
public static bool IsFinite(float x) => float.IsFinite(x);
```

**Returns:** `bool`

**Parameters:**
- `float x`

### IsInf

```csharp
public static bool IsInf(float x) => float.IsInfinity(x);
```

**Returns:** `bool`

**Parameters:**
- `float x`

### IsNaN

```csharp
public static bool IsNaN(float x) => float.IsNaN(x);
```

**Returns:** `bool`

**Parameters:**
- `float x`

### Lerp

```csharp
public static float Lerp(float a, float b, float t) => a + (b - a) * t;
```

**Returns:** `float`

**Parameters:**
- `float a`
- `float b`
- `float t`

### LerpAngle

```csharp
public static float LerpAngle(float from, float to, float weight)
    {
        var diff = (to - from) % Tau;
        var distance = (2 * diff) % Tau - diff;
        return from + distance * weight;
    }
```

**Returns:** `float`

**Parameters:**
- `float from`
- `float to`
- `float weight`

### InverseLerp

```csharp
public static float InverseLerp(float from, float to, float value) => (value - from) / (to - from);
```

**Returns:** `float`

**Parameters:**
- `float from`
- `float to`
- `float value`

### Log

```csharp
public static float Log(float x) => MathF.Log(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Log10

```csharp
public static float Log10(float x) => MathF.Log10(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Max

```csharp
public static float Max(float a, float b) => MathF.Max(a, b);
```

**Returns:** `float`

**Parameters:**
- `float a`
- `float b`

### Max

```csharp
public static int Max(int a, int b) => System.Math.Max(a, b);
```

**Returns:** `int`

**Parameters:**
- `int a`
- `int b`

### Min

```csharp
public static float Min(float a, float b) => MathF.Min(a, b);
```

**Returns:** `float`

**Parameters:**
- `float a`
- `float b`

### Min

```csharp
public static int Min(int a, int b) => System.Math.Min(a, b);
```

**Returns:** `int`

**Parameters:**
- `int a`
- `int b`

### MoveToward

```csharp
public static float MoveToward(float from, float to, float delta)
    {
        if (MathF.Abs(to - from) <= delta) return to;
        return from + MathF.Sign(to - from) * delta;
    }
```

**Returns:** `float`

**Parameters:**
- `float from`
- `float to`
- `float delta`

### NearestPo2

```csharp
public static int NearestPo2(int value)
    {
        value--;
        value |= value >> 1;
        value |= value >> 2;
        value |= value >> 4;
        value |= value >> 8;
        value |= value >> 16;
        return value + 1;
    }
```

**Returns:** `int`

**Parameters:**
- `int value`

### Pingpong

```csharp
public static float Pingpong(float value, float length) =>
        length != 0 ? MathF.Abs((value % (length * 2)) - length) : 0;
```

**Returns:** `float`

**Parameters:**
- `float value`
- `float length`

### Pow

```csharp
public static float Pow(float x, float y) => MathF.Pow(x, y);
```

**Returns:** `float`

**Parameters:**
- `float x`
- `float y`

### Round

```csharp
public static float Round(float x) => MathF.Round(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### RoundToInt

```csharp
public static int RoundToInt(float x) => (int)MathF.Round(x);
```

**Returns:** `int`

**Parameters:**
- `float x`

### Sign

```csharp
public static float Sign(float x) => MathF.Sign(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Sign

```csharp
public static int Sign(int x) => Math.Sign(x);
```

**Returns:** `int`

**Parameters:**
- `int x`

### Sin

```csharp
public static float Sin(float x) => MathF.Sin(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Sinh

```csharp
public static float Sinh(float x) => MathF.Sinh(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Smoothstep

```csharp
public static float Smoothstep(float from, float to, float t)
    {
        t = Clamp((t - from) / (to - from), 0f, 1f);
        return t * t * (3 - 2 * t);
    }
```

**Returns:** `float`

**Parameters:**
- `float from`
- `float to`
- `float t`

### Sqrt

```csharp
public static float Sqrt(float x) => MathF.Sqrt(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### StepDecimals

```csharp
public static float StepDecimals(float step)
    {
        var abs = MathF.Abs(step);
        if (abs < 1e-10f) return 0;
        return MathF.Max(0, -MathF.Floor(MathF.Log10(abs)));
    }
```

**Returns:** `float`

**Parameters:**
- `float step`

### Tan

```csharp
public static float Tan(float x) => MathF.Tan(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Tanh

```csharp
public static float Tanh(float x) => MathF.Tanh(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Wrap

```csharp
public static int Wrap(int value, int min, int max) => ((value - min) % (max - min) + (max - min)) % (max - min) + min;
```

**Returns:** `int`

**Parameters:**
- `int value`
- `int min`
- `int max`

### Wrap

```csharp
public static float Wrap(float value, float min, float max) => ((value - min) % (max - min) + (max - min)) % (max - min) + min;
```

**Returns:** `float`

**Parameters:**
- `float value`
- `float min`
- `float max`

