---
title: "GridPositioningIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/gridpositioningintegrationtests/"
---

# GridPositioningIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class GridPositioningIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for grid positioning and coordinate conversion.
Ported from: systems/grid_targeting/unit/validators/gb_positioning_2d_utils_test.gd
Tests coordinate conversion between screen, world, and tile coordinates.
Requires actual Godot Viewport, Camera2D, and TileMapLayer instances.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/GridPositioningIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up Grid Positioning Integration Tests");
    }
```

**Returns:** `void`

### Setup

```csharp
[Setup]
    public void Setup()
    {
        // Create a SubViewport for controlled viewport testing
        _viewport = new SubViewport();
        _viewport.Size = new Vector2I(800, 600);
        _testScene.AddChild(_viewport);

        // Create camera
        _camera = new Camera2D();
        _camera.Position = Vector2.Zero;
        _camera.Zoom = Vector2.One;
        _viewport.AddChild(_camera);

        // Create tile map
        _tileMap = new TileMapLayer();
        var tileSet = new TileSet();
        tileSet.TileSize = TileSize;
        _tileMap.TileSet = tileSet;
        _viewport.AddChild(_tileMap);
    }
```

**Returns:** `void`

### Cleanup

```csharp
[Cleanup]
    public void Cleanup()
    {
        _viewport?.QueueFree();
        _viewport = null;
        _camera = null;
        _tileMap = null;
    }
```

**Returns:** `void`

### Camera_Position_AffectsViewportCenter

```csharp
#region Camera Position Tests

    [Test]
    public void Camera_Position_AffectsViewportCenter()
    {
        // Arrange
        _camera!.Position = new Vector2(100, 100);

        // Act & Assert: Camera should be at the specified position
        _camera.Position.ShouldBe(new Vector2(100, 100));
        _camera.GlobalPosition.ShouldBe(new Vector2(100, 100));
    }
```

**Returns:** `void`

### Camera_Zoom_AffectsScale

```csharp
[Test]
    public void Camera_Zoom_AffectsScale()
    {
        // Arrange
        _camera!.Zoom = new Vector2(2, 2);

        // Assert
        _camera.Zoom.ShouldBe(new Vector2(2, 2));
    }
```

**Returns:** `void`

### Camera_ZoomOut_DoublesVisibleArea

```csharp
[Test]
    public void Camera_ZoomOut_DoublesVisibleArea()
    {
        // Arrange: Zoom out (smaller zoom value = more visible)
        _camera!.Zoom = new Vector2(0.5f, 0.5f);

        // Assert
        _camera.Zoom.X.ShouldBe(0.5f);
        _camera.Zoom.Y.ShouldBe(0.5f);
    }
```

**Returns:** `void`

### TileMap_LocalToMap_ConvertsWorldToTile

```csharp
#endregion

    #region Tile Coordinate Conversion Tests

    [Test]
    public void TileMap_LocalToMap_ConvertsWorldToTile()
    {
        // Arrange: World position at center of tile (1, 1)
        var worldPos = new Vector2(TileSize.X + TileSize.X / 2, TileSize.Y + TileSize.Y / 2);

        // Act
        var tileCoord = _tileMap!.LocalToMap(worldPos);

        // Assert
        tileCoord.ShouldBe(new Vector2I(1, 1));
    }
```

**Returns:** `void`

### TileMap_MapToLocal_ConvertsTileToWorld

```csharp
[Test]
    public void TileMap_MapToLocal_ConvertsTileToWorld()
    {
        // Arrange
        var tileCoord = new Vector2I(2, 3);

        // Act
        var worldPos = _tileMap!.MapToLocal(tileCoord);

        // Assert: Should return center of tile
        var expectedX = tileCoord.X * TileSize.X + TileSize.X / 2;
        var expectedY = tileCoord.Y * TileSize.Y + TileSize.Y / 2;
        worldPos.X.ShouldBe(expectedX, 0.1f);
        worldPos.Y.ShouldBe(expectedY, 0.1f);
    }
```

**Returns:** `void`

### TileMap_OriginTile_IsAtZeroZero

```csharp
[Test]
    public void TileMap_OriginTile_IsAtZeroZero()
    {
        // Arrange: Position at origin
        var worldPos = new Vector2(TileSize.X / 2, TileSize.Y / 2);

        // Act
        var tileCoord = _tileMap!.LocalToMap(worldPos);

        // Assert
        tileCoord.ShouldBe(new Vector2I(0, 0));
    }
