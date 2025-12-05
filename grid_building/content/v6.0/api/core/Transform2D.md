---
title: "Transform2D"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/transform2d/"
---

# Transform2D

```csharp
GridBuilding.Core.Types
struct Transform2D
{
    // Members...
}
```

2D transformation matrix.
Engine-agnostic equivalent of Godot's Transform2D.
Represents position, rotation, and scale in 2D space.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Types/Transform2D.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Rotation

```csharp
// Properties
    public float Rotation => MathF.Atan2(X.Y, X.X);
```

### Scale

```csharp
public Vector2 Scale => new(X.Length, Y.Length);
```

### Skew

```csharp
public float Skew => MathF.Acos(X.Normalized().Dot(Y.Normalized())) - MathF.PI / 2;
```


## Methods

### BasisXform

```csharp
// Transform operations
    public Vector2 BasisXform(Vector2 v) => X * v.X + Y * v.Y;
```

**Returns:** `Vector2`

**Parameters:**
- `Vector2 v`

### BasisXformInv

```csharp
public Vector2 BasisXformInv(Vector2 v) => new(X.Dot(v), Y.Dot(v));
```

**Returns:** `Vector2`

**Parameters:**
- `Vector2 v`

### Xform

```csharp
public Vector2 Xform(Vector2 v) => BasisXform(v) + Origin;
```

**Returns:** `Vector2`

**Parameters:**
- `Vector2 v`

### XformInv

```csharp
public Vector2 XformInv(Vector2 v) => BasisXformInv(v - Origin);
```

**Returns:** `Vector2`

**Parameters:**
- `Vector2 v`

### Xform

```csharp
public Rect2 Xform(Rect2 rect)
    {
        var pos = Xform(rect.Position);
        var x = BasisXform(new Vector2(rect.Size.X, 0));
        var y = BasisXform(new Vector2(0, rect.Size.Y));
        
        var minX = System.Math.Min(System.Math.Min(pos.X, pos.X + x.X), System.Math.Min(pos.X + y.X, pos.X + x.X + y.X));
        var minY = System.Math.Min(System.Math.Min(pos.Y, pos.Y + x.Y), System.Math.Min(pos.Y + y.Y, pos.Y + x.Y + y.Y));
        var maxX = System.Math.Max(System.Math.Max(pos.X, pos.X + x.X), System.Math.Max(pos.X + y.X, pos.X + x.X + y.X));
        var maxY = System.Math.Max(System.Math.Max(pos.Y, pos.Y + x.Y), System.Math.Max(pos.Y + y.Y, pos.Y + x.Y + y.Y));
        
        return new Rect2(minX, minY, maxX - minX, maxY - minY);
    }
```

**Returns:** `Rect2`

**Parameters:**
- `Rect2 rect`

### Inverse

```csharp
public Transform2D Inverse()
    {
        var det = X.X * Y.Y - X.Y * Y.X;
        if (MathF.Abs(det) < 1e-10f)
            return Identity;
            
        var invDet = 1.0f / det;
        var newX = new Vector2(Y.Y * invDet, -X.Y * invDet);
        var newY = new Vector2(-Y.X * invDet, X.X * invDet);
        var newOrigin = -(newX * Origin.X + newY * Origin.Y);
        return new Transform2D(newX, newY, newOrigin);
    }
```

**Returns:** `Transform2D`

### AffineInverse

```csharp
public Transform2D AffineInverse()
    {
        var inv = Inverse();
        return new Transform2D(inv.X, inv.Y, XformInv(Vector2.Zero));
    }
```

**Returns:** `Transform2D`

### Orthonormalized

```csharp
public Transform2D Orthonormalized()
    {
        var xNorm = X.Normalized();
        var yNorm = (Y - xNorm * xNorm.Dot(Y)).Normalized();
        return new Transform2D(xNorm, yNorm, Origin);
    }
```

**Returns:** `Transform2D`

### Rotated

```csharp
public Transform2D Rotated(float angle)
    {
        var rot = new Transform2D(angle, Vector2.Zero);
        return this * rot;
    }
```

**Returns:** `Transform2D`

**Parameters:**
- `float angle`

### Scaled

```csharp
public Transform2D Scaled(Vector2 scale) =>
        new(X * scale.X, Y * scale.Y, Origin);
```

**Returns:** `Transform2D`

**Parameters:**
- `Vector2 scale`

### Translated

```csharp
public Transform2D Translated(Vector2 offset) =>
        new(X, Y, Origin + BasisXform(offset));
```

**Returns:** `Transform2D`

**Parameters:**
- `Vector2 offset`

### Interpolate

```csharp
public Transform2D Interpolate(Transform2D other, float weight)
    {
        var rot1 = Rotation;
        var rot2 = other.Rotation;
        var scale1 = Scale;
        var scale2 = other.Scale;
        var origin1 = Origin;
        var origin2 = other.Origin;

        var rotDiff = rot2 - rot1;
        // Handle angle wraparound
        if (rotDiff > MathF.PI) rotDiff -= 2 * MathF.PI;
        else if (rotDiff < -MathF.PI) rotDiff += 2 * MathF.PI;

        var newRot = rot1 + rotDiff * weight;
        var newScale = scale1.Lerp(scale2, weight);
        var newOrigin = origin1.Lerp(origin2, weight);

        return new Transform2D(newRot, newScale, 0, newOrigin);
    }
```

**Returns:** `Transform2D`

**Parameters:**
- `Transform2D other`
- `float weight`

### Equals

```csharp
// Equality
    public bool Equals(Transform2D other) => 
        X.Equals(other.X) && Y.Equals(other.Y) && Origin.Equals(other.Origin);
```

**Returns:** `bool`

**Parameters:**
- `Transform2D other`

### Equals

```csharp
public override bool Equals(object? obj) => obj is Transform2D other && Equals(other);
```

**Returns:** `bool`

**Parameters:**
- `object? obj`

### GetHashCode

```csharp
public override int GetHashCode() => HashCode.Combine(X, Y, Origin);
```

**Returns:** `int`

### ToString

```csharp
public override string ToString() => $"Transform2D(X:{X}, Y:{Y}, O:{Origin})";
```

**Returns:** `string`

