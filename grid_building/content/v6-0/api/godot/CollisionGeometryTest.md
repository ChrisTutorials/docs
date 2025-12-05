---
title: "CollisionGeometryTest"
description: "Tests for collision geometry utilities and calculations.
Validates the CollisionGeometryUtils class functionality for rotated objects
and tile range calculations without requiring Godot runtime."
weight: 20
url: "/gridbuilding/v6-0/api/godot/collisiongeometrytest/"
---

# CollisionGeometryTest

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class CollisionGeometryTest
{
    // Members...
}
```

Tests for collision geometry utilities and calculations.
Validates the CollisionGeometryUtils class functionality for rotated objects
and tile range calculations without requiring Godot runtime.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/CollisionGeometryTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Integration.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### BuildShapeTransformTestData

```csharp
#region Test Functions

    #region Parameterized Transform Tests

    public static TheoryData<Vector2, float, Vector2, Vector2> BuildShapeTransformTestData()
    {
        return new TheoryData<Vector2, float, Vector2, Vector2>
        {
            { new Vector2(100, 100), DEFAULT_ROTATION, Vector2.One, new Vector2(16, 16) },
            { new Vector2(0, 0), 0, Vector2.One, new Vector2(32, 48) },
            { Vector2.Zero, 0, new Vector2(2, 0.5f), new Vector2(16, 16) },
            { new Vector2(50, 50), Mathf.Pi / 6, new Vector2(1.5f, 1.5f), new Vector2(8, 8) }
        };
    }
```

**Returns:** `TheoryData<Vector2, float, Vector2, Vector2>`

### BuildShapeTransform_Parameterized_ReturnsCorrectTransform

```csharp
[Theory]
    [MemberData(nameof(BuildShapeTransformTestData))]
    public void BuildShapeTransform_Parameterized_ReturnsCorrectTransform(
        Vector2 objPos, float objRot, Vector2 objScale, Vector2 shapeLocalPos)
    {
        var result = CollisionGeometryUtils.BuildShapeTransform(objPos, objRot, objScale, shapeLocalPos);

        result.ShouldNotBeNull();
        
        // The result should have the same rotation and scale as the parent
        var actualRotation = Mathf.Atan2(result.Y.X, result.X.X);
        actualRotation.ShouldBeApproximately(objRot, 0.01f);
        
        // Check scaling
        result.X.X.ShouldBeApproximately(objScale.X * Mathf.Cos(objRot), 0.01f);
        result.Y.Y.ShouldBeApproximately(objScale.Y * Mathf.Cos(objRot), 0.01f);
    }
```

**Returns:** `void`

**Parameters:**
- `Vector2 objPos`
- `float objRot`
- `Vector2 objScale`
- `Vector2 shapeLocalPos`

### CalculateTileRangeTestData

```csharp
#endregion

    #region Parameterized Tile Range Tests

    public static TheoryData<Vector2, Transform2D, Vector2, string> CalculateTileRangeTestData()
    {
        return new TheoryData<Vector2, Transform2D, Vector2, string>
        {
            { DEFAULT_SIZE, new Transform2D(0, Vector2.One, 0, Vector2.Zero), DEFAULT_TILE_SIZE, "axis_aligned" },
            { DEFAULT_SIZE, new Transform2D(DEFAULT_ROTATION, Vector2.One, 0, Vector2.Zero), DEFAULT_TILE_SIZE, "rotated" },
            { DEFAULT_SIZE, new Transform2D(0, new Vector2(2, 2), 0, Vector2.Zero), DEFAULT_TILE_SIZE, "scaled" },
            { DEFAULT_SIZE, new Transform2D(0, Vector2.One, 0, new Vector2(50, 50)), DEFAULT_TILE_SIZE, "offset" },
            { Vector2.Zero, new Transform2D(0, Vector2.One, 0, Vector2.Zero), DEFAULT_TILE_SIZE, "zero_size" }
        };
    }
