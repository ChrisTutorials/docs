---
title: "TransformData"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/transformdata/"
---

# TransformData

```csharp
GridBuilding.Godot.Tests.Manipulation.Types
class TransformData
{
    // Members...
}
```

Immutable transform data structure - mirrors GDScript ManipulationTransformData
Contains position, rotation, and scale for a 2D transform.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Integration/Manipulation/Types/TransformData.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Manipulation.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Position

```csharp
public Vector2TypeSafe Position { get; }
```

### Rotation

```csharp
public float Rotation { get; }
```

### Scale

```csharp
public Vector2TypeSafe Scale { get; }
```


## Methods

### Identity

```csharp
/// <summary>
    /// Creates a default identity transform (zero position, zero rotation, unit scale)
    /// </summary>
    public static TransformData Identity() => new(
        Vector2TypeSafe.Zero(),
        0.0f,
        Vector2TypeSafe.One()
    );
```

Creates a default identity transform (zero position, zero rotation, unit scale)

**Returns:** `TransformData`

### IsValid

```csharp
/// <summary>
    /// Checks if all transform components are valid (no NaN or Infinity values)
    /// </summary>
    public bool IsValid() =>
        Position.IsValid() &&
        !float.IsNaN(Rotation) && !float.IsInfinity(Rotation) &&
        Scale.IsValid();
```

Checks if all transform components are valid (no NaN or Infinity values)

**Returns:** `bool`

### HasValidScale

```csharp
/// <summary>
    /// Checks if the transform has a valid scale (non-zero absolute values)
    /// </summary>
    public bool HasValidScale(float minAbsoluteValue = 0.01f) =>
        Scale.IsValidScale(minAbsoluteValue);
```

Checks if the transform has a valid scale (non-zero absolute values)

**Returns:** `bool`

**Parameters:**
- `float minAbsoluteValue`

### ToString

```csharp
public override string ToString() =>
        $"TransformData(Position: {Position}, Rotation: {Rotation:F4}, Scale: {Scale})";
```

**Returns:** `string`

