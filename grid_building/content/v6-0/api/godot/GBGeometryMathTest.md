---
title: "GBGeometryMathTest"
description: "Comprehensive test suite for GBGeometryMath functions across all tile shapes.
POCS tests - uses local mock types instead of Godot runtime.
Ported from GDScript with parameterized test cases for square, isometric, and half-offset square tiles."
weight: 20
url: "/gridbuilding/v6-0/api/godot/gbgeometrymathtest/"
---

# GBGeometryMathTest

```csharp
GridBuilding.Godot.Tests.Geometry
class GBGeometryMathTest
{
    // Members...
}
```

Comprehensive test suite for GBGeometryMath functions across all tile shapes.
POCS tests - uses local mock types instead of Godot runtime.
Ported from GDScript with parameterized test cases for square, isometric, and half-offset square tiles.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Geometry/GBGeometryMathTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetTilePolygon_ForAllShapes_ShouldReturnCorrectVertexCount

```csharp
#region Tile Polygon Generation Tests

    [Theory]
    [InlineData("square_origin", TileSet.TileShape.Square, 0, 0, 16, 16, 4)]
    [InlineData("square_offset", TileSet.TileShape.Square, 32, 48, 16, 16, 4)]
    [InlineData("square_large", TileSet.TileShape.Square, 0, 0, 32, 32, 4)]
    [InlineData("square_rectangular", TileSet.TileShape.Square, 0, 0, 24, 16, 4)]
    [InlineData("isometric_origin", TileSet.TileShape.Isometric, 0, 0, 16, 16, 4)]
    [InlineData("isometric_offset", TileSet.TileShape.Isometric, 32, 48, 16, 16, 4)]
    [InlineData("isometric_large", TileSet.TileShape.Isometric, 0, 0, 32, 32, 4)]
    [InlineData("isometric_rectangular", TileSet.TileShape.Isometric, 0, 0, 24, 16, 4)]
    [InlineData("half_offset_origin", TileSet.TileShape.HalfOffsetSquare, 0, 0, 16, 16, 4)]
    [InlineData("half_offset_offset", TileSet.TileShape.HalfOffsetSquare, 32, 48, 16, 16, 4)]
    [InlineData("half_offset_large", TileSet.TileShape.HalfOffsetSquare, 0, 0, 32, 32, 4)]
    [InlineData("half_offset_rectangular", TileSet.TileShape.HalfOffsetSquare, 0, 0, 24, 16, 4)]
    public void GetTilePolygon_ForAllShapes_ShouldReturnCorrectVertexCount(
        string tileShapeName,
        TileSet.TileShape tileShape,
        float tilePosX, float tilePosY,
        float tileSizeX, float tileSizeY,
        int expectedVertexCount)
    {
        // Arrange
        var tilePos = new Vector2(tilePosX, tilePosY);
        var tileSize = new Vector2(tileSizeX, tileSizeY);

        // Act
        var tilePolygon = GBGeometryMath.GetTilePolygon(tilePos, tileSize, tileShape);

        // Assert
        ;
        ;
        Assert.NotEmpty(tilePolygon);

        // Additional validation: polygon bounds should encompass expected area
        var bounds = GBGeometryMath.GetPolygonBounds(tilePolygon);
        ;
        
        if (tileShape == TileSet.TileShape.Isometric)
        {
            // Isometric diamonds should fit within the tile size bounding box
            ; // Allow small tolerance
            ;
        }
        else
        {
            // Square and half-offset should match tile size exactly
            ;
            ;
        }
    }
```

**Returns:** `void`

**Parameters:**
- `string tileShapeName`
- `TileSet.TileShape tileShape`
- `float tilePosX`
- `float tilePosY`
- `float tileSizeX`
- `float tileSizeY`
- `int expectedVertexCount`

### WorldToTile_CoordinateConversion_ShouldReturnCorrectTileCoordinates