```

**Returns:** `TheoryData<Vector2, Transform2D, Vector2, string>`

### CalculateTileRange_Parameterized_ReturnsCorrectRange

```csharp
[Theory]
    [MemberData(nameof(CalculateTileRangeTestData))]
    public void CalculateTileRange_Parameterized_ReturnsCorrectRange(
        Vector2 size, Transform2D transform, Vector2 tileSize, string testCase)
    {
        var result = CollisionGeometryUtils.CalculateTileRange(size, transform, tileSize);

        result.ShouldNotBeNull();
        
        // Basic validation - should have at least one tile
        (result.MaxTile.X - result.MinTile.X + 1).ShouldBeGreaterThanOrEqualTo(1);
        (result.MaxTile.Y - result.MinTile.Y + 1).ShouldBeGreaterThanOrEqualTo(1);
        
        // Test-specific validations
        switch (testCase)
        {
            case "axis_aligned":
                // For 32x32 rectangle at origin with 16x16 tiles, we should get 2x2 tiles
                (result.MaxTile.X - result.MinTile.X + 1).ShouldBe(2);
                (result.MaxTile.Y - result.MinTile.Y + 1).ShouldBe(2);
                break;
                
            case "rotated":
                // Rotated rectangle should cover more tiles than axis-aligned
                var axisAlignedRange = CollisionGeometryUtils.CalculateTileRange(
                    size, new Transform2D(0, Vector2.One, 0, Vector2.Zero), tileSize);
                var rotatedWidth = result.MaxTile.X - result.MinTile.X + 1;
                var axisAlignedWidth = axisAlignedRange.MaxTile.X - axisAlignedRange.MinTile.X + 1;
                rotatedWidth.ShouldBeGreaterThanOrEqualTo(axisAlignedWidth);
                break;
                
            case "scaled":
                // Scaled rectangle should cover more tiles
                var normalRange = CollisionGeometryUtils.CalculateTileRange(
                    size, new Transform2D(0, Vector2.One, 0, Vector2.Zero), tileSize);
                var scaledWidth = result.MaxTile.X - result.MinTile.X + 1;
                var normalWidth = normalRange.MaxTile.X - normalRange.MinTile.X + 1;
                scaledWidth.ShouldBeGreaterThan(normalWidth);
                break;
                
            case "offset":
                // The tile range should be offset from origin
                result.MinTile.X.ShouldBeGreaterThanOrEqualTo(2);
                result.MinTile.Y.ShouldBeGreaterThanOrEqualTo(2);
                break;
                
            case "zero_size":
                // Zero size should still result in at least one tile
                (result.MaxTile.X - result.MinTile.X + 1).ShouldBe(1);
                (result.MaxTile.Y - result.MinTile.Y + 1).ShouldBe(1);
                break;
        }
    }
```

**Returns:** `void`

**Parameters:**
- `Vector2 size`
- `Transform2D transform`
- `Vector2 tileSize`
- `string testCase`

### BuildShapeTransform_ComplexLocalPosition_ReturnsCorrectOrigin

```csharp
#endregion

    /// <summary>
    /// Tests shape transform with complex local position.
    /// </summary>
    [Test]
    public void BuildShapeTransform_ComplexLocalPosition_ReturnsCorrectOrigin()
    {
        var objPos = new Vector2(100, 100);
        var objRot = 0;
        var objScale = Vector2.One;
        var shapeLocalPos = new Vector2(32, 48);

        var result = CollisionGeometryUtils.BuildShapeTransform(objPos, objRot, objScale, shapeLocalPos);

        result.ShouldNotBeNull();
        
        // The shape origin should be object position + local position
        var expectedOrigin = objPos + shapeLocalPos;
        result.Origin.ShouldBeApproximately(expectedOrigin, 0.01f);
    }
```

Tests shape transform with complex local position.

**Returns:** `void`

### BuildShapeTransform_WithScaling_ReturnsCorrectTransform

```csharp
/// <summary>
    /// Tests shape transform with scaling.
    /// </summary>
    [Test]
    public void BuildShapeTransform_WithScaling_ReturnsCorrectTransform()
    {
        var objPos = Vector2.Zero;
        var objRot = 0;
        var objScale = new Vector2(2, 0.5f);
        var shapeLocalPos = new Vector2(16, 16);

        var result = CollisionGeometryUtils.BuildShapeTransform(objPos, objRot, objScale, shapeLocalPos);

        result.ShouldNotBeNull();
        
        // The transform should reflect the scaling
        result.X.X.ShouldBeApproximately(objScale.X, 0.01f);
        result.Y.Y.ShouldBeApproximately(objScale.Y, 0.01f);
    }
