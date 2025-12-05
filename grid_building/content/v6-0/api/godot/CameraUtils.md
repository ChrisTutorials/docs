---
title: "CameraUtils"
description: "Camera utility functions for grid building system
Provides camera positioning, zooming, and coordinate conversion utilities
Ported from: godot/addons/grid_building/utils/gb_camera_utils.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/camerautils/"
---

# CameraUtils

```csharp
GridBuilding.Godot.Utils
class CameraUtils
{
    // Members...
}
```

Camera utility functions for grid building system
Provides camera positioning, zooming, and coordinate conversion utilities
Ported from: godot/addons/grid_building/utils/gb_camera_utils.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/Utils/CameraUtils.cs`  
**Namespace:** `GridBuilding.Godot.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CenterCameraOnGrid

```csharp
#region Camera Positioning

    /// <summary>
    /// Centers the camera on the specified grid position
    /// </summary>
    /// <param name="camera">The camera to position</param>
    /// <param name="gridPosition">Grid position to center on</param>
    /// <param name="tileSize">Size of tiles for coordinate conversion</param>
    public static void CenterCameraOnGrid(Camera2D camera, Vector2I gridPosition, Vector2 tileSize)
    {
        if (camera == null) return;
        
        var worldPosition = new Vector2(
            gridPosition.X * tileSize.X + tileSize.X * 0.5f,
            gridPosition.Y * tileSize.Y + tileSize.Y * 0.5f
        );
        
        camera.Position = worldPosition;
    }
```

Centers the camera on the specified grid position

**Returns:** `void`

**Parameters:**
- `Camera2D camera`
- `Vector2I gridPosition`
- `Vector2 tileSize`

### CenterCameraOnWorld

```csharp
/// <summary>
    /// Centers the camera on the specified world position
    /// </summary>
    /// <param name="camera">The camera to position</param>
    /// <param name="worldPosition">World position to center on</param>
    public static void CenterCameraOnWorld(Camera2D camera, Vector2 worldPosition)
    {
        if (camera == null) return;
        camera.Position = worldPosition;
    }
```

Centers the camera on the specified world position

**Returns:** `void`

**Parameters:**
- `Camera2D camera`
- `Vector2 worldPosition`

### GetOptimalCameraPosition

```csharp
/// <summary>
    /// Gets the optimal camera position to show the specified grid area
    /// </summary>
    /// <param name="camera">The camera</param>
    /// <param name="gridBounds">Grid bounds to show (min, max)</param>
    /// <param name="tileSize">Size of tiles</param>
    /// <returns>Optimal camera position</returns>
    public static Vector2 GetOptimalCameraPosition(Camera2D camera, (Vector2I min, Vector2I max) gridBounds, Vector2 tileSize)
    {
        if (camera == null) return Vector2.Zero;
        
        var worldMin = new Vector2(gridBounds.min.X * tileSize.X, gridBounds.min.Y * tileSize.Y);
        var worldMax = new Vector2(gridBounds.max.X * tileSize.X + tileSize.X, gridBounds.max.Y * tileSize.Y + tileSize.Y);
        
        var center = (worldMin + worldMax) * 0.5f;
        return center;
    }
```

Gets the optimal camera position to show the specified grid area

**Returns:** `Vector2`

**Parameters:**
- `Camera2D camera`
- `(Vector2I min, Vector2I max) gridBounds`
- `Vector2 tileSize`

### ZoomToFitGridArea

