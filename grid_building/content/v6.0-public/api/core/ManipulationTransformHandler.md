---
title: "ManipulationTransformHandler"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/manipulationtransformhandler/"
---

# ManipulationTransformHandler

```csharp
GridBuilding.Core.Services.Manipulation
class ManipulationTransformHandler
{
    // Members...
}
```

Core transform operations for manipulated objects (engine-agnostic).
Handles rotation, flip, and other transform operations without engine dependencies.
Responsibilities:
- Apply rotation transformations
- Apply horizontal/vertical flips
- Preserve transform state
- Provide rotation utility functions

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Manipulation/ManipulationTransformHandler.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ApplyRotation

```csharp
#region Public Methods

        /// <summary>
        /// Applies rotation to target transform.
        /// </summary>
        /// <param name="currentRotation">Current rotation in degrees</param>
        /// <param name="degrees">Rotation amount in degrees (0-360)</param>
        /// <returns>New rotation in degrees</returns>
        public float ApplyRotation(float currentRotation, float degrees)
        {
            return currentRotation + degrees;
        }
```

Applies rotation to target transform.

**Returns:** `float`

**Parameters:**
- `float currentRotation`
- `float degrees`

### ApplyFlipHorizontal

```csharp
/// <summary>
        /// Applies horizontal flip (mirror across Y axis).
        /// </summary>
        /// <param name="currentScale">Current scale vector</param>
        /// <returns>New scale vector with horizontal flip applied</returns>
        public Vector2 ApplyFlipHorizontal(Vector2 currentScale)
        {
            return new Vector2(currentScale.X * -1.0f, currentScale.Y);
        }
```

Applies horizontal flip (mirror across Y axis).

**Returns:** `Vector2`

**Parameters:**
- `Vector2 currentScale`

### ApplyFlipVertical

```csharp
/// <summary>
        /// Applies vertical flip (mirror across X axis).
        /// </summary>
        /// <param name="currentScale">Current scale vector</param>
        /// <returns>New scale vector with vertical flip applied</returns>
        public Vector2 ApplyFlipVertical(Vector2 currentScale)
        {
            return new Vector2(currentScale.X, currentScale.Y * -1.0f);
        }
```

Applies vertical flip (mirror across X axis).

**Returns:** `Vector2`

**Parameters:**
- `Vector2 currentScale`

### ApplyRotationRadians

```csharp
/// <summary>
        /// Applies rotation in radians to target transform.
        /// </summary>
        /// <param name="currentRotation">Current rotation in radians</param>
        /// <param name="radians">Rotation amount in radians</param>
        /// <returns>New rotation in radians</returns>
        public float ApplyRotationRadians(float currentRotation, float radians)
        {
            return currentRotation + radians;
        }
```

Applies rotation in radians to target transform.

**Returns:** `float`

**Parameters:**
- `float currentRotation`
- `float radians`

### SetRotation

```csharp
/// <summary>
        /// Sets absolute rotation.
        /// </summary>
        /// <param name="degrees">Absolute rotation in degrees</param>
        /// <returns>Rotation in degrees</returns>
        public float SetRotation(float degrees)
        {
            return degrees;
        }
```

Sets absolute rotation.

**Returns:** `float`

**Parameters:**
- `float degrees`

### SetRotationRadians

```csharp
/// <summary>
        /// Sets absolute rotation in radians.
        /// </summary>
        /// <param name="radians">Absolute rotation in radians</param>
        /// <returns>Rotation in radians</returns>
        public float SetRotationRadians(float radians)
        {
            return radians;
        }
```

Sets absolute rotation in radians.

**Returns:** `float`

**Parameters:**
- `float radians`

### ResetRotation

```csharp
/// <summary>
        /// Resets rotation to identity (0 degrees).
        /// </summary>
        /// <returns>Identity rotation (0 degrees)</returns>
        public float ResetRotation()
        {
            return 0f;
        }
```

Resets rotation to identity (0 degrees).

**Returns:** `float`

### ResetScale

```csharp
/// <summary>
        /// Resets scale to identity (1, 1).
        /// </summary>
        /// <returns>Identity scale</returns>
        public Vector2 ResetScale()
        {
            return Vector2.One;
        }
```

Resets scale to identity (1, 1).

**Returns:** `Vector2`

### IsFlippedHorizontal

```csharp
/// <summary>
        /// Checks if the scale is flipped horizontally.
        /// </summary>
        /// <param name="scale">Scale vector to check</param>
        /// <returns>True if flipped horizontally (scale X is negative)</returns>
        public bool IsFlippedHorizontal(Vector2 scale)
        {
            return scale.X < 0f;
        }
```

Checks if the scale is flipped horizontally.

**Returns:** `bool`

**Parameters:**
- `Vector2 scale`

### IsFlippedVertical

```csharp
/// <summary>
        /// Checks if the scale is flipped vertically.
        /// </summary>
        /// <param name="scale">Scale vector to check</param>
        /// <returns>True if flipped vertically (scale Y is negative)</returns>
        public bool IsFlippedVertical(Vector2 scale)
        {
            return scale.Y < 0f;
        }
```

Checks if the scale is flipped vertically.

**Returns:** `bool`

**Parameters:**
- `Vector2 scale`

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
            const float twoPi = 2f * MathF.PI;
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
            return degrees * MathF.PI / 180f;
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
            return radians * 180f / MathF.PI;
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
        /// <param name="currentRotation">Current rotation in degrees</param>
        /// <param name="degrees">Desired rotation in degrees</param>
        /// <param name="increment">Snap increment in degrees</param>
        /// <returns>Snapped rotation in degrees</returns>
        public float ApplySnappedRotation(float currentRotation, float degrees, float increment)
        {
            var newRotation = currentRotation + degrees;
            var snappedRotation = MathF.Round(newRotation / increment) * increment;
            return snappedRotation;
        }
```

Applies a rotation that snaps to the nearest increment.

**Returns:** `float`

**Parameters:**
- `float currentRotation`
- `float degrees`
- `float increment`