```

Tests shape transform with scaling.

**Returns:** `void`

### ComputePolygonTileOffsets_ComprehensiveShapes

```csharp
#endregion

    #region Comprehensive Parameterized Tests

    /// <summary>
    /// Comprehensive parameterized test for polygon tile offset computation.
    /// Ports the extensive GDScript test suite with 14+ test cases.
    /// </summary>
    [Test]
    [TestCase("single_tile_square", -8, -8, 8, 8, 20, 20, 1, "16x16 square at center of tile should cover 1 tile")]
    [TestCase("two_tile_rectangle", -24, -8, 24, 8, 32, 32, 2, "48x16 rectangle should cover 2+ tiles horizontally")]
    [TestCase("four_tile_large_square", -16, -16, 16, 16, 32, 32, 4, "32x32 square should cover 4 tiles")]
    [TestCase("tiny_polygon", -1, -1, 1, 1, 16, 16, 1, "Tiny 2x2 polygon should still register overlap")]
    [TestCase("triangle_single_tile", 0, -10, -8, 8, 8, 8, 20, 20, 1, "Triangle within single tile")]
    [TestCase("diamond_shape", 0, -12, 12, 0, 0, 12, -12, 0, 32, 32, 1, "Diamond shape centered in tile")]
    [TestCase("large_tile_small_polygon", -4, -4, 4, 4, 40, 40, 1, "Small polygon in large tile")]
    [TestCase("small_tile_large_polygon", -16, -16, 16, 16, 10, 10, 9, "Large polygon covering many small tiles")]
    public void ComputePolygonTileOffsets_ComprehensiveShapes(
        string testName, float x1, float y1, float x2, float y2, float worldX, float worldY, int expectedMinTiles, string description)
    {
        // Arrange - create polygon from test parameters
        var worldPoints = new Vector2[]
        {
            new(worldX + x1, worldY + y1),
            new(worldX + x2, worldY + y1),
            new(worldX + x2, worldY + y2),
            new(worldX + x1, worldY + y2)
        };
        
        var tileSize = DEFAULT_TILE_SIZE;
        var centerTile = new Vector2I(
            (int)(worldX / tileSize.X), 
            (int)(worldY / tileSize.Y)
        );

        // Act - compute tile offsets using Core utilities
        var offsets = CollisionUtilities.ComputePolygonTileOffsets(
            worldPoints, tileSize, centerTile, TileSet.TileShapeEnum.Square);

        // Assert - check minimum expected coverage
        offsets.Count.ShouldBeGreaterThanOrEqualTo(expectedMinTiles, 
            $"Test '{testName}': {description}. Expected at least {expectedMinTiles} tiles, got {offsets.Count}");

        // Additional validation - offsets should be reasonable
        foreach (var offset in offsets)
        {
            offset.Length().ShouldBeLessThanOrEqualTo(10, 
                $"Test '{testName}': Offset {offset} is unreasonably far from center tile");
        }
    }
```

Comprehensive parameterized test for polygon tile offset computation.
Ports the extensive GDScript test suite with 14+ test cases.

**Returns:** `void`

**Parameters:**
- `string testName`
- `float x1`
- `float y1`
- `float x2`
- `float y2`
- `float worldX`
- `float worldY`
- `int expectedMinTiles`
- `string description`

### ComputePolygonTileOffsets_TriangleShapes

```csharp
/// <summary>
    /// Test for triangle shapes specifically.
    /// </summary>
    [Test]
    [TestCase("triangle_multi_tile", 0, -20, -16, 16, 16, 16, 32, 32, 2, "Triangle spanning multiple tiles")]
    public void ComputePolygonTileOffsets_TriangleShapes(
        string testName, float x1, float y1, float x2, float y2, float x3, float y3, 
        float worldX, float worldY, int expectedMinTiles, string description)
    {
        // Arrange - create triangle
        var worldPoints = new Vector2[]
        {
            new(worldX + x1, worldY + y1),
            new(worldX + x2, worldY + y2),
            new(worldX + x3, worldY + y3)
        };
        
        var tileSize = DEFAULT_TILE_SIZE;
        var centerTile = new Vector2I(
            (int)(worldX / tileSize.X), 
            (int)(worldY / tileSize.Y)
        );

        // Act
        var offsets = CollisionUtilities.ComputePolygonTileOffsets(
            worldPoints, tileSize, centerTile, TileSet.TileShapeEnum.Square);

        // Assert
        offsets.Count.ShouldBeGreaterThanOrEqualTo(expectedMinTiles, 
            $"Test '{testName}': {description}. Expected at least {expectedMinTiles} tiles, got {offsets.Count}");
    }
