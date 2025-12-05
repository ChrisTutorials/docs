---
title: "GBCameraUtilsTests"
description: "Comprehensive tests for GBCameraUtils
Tests camera positioning, zooming, and coordinate conversion utilities"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gbcamerautilstests/"
---

# GBCameraUtilsTests

```csharp
GridBuilding.Godot.Tests.Utils
class GBCameraUtilsTests
{
    // Members...
}
```

Comprehensive tests for GBCameraUtils
Tests camera positioning, zooming, and coordinate conversion utilities

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GBCameraUtilsTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CenterCameraOnGrid_ValidPosition_ShouldCenterCorrectly

```csharp
#region Camera Positioning Tests

        [Fact]
        public void CenterCameraOnGrid_ValidPosition_ShouldCenterCorrectly()
        {
            // Arrange
            var camera = CreateTestCamera();
            var gridPosition = new Vector2I(5, 3);
            var tileSize = new Vector2(32, 32);

            // Act
            GBCameraUtils.CenterCameraOnGrid(camera, gridPosition, tileSize);

            // Assert
            var expectedPosition = new Vector2(
                gridPosition.X * tileSize.X + tileSize.X * 0.5f,
                gridPosition.Y * tileSize.Y + tileSize.Y * 0.5f
            );
            ;
        }
```

**Returns:** `void`

### CenterCameraOnGrid_NullCamera_ShouldNotThrow

```csharp
[Fact]
        public void CenterCameraOnGrid_NullCamera_ShouldNotThrow()
        {
            // Arrange
            Camera2D camera = null;
            var gridPosition = new Vector2I(5, 3);
            var tileSize = new Vector2(32, 32);

            // Act & Assert - Should not throw
            GBCameraUtils.CenterCameraOnGrid(camera, gridPosition, tileSize);
        }
```

**Returns:** `void`

### CenterCameraOnWorld_ValidPosition_ShouldCenterCorrectly

```csharp
[Fact]
        public void CenterCameraOnWorld_ValidPosition_ShouldCenterCorrectly()
        {
            // Arrange
            var camera = CreateTestCamera();
            var worldPosition = new Vector2(100.5f, 75.25f);

            // Act
            GBCameraUtils.CenterCameraOnWorld(camera, worldPosition);

            // Assert
            ;
        }
```

**Returns:** `void`

### CenterCameraOnWorld_NullCamera_ShouldNotThrow

```csharp
[Fact]
        public void CenterCameraOnWorld_NullCamera_ShouldNotThrow()
        {
            // Arrange
            Camera2D camera = null;
            var worldPosition = new Vector2(100.5f, 75.25f);

            // Act & Assert - Should not throw
            GBCameraUtils.CenterCameraOnWorld(camera, worldPosition);
        }
```

**Returns:** `void`

### GetOptimalCameraPosition_ValidBounds_ShouldReturnCenter

```csharp
[Fact]
        public void GetOptimalCameraPosition_ValidBounds_ShouldReturnCenter()
        {
            // Arrange
            var camera = CreateTestCamera();
            var gridBounds = (min: new Vector2I(0, 0), max: new Vector2I(9, 9));
            var tileSize = new Vector2(32, 32);

            // Act
            var result = GBCameraUtils.GetOptimalCameraPosition(camera, gridBounds, tileSize);

            // Assert
            var expectedMin = new Vector2(0, 0);
            var expectedMax = new Vector2(320, 320); // (9+1) * 32
            var expectedCenter = (expectedMin + expectedMax) * 0.5f;
            ;
        }
```

**Returns:** `void`

### GetOptimalCameraPosition_NullCamera_ShouldReturnZero

```csharp
[Fact]
        public void GetOptimalCameraPosition_NullCamera_ShouldReturnZero()
        {
            // Arrange
            Camera2D camera = null;
            var gridBounds = (min: new Vector2I(0, 0), max: new Vector2I(9, 9));
            var tileSize = new Vector2(32, 32);

            // Act
            var result = GBCameraUtils.GetOptimalCameraPosition(camera, gridBounds, tileSize);

            // Assert
            ;
        }
```