```csharp
#endregion

    #region Zoom Control

    /// <summary>
    /// Sets camera zoom to fit the specified grid area
    /// </summary>
    /// <param name="camera">The camera to zoom</param>
    /// <param name="gridBounds">Grid bounds to fit</param>
    /// <param name="tileSize">Size of tiles</param>
    /// <param name="viewportSize">Viewport size</param>
    /// <param name="padding">Optional padding around the bounds</param>
    public static void ZoomToFitGridArea(Camera2D camera, (Vector2I min, Vector2I max) gridBounds, Vector2 tileSize, Vector2 viewportSize, float padding = 0.1f)
    {
        if (camera == null) return;
        
        var worldMin = new Vector2(gridBounds.min.X * tileSize.X, gridBounds.min.Y * tileSize.Y);
        var worldMax = new Vector2(gridBounds.max.X * tileSize.X + tileSize.X, gridBounds.max.Y * tileSize.Y + tileSize.Y);
        
        var worldSize = worldMax - worldMin;
        var paddedViewportSize = viewportSize * (1.0f - padding);
        
        var zoomX = paddedViewportSize.X / worldSize.X;
        var zoomY = paddedViewportSize.Y / worldSize.Y;
        var targetZoom = Mathf.Min(zoomX, zoomY);
        
        // Clamp zoom to reasonable limits
        targetZoom = Mathf.Clamp(targetZoom, 0.1f, 10.0f);
        
        camera.Zoom = new Vector2(targetZoom, targetZoom);
    }
```

Sets camera zoom to fit the specified grid area

**Returns:** `void`

**Parameters:**
- `Camera2D camera`
- `(Vector2I min, Vector2I max) gridBounds`
- `Vector2 tileSize`
- `Vector2 viewportSize`
- `float padding`

### SmoothZoomTo

```csharp
/// <summary>
    /// Smoothly zooms the camera to the target zoom level
    /// </summary>
    /// <param name="camera">The camera to zoom</param>
    /// <param name="targetZoom">Target zoom level</param>
    /// <param name="duration">Duration of the zoom animation</param>
    /// <param name="easeType">Easing type for the animation</param>
    public static void SmoothZoomTo(Camera2D camera, float targetZoom, float duration = 0.5f, Tween.EaseType easeType = Tween.EaseType.Out)
    {
        if (camera == null) return;
        
        var tween = camera.CreateTween();
        tween.SetEase(easeType);
        tween.SetTrans(Tween.TransitionType.Sine);
        tween.TweenProperty(camera, "zoom:x", targetZoom, duration);
        tween.TweenProperty(camera, "zoom:y", targetZoom, duration);
    }
```

Smoothly zooms the camera to the target zoom level

**Returns:** `void`

**Parameters:**
- `Camera2D camera`
- `float targetZoom`
- `float duration`
- `Tween.EaseType easeType`

### ZoomByFactor

```csharp
/// <summary>
    /// Zooms the camera by the specified factor
    /// </summary>
    /// <param name="camera">The camera to zoom</param>
    /// <param name="zoomFactor">Factor to zoom by (1.0 = no change, >1.0 = zoom in, <1.0 = zoom out)</param>
    /// <param name="minZoom">Minimum zoom level</param>
    /// <param name="maxZoom">Maximum zoom level</param>
    public static void ZoomByFactor(Camera2D camera, float zoomFactor, float minZoom = 0.1f, float maxZoom = 10.0f)
    {
        if (camera == null) return;
        
        var currentZoom = camera.Zoom.X; // Assuming uniform zoom
        var newZoom = currentZoom * zoomFactor;
        newZoom = Mathf.Clamp(newZoom, minZoom, maxZoom);
        
        camera.Zoom = new Vector2(newZoom, newZoom);
    }
```

Zooms the camera by the specified factor

**Returns:** `void`

**Parameters:**
- `Camera2D camera`
- `float zoomFactor`
- `float minZoom`
- `float maxZoom`

### ScreenToWorld

```csharp
#endregion

    #region Coordinate Conversion

    /// <summary>
    /// Converts screen coordinates to world coordinates
    /// </summary>
    /// <param name="camera">The camera</param>
    /// <param name="screenPosition">Screen position</param>
    /// <returns>World position</returns>
    public static Vector2 ScreenToWorld(Camera2D camera, Vector2 screenPosition)
    {
        if (camera == null) return screenPosition;
        return camera.GetGlobalMousePosition();
    }
```

