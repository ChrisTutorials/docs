---
title: "PolygonTileMapperTest"
description: "Unit tests for PolygonTileMapper static methods"
weight: 20
url: "/gridbuilding/v6-0/api/godot/polygontilemappertest/"
---

# PolygonTileMapperTest

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class PolygonTileMapperTest
{
    // Members...
}
```

Unit tests for PolygonTileMapper static methods

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/PolygonTileMapperTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Integration.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ComputeTileOffsets_PolygonShapes_ReturnsValidOffsets

```csharp
#endregion

    #region Test Functions

    /// <summary>
    /// Test different polygon shapes on square tiles
    /// </summary>
    [Test]
    public void ComputeTileOffsets_PolygonShapes_ReturnsValidOffsets()
    {
        // Triangle
        var trianglePoints = new Vector2[]
        {
            new(0, 0), new(64, 0), new(32, 64)
        };
        RunPolygonTest(trianglePoints, "basic triangle polygon", "square", 1, -1, new Vector2(320, 320));

        // Rectangle
        var rectanglePoints = new Vector2[]
        {
            new(-32, -32), new(32, -32), new(32, 32), new(-32, 32)
        };
        RunPolygonTest(rectanglePoints, "32x32 rectangle polygon", "square", 1, 9);

        // Complex convex
        var convexPoints = new Vector2[]
        {
            new(0, 0), new(24, -8), new(64, 32), new(32, 64), new(-8, 24)
        };
        RunPolygonTest(convexPoints, "complex convex polygon", "square", 1, -1);

        // Concave
        var concavePoints = new Vector2[]
        {
            new(0, 0), new(64, 0), new(32, 32), new(64, 64), new(0, 64)
        };
        RunPolygonTest(concavePoints, "concave polygon with indent", "square", 1, -1);
    }
```

Test different polygon shapes on square tiles

**Returns:** `void`

### ComputeTileOffsets_TileTypes_ReturnsValidOffsets

```csharp
/// <summary>
    /// Test different tile types
    /// </summary>
    [Test]
    public void ComputeTileOffsets_TileTypes_ReturnsValidOffsets()
    {
        var points = new Vector2[]
        {
            new(0, 0), new(64, 0), new(32, 64)
        };

        // Test square tiles
        RunPolygonTest(points, "square tiles", "square", 1, -1);

        // Test isometric tiles (same implementation for now)
        RunPolygonTest(points, "isometric tiles", "isometric", 1, -1);
    }
```

Test different tile types

**Returns:** `void`

### ProcessPolygon_WithDiagnostics_GeneratesValidOutput

```csharp
/// <summary>
    /// Test processing polygon with diagnostics
    /// </summary>
    [Test]
    public void ProcessPolygon_WithDiagnostics_GeneratesValidOutput()
    {
        var points = new Vector2[]
        {
            new(0, 0), new(64, 0), new(32, 64)
        };
        RunPolygonTest(points, "diagnostic processing");
    }
```

Test processing polygon with diagnostics

**Returns:** `void`

### ComputeTileOffsets_NullPolygon_ReturnsEmptyResult

```csharp
/// <summary>
    /// Test null polygon handling
    /// </summary>
    [Test]
    public void ComputeTileOffsets_NullPolygon_ReturnsEmptyResult()
    {
        var testMap = CreateTestTileMap();

        var result = PolygonTileMapper.ComputeTileOffsets(null, testMap);

        result.Count.ShouldBe(0, "Expected null polygon to return empty result");
    }
```

Test null polygon handling

**Returns:** `void`

### ComputeTileOffsets_NullMap_ReturnsEmptyResult

```csharp
/// <summary>
    /// Test null map handling
    /// </summary>
    [Test]
    public void ComputeTileOffsets_NullMap_ReturnsEmptyResult()
    {
        // Create a StaticBody2D parent for proper collision hierarchy
        var staticBody = CreateStaticBody();

        var trianglePolygon = CreateCollisionPolygon(new Vector2[]
        {
            new(0, 0),
            new(32, 0),
            new(16, 32)
        }, staticBody);

        var result = PolygonTileMapper.ComputeTileOffsets(trianglePolygon, null);

        result.Count.ShouldBe(0, "Expected null map to return empty result");

        staticBody.QueueFree();
    }
