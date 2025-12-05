---
title: "Mathf"
description: "Mathf static class - mirrors Godot.Mathf"
weight: 20
url: "/gridbuilding/v6-0/api/godot/mathf/"
---

# Mathf

```csharp
GridBuilding.Godot.Tests.Helpers
class Mathf
{
    // Members...
}
```

Mathf static class - mirrors Godot.Mathf

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GodotTypes.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Floor

```csharp
public static float Floor(float x) => MathF.Floor(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Ceil

```csharp
public static float Ceil(float x) => MathF.Ceiling(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Round

```csharp
public static float Round(float x) => MathF.Round(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Abs

```csharp
public static float Abs(float x) => MathF.Abs(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Sqrt

```csharp
public static float Sqrt(float x) => MathF.Sqrt(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Sin

```csharp
public static float Sin(float x) => MathF.Sin(x);
```

**Returns:** `float`

**Parameters:**
- `float x`

### Cos

```csharp
public static float Cos(float x) => MathF.Cos(x);
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

### Clamp

```csharp
public static float Clamp(float value, float min, float max) => Math.Clamp(value, min, max);
```

**Returns:** `float`

**Parameters:**
- `float value`
- `float min`
- `float max`

### Lerp

```csharp
public static float Lerp(float a, float b, float t) => a + (b - a) * t;
```

**Returns:** `float`

**Parameters:**
- `float a`
- `float b`
- `float t`

### Min

```csharp
public static float Min(float a, float b) => MathF.Min(a, b);
```

**Returns:** `float`

**Parameters:**
- `float a`
- `float b`

### Max

```csharp
public static float Max(float a, float b) => MathF.Max(a, b);
```

**Returns:** `float`

**Parameters:**
- `float a`
- `float b`

### IsEqualApprox

```csharp
public static bool IsEqualApprox(float a, float b, float tolerance = 0.00001f) 
        => MathF.Abs(a - b) < tolerance;
```

**Returns:** `bool`

**Parameters:**
- `float a`
- `float b`
- `float tolerance`

