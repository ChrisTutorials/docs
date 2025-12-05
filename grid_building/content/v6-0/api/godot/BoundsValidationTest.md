---
title: "BoundsValidationTest"
description: "Unit tests for bounds validation utilities.
Tests rectangle bounds, tile range calculations, and boundary checking.
Ported from: godot/addons/grid_building/test/grid_building/systems/building/unit/validators/rect4x2_bounds_validation_unit_test.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/boundsvalidationtest/"
---

# BoundsValidationTest

```csharp
GridBuilding.Godot.Tests.Validation
class BoundsValidationTest
{
    // Members...
}
```

Unit tests for bounds validation utilities.
Tests rectangle bounds, tile range calculations, and boundary checking.
Ported from: godot/addons/grid_building/test/grid_building/systems/building/unit/validators/rect4x2_bounds_validation_unit_test.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Validation/BoundsValidationTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CreateRect_WithValidDimensions_ReturnsCorrectBounds

```csharp
#region Rect Bounds Creation Tests

    [Fact]
    public void CreateRect_WithValidDimensions_ReturnsCorrectBounds()
    {
        var rect = new RectBounds(10.0f, 20.0f, 100.0f, 50.0f);
        
        rect.X.ShouldBe(10.0f);
        rect.Y.ShouldBe(20.0f);
        rect.Width.ShouldBe(100.0f);
        rect.Height.ShouldBe(50.0f);
    }
```

**Returns:** `void`

### CreateRect_WithZeroDimensions_IsValid

```csharp
[Fact]
    public void CreateRect_WithZeroDimensions_IsValid()
    {
        var rect = new RectBounds(0, 0, 0, 0);
        
        rect.Width.ShouldBe(0);
        rect.Height.ShouldBe(0);
        rect.Area.ShouldBe(0);
    }
```

**Returns:** `void`

### CreateRect_NegativeDimensions_ThrowsException

```csharp
[Fact]
    public void CreateRect_NegativeDimensions_ThrowsException()
    {
        Should.Throw<ArgumentException>(() => new RectBounds(0, 0, -10, 10));
        Should.Throw<ArgumentException>(() => new RectBounds(0, 0, 10, -10));
    }
```

**Returns:** `void`

### Area_CalculatesCorrectly

```csharp
#endregion

    #region Area Calculations

    [Theory]
    [InlineData(10, 10, 100)]
    [InlineData(4, 2, 8)]
    [InlineData(16, 16, 256)]
    [InlineData(1, 1, 1)]
    public void Area_CalculatesCorrectly(float width, float height, float expectedArea)
    {
        var rect = new RectBounds(0, 0, width, height);
        rect.Area.ShouldBe(expectedArea);
    }
```

**Returns:** `void`

**Parameters:**
- `float width`
- `float height`
- `float expectedArea`

### Perimeter_CalculatesCorrectly

```csharp
[Fact]
    public void Perimeter_CalculatesCorrectly()
    {
        var rect = new RectBounds(0, 0, 10, 5);
        rect.Perimeter.ShouldBe(30);  // 2 * (10 + 5)
    }
```

**Returns:** `void`

### Contains_PointInside_ReturnsTrue

```csharp
#endregion

    #region Bounds Checking

    [Fact]
    public void Contains_PointInside_ReturnsTrue()
    {
        var rect = new RectBounds(0, 0, 100, 100);
        
        rect.Contains(50, 50).ShouldBeTrue();
        rect.Contains(0, 0).ShouldBeTrue();
        rect.Contains(99, 99).ShouldBeTrue();
    }
```

**Returns:** `void`

### Contains_PointOutside_ReturnsFalse

```csharp
[Fact]
    public void Contains_PointOutside_ReturnsFalse()
    {
        var rect = new RectBounds(0, 0, 100, 100);
        
        rect.Contains(-1, 50).ShouldBeFalse();
        rect.Contains(50, -1).ShouldBeFalse();
        rect.Contains(100, 50).ShouldBeFalse();
        rect.Contains(50, 100).ShouldBeFalse();
    }
```

**Returns:** `void`

### Contains_PointOnEdge_ReturnsTrue

