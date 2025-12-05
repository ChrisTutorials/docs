---
title: "ManipulationTransformHandler"
description: "Handles all transform operations (rotation, flip) for manipulated objects.
Responsibilities:
- Apply rotation transformations
- Apply horizontal/vertical flips
- Preserve transform state
- Provide rotation utility functions
Ported from: godot/addons/grid_building/systems/manipulation/handlers/manipulation_transform_handler.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/manipulationtransformhandler/"
---

# ManipulationTransformHandler

```csharp
GridBuilding.Godot.Systems.Manipulation.Internal
class ManipulationTransformHandler
{
    // Members...
}
```

Handles all transform operations (rotation, flip) for manipulated objects.
Responsibilities:
- Apply rotation transformations
- Apply horizontal/vertical flips
- Preserve transform state
- Provide rotation utility functions
Ported from: godot/addons/grid_building/systems/manipulation/handlers/manipulation_transform_handler.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/Internal/ManipulationTransformHandler.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Internal`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ApplyRotation

```csharp
#region Public Methods

    /// <summary>
    /// Applies rotation to target node.
    /// </summary>
    /// <param name="target">Node to rotate</param>
    /// <param name="degrees">Rotation amount in degrees (0-360)</param>
    public void ApplyRotation(Node? target, float degrees)
    {
        if (target == null)
            return;

        if (target is not Node2D node2D)
            return;

        node2D.RotationDegrees += degrees;
    }
```

Applies rotation to target node.

**Returns:** `void`

**Parameters:**
- `Node? target`
- `float degrees`

### ApplyFlipHorizontal

```csharp
/// <summary>
    /// Applies horizontal flip (mirror across Y axis).
    /// </summary>
    /// <param name="target">Node to flip</param>
    public void ApplyFlipHorizontal(Node? target)
    {
        if (target == null)
            return;

        if (target is not Node2D node2D)
            return;

        node2D.Scale = new Vector2(node2D.Scale.X * -1.0f, node2D.Scale.Y);
    }
```

Applies horizontal flip (mirror across Y axis).

**Returns:** `void`

**Parameters:**
- `Node? target`

### ApplyFlipVertical

```csharp
/// <summary>
    /// Applies vertical flip (mirror across X axis).
    /// </summary>
    /// <param name="target">Node to flip</param>
    public void ApplyFlipVertical(Node? target)
    {
        if (target == null)
            return;

        if (target is not Node2D node2D)
            return;

        node2D.Scale = new Vector2(node2D.Scale.X, node2D.Scale.Y * -1.0f);
    }
```

Applies vertical flip (mirror across X axis).

**Returns:** `void`

**Parameters:**
- `Node? target`

### ApplyRotationRadians

```csharp
/// <summary>
    /// Applies rotation in radians to target node.
    /// </summary>
    /// <param name="target">Node to rotate</param>
    /// <param name="radians">Rotation amount in radians</param>
    public void ApplyRotationRadians(Node? target, float radians)
    {
        if (target == null)
            return;

        if (target is not Node2D node2D)
            return;

        node2D.Rotation += radians;
    }
```

Applies rotation in radians to target node.

**Returns:** `void`

**Parameters:**
- `Node? target`
- `float radians`

### SetRotation

```csharp
/// <summary>
    /// Sets absolute rotation of target node.
    /// </summary>
    /// <param name="target">Node to rotate</param>
    /// <param name="degrees">Absolute rotation in degrees</param>
    public void SetRotation(Node? target, float degrees)
    {
        if (target == null)
            return;

        if (target is not Node2D node2D)
            return;

        node2D.RotationDegrees = degrees;
    }
```

Sets absolute rotation of target node.

**Returns:** `void`

**Parameters:**
- `Node? target`
- `float degrees`

### SetRotationRadians

```csharp
/// <summary>
    /// Sets absolute rotation of target node in radians.
    /// </summary>
    /// <param name="target">Node to rotate</param>
    /// <param name="radians">Absolute rotation in radians</param>
    public void SetRotationRadians(Node? target, float radians)
    {
        if (target == null)
            return;

        if (target is not Node2D node2D)
            return;

        node2D.Rotation = radians;
    }
```

Sets absolute rotation of target node in radians.

**Returns:** `void`

**Parameters:**
- `Node? target`
- `float radians`

### ResetRotation

```csharp
/// <summary>
    /// Resets rotation to identity (0 degrees).
    /// </summary>
    /// <param name="target">Node to reset</param>
    public void ResetRotation(Node? target)
    {
        SetRotation(target, 0f);
    }
```

Resets rotation to identity (0 degrees).

**Returns:** `void`

**Parameters:**
- `Node? target`

### ResetScale

```csharp
/// <summary>
    /// Resets scale to identity (1, 1).
    /// </summary>
    /// <param name="target">Node to reset</param>
    public void ResetScale(Node? target)
    {
        if (target == null)
            return;

        if (target is not Node2D node2D)
            return;

        node2D.Scale = Vector2.One;
    }
```

Resets scale to identity (1, 1).

**Returns:** `void`

**Parameters:**
- `Node? target`

### ResetTransform

```csharp
/// <summary>
    /// Resets transform to identity (position: 0,0, rotation: 0°, scale: 1,1).
    /// </summary>
    /// <param name="target">Node to reset</param>
    public void ResetTransform(Node? target)
    {
        if (target == null)
            return;

        if (target is not Node2D node2D)
            return;

        node2D.Position = Vector2.Zero;
        node2D.Rotation = 0f;
        node2D.Scale = Vector2.One;
    }
