---
title: "MathHelper"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/mathhelper/"
---

# MathHelper

```csharp
GridBuilding.Godot.Tests.Helpers
class MathHelper
{
    // Members...
}
```

Math helpers that mirror GDScript built-in functions

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GodotTypes.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### DegToRad

```csharp
public static float DegToRad(float degrees) => degrees * MathF.PI / 180f;
```

**Returns:** `float`

**Parameters:**
- `float degrees`

### RadToDeg

```csharp
public static float RadToDeg(float radians) => radians * 180f / MathF.PI;
```

**Returns:** `float`

**Parameters:**
- `float radians`

### Lerp

```csharp
public static float Lerp(float a, float b, float t) => a + (b - a) * t;
```

**Returns:** `float`

**Parameters:**
- `float a`
- `float b`
- `float t`

### Lerp

```csharp
public static Vector2 Lerp(Vector2 a, Vector2 b, float t) => a + (b - a) * t;
```

**Returns:** `Vector2`

**Parameters:**
- `Vector2 a`
- `Vector2 b`
- `float t`