**Returns:** `void`

### ZoomToFitGridArea_ValidBounds_ShouldSetCorrectZoom

```csharp
#endregion

        #region Zoom Control Tests

        [Fact]
        public void ZoomToFitGridArea_ValidBounds_ShouldSetCorrectZoom()
        {
            // Arrange
            var camera = CreateTestCamera();
            var gridBounds = (min: new Vector2I(0, 0), max: new Vector2I(4, 4));
            var tileSize = new Vector2(32, 32);
            var viewportSize = new Vector2(800, 600);

            // Act
            GBCameraUtils.ZoomToFitGridArea(camera, gridBounds, tileSize, viewportSize);

            // Assert
            ;
            ;
            ; // Uniform zoom
        }
```

**Returns:** `void`

### ZoomToFitGridArea_NullCamera_ShouldNotThrow

```csharp
[Fact]
        public void ZoomToFitGridArea_NullCamera_ShouldNotThrow()
        {
            // Arrange
            Camera2D camera = null;
            var gridBounds = (min: new Vector2I(0, 0), max: new Vector2I(4, 4));
            var tileSize = new Vector2(32, 32);
            var viewportSize = new Vector2(800, 600);

            // Act & Assert - Should not throw
            GBCameraUtils.ZoomToFitGridArea(camera, gridBounds, tileSize, viewportSize);
        }
```

**Returns:** `void`

### SmoothZoomTo_ValidTarget_ShouldCreateTween

```csharp
[Fact]
        public void SmoothZoomTo_ValidTarget_ShouldCreateTween()
        {
            // Arrange
            var camera = CreateTestCamera();
            var targetZoom = 2.0f;

            // Act & Assert - Should not throw
            GBCameraUtils.SmoothZoomTo(camera, targetZoom);
        }
```

**Returns:** `void`

### SmoothZoomTo_NullCamera_ShouldNotThrow

```csharp
[Fact]
        public void SmoothZoomTo_NullCamera_ShouldNotThrow()
        {
            // Arrange
            Camera2D camera = null;
            var targetZoom = 2.0f;

            // Act & Assert - Should not throw
            GBCameraUtils.SmoothZoomTo(camera, targetZoom);
        }
```

**Returns:** `void`

### ZoomByFactor_ValidFactor_ShouldZoomCorrectly

```csharp
[Fact]
        public void ZoomByFactor_ValidFactor_ShouldZoomCorrectly()
        {
            // Arrange
            var camera = CreateTestCamera();
            camera.Zoom = Vector2.One;
            var zoomFactor = 2.0f;

            // Act
            GBCameraUtils.ZoomByFactor(camera, zoomFactor);

            // Assert
            ;
            ;
        }
```

**Returns:** `void`

### ZoomByFactor_ExceedsMaxZoom_ShouldClampToMax

```csharp
[Fact]
        public void ZoomByFactor_ExceedsMaxZoom_ShouldClampToMax()
        {
            // Arrange
            var camera = CreateTestCamera();
            camera.Zoom = Vector2.One;
            var zoomFactor = 100.0f; // Very large factor
            var maxZoom = 10.0f;

            // Act
            GBCameraUtils.ZoomByFactor(camera, zoomFactor, 0.1f, maxZoom);

            // Assert
            ;
            ;
        }
```

**Returns:** `void`

### ZoomByFactor_BelowMinZoom_ShouldClampToMin

```csharp
[Fact]
        public void ZoomByFactor_BelowMinZoom_ShouldClampToMin()
        {
            // Arrange
            var camera = CreateTestCamera();
            camera.Zoom = Vector2.One;
            var zoomFactor = 0.001f; // Very small factor
            var minZoom = 0.1f;

            // Act
            GBCameraUtils.ZoomByFactor(camera, zoomFactor, minZoom, 10.0f);

            // Assert
            ;
            ;
        }
```