```

Resets transform to identity (position: 0,0, rotation: 0°, scale: 1,1).

**Returns:** `void`

**Parameters:**
- `Node? target`

### GetRotationDegrees

```csharp
/// <summary>
    /// Gets the current rotation in degrees.
    /// </summary>
    /// <param name="target">Node to query</param>
    /// <returns>Current rotation in degrees, or 0 if invalid</returns>
    public float GetRotationDegrees(Node? target)
    {
        if (target is Node2D node2D)
            return node2D.RotationDegrees;
        
        return 0f;
    }
```

Gets the current rotation in degrees.

**Returns:** `float`

**Parameters:**
- `Node? target`

### GetRotationRadians

```csharp
/// <summary>
    /// Gets the current rotation in radians.
    /// </summary>
    /// <param name="target">Node to query</param>
    /// <returns>Current rotation in radians, or 0 if invalid</returns>
    public float GetRotationRadians(Node? target)
    {
        if (target is Node2D node2D)
            return node2D.Rotation;
        
        return 0f;
    }
```

Gets the current rotation in radians.

**Returns:** `float`

**Parameters:**
- `Node? target`

### GetScale

```csharp
/// <summary>
    /// Gets the current scale.
    /// </summary>
    /// <param name="target">Node to query</param>
    /// <returns>Current scale, or Vector2.One if invalid</returns>
    public Vector2 GetScale(Node? target)
    {
        if (target is Node2D node2D)
            return node2D.Scale;
        
        return Vector2.One;
    }
```

Gets the current scale.

**Returns:** `Vector2`

**Parameters:**
- `Node? target`

### IsFlippedHorizontal

```csharp
/// <summary>
    /// Checks if the target is flipped horizontally.
    /// </summary>
    /// <param name="target">Node to check</param>
    /// <returns>True if flipped horizontally (scale X is negative)</returns>
    public bool IsFlippedHorizontal(Node? target)
    {
        if (target is Node2D node2D)
            return node2D.Scale.X < 0f;
        
        return false;
    }
```

Checks if the target is flipped horizontally.

**Returns:** `bool`

**Parameters:**
- `Node? target`

### IsFlippedVertical

```csharp
/// <summary>
    /// Checks if the target is flipped vertically.
    /// </summary>
    /// <param name="target">Node to check</param>
    /// <returns>True if flipped vertically (scale Y is negative)</returns>
    public bool IsFlippedVertical(Node? target)
    {
        if (target is Node2D node2D)
            return node2D.Scale.Y < 0f;
        
        return false;
    }
```

Checks if the target is flipped vertically.

**Returns:** `bool`

**Parameters:**
- `Node? target`

### NormalizeRotation

```csharp
/// <summary>
    /// Normalizes rotation to 0-360 degree range.
    /// </summary>
    /// <param name="degrees">Rotation to normalize</param>
    /// <returns>Normalized rotation in degrees</returns>
    public static float NormalizeRotation(float degrees)
    {
        degrees = degrees % 360f;
        if (degrees < 0f)
            degrees += 360f;
        return degrees;
    }
```

Normalizes rotation to 0-360 degree range.

**Returns:** `float`

**Parameters:**
- `float degrees`

### NormalizeRotationRadians

```csharp
/// <summary>
    /// Normalizes rotation to 0-2π radian range.
    /// </summary>
    /// <param name="radians">Rotation to normalize</param>
    /// <returns>Normalized rotation in radians</returns>
    public static float NormalizeRotationRadians(float radians)
    {
        const float twoPi = 2f * Mathf.Pi;
        radians = radians % twoPi;
        if (radians < 0f)
            radians += twoPi;
        return radians;
    }
```

Normalizes rotation to 0-2π radian range.

**Returns:** `float`

**Parameters:**
- `float radians`

### DegreesToRadians

```csharp
/// <summary>
    /// Converts degrees to radians.
    /// </summary>
    /// <param name="degrees">Angle in degrees</param>
    /// <returns>Angle in radians</returns>
    public static float DegreesToRadians(float degrees)
    {
        return degrees * Mathf.Pi / 180f;
    }
```

Converts degrees to radians.

**Returns:** `float`

**Parameters:**
- `float degrees`

### RadiansToDegrees

```csharp
/// <summary>
    /// Converts radians to degrees.
    /// </summary>
    /// <param name="radians">Angle in radians</param>
    /// <returns>Angle in degrees</returns>
    public static float RadiansToDegrees(float radians)
    {
        return radians * 180f / Mathf.Pi;
    }
```

Converts radians to degrees.

**Returns:** `float`

**Parameters:**
- `float radians`

### ApplySnappedRotation

```csharp
/// <summary>
    /// Applies a rotation that snaps to the nearest increment.
    /// </summary>
    /// <param name="target">Node to rotate</param>
    /// <param name="degrees">Desired rotation in degrees</param>
    /// <param name="increment">Snap increment in degrees</param>
    public void ApplySnappedRotation(Node? target, float degrees, float increment)
    {
        if (target is not Node2D node2D)
            return;

        var newRotation = node2D.RotationDegrees + degrees;
        var snappedRotation = Mathf.Round(newRotation / increment) * increment;
        node2D.RotationDegrees = snappedRotation;
    }
```

Applies a rotation that snaps to the nearest increment.

**Returns:** `void`

**Parameters:**
- `Node? target`
- `float degrees`
- `float increment`