```

Test null map handling

**Returns:** `void`

### ComputeTileOffsets_NoTileSet_ReturnsEmptyResult

```csharp
/// <summary>
    /// Test map without tile set
    /// </summary>
    [Test]
    public void ComputeTileOffsets_NoTileSet_ReturnsEmptyResult()
    {
        var testMap = new TileMapLayer(); // No tile set
        TestScene.AddChild(testMap);

        // Create a StaticBody2D parent for proper collision hierarchy
        var staticBody = CreateStaticBody();

        var trianglePolygon = CreateCollisionPolygon(new Vector2[]
        {
            new(0, 0),
            new(32, 0),
            new(16, 32)
        }, staticBody);

        var result = PolygonTileMapper.ComputeTileOffsets(trianglePolygon, testMap);

        result.Count.ShouldBe(0, "Expected map without tile set to return empty result");

        staticBody.QueueFree();
        testMap.QueueFree();
    }
```

Test map without tile set

**Returns:** `void`

### ComputeTileOffsets_DegeneratePolygons_HandlesGracefully

```csharp
/// <summary>
    /// Test degenerate polygons
    /// </summary>
    [Test]
    public void ComputeTileOffsets_DegeneratePolygons_HandlesGracefully()
    {
        // Empty polygon
        var emptyPoints = new Vector2[] { };
        RunPolygonTest(emptyPoints, "empty polygon", "square", 0, 1);

        // Line polygon (2 points)
        var linePoints = new Vector2[] { new(0, 0), new(32, 32) };
        RunPolygonTest(linePoints, "line polygon", "square", 0, 1);

        // Single point polygon
        var pointPoints = new Vector2[] { new(16, 16) };
        RunPolygonTest(pointPoints, "point polygon", "square", 0, 1);
    }
```

Test degenerate polygons

**Returns:** `void`

### ComputeTileOffsets_AtOrigin_ReturnsValidOffsets

```csharp
/// <summary>
    /// Test polygon at origin
    /// </summary>
    [Test]
    public void ComputeTileOffsets_AtOrigin_ReturnsValidOffsets()
    {
        var points = new Vector2[]
        {
            new(0, 0), new(32, 0), new(16, 32)
        };
        RunPolygonTest(points, "polygon at origin", "square", 1, -1, Vector2.Zero);
    }
```

Test polygon at origin

**Returns:** `void`

### ComputeTileOffsets_LargePolygon_CoversMultipleTiles

```csharp
/// <summary>
    /// Test large polygon covering many tiles
    /// </summary>
    [Test]
    public void ComputeTileOffsets_LargePolygon_CoversMultipleTiles()
    {
        var points = new Vector2[]
        {
            new(-64, -64),
            new(64, -64),
            new(64, 64),
            new(-64, 64)
        };
        RunPolygonTest(points, "large 128x128 polygon", "square", 16, -1); // Should cover at least 16 tiles
    }
```

Test large polygon covering many tiles

**Returns:** `void`

### ComputeTileOffsets_WithParent_AppliesTransform

```csharp
/// <summary>
    /// Test polygon with parent transform
    /// </summary>
    [Test]
    public void ComputeTileOffsets_WithParent_AppliesTransform()
    {
        var points = new Vector2[]
        {
            new(0, 0), new(32, 0), new(16, 32)
        };
        RunPolygonTest(points, "polygon with parent transform", "square", 1, -1);
    }