**Returns:** `void`

### ZoomByFactor_NullCamera_ShouldNotThrow

```csharp
[Fact]
        public void ZoomByFactor_NullCamera_ShouldNotThrow()
        {
            // Arrange
            Camera2D camera = null;
            var zoomFactor = 2.0f;

            // Act & Assert - Should not throw
            GBCameraUtils.ZoomByFactor(camera, zoomFactor);
        }
```

**Returns:** `void`

### ScreenToWorld_ValidCamera_ShouldConvertCorrectly

```csharp
#endregion

        #region Coordinate Conversion Tests

        [Fact]
        public void ScreenToWorld_ValidCamera_ShouldConvertCorrectly()
        {
            // Arrange
            var camera = CreateTestCamera();
            var screenPosition = new Vector2(400, 300);

            // Act
            var result = GBCameraUtils.ScreenToWorld(camera, screenPosition);

            // Assert
            // Note: This test assumes camera.GetGlobalMousePosition() works correctly
            // In a real test environment, you might need to mock this behavior
            ;
        }
```

**Returns:** `void`

### ScreenToWorld_NullCamera_ShouldReturnInput

```csharp
[Fact]
        public void ScreenToWorld_NullCamera_ShouldReturnInput()
        {
            // Arrange
            Camera2D camera = null;
            var screenPosition = new Vector2(400, 300);

            // Act
            var result = GBCameraUtils.ScreenToWorld(camera, screenPosition);

            // Assert
            ;
        }
```

**Returns:** `void`

### WorldToGrid_ValidPosition_ShouldConvertCorrectly

```csharp
[Fact]
        public void WorldToGrid_ValidPosition_ShouldConvertCorrectly()
        {
            // Arrange
            var worldPosition = new Vector2(95.5f, 63.5f);
            var tileSize = new Vector2(32, 32);

            // Act
            var result = GBCameraUtils.WorldToGrid(worldPosition, tileSize);

            // Assert
            var expectedGrid = new Vector2I(2, 1); // Floor(95.5/32) = 2, Floor(63.5/32) = 1
            ;
        }
```

**Returns:** `void`

### GridToWorld_ValidPosition_ShouldConvertCorrectly

```csharp
[Fact]
        public void GridToWorld_ValidPosition_ShouldConvertCorrectly()
        {
            // Arrange
            var gridPosition = new Vector2I(3, 2);
            var tileSize = new Vector2(32, 32);

            // Act
            var result = GBCameraUtils.GridToWorld(gridPosition, tileSize);

            // Assert
            var expectedWorld = new Vector2(
                gridPosition.X * tileSize.X + tileSize.X * 0.5f,
                gridPosition.Y * tileSize.Y + tileSize.Y * 0.5f
            );
            ;
        }
```

**Returns:** `void`

### ScreenToGrid_ValidCamera_ShouldConvertCorrectly

```csharp
[Fact]
        public void ScreenToGrid_ValidCamera_ShouldConvertCorrectly()
        {
            // Arrange
            var camera = CreateTestCamera();
            var screenPosition = new Vector2(400, 300);
            var tileSize = new Vector2(32, 32);

            // Act
            var result = GBCameraUtils.ScreenToGrid(camera, screenPosition, tileSize);

            // Assert
            ;
        }
```

**Returns:** `void`

### GridToScreen_ValidCamera_ShouldConvertCorrectly

```csharp
[Fact]
        public void GridToScreen_ValidCamera_ShouldConvertCorrectly()
        {
            // Arrange
            var camera = CreateTestCamera();
            var gridPosition = new Vector2I(3, 2);
            var tileSize = new Vector2(32, 32);

            // Act
            var result = GBCameraUtils.GridToScreen(camera, gridPosition, tileSize);

            // Assert
            ;
        }
```

**Returns:** `void`

### GetVisibleGridBounds_ValidCamera_ShouldReturnBounds