```csharp
[Fact]
    public void Contains_PointOnEdge_ReturnsTrue()
    {
        var rect = new RectBounds(0, 0, 100, 100);
        
        rect.Contains(0, 50).ShouldBeTrue();  // Left edge
        rect.Contains(50, 0).ShouldBeTrue();  // Top edge
        rect.Contains(99.9f, 50).ShouldBeTrue();  // Near right edge
        rect.Contains(50, 99.9f).ShouldBeTrue();  // Near bottom edge
    }
```

**Returns:** `void`

### Intersects_OverlappingRects_ReturnsTrue

```csharp
#endregion

    #region Intersection Tests

    [Fact]
    public void Intersects_OverlappingRects_ReturnsTrue()
    {
        var rect1 = new RectBounds(0, 0, 100, 100);
        var rect2 = new RectBounds(50, 50, 100, 100);
        
        rect1.Intersects(rect2).ShouldBeTrue();
        rect2.Intersects(rect1).ShouldBeTrue();
    }
```

**Returns:** `void`

### Intersects_NonOverlappingRects_ReturnsFalse

```csharp
[Fact]
    public void Intersects_NonOverlappingRects_ReturnsFalse()
    {
        var rect1 = new RectBounds(0, 0, 100, 100);
        var rect2 = new RectBounds(200, 200, 100, 100);
        
        rect1.Intersects(rect2).ShouldBeFalse();
        rect2.Intersects(rect1).ShouldBeFalse();
    }
```

**Returns:** `void`

### Intersects_TouchingRects_ReturnsFalse

```csharp
[Fact]
    public void Intersects_TouchingRects_ReturnsFalse()
    {
        var rect1 = new RectBounds(0, 0, 100, 100);
        var rect2 = new RectBounds(100, 0, 100, 100);  // Right edge touches left edge of rect2
        
        rect1.Intersects(rect2).ShouldBeFalse();
    }
```

**Returns:** `void`

### GetIntersection_OverlappingRects_ReturnsCorrectBounds

```csharp
[Fact]
    public void GetIntersection_OverlappingRects_ReturnsCorrectBounds()
    {
        var rect1 = new RectBounds(0, 0, 100, 100);
        var rect2 = new RectBounds(50, 50, 100, 100);
        
        var intersection = rect1.GetIntersection(rect2);
        
        intersection.ShouldNotBeNull();
        intersection!.X.ShouldBe(50);
        intersection.Y.ShouldBe(50);
        intersection.Width.ShouldBe(50);
        intersection.Height.ShouldBe(50);
    }
```

**Returns:** `void`

### GetIntersection_NonOverlapping_ReturnsNull

```csharp
[Fact]
    public void GetIntersection_NonOverlapping_ReturnsNull()
    {
        var rect1 = new RectBounds(0, 0, 100, 100);
        var rect2 = new RectBounds(200, 200, 100, 100);
        
        var intersection = rect1.GetIntersection(rect2);
        
        intersection.ShouldBeNull();
    }
```

**Returns:** `void`

### ToTileBounds_ConvertsToCellCoordinates

```csharp
#endregion

    #region Tile Bounds Tests

    [Fact]
    public void ToTileBounds_ConvertsToCellCoordinates()
    {
        var rect = new RectBounds(32, 64, 64, 32);  // 2x1 tiles at (2,4)
        
        var tileBounds = rect.ToTileBounds(16);  // 16x16 tiles
        
        tileBounds.StartX.ShouldBe(2);
        tileBounds.StartY.ShouldBe(4);
        tileBounds.EndX.ShouldBe(6);  // (32+64)/16 = 6
        tileBounds.EndY.ShouldBe(6);  // (64+32)/16 = 6
    }
```

**Returns:** `void`

### ToTileBounds_HandlesNonAlignedBounds

```csharp
[Fact]
    public void ToTileBounds_HandlesNonAlignedBounds()
    {
        // Rect that doesn't align to tile boundaries
        var rect = new RectBounds(10, 10, 50, 50);
        
        var tileBounds = rect.ToTileBounds(16);
        
        // Should encompass all tiles the rect touches
        tileBounds.StartX.ShouldBe(0);  // floor(10/16) = 0
        tileBounds.StartY.ShouldBe(0);  // floor(10/16) = 0
        tileBounds.EndX.ShouldBe(4);    // ceil((10+50)/16) = 4
        tileBounds.EndY.ShouldBe(4);    // ceil((10+50)/16) = 4
    }
```