Converts screen coordinates to world coordinates

**Returns:** `Vector2`

**Parameters:**
- `Camera2D camera`
- `Vector2 screenPosition`

### WorldToGrid

```csharp
/// <summary>
    /// Converts world coordinates to grid coordinates
    /// </summary>
    /// <param name="worldPosition">World position</param>
    /// <param name="tileSize">Size of tiles</param>
    /// <returns>Grid position</returns>
    public static Vector2I WorldToGrid(Vector2 worldPosition, Vector2 tileSize)
    {
        return new Vector2I(
            Mathf.FloorToInt(worldPosition.X / tileSize.X),
            Mathf.FloorToInt(worldPosition.Y / tileSize.Y)
        );
    }
```

Converts world coordinates to grid coordinates

**Returns:** `Vector2I`

**Parameters:**
- `Vector2 worldPosition`
- `Vector2 tileSize`

### GridToWorld

```csharp
/// <summary>
    /// Converts grid coordinates to world coordinates (tile center)
    /// </summary>
    /// <param name="gridPosition">Grid position</param>
    /// <param name="tileSize">Size of tiles</param>
    /// <returns>World position (center of tile)</returns>
    public static Vector2 GridToWorld(Vector2I gridPosition, Vector2 tileSize)
    {
        return new Vector2(
            gridPosition.X * tileSize.X + tileSize.X * 0.5f,
            gridPosition.Y * tileSize.Y + tileSize.Y * 0.5f
        );
    }
```

Converts grid coordinates to world coordinates (tile center)

**Returns:** `Vector2`

**Parameters:**
- `Vector2I gridPosition`
- `Vector2 tileSize`

### ScreenToGrid

```csharp
/// <summary>
    /// Converts screen coordinates directly to grid coordinates
    /// </summary>
    /// <param name="camera">The camera</param>
    /// <param name="screenPosition">Screen position</param>
    /// <param name="tileSize">Size of tiles</param>
    /// <returns>Grid position</returns>
    public static Vector2I ScreenToGrid(Camera2D camera, Vector2 screenPosition, Vector2 tileSize)
    {
        var worldPos = ScreenToWorld(camera, screenPosition);
        return WorldToGrid(worldPos, tileSize);
    }
```

Converts screen coordinates directly to grid coordinates

**Returns:** `Vector2I`

**Parameters:**
- `Camera2D camera`
- `Vector2 screenPosition`
- `Vector2 tileSize`

### GridToScreen

```csharp
/// <summary>
    /// Converts grid coordinates to screen coordinates
    /// </summary>
    /// <param name="camera">The camera</param>
    /// <param name="gridPosition">Grid position</param>
    /// <param name="tileSize">Size of tiles</param>
    /// <returns>Screen position</returns>
    public static Vector2 GridToScreen(Camera2D camera, Vector2I gridPosition, Vector2 tileSize)
    {
        var worldPos = GridToWorld(gridPosition, tileSize);
        return camera.GetScreenCenterPosition() + (worldPos - camera.Position);
    }
```

Converts grid coordinates to screen coordinates

**Returns:** `Vector2`

**Parameters:**
- `Camera2D camera`
- `Vector2I gridPosition`
- `Vector2 tileSize`

### GetVisibleGridBounds

```csharp
#endregion

    #region Camera Bounds

    /// <summary>
    /// Gets the visible grid bounds of the camera
    /// </summary>
    /// <param name="camera">The camera</param>
    /// <param name="tileSize">Size of tiles</param>
    /// <param name="viewportSize">Viewport size</param>
    /// <returns>Visible grid bounds (min, max)</returns>
    public static (Vector2I min, Vector2I max) GetVisibleGridBounds(Camera2D camera, Vector2 tileSize, Vector2 viewportSize)
    {
        if (camera == null) return (Vector2I.Zero, Vector2I.Zero);
        
        var cameraPos = camera.Position;
        var zoom = camera.Zoom.X; // Assuming uniform zoom
        
        // Calculate visible world bounds
        var halfViewport = viewportSize * 0.5f / zoom;
        var worldMin = cameraPos - halfViewport;
        var worldMax = cameraPos + halfViewport;
        
        // Convert to grid bounds
        var gridMin = WorldToGrid(worldMin, tileSize);
        var gridMax = WorldToGrid(worldMax, tileSize);
        
        return (gridMin, gridMax);
    }
```