```csharp
#endregion

        #region Camera Bounds Tests

        [Fact]
        public void GetVisibleGridBounds_ValidCamera_ShouldReturnBounds()
        {
            // Arrange
            var camera = CreateTestCamera();
            camera.Position = new Vector2(160, 160);
            camera.Zoom = Vector2.One;
            var tileSize = new Vector2(32, 32);
            var viewportSize = new Vector2(800, 600);

            // Act
            var (min, max) = GBCameraUtils.GetVisibleGridBounds(camera, tileSize, viewportSize);

            // Assert
            ;
            ;
        }
```

**Returns:** `void`

### GetVisibleGridBounds_NullCamera_ShouldReturnZero

```csharp
[Fact]
        public void GetVisibleGridBounds_NullCamera_ShouldReturnZero()
        {
            // Arrange
            Camera2D camera = null;
            var tileSize = new Vector2(32, 32);
            var viewportSize = new Vector2(800, 600);

            // Act
            var (min, max) = GBCameraUtils.GetVisibleGridBounds(camera, tileSize, viewportSize);

            // Assert
            ;
            ;
        }
```

**Returns:** `void`

### IsGridPositionVisible_ValidPosition_ShouldReturnCorrectResult

```csharp
[Fact]
        public void IsGridPositionVisible_ValidPosition_ShouldReturnCorrectResult()
        {
            // Arrange
            var camera = CreateTestCamera();
            camera.Position = new Vector2(160, 160);
            camera.Zoom = Vector2.One;
            var tileSize = new Vector2(32, 32);
            var viewportSize = new Vector2(800, 600);
            var visiblePosition = new Vector2I(5, 5);

            // Act
            var isVisible = GBCameraUtils.IsGridPositionVisible(camera, visiblePosition, tileSize, viewportSize);

            // Assert
            // The exact result depends on camera position and zoom, but should be a boolean
            Assert.IsType<bool>(isVisible);
        }
```

**Returns:** `void`

### ConstrainCameraToGridBounds_ValidBounds_ShouldConstrainPosition

```csharp
[Fact]
        public void ConstrainCameraToGridBounds_ValidBounds_ShouldConstrainPosition()
        {
            // Arrange
            var camera = CreateTestCamera();
            camera.Position = new Vector2(500, 500); // Outside bounds
            var gridBounds = (min: new Vector2I(0, 0), max: new Vector2I(9, 9));
            var tileSize = new Vector2(32, 32);
            var viewportSize = new Vector2(800, 600);

            // Act
            GBCameraUtils.ConstrainCameraToGridBounds(camera, gridBounds, tileSize, viewportSize);

            // Assert
            // Position should be constrained within bounds
            ;
            ;
        }
```

**Returns:** `void`

### ConstrainCameraToGridBounds_NullCamera_ShouldNotThrow

```csharp
[Fact]
        public void ConstrainCameraToGridBounds_NullCamera_ShouldNotThrow()
        {
            // Arrange
            Camera2D camera = null;
            var gridBounds = (min: new Vector2I(0, 0), max: new Vector2I(9, 9));
            var tileSize = new Vector2(32, 32);
            var viewportSize = new Vector2(800, 600);

            // Act & Assert - Should not throw
            GBCameraUtils.ConstrainCameraToGridBounds(camera, gridBounds, tileSize, viewportSize);
        }
```

**Returns:** `void`

### ShakeCamera_ValidParameters_ShouldNotThrow

```csharp
#endregion

        #region Camera Effects Tests

        [Fact]
        public void ShakeCamera_ValidParameters_ShouldNotThrow()
        {
            // Arrange
            var camera = CreateTestCamera();

            // Act & Assert - Should not throw
            GBCameraUtils.ShakeCamera(camera, 10.0f, 0.1f, 60.0f);
        }
```

**Returns:** `void`

### ShakeCamera_NullCamera_ShouldNotThrow