```csharp
#endregion

    #region Coordinate Conversion Tests

    [Theory]
    [InlineData(TileSet.TileShape.Square, 0, 0, 16, 16, 0, 0)]
    [InlineData(TileSet.TileShape.Square, 32, 48, 16, 16, 2, 3)]
    [InlineData(TileSet.TileShape.Isometric, 0, 0, 16, 16, 0, 0)]
    [InlineData(TileSet.TileShape.Isometric, 0, 64, 16, 16, 4, -4)]  // WorldToTile: (0/16+64/16, 0/16-64/16) = (4, -4)
    [InlineData(TileSet.TileShape.HalfOffsetSquare, 0, 0, 16, 16, 0, 0)]
    [InlineData(TileSet.TileShape.HalfOffsetSquare, 32, 48, 16, 16, 2, 3)]  // even row, no offset
    public void WorldToTile_CoordinateConversion_ShouldReturnCorrectTileCoordinates(
        TileSet.TileShape tileShape,
        float worldX, float worldY,
        float tileSizeX, float tileSizeY,
        int expectedTileX, int expectedTileY)
    {
        // Arrange
        var worldPos = new Vector2(worldX, worldY);
        var tileSize = new Vector2(tileSizeX, tileSizeY);

        // Act
        var tileCoords = GBGeometryMath.WorldToTile(worldPos, tileSize, tileShape);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `TileSet.TileShape tileShape`
- `float worldX`
- `float worldY`
- `float tileSizeX`
- `float tileSizeY`
- `int expectedTileX`
- `int expectedTileY`

### TileToWorld_CoordinateConversion_ShouldReturnCorrectWorldCoordinates

```csharp
[Theory]
    [InlineData(TileSet.TileShape.Square, 0, 0, 16, 16, 0, 0)]
    [InlineData(TileSet.TileShape.Square, 2, 3, 16, 16, 32, 48)]
    [InlineData(TileSet.TileShape.Isometric, 0, 0, 16, 16, 0, 0)]
    [InlineData(TileSet.TileShape.Isometric, 4, 4, 16, 16, 0, 64)]  // ((4-4)*8, (4+4)*8) = (0, 64)
    [InlineData(TileSet.TileShape.HalfOffsetSquare, 0, 0, 16, 16, 0, 0)]
    [InlineData(TileSet.TileShape.HalfOffsetSquare, 2, 3, 16, 16, 40, 48)]  // odd row offset: 2*16+8=40
    public void TileToWorld_CoordinateConversion_ShouldReturnCorrectWorldCoordinates(
        TileSet.TileShape tileShape,
        int tileX, int tileY,
        float tileSizeX, float tileSizeY,
        float expectedWorldX, float expectedWorldY)
    {
        // Arrange
        var tileCoords = new Vector2I(tileX, tileY);
        var tileSize = new Vector2(tileSizeX, tileSizeY);

        // Act
        var worldPos = GBGeometryMath.TileToWorld(tileCoords, tileSize, tileShape);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `TileSet.TileShape tileShape`
- `int tileX`
- `int tileY`
- `float tileSizeX`
- `float tileSizeY`
- `float expectedWorldX`
- `float expectedWorldY`

### GetTileCenter_ShouldReturnCorrectCenterPosition

```csharp
#endregion

    #region Tile Center Calculation Tests

    [Theory]
    // Square tiles: center is at position + half tile size
    [InlineData(TileSet.TileShape.Square, 0, 0, 16, 16, 8, 8)]
    [InlineData(TileSet.TileShape.Square, 2, 3, 16, 16, 40, 56)]  // tile(2,3) -> world(32,48) + half(8,8) = (40,56)
    // Isometric tiles: center is shifted based on isometric projection
    [InlineData(TileSet.TileShape.Isometric, 0, 0, 16, 16, 0, 8)]
    [InlineData(TileSet.TileShape.Isometric, 2, 2, 16, 16, 0, 40)]  // TileToWorld(2,2) = (0,32) + half(0,8) = (0,40)
    // HalfOffset tiles: odd rows are offset by half tile width
    [InlineData(TileSet.TileShape.HalfOffsetSquare, 0, 0, 16, 16, 8, 8)]
    [InlineData(TileSet.TileShape.HalfOffsetSquare, 2, 3, 16, 16, 48, 56)]  // odd row offset
    public void GetTileCenter_ShouldReturnCorrectCenterPosition(
        TileSet.TileShape tileShape,
        int tileX, int tileY,
        float tileSizeX, float tileSizeY,
        float expectedCenterX, float expectedCenterY)
    {
        // Arrange
        var tileCoords = new Vector2I(tileX, tileY);
        var tileSize = new Vector2(tileSizeX, tileSizeY);

        // Act
        var centerPos = GBGeometryMath.GetTileCenter(tileCoords, tileSize, tileShape);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `TileSet.TileShape tileShape`
- `int tileX`
- `int tileY`
- `float tileSizeX`
- `float tileSizeY`
- `float expectedCenterX`
- `float expectedCenterY`

### GetTileBounds_ShouldReturnCorrectBounds

```csharp
#endregion

    #region Tile Bounds Tests

    [Theory]
    // Square tiles: bounds start at world position with tile size
    [InlineData(TileSet.TileShape.Square, 0, 0, 16, 16, 0, 0, 16, 16)]
    [InlineData(TileSet.TileShape.Square, 2, 3, 16, 16, 32, 48, 16, 16)]  // tile(2,3) -> pos(32,48), size(16,16)
    // Isometric tiles: diamond shape, offset differently  
    [InlineData(TileSet.TileShape.Isometric, 0, 0, 16, 16, -8, 0, 16, 16)]
    [InlineData(TileSet.TileShape.Isometric, 2, 2, 16, 16, -8, 32, 16, 16)]  // TileToWorld(2,2) = (0,32), center adjusted
    // HalfOffset tiles: odd rows offset by half tile width
    [InlineData(TileSet.TileShape.HalfOffsetSquare, 0, 0, 16, 16, 0, 0, 16, 16)]
    [InlineData(TileSet.TileShape.HalfOffsetSquare, 2, 3, 16, 16, 40, 48, 16, 16)]  // odd row offset
    public void GetTileBounds_ShouldReturnCorrectBounds(
        TileSet.TileShape tileShape,
        int tileX, int tileY,
        float tileSizeX, float tileSizeY,
        float expectedX, float expectedY,
        float expectedWidth, float expectedHeight)
    {
        // Arrange
        var tileCoords = new Vector2I(tileX, tileY);
        var tileSize = new Vector2(tileSizeX, tileSizeY);

        // Act
        var bounds = GBGeometryMath.GetTileBounds(tileCoords, tileSize, tileShape);

        // Assert
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `TileSet.TileShape tileShape`
- `int tileX`
- `int tileY`
- `float tileSizeX`
- `float tileSizeY`
- `float expectedX`
- `float expectedY`
- `float expectedWidth`
- `float expectedHeight`

### GetPolygonBounds_ValidPolygon_ShouldReturnCorrectBounds

```csharp
#endregion

    #region Polygon Utility Tests

    [Fact]
    public void GetPolygonBounds_ValidPolygon_ShouldReturnCorrectBounds()
    {
        // Arrange
        var polygon = new List<Vector2>
        {
            new(0, 0),
            new(10, 0),
            new(10, 8),
            new(0, 8)
        };

        // Act
        var bounds = GBGeometryMath.GetPolygonBounds(polygon);

        // Assert
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### GetPolygonBounds_EmptyPolygon_ShouldReturnEmptyBounds

```csharp
[Fact]
    public void GetPolygonBounds_EmptyPolygon_ShouldReturnEmptyBounds()
    {
        // Arrange
        var polygon = new List<Vector2>();

        // Act
        var bounds = GBGeometryMath.GetPolygonBounds(polygon);

        // Assert
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### GetPolygonBounds_SinglePointPolygon_ShouldReturnPointBounds

```csharp
[Fact]
    public void GetPolygonBounds_SinglePointPolygon_ShouldReturnPointBounds()
    {
        // Arrange
        var polygon = new List<Vector2> { new(5, 7) };

        // Act
        var bounds = GBGeometryMath.GetPolygonBounds(polygon);

        // Assert
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### GetTileDistance_ManhattanDistance_ShouldReturnCorrectDistance

```csharp
#endregion

    #region Tile Distance Tests

    [Theory]
    [InlineData(TileSet.TileShape.Square, 0, 0, 1, 0, 1)]
    [InlineData(TileSet.TileShape.Square, 0, 0, 0, 1, 1)]
    [InlineData(TileSet.TileShape.Square, 0, 0, 1, 1, 2)]
    [InlineData(TileSet.TileShape.Isometric, 0, 0, 1, 0, 1)]
    [InlineData(TileSet.TileShape.Isometric, 0, 0, 0, 1, 1)]
    [InlineData(TileSet.TileShape.Isometric, 0, 0, 1, 1, 2)]
    [InlineData(TileSet.TileShape.HalfOffsetSquare, 0, 0, 1, 0, 1)]
    [InlineData(TileSet.TileShape.HalfOffsetSquare, 0, 0, 0, 1, 1)]
    [InlineData(TileSet.TileShape.HalfOffsetSquare, 0, 0, 1, 1, 2)]
    public void GetTileDistance_ManhattanDistance_ShouldReturnCorrectDistance(
        TileSet.TileShape tileShape,
        int fromX, int fromY,
        int toX, int toY,
        int expectedDistance)
    {
        // Arrange
        var fromTile = new Vector2I(fromX, fromY);
        var toTile = new Vector2I(toX, toY);

        // Act
        var distance = GBGeometryMath.GetTileDistance(fromTile, toTile, tileShape);

        // Assert
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `TileSet.TileShape tileShape`
- `int fromX`
- `int fromY`
- `int toX`
- `int toY`
- `int expectedDistance`

### AreTilesAdjacent_ShouldReturnCorrectAdjacency

```csharp
#endregion

    #region Tile Adjacency Tests

    [Theory]
    [InlineData(TileSet.TileShape.Square, 0, 0, 1, 0, true)]
    [InlineData(TileSet.TileShape.Square, 0, 0, 0, 1, true)]
    [InlineData(TileSet.TileShape.Square, 0, 0, 1, 1, false)]
    [InlineData(TileSet.TileShape.Square, 0, 0, 2, 0, false)]
    [InlineData(TileSet.TileShape.Isometric, 0, 0, 1, 0, true)]
    [InlineData(TileSet.TileShape.Isometric, 0, 0, 0, 1, true)]
    [InlineData(TileSet.TileShape.Isometric, 0, 0, 1, 1, true)] // Diagonal adjacency in isometric
    [InlineData(TileSet.TileShape.HalfOffsetSquare, 0, 0, 1, 0, true)]
    [InlineData(TileSet.TileShape.HalfOffsetSquare, 0, 0, 0, 1, true)]
    [InlineData(TileSet.TileShape.HalfOffsetSquare, 0, 0, 1, 1, false)]
    public void AreTilesAdjacent_ShouldReturnCorrectAdjacency(
        TileSet.TileShape tileShape,
        int fromX, int fromY,
        int toX, int toY,
        bool expectedAdjacent)
    {
        // Arrange
        var fromTile = new Vector2I(fromX, fromY);
        var toTile = new Vector2I(toX, toY);

        // Act
        var isAdjacent = GBGeometryMath.AreTilesAdjacent(fromTile, toTile, tileShape);

        // Assert
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `TileSet.TileShape tileShape`
- `int fromX`
- `int fromY`
- `int toX`
- `int toY`
- `bool expectedAdjacent`