Gets the visible grid bounds of the camera

**Returns:** `(Vector2I min, Vector2I max)`

**Parameters:**
- `Camera2D camera`
- `Vector2 tileSize`
- `Vector2 viewportSize`

### IsGridPositionVisible

```csharp
/// <summary>
    /// Checks if a grid position is visible to the camera
    /// </summary>
    /// <param name="camera">The camera</param>
    /// <param name="gridPosition">Grid position to check</param>
    /// <param name="tileSize">Size of tiles</param>
    /// <param name="viewportSize">Viewport size</param>
    /// <returns>True if the grid position is visible</returns>
    public static bool IsGridPositionVisible(Camera2D camera, Vector2I gridPosition, Vector2 tileSize, Vector2 viewportSize)
    {
        var (min, max) = GetVisibleGridBounds(camera, tileSize, viewportSize);
        return gridPosition.X >= min.X && gridPosition.X <= max.X &&
               gridPosition.Y >= min.Y && gridPosition.Y <= max.Y;
    }
```

Checks if a grid position is visible to the camera

**Returns:** `bool`

**Parameters:**
- `Camera2D camera`
- `Vector2I gridPosition`
- `Vector2 tileSize`
- `Vector2 viewportSize`

### ConstrainCameraToGridBounds

```csharp
/// <summary>
    /// Constrains camera position to stay within the specified grid bounds
    /// </summary>
    /// <param name="camera">The camera to constrain</param>
    /// <param name="gridBounds">Grid bounds to constrain to</param>
    /// <param name="tileSize">Size of tiles</param>
    /// <param name="viewportSize">Viewport size</param>
    public static void ConstrainCameraToGridBounds(Camera2D camera, (Vector2I min, Vector2I max) gridBounds, Vector2 tileSize, Vector2 viewportSize)
    {
        if (camera == null) return;
        
        var zoom = camera.Zoom.X;
        var halfViewport = viewportSize * 0.5f / zoom;
        
        var worldMin = new Vector2(gridBounds.min.X * tileSize.X, gridBounds.min.Y * tileSize.Y);
        var worldMax = new Vector2(gridBounds.max.X * tileSize.X + tileSize.X, gridBounds.max.Y * tileSize.Y + tileSize.Y);
        
        var constrainedMin = worldMin + halfViewport;
        var constrainedMax = worldMax - halfViewport;
        
        var currentPos = camera.Position;
        var newPos = currentPos;
        
        if (currentPos.X < constrainedMin.X) newPos.X = constrainedMin.X;
        if (currentPos.X > constrainedMax.X) newPos.X = constrainedMax.X;
        if (currentPos.Y < constrainedMin.Y) newPos.Y = constrainedMin.Y;
        if (currentPos.Y > constrainedMax.Y) newPos.Y = constrainedMax.Y;
        
        camera.Position = newPos;
    }
```

Constrains camera position to stay within the specified grid bounds

**Returns:** `void`

**Parameters:**
- `Camera2D camera`
- `(Vector2I min, Vector2I max) gridBounds`
- `Vector2 tileSize`
- `Vector2 viewportSize`

### ShakeCamera