```

Test for triangle shapes specifically.

**Returns:** `void`

**Parameters:**
- `string testName`
- `float x1`
- `float y1`
- `float x2`
- `float y2`
- `float x3`
- `float y3`
- `float worldX`
- `float worldY`
- `int expectedMinTiles`
- `string description`

### ComputePolygonTileOffsets_EdgeCases

```csharp
/// <summary>
    /// Test edge cases and boundary conditions.
    /// Ports the comprehensive edge case tests from GDScript.
    /// </summary>
    [Test]
    public void ComputePolygonTileOffsets_EdgeCases()
    {
        var tileSize = DEFAULT_TILE_SIZE;

        // Test empty polygon
        var emptyOffsets = CollisionUtilities.ComputePolygonTileOffsets(
            Array.Empty<Vector2>(), tileSize, Vector2I.Zero, TileSet.TileShapeEnum.Square);
        emptyOffsets.Count.ShouldBe(0, "Empty polygon should return empty offsets");

        // Test single point
        var singlePointOffsets = CollisionUtilities.ComputePolygonTileOffsets(
            new Vector2[] { new(32, 32) }, tileSize, Vector2i(2, 2), TileSet.TileShapeEnum.Square);
        singlePointOffsets.Count.ShouldBe(0, "Single point should return empty offsets");

        // Test line segment
        var lineOffsets = CollisionUtilities.ComputePolygonTileOffsets(
            new Vector2[] { new(32, 32), new(48, 32) }, tileSize, Vector2i(2, 2), TileSet.TileShapeEnum.Square);
        lineOffsets.Count.ShouldBe(0, "Line segment should return empty offsets");

        // Test tile-aligned square
        var alignedOffsets = CollisionUtilities.ComputePolygonTileOffsets(
            new Vector2[] { new(0, 0), new(16, 0), new(16, 16), new(0, 16) }, 
            tileSize, Vector2i.Zero, TileSet.TileShapeEnum.Square);
        alignedOffsets.Count.ShouldBe(1, "Tile-aligned square should cover exactly 1 tile");

        // Test half-tile offset
        var halfTileOffsets = CollisionUtilities.ComputePolygonTileOffsets(
            new Vector2[] { new(8, 8), new(24, 8), new(24, 24), new(8, 24) }, 
            tileSize, Vector2i(1, 1), TileSet.TileShapeEnum.Square);
        halfTileOffsets.Count.ShouldBe(4, "Half-tile offset should cover 4 tiles");
    }
```

Test edge cases and boundary conditions.
Ports the comprehensive edge case tests from GDScript.

**Returns:** `void`

### ComputePolygonTileOffsets_MicroPolygons

```csharp
/// <summary>
    /// Test micro polygons and area threshold behavior.
    /// Validates the 5% minimum area overlap threshold.
    /// </summary>
    [Test]
    public void ComputePolygonTileOffsets_MicroPolygons()
    {
        var tileSize = DEFAULT_TILE_SIZE;

        // Test micro square (8x8=64 units, 25% of tile) - should register
        var microOffsets = CollisionUtilities.ComputePolygonTileOffsets(
            new Vector2[] { new(17, 17), new(25, 17), new(25, 25), new(17, 25) }, 
            tileSize, Vector2i(1, 1), TileSet.TileShapeEnum.Square);
        microOffsets.Count.ShouldBe(1, "Micro square (25% of tile) should register 1 tile");

        // Test truly micro square (2x2=4 units, 1.56% of tile) - should return 0 due to 5% threshold
        var trulyMicroOffsets = CollisionUtilities.ComputePolygonTileOffsets(
            new Vector2[] { new(17, 17), new(19, 17), new(19, 19), new(17, 19) }, 
            tileSize, Vector2i(1, 1), TileSet.TileShapeEnum.Square);
        trulyMicroOffsets.Count.ShouldBe(0, "Truly micro square (1.56% of tile) should return 0 tiles due to 5% threshold");

        // Test floating point precision case
        var precisionOffsets = CollisionUtilities.ComputePolygonTileOffsets(
            new Vector2[] { new(15.999f, 15.999f), new(16.001f, 15.999f), new(16.001f, 16.001f), new(15.999f, 16.001f) }, 
            tileSize, Vector2i(1, 0), TileSet.TileShapeEnum.Square);
        precisionOffsets.Count.ShouldBe(0, "Tiny floating point precision polygon should return 0 tiles due to 5% area threshold");
    }
