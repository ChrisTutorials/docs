---
title: "TransformData"
description: "Transform data for node positioning and manipulation
Contains position, rotation, and scale information"
weight: 10
url: "/gridbuilding/v6-0/api/core/transformdata/"
---

# TransformData

```csharp
GridBuilding.Core.Types
class TransformData
{
    // Members...
}
```

Transform data for node positioning and manipulation
Contains position, rotation, and scale information

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Common/Types/TransformData.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Position

```csharp
#region Properties
    
    /// <summary>
    /// Position in 2D space
    /// </summary>
    public Vector2 Position { get; set; }
```

Position in 2D space

### Rotation

```csharp
/// <summary>
    /// Rotation in degrees
    /// </summary>
    public float Rotation { get; set; }
```

Rotation in degrees

### Scale

```csharp
/// <summary>
    /// Scale factor
    /// </summary>
    public Vector2 Scale { get; set; }
```

Scale factor

### Transform

```csharp
/// <summary>
    /// Transform matrix (computed)
    /// </summary>
    public Transform2D Transform { get; set; }
```

Transform matrix (computed)

### Identity

```csharp
#endregion
    
    #region Static Methods
    
    /// <summary>
    /// Creates an identity transform
    /// </summary>
    public static TransformData Identity => new();
```

Creates an identity transform


## Methods

### UpdateTransform

```csharp
#endregion
    
    #region Methods
    
    /// <summary>
    /// Updates the transform matrix based on position, rotation, and scale
    /// </summary>
    public void UpdateTransform()
    {
        Transform = new Transform2D(Rotation, Position, Scale);
    }
```

Updates the transform matrix based on position, rotation, and scale

**Returns:** `void`

### Clone

```csharp
/// <summary>
    /// Creates a copy of this TransformData
    /// </summary>
    public TransformData Clone()
    {
        return new TransformData(Position, Rotation, Scale);
    }
```

Creates a copy of this TransformData

**Returns:** `TransformData`

### Lerp

```csharp
/// <summary>
    /// Linear interpolation between two transforms
    /// </summary>
    public static TransformData Lerp(TransformData a, TransformData b, float weight)
    {
        return new TransformData(
            Vector2.Lerp(a.Position, b.Position, weight),
            Mathf.Lerp(a.Rotation, b.Rotation, weight),
            Vector2.Lerp(a.Scale, b.Scale, weight)
        );
    }
```

Linear interpolation between two transforms

**Returns:** `TransformData`

**Parameters:**
- `TransformData a`
- `TransformData b`
- `float weight`

### TransformPoint

```csharp
/// <summary>
    /// Applies this transform to a point
    /// </summary>
    public Vector2 TransformPoint(Vector2 point)
    {
        return Transform * point;
    }
```

Applies this transform to a point

**Returns:** `Vector2`

**Parameters:**
- `Vector2 point`

### TransformVector

```csharp
/// <summary>
    /// Applies this transform to a vector (ignoring position)
    /// </summary>
    public Vector2 TransformVector(Vector2 vector)
    {
        return Transform.BasisXform(vector);
    }
```

Applies this transform to a vector (ignoring position)

**Returns:** `Vector2`

**Parameters:**
- `Vector2 vector`

### WithPosition

```csharp
/// <summary>
    /// Creates a transform with only position
    /// </summary>
    public static TransformData WithPosition(Vector2 position)
    {
        return new TransformData(position);
    }
```

Creates a transform with only position

**Returns:** `TransformData`

**Parameters:**
- `Vector2 position`

### WithRotation

```csharp
/// <summary>
    /// Creates a transform with only rotation
    /// </summary>
    public static TransformData WithRotation(float rotation)
    {
        return new TransformData(Vector2.Zero, rotation);
    }
```

Creates a transform with only rotation

**Returns:** `TransformData`

**Parameters:**
- `float rotation`

### WithScale

```csharp
/// <summary>
    /// Creates a transform with only scale
    /// </summary>
    public static TransformData WithScale(Vector2 scale)
    {
        return new TransformData(Vector2.Zero, 0f, scale);
    }
```

Creates a transform with only scale

**Returns:** `TransformData`

**Parameters:**
- `Vector2 scale`

