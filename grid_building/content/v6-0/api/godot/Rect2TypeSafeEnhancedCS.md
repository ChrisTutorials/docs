---
title: "Rect2TypeSafeEnhancedCS"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/rect2typesafeenhancedcs/"
---

# Rect2TypeSafeEnhancedCS

```csharp
GridBuilding.Godot.Tests.Geometry
class Rect2TypeSafeEnhancedCS
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

### Position

```csharp
public Vector2TypeSafeEnhancedCS Position { get; }
```

### Size

```csharp
public Vector2TypeSafeEnhancedCS Size { get; }
```


## Methods

### IsValid

```csharp
public bool IsValid() => Position != null && Size != null && Size.X >= 0 && Size.Y >= 0;
```

**Returns:** `bool`

### GetArea

```csharp
public float GetArea() => Size.X * Size.Y;
```

**Returns:** `float`