```

Test polygon with parent transform

**Returns:** `void`

### ProcessPolygon_DiagnosticsConvex_GeneratesCorrectInfo

```csharp
/// <summary>
    /// Test diagnostic information for convex polygon
    /// </summary>
    [Test]
    public void ProcessPolygon_DiagnosticsConvex_GeneratesCorrectInfo()
    {
        var testMap = CreateTestTileMap();
        var convexPolygon = new CollisionPolygon2D();
        TestScene.AddChild(convexPolygon);
        convexPolygon.Polygon = new Vector2[]
        {
            new(0, 0), new(32, 0), new(32, 32), new(0, 32)
        };

        var result = PolygonTileMapper.ComputeTileOffsets(convexPolygon, testMap);

        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0, "Convex polygon should produce tile offsets");

        convexPolygon.QueueFree();
    }
```

Test diagnostic information for convex polygon

**Returns:** `void`

### ProcessPolygon_DiagnosticsConcave_GeneratesCorrectInfo

```csharp
/// <summary>
    /// Test diagnostic information for concave polygon
    /// </summary>
    [Test]
    public void ProcessPolygon_DiagnosticsConcave_GeneratesCorrectInfo()
    {
        var testMap = CreateTestTileMap();
        var concavePolygon = new CollisionPolygon2D();
        TestScene.AddChild(concavePolygon);
        concavePolygon.Polygon = new Vector2[]
        {
            new(0, 0), new(64, 0), new(32, 32), new(64, 64), new(0, 64)
        };

        var result = PolygonTileMapper.ComputeTileOffsets(concavePolygon, testMap);

        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0, "Concave polygon should produce tile offsets");

        concavePolygon.QueueFree();
    }
```

Test diagnostic information for concave polygon

**Returns:** `void`

### GetPolygonTileOverlapArea_ExactMatch_ReturnsCorrectArea

```csharp
/// <summary>
    /// Test polygon tile overlap area calculations
    /// </summary>
    [Test]
    public void GetPolygonTileOverlapArea_ExactMatch_ReturnsCorrectArea()
    {
        var rect = new Rect2(0, 0, 16, 16);
        var matchingPolygon = new Vector2[]
        {
            new(0, 0), new(16, 0), new(16, 16), new(0, 16)
        };
        var area = PolygonTileMapper.GetPolygonTileOverlapArea(matchingPolygon, rect);
        
        area.ShouldBe(256.0f, "Expected polygon matching rect bounds to have 256 area");
    }
```

Test polygon tile overlap area calculations

**Returns:** `void`

### GetPolygonTileOverlapArea_EmptyPolygon_ReturnsZero

```csharp
/// <summary>
    /// Test polygon tile overlap area with empty polygon
    /// </summary>
    [Test]
    public void GetPolygonTileOverlapArea_EmptyPolygon_ReturnsZero()
    {
        var rect = new Rect2(0, 0, 16, 16);
        var emptyPolygon = new Vector2[] { };
        var area = PolygonTileMapper.GetPolygonTileOverlapArea(emptyPolygon, rect);
        
        area.ShouldBe(0.0f, "Expected empty polygon to have 0 area");
    }
```

Test polygon tile overlap area with empty polygon

**Returns:** `void`

### GetPolygonTileOverlapArea_OutsideRect_ReturnsZero

```csharp
/// <summary>
    /// Test polygon tile overlap area with polygon outside rect
    /// </summary>
    [Test]
    public void GetPolygonTileOverlapArea_OutsideRect_ReturnsZero()
    {
        var rect = new Rect2(0, 0, 16, 16);
        var outsidePolygon = new Vector2[]
        {
            new(20, 20), new(30, 20), new(30, 30), new(20, 30)
        };
        var area = PolygonTileMapper.GetPolygonTileOverlapArea(outsidePolygon, rect);
        
        area.ShouldBe(0.0f, "Expected polygon outside rect to have 0 area");
    }