```csharp
#endregion

    #region Camera Effects

    /// <summary>
    /// Shakes the camera for the specified duration
    /// </summary>
    /// <param name="camera">The camera to shake</param>
    /// <param name="intensity">Shake intensity</param>
    /// <param name="duration">Shake duration</param>
    /// <param name="frequency">Shake frequency</param>
    public static void ShakeCamera(Camera2D camera, float intensity, float duration = 0.5f, float frequency = 30.0f)
    {
        if (camera == null) return;
        
        var originalPosition = camera.Position;
        var shakeTimer = new Timer();
        shakeTimer.WaitTime = 1.0f / frequency;
        shakeTimer.Autostart = true;
        
        var elapsedTime = 0.0f;
        
        shakeTimer.Timeout += () =>
        {
            if (elapsedTime >= duration)
            {
                camera.Position = originalPosition;
                shakeTimer.QueueFree();
                return;
            }
            
            var shakeOffset = new Vector2(
                GD.RandRange(-intensity, intensity),
                GD.RandRange(-intensity, intensity)
            );
            
            camera.Position = originalPosition + shakeOffset;
            elapsedTime += (float)shakeTimer.WaitTime;
        };
        
        camera.AddChild(shakeTimer);
    }
```

Shakes the camera for the specified duration

**Returns:** `void`

**Parameters:**
- `Camera2D camera`
- `float intensity`
- `float duration`
- `float frequency`

### SmoothFollow

```csharp
/// <summary>
    /// Creates a smooth camera follow effect
    /// </summary>
    /// <param name="camera">The camera to move</param>
    /// <param name="targetPosition">Target position to follow</param>
    /// <param name="followSpeed">Follow speed (lower = slower)</param>
    public static void SmoothFollow(Camera2D camera, Vector2 targetPosition, float followSpeed = 5.0f)
    {
        if (camera == null) return;
        
        var currentPos = camera.Position;
        var newPos = currentPos.Lerp(targetPosition, followSpeed * (float)Engine.GetProcessDeltaTime());
        camera.Position = newPos;
    }
```

Creates a smooth camera follow effect

**Returns:** `void`

**Parameters:**
- `Camera2D camera`
- `Vector2 targetPosition`
- `float followSpeed`

### GetZoomPercentage

```csharp
#endregion

    #region Utility Methods

    /// <summary>
    /// Gets the camera's zoom level as a percentage
    /// </summary>
    /// <param name="camera">The camera</param>
    /// <param name="baseZoom">Base zoom level (100%)</param>
    /// <returns>Zoom percentage</returns>
    public static float GetZoomPercentage(Camera2D camera, float baseZoom = 1.0f)
    {
        if (camera == null) return 100.0f;
        return (camera.Zoom.X / baseZoom) * 100.0f;
    }
```

Gets the camera's zoom level as a percentage

**Returns:** `float`

**Parameters:**
- `Camera2D camera`
- `float baseZoom`

### SetZoomFromPercentage

```csharp
/// <summary>
    /// Sets the camera zoom from a percentage
    /// </summary>
    /// <param name="camera">The camera</param>
    /// <param name="zoomPercentage">Zoom percentage</param>
    /// <param name="baseZoom">Base zoom level (100%)</param>
    public static void SetZoomFromPercentage(Camera2D camera, float zoomPercentage, float baseZoom = 1.0f)
    {
        if (camera == null) return;
        var targetZoom = (zoomPercentage / 100.0f) * baseZoom;
        camera.Zoom = new Vector2(targetZoom, targetZoom);
    }
```

Sets the camera zoom from a percentage

**Returns:** `void`

**Parameters:**
- `Camera2D camera`
- `float zoomPercentage`
- `float baseZoom`

### GetDistanceToPosition

```csharp
/// <summary>
    /// Gets the distance from the camera to the specified position
    /// </summary>
    /// <param name="camera">The camera</param>
    /// <param name="position">Position to measure distance to</param>
    /// <returns>Distance in world units</returns>
    public static float GetDistanceToPosition(Camera2D camera, Vector2 position)
    {
        if (camera == null) return 0.0f;
        return camera.Position.DistanceTo(position);
    }
```

Gets the distance from the camera to the specified position

**Returns:** `float`

**Parameters:**
- `Camera2D camera`
- `Vector2 position`

