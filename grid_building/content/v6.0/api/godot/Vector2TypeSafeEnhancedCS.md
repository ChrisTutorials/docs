---
title: "Vector2TypeSafeEnhancedCS"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/vector2typesafeenhancedcs/"
---

# Vector2TypeSafeEnhancedCS

```csharp
GridBuilding.Godot.Tests.Geometry
class Vector2TypeSafeEnhancedCS
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Geometry/GeometryMathEnhancedTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Geometry`  
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
public static Vector2TypeSafeEnhancedCS Zero() => new Vector2TypeSafeEnhancedCS(0.0f, 0.0f);
```

**Returns:** `Vector2TypeSafeEnhancedCS`

### One

```csharp
public static Vector2TypeSafeEnhancedCS One() => new Vector2TypeSafeEnhancedCS(1.0f, 1.0f);
```

**Returns:** `Vector2TypeSafeEnhancedCS`

### Add

```csharp
public Vector2TypeSafeEnhancedCS Add(Vector2TypeSafeEnhancedCS other) 
            => new Vector2TypeSafeEnhancedCS(X + other.X, Y + other.Y);
```

**Returns:** `Vector2TypeSafeEnhancedCS`

**Parameters:**
- `Vector2TypeSafeEnhancedCS other`

### IsEqualTo

```csharp
public bool IsEqualTo(Vector2TypeSafeEnhancedCS other, float tolerance = 0.0001f)
            => Math.Abs(X - other.X) < tolerance && Math.Abs(Y - other.Y) < tolerance;
```

**Returns:** `bool`

**Parameters:**
- `Vector2TypeSafeEnhancedCS other`
- `float tolerance`