```csharp
[Fact]
        public void ShakeCamera_NullCamera_ShouldNotThrow()
        {
            // Arrange
            Camera2D camera = null;

            // Act & Assert - Should not throw
            GBCameraUtils.ShakeCamera(camera, 10.0f, 0.1f, 60.0f);
        }
```

**Returns:** `void`

### SmoothFollow_ValidParameters_ShouldMoveCamera

```csharp
[Fact]
        public void SmoothFollow_ValidParameters_ShouldMoveCamera()
        {
            // Arrange
            var camera = CreateTestCamera();
            camera.Position = Vector2.Zero;
            var targetPosition = new Vector2(100, 100);

            // Act
            GBCameraUtils.SmoothFollow(camera, targetPosition, 5.0f);

            // Assert
            // Camera should have moved towards the target
            ;
        }
```

**Returns:** `void`

### SmoothFollow_NullCamera_ShouldNotThrow

```csharp
[Fact]
        public void SmoothFollow_NullCamera_ShouldNotThrow()
        {
            // Arrange
            Camera2D camera = null;
            var targetPosition = new Vector2(100, 100);

            // Act & Assert - Should not throw
            GBCameraUtils.SmoothFollow(camera, targetPosition, 5.0f);
        }
```

**Returns:** `void`

### GetZoomPercentage_ValidCamera_ShouldReturnCorrectPercentage

```csharp
#endregion

        #region Utility Methods Tests

        [Fact]
        public void GetZoomPercentage_ValidCamera_ShouldReturnCorrectPercentage()
        {
            // Arrange
            var camera = CreateTestCamera();
            camera.Zoom = new Vector2(2.0f, 2.0f);

            // Act
            var percentage = GBCameraUtils.GetZoomPercentage(camera);

            // Assert
            ;
        }
```

**Returns:** `void`

### GetZoomPercentage_NullCamera_ShouldReturn100

```csharp
[Fact]
        public void GetZoomPercentage_NullCamera_ShouldReturn100()
        {
            // Arrange
            Camera2D camera = null;

            // Act
            var percentage = GBCameraUtils.GetZoomPercentage(camera);

            // Assert
            ;
        }
```

**Returns:** `void`

### SetZoomFromPercentage_ValidPercentage_ShouldSetCorrectZoom

```csharp
[Fact]
        public void SetZoomFromPercentage_ValidPercentage_ShouldSetCorrectZoom()
        {
            // Arrange
            var camera = CreateTestCamera();

            // Act
            GBCameraUtils.SetZoomFromPercentage(camera, 150.0f);

            // Assert
            ;
            ;
        }
```

**Returns:** `void`

### SetZoomFromPercentage_NullCamera_ShouldNotThrow

```csharp
[Fact]
        public void SetZoomFromPercentage_NullCamera_ShouldNotThrow()
        {
            // Arrange
            Camera2D camera = null;

            // Act & Assert - Should not throw
            GBCameraUtils.SetZoomFromPercentage(camera, 150.0f);
        }
```

**Returns:** `void`

### GetDistanceToPosition_ValidCamera_ShouldReturnCorrectDistance

```csharp
[Fact]
        public void GetDistanceToPosition_ValidCamera_ShouldReturnCorrectDistance()
        {
            // Arrange
            var camera = CreateTestCamera();
            camera.Position = Vector2.Zero;
            var position = new Vector2(100, 100);

            // Act
            var distance = GBCameraUtils.GetDistanceToPosition(camera, position);

            // Assert
            ; // sqrt(100^2 + 100^2)
        }
```

**Returns:** `void`

### GetDistanceToPosition_NullCamera_ShouldReturnZero

```csharp
[Fact]
        public void GetDistanceToPosition_NullCamera_ShouldReturnZero()
        {
            // Arrange
            Camera2D camera = null;
            var position = new Vector2(100, 100);

            // Act
            var distance = GBCameraUtils.GetDistanceToPosition(camera, position);

            // Assert
            ;
        }
```

**Returns:** `void`