```

**Returns:** `void`

### TileMap_NegativeCoordinates_WorkCorrectly

```csharp
[Test]
    public void TileMap_NegativeCoordinates_WorkCorrectly()
    {
        // Arrange: Position in negative space
        var worldPos = new Vector2(-TileSize.X / 2, -TileSize.Y / 2);

        // Act
        var tileCoord = _tileMap!.LocalToMap(worldPos);

        // Assert
        tileCoord.ShouldBe(new Vector2I(-1, -1));
    }
```

**Returns:** `void`

### Viewport_Size_IsCorrect

```csharp
#endregion

    #region Viewport Coordinate Tests

    [Test]
    public void Viewport_Size_IsCorrect()
    {
        // Assert
        _viewport!.Size.ShouldBe(new Vector2I(800, 600));
    }
```

**Returns:** `void`

### Viewport_GetVisibleRect_ReturnsCorrectSize

```csharp
[Test]
    public void Viewport_GetVisibleRect_ReturnsCorrectSize()
    {
        // Act
        var visibleRect = _viewport!.GetVisibleRect();

        // Assert
        visibleRect.Size.X.ShouldBe(800);
        visibleRect.Size.Y.ShouldBe(600);
    }
```

**Returns:** `void`

### ScreenToWorld_CenterOfScreen_MatchesCameraPosition

```csharp
#endregion

    #region Screen to World Conversion Tests

    [Test]
    public void ScreenToWorld_CenterOfScreen_MatchesCameraPosition()
    {
        // Arrange
        _camera!.Position = new Vector2(160, 120);
        var screenCenter = new Vector2(400, 300); // Center of 800x600 viewport

        // Act: Convert screen center to world
        var worldPos = ScreenToWorld(screenCenter);

        // Assert: Should match camera position (center of view)
        worldPos.X.ShouldBe(_camera.Position.X, 1f);
        worldPos.Y.ShouldBe(_camera.Position.Y, 1f);
    }
```

**Returns:** `void`

### ScreenToWorld_WithZoom_ScalesCorrectly

```csharp
[Test]
    public void ScreenToWorld_WithZoom_ScalesCorrectly()
    {
        // Arrange: Zoom in 2x
        _camera!.Position = Vector2.Zero;
        _camera.Zoom = new Vector2(2, 2);
        var screenPos = new Vector2(400, 300); // Center

        // Act
        var worldPos = ScreenToWorld(screenPos);

        // Assert: With 2x zoom, screen center should still map to camera position
        worldPos.X.ShouldBe(0, 1f);
        worldPos.Y.ShouldBe(0, 1f);
    }
```

**Returns:** `void`

### ScreenToWorld_OffCenter_CalculatesOffset

```csharp
[Test]
    public void ScreenToWorld_OffCenter_CalculatesOffset()
    {
        // Arrange
        _camera!.Position = Vector2.Zero;
        _camera.Zoom = Vector2.One;
        // Position at top-left quadrant
        var screenPos = new Vector2(200, 150); // 1/4 from left, 1/4 from top

        // Act
        var worldPos = ScreenToWorld(screenPos);

        // Assert: Should be offset from center
        // Center is at (0, 0), top-left of viewport is at (-400, -300)
        // Position (200, 150) is at (-200, -150) in world coords
        worldPos.X.ShouldBe(-200, 1f);
        worldPos.Y.ShouldBe(-150, 1f);
    }
```

**Returns:** `void`

### GetTileCenter_ReturnsCorrectPosition

```csharp
#endregion

    #region Tile Center Alignment Tests

    [Test]
    public void GetTileCenter_ReturnsCorrectPosition()
    {
        // Arrange
        var tileCoord = new Vector2I(5, 3);

        // Act
        var tileCenter = _tileMap!.MapToLocal(tileCoord);

        // Assert
        var expectedCenter = new Vector2(
            tileCoord.X * TileSize.X + TileSize.X / 2,
            tileCoord.Y * TileSize.Y + TileSize.Y / 2
        );
        tileCenter.X.ShouldBe(expectedCenter.X, 0.1f);
        tileCenter.Y.ShouldBe(expectedCenter.Y, 0.1f);
    }
```

**Returns:** `void`

### SnapToTile_RoundsToNearestTile

```csharp
[Test]
    public void SnapToTile_RoundsToNearestTile()
    {
        // Arrange: Position slightly off-center of tile (2, 2)
        var worldPos = new Vector2(75, 82); // Close to tile (2, 2) center at (80, 80)

        // Act
        var tileCoord = _tileMap!.LocalToMap(worldPos);
        var snappedPos = _tileMap.MapToLocal(tileCoord);

        // Assert: Should snap to tile center
        var expectedTile = new Vector2I(2, 2);
        tileCoord.ShouldBe(expectedTile);
    }
```

**Returns:** `void`