```

Test micro polygons and area threshold behavior.
Validates the 5% minimum area overlap threshold.

**Returns:** `void`

### IsPolygonConvexTestData

```csharp
#region Parameterized Polygon Convexity Tests

    public static TheoryData<Vector2[], bool> IsPolygonConvexTestData()
    {
        return new TheoryData<Vector2[], bool>
        {
            // Convex shapes
            { new Vector2[] { new(-8, -8), new(8, -8), new(8, 8), new(-8, 8) }, true }, // Square
            { new Vector2[] { new(-10, -5), new(10, -5), new(10, 5), new(-10, 5) }, true }, // Rectangle
            { new Vector2[] { new(0, -10), new(-8, 8), new(8, 8) }, true }, // Triangle
            { new Vector2[] { new(0, -12), new(12, 0), new(0, 12), new(-12, 0) }, true }, // Diamond
            
            // Concave shapes
            { new Vector2[] { new(-12, -12), new(4, -12), new(4, -4), new(12, -4), new(12, 12), new(-12, 12) }, false }, // L-shape
            { new Vector2[] { new(-16, -8), new(16, -8), new(16, 0), new(4, 0), new(4, 4), new(-4, 4), new(-4, 0), new(-16, 0) }, false }, // U-shape
            
            // Edge cases
            { new Vector2[] { new(0, 0), new(10, 0), new(20, 0) }, true }, // Collinear triangle
            { new Vector2[] { new(-10, -10), new(10, 10), new(10, -10), new(-10, 10) }, false } // Self-intersecting
        };
    }
```

**Returns:** `TheoryData<Vector2[], bool>`

### IsPolygonConvex_Parameterized_ReturnsExpected

```csharp
[Theory]
    [MemberData(nameof(IsPolygonConvexTestData))]
    public void IsPolygonConvex_Parameterized_ReturnsExpected(Vector2[] polygon, bool expected)
    {
        var result = CollisionGeometryUtils.IsPolygonConvex(polygon);
        result.ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `Vector2[] polygon`
- `bool expected`

### TrapezoidWorldTransformAndTileOffsets

```csharp
#endregion

    /// <summary>
    /// Test trapezoid world transform and tile offsets.
    /// Replicates the specific failing case from GDScript tests.
    /// </summary>
    [Test]
    public void TrapezoidWorldTransformAndTileOffsets()
    {
        // Arrange - create trapezoid matching runtime scenario
        var worldPoints = new Vector2[]
        {
            new(-32, 12), new(-16, -12), new(17, -12), new(32, 12)
        };
        
        var position = new Vector2(440, 552);
        var tileSize = new Vector2(16, 16);
        var centerTile = new Vector2i(
            (int)(position.X / tileSize.X), 
            (int)(position.Y / tileSize.Y)
        );

        // Transform to world coordinates
        var transformedPoints = new Vector2[worldPoints.Length];
        for (int i = 0; i < worldPoints.Length; i++)
        {
            transformedPoints[i] = position + worldPoints[i];
        }

        // Act - compute tile offsets
        var offsets = CollisionUtilities.ComputePolygonTileOffsets(
            transformedPoints, tileSize, centerTile, TileSet.TileShapeEnum.Square);

        // Assert - should cover multiple tiles (expect 8-13 based on GDScript test)
        offsets.Count.ShouldBeGreaterThanOrEqualTo(8, 
            $"Trapezoid should cover at least 8 tiles, got {offsets.Count}: {string.Join(", ", offsets)}");
        
        offsets.Count.ShouldBeLessThanOrEqualTo(13, 
            $"Trapezoid should cover at most 13 tiles, got {offsets.Count}: {string.Join(", ", offsets)}");
    }
```

Test trapezoid world transform and tile offsets.
Replicates the specific failing case from GDScript tests.

**Returns:** `void`

### FailingMapperCase

```csharp
/// <summary>
    /// Test the specific failing mapper case from GDScript.
    /// Replicates exact coordinates from polygon_tile_mapper tests.
    /// </summary>
    [Test]
    public void FailingMapperCase()
    {
        // Arrange - exact coordinates from failing GDScript test
        var worldPoints = new Vector2[]
        {
            new(300, 300), new(340, 300), new(340, 340), new(300, 340)
        };
        var tileSize = new Vector2(40, 40);
        var centerTile = new Vector2i(8, 8); // 320/40 = 8

        // Act
        var offsets = CollisionUtilities.ComputePolygonTileOffsets(
            worldPoints, tileSize, centerTile, TileSet.TileShapeEnum.Square);

        // Assert - should definitely return at least 1 offset
        offsets.Count.ShouldBeGreaterThan(0, 
            "40x40 square at (300,300)-(340,340) should overlap tiles");

        // Should include center tile offset (0,0)
        offsets.ShouldContain(Vector2i.Zero, 
            "Should include center tile offset (0,0)");
    }
```

Test the specific failing mapper case from GDScript.
Replicates exact coordinates from polygon_tile_mapper tests.

**Returns:** `void`