```

Test polygon tile overlap area with polygon outside rect

**Returns:** `void`

### GetPolygonTileOverlapArea_CompletelyInside_ReturnsCorrectArea

```csharp
/// <summary>
    /// Test polygon tile overlap area with polygon completely inside rect
    /// </summary>
    [Test]
    public void GetPolygonTileOverlapArea_CompletelyInside_ReturnsCorrectArea()
    {
        var rect = new Rect2(0, 0, 16, 16);
        var insidePolygon = new Vector2[]
        {
            new(4, 4), new(12, 4), new(12, 12), new(4, 12)
        };
        var area = PolygonTileMapper.GetPolygonTileOverlapArea(insidePolygon, rect);
        
        area.ShouldBe(64.0f, "Expected 8x8 polygon inside 16x16 rect to have 64 area"); // 8x8 square = 64
    }
```

Test polygon tile overlap area with polygon completely inside rect

**Returns:** `void`

### GetPolygonTileOverlapArea_Triangle_ReturnsCorrectArea

```csharp
/// <summary>
    /// Test polygon tile overlap area with triangle
    /// </summary>
    [Test]
    public void GetPolygonTileOverlapArea_Triangle_ReturnsCorrectArea()
    {
        var rect = new Rect2(0, 0, 16, 16);
        var triangle = new Vector2[]
        {
            new(0, 0), new(16, 0), new(8, 16)
        };
        var area = PolygonTileMapper.GetPolygonTileOverlapArea(triangle, rect);
        
        area.ShouldBeBetween(120.0f, 140.0f, "Expected triangle overlap to be around 128 area"); // Should be around 128
    }
```

Test polygon tile overlap area with triangle

**Returns:** `void`

### GetPolygonTileOverlapArea_PartialOverlap_ReturnsCorrectArea

```csharp
/// <summary>
    /// Test polygon tile overlap area with partial overlap
    /// </summary>
    [Test]
    public void GetPolygonTileOverlapArea_PartialOverlap_ReturnsCorrectArea()
    {
        var rect = new Rect2(0, 0, 16, 16);
        var partialPolygon = new Vector2[]
        {
            new(-8, -8), new(8, -8), new(8, 8), new(-8, 8)
        };
        var area = PolygonTileMapper.GetPolygonTileOverlapArea(partialPolygon, rect);
        
        area.ShouldBeBetween(30.0f, 70.0f, "Expected partial overlap to be around 64 area"); // Should be around 64
    }
```

Test polygon tile overlap area with partial overlap

**Returns:** `void`

### ConcavePolygon_TileDistribution_HandlesCorrectly

```csharp
/// <summary>
    /// Test concave polygon tile distribution
    /// </summary>
    [Test]
    public void ConcavePolygon_TileDistribution_HandlesCorrectly()
    {
        var testMap = CreateTestTileMap();
        var staticBody = CreateStaticBody();

        // Create the same concave polygon from the failing integration test
        // This creates a shape that should have a "hole" in the middle
        var concavePoints = new Vector2[]
        {
            new(0, 0), new(64, 0), new(64, 64), new(32, 32), new(0, 64)
        };

        var polygon = CreateCollisionPolygon(concavePoints, staticBody);
        var result = PolygonTileMapper.ComputeTileOffsets(polygon, testMap);

        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0, "Concave polygon should produce tile offsets");

        staticBody.QueueFree();
    }
```

Test concave polygon tile distribution

**Returns:** `void`

### ComputeTileOffsets_Consistency_ReturnsSameResults

```csharp
/// <summary>
    /// Test polygon tile offset consistency
    /// </summary>
    [Test]
    public void ComputeTileOffsets_Consistency_ReturnsSameResults()
    {
        var testMap = CreateTestTileMap();
        var trianglePolygon = new CollisionPolygon2D();
        TestScene.AddChild(trianglePolygon);
        trianglePolygon.Polygon = new Vector2[]
        {
            new(0, 0), new(32, 0), new(16, 32)
        };

        // Run the same test multiple times to ensure consistency
        var result1 = PolygonTileMapper.ComputeTileOffsets(trianglePolygon, testMap);
        var result2 = PolygonTileMapper.ComputeTileOffsets(trianglePolygon, testMap);

        result1.Count.ShouldBe(result2.Count, "Results should be consistent between runs");

        trianglePolygon.QueueFree();
    }
```

Test polygon tile offset consistency

**Returns:** `void`