**Returns:** `void`

### TileBounds_TileCount_CalculatesCorrectly

```csharp
[Theory]
    [InlineData(16, 4, 4, 16)]  // 4x4 tiles = 16 tiles
    [InlineData(32, 2, 2, 4)]   // 2x2 tiles = 4 tiles
    [InlineData(8, 8, 8, 64)]   // 8x8 tiles = 64 tiles
    public void TileBounds_TileCount_CalculatesCorrectly(int tileSize, int expectedWidth, int expectedHeight, int expectedCount)
    {
        var rect = new RectBounds(0, 0, tileSize * expectedWidth, tileSize * expectedHeight);
        var tileBounds = rect.ToTileBounds(tileSize);
        
        tileBounds.TileCount.ShouldBe(expectedCount);
    }
```

**Returns:** `void`

**Parameters:**
- `int tileSize`
- `int expectedWidth`
- `int expectedHeight`
- `int expectedCount`

### Rect4x2_AtOrigin_HasCorrectBounds

```csharp
#endregion

    #region 4x2 Rect Specific Tests (from GDScript)

    [Fact]
    public void Rect4x2_AtOrigin_HasCorrectBounds()
    {
        // A 4x2 tile rect at origin with 16px tiles
        var rect = new RectBounds(0, 0, 64, 32);  // 4*16, 2*16
        
        rect.Area.ShouldBe(64 * 32);
        
        var tileBounds = rect.ToTileBounds(16);
        tileBounds.TileWidth.ShouldBe(4);
        tileBounds.TileHeight.ShouldBe(2);
        tileBounds.TileCount.ShouldBe(8);
    }
```

**Returns:** `void`

### Rect4x2_Offset_HasCorrectBounds

```csharp
[Fact]
    public void Rect4x2_Offset_HasCorrectBounds()
    {
        // A 4x2 tile rect offset by 2 tiles
        var rect = new RectBounds(32, 32, 64, 32);  // Start at (2,2) tiles
        
        var tileBounds = rect.ToTileBounds(16);
        
        tileBounds.StartX.ShouldBe(2);
        tileBounds.StartY.ShouldBe(2);
        tileBounds.EndX.ShouldBe(6);  // 2 + 4
        tileBounds.EndY.ShouldBe(4);  // 2 + 2
    }
```

**Returns:** `void`

### Rect4x2_EnumerateTiles_ReturnsAllTiles

```csharp
[Fact]
    public void Rect4x2_EnumerateTiles_ReturnsAllTiles()
    {
        var rect = new RectBounds(0, 0, 64, 32);
        var tileBounds = rect.ToTileBounds(16);
        
        var tiles = tileBounds.EnumerateTiles().ToList();
        
        tiles.Count.ShouldBe(8);
        tiles.ShouldContain((0, 0));
        tiles.ShouldContain((1, 0));
        tiles.ShouldContain((2, 0));
        tiles.ShouldContain((3, 0));
        tiles.ShouldContain((0, 1));
        tiles.ShouldContain((1, 1));
        tiles.ShouldContain((2, 1));
        tiles.ShouldContain((3, 1));
    }
```

**Returns:** `void`

### SingleTile_HasCorrectBounds

```csharp
#endregion

    #region Validation Edge Cases

    [Fact]
    public void SingleTile_HasCorrectBounds()
    {
        var rect = new RectBounds(16, 16, 16, 16);
        var tileBounds = rect.ToTileBounds(16);
        
        tileBounds.TileCount.ShouldBe(1);
        tileBounds.StartX.ShouldBe(1);
        tileBounds.StartY.ShouldBe(1);
    }
```

**Returns:** `void`

### VeryLargeRect_HandlesBoundsCorrectly

```csharp
[Fact]
    public void VeryLargeRect_HandlesBoundsCorrectly()
    {
        var rect = new RectBounds(0, 0, 10000, 10000);
        var tileBounds = rect.ToTileBounds(16);
        
        tileBounds.TileCount.ShouldBe(625 * 625);  // 625 * 625 = 390625
        tileBounds.TileWidth.ShouldBe(625);
        tileBounds.TileHeight.ShouldBe(625);
    }
```

**Returns:** `void`

