---
title: "GeometryIntegrationTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/geometryintegrationtest/"
---

# GeometryIntegrationTest

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class GeometryIntegrationTest
{
    // Members...
}
```

Integration tests for geometry math functions with Godot runtime.
Tests Core geometry functions with real Godot types and runtime scenarios.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/GeometryIntegrationTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Integration.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Setup

```csharp
#region Setup and Cleanup

    [SetUp]
    public void Setup()
    {
        // Create test TileMap
        _testTileMap = new TileMapLayer();
        _testTileMap.Name = "TestTileMap";
        TestScene.AddChild(_testTileMap);
        
        // Create test node
        _testNode = new Node2D();
        _testNode.Name = "TestNode";
        _testNode.GlobalPosition = DEFAULT_POSITION;
        TestScene.AddChild(_testNode);
    }
```

**Returns:** `void`

### Cleanup

```csharp
[TearDown]
    public void Cleanup()
    {
        _testNode?.QueueFree();
        _testTileMap?.QueueFree();
    }
```

**Returns:** `void`

### GetTilePolygon_SquareTile_Integration_ReturnsCorrectVertices

```csharp
#endregion

    #region Tile Polygon Generation Integration Tests

    [Test]
    public void GetTilePolygon_SquareTile_Integration_ReturnsCorrectVertices()
    {
        // Arrange
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const TileShape tileShape = TileShape.Square;

        // Act
        var tilePolygon = GeometryMath.GetTilePolygon(tilePos, tileSize, tileShape);

        // Assert
        tilePolygon.ShouldNotBeNull();
        tilePolygon.Length.ShouldBe(4);
        
        // Verify square vertices
        var expectedVertices = new[]
        {
            new Vector2(0, 0), new Vector2(16, 0), new Vector2(16, 16), new Vector2(0, 16)
        };

        for (int i = 0; i < expectedVertices.Length; i++)
        {
            tilePolygon[i].ShouldBeApproximately(expectedVertices[i], 0.001f);
        }
    }
```

**Returns:** `void`

### GetTilePolygon_IsometricTile_Integration_ReturnsDiamondShape

```csharp
[Test]
    public void GetTilePolygon_IsometricTile_Integration_ReturnsDiamondShape()
    {
        // Arrange
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const TileShape tileShape = TileShape.Isometric;

        // Act
        var tilePolygon = GeometryMath.GetTilePolygon(tilePos, tileSize, tileShape);

        // Assert
        tilePolygon.ShouldNotBeNull();
        tilePolygon.Length.ShouldBe(4);
        
        // Verify diamond shape (rotated square)
        var center = tilePos + tileSize / 2f;
        var halfWidth = tileSize.X / 2f;
        var halfHeight = tileSize.Y / 2f;
        
        var expectedVertices = new[]
        {
            center + new Vector2(0, -halfHeight),    // Top
            center + new Vector2(halfWidth, 0),      // Right
            center + new Vector2(0, halfHeight),     // Bottom
            center + new Vector2(-halfWidth, 0)      // Left
        };

        for (int i = 0; i < expectedVertices.Length; i++)
        {
            tilePolygon[i].ShouldBeApproximately(expectedVertices[i], 0.1f);
        }
    }
```

**Returns:** `void`

### GetTilePolygon_HalfOffsetSquareTile_Integration_ReturnsCenteredSquare

```csharp
[Test]
    public void GetTilePolygon_HalfOffsetSquareTile_Integration_ReturnsCenteredSquare()
    {
        // Arrange
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const TileShape tileShape = TileShape.HalfOffsetSquare;

        // Act
        var tilePolygon = GeometryMath.GetTilePolygon(tilePos, tileSize, tileShape);

        // Assert
        tilePolygon.ShouldNotBeNull();
        tilePolygon.Length.ShouldBe(4);
        
        // Verify centered square
        var center = tilePos + tileSize / 2f;
        var halfSize = tileSize / 2f;
        
        var expectedVertices = new[]
        {
            center + new Vector2(-halfSize.X, -halfSize.Y),  // Bottom-left
            center + new Vector2(halfSize.X, -halfSize.Y),   // Bottom-right
            center + new Vector2(halfSize.X, halfSize.Y),    // Top-right
            center + new Vector2(-halfSize.X, halfSize.Y)    // Top-left
        };

        for (int i = 0; i < expectedVertices.Length; i++)
        {
            tilePolygon[i].ShouldBeApproximately(expectedVertices[i], 0.001f);
        }
    }
```

**Returns:** `void`

### GetPolygonBounds_SquarePolygon_Integration_ReturnsCorrectBounds

```csharp
#endregion

    #region Polygon Bounds Integration Tests

    [Test]
    public void GetPolygonBounds_SquarePolygon_Integration_ReturnsCorrectBounds()
    {
        // Arrange
        var polygon = new Vector2[]
        {
            new(0, 0), new(10, 0), new(10, 10), new(0, 10)
        };

        // Act
        var bounds = GeometryMath.GetPolygonBounds(polygon);

        // Assert
        bounds.ShouldNotBeNull();
        bounds.Position.ShouldBe(new Vector2(0, 0));
        bounds.Size.ShouldBe(new Vector2(10, 10));
    }
```

**Returns:** `void`

### GetPolygonBounds_TransformedPolygon_Integration_ReturnsCorrectBounds

```csharp
[Test]
    public void GetPolygonBounds_TransformedPolygon_Integration_ReturnsCorrectBounds()
    {
        // Arrange
        var transform = new Transform2D(DEFAULT_ROTATION, DEFAULT_POSITION);
        var basePolygon = new Vector2[]
        {
            new(-5, -5), new(5, -5), new(5, 5), new(-5, 5)
        };
        var transformedPolygon = new Vector2[basePolygon.Length];
        for (int i = 0; i < basePolygon.Length; i++)
        {
            transformedPolygon[i] = transform * basePolygon[i];
        }

        // Act
        var bounds = GeometryMath.GetPolygonBounds(transformedPolygon);

        // Assert
        bounds.ShouldNotBeNull();
        bounds.Size.X.ShouldBeGreaterThan(0);
        bounds.Size.Y.ShouldBeGreaterThan(0);
        
        // Bounds should contain the center point
        bounds.Contains(DEFAULT_POSITION).ShouldBeTrue();
    }
```

**Returns:** `void`

### GetPolygonBounds_ComplexPolygon_Integration_ReturnsCorrectBounds

```csharp
[Test]
    public void GetPolygonBounds_ComplexPolygon_Integration_ReturnsCorrectBounds()
    {
        // Arrange
        var starPolygon = new Vector2[]
        {
            new(8, 0), new(10, 6), new(16, 6), new(11, 10),
            new(13, 16), new(8, 12), new(3, 16), new(5, 10),
            new(0, 6), new(6, 6)
        };

        // Act
        var bounds = GeometryMath.GetPolygonBounds(starPolygon);

        // Assert
        bounds.ShouldNotBeNull();
        bounds.Size.X.ShouldBeGreaterThan(16);
        bounds.Size.Y.ShouldBeGreaterThan(16);
        
        // Verify all points are within bounds
        foreach (var point in starPolygon)
        {
            bounds.Contains(point).ShouldBeTrue();
        }
    }
```

**Returns:** `void`

### PolygonIntersectionArea_OverlappingSquares_Integration_ReturnsCorrectArea

```csharp
#endregion

    #region Polygon Intersection Area Integration Tests

    [Test]
    public void PolygonIntersectionArea_OverlappingSquares_Integration_ReturnsCorrectArea()
    {
        // Arrange
        var polygon1 = new Vector2[]
        {
            new(0, 0), new(10, 0), new(10, 10), new(0, 10)
        };
        var polygon2 = new Vector2[]
        {
            new(5, 5), new(15, 5), new(15, 15), new(5, 15)
        };

        // Act
        var area = GeometryMath.PolygonIntersectionArea(polygon1, polygon2);

        // Assert
        area.ShouldBe(25.0f); // 5x5 intersection area
    }
```

**Returns:** `void`

### PolygonIntersectionArea_IdenticalPolygons_Integration_ReturnsPolygonArea

```csharp
[Test]
    public void PolygonIntersectionArea_IdenticalPolygons_Integration_ReturnsPolygonArea()
    {
        // Arrange
        var polygon = new Vector2[]
        {
            new(0, 0), new(10, 0), new(10, 10), new(0, 10)
        };

        // Act
        var area = GeometryMath.PolygonIntersectionArea(polygon, polygon);

        // Assert
        area.ShouldBe(100.0f); // 10x10 area
    }
```

**Returns:** `void`

### PolygonIntersectionArea_NonOverlappingPolygons_Integration_ReturnsZero

```csharp
[Test]
    public void PolygonIntersectionArea_NonOverlappingPolygons_Integration_ReturnsZero()
    {
        // Arrange
        var polygon1 = new Vector2[]
        {
            new(0, 0), new(5, 0), new(5, 5), new(0, 5)
        };
        var polygon2 = new Vector2[]
        {
            new(10, 10), new(15, 10), new(15, 15), new(10, 15)
        };

        // Act
        var area = GeometryMath.PolygonIntersectionArea(polygon1, polygon2);

        // Assert
        area.ShouldBe(0.0f);
    }
```

**Returns:** `void`

### PolygonIntersectionArea_ComplexOverlap_Integration_ReturnsCorrectArea

```csharp
[Test]
    public void PolygonIntersectionArea_ComplexOverlap_Integration_ReturnsCorrectArea()
    {
        // Arrange
        var diamond = new Vector2[]
        {
            new(8, 0), new(16, 8), new(8, 16), new(0, 8)
        };
        var square = new Vector2[]
        {
            new(4, 4), new(12, 4), new(12, 12), new(4, 12)
        };

        // Act
        var area = GeometryMath.PolygonIntersectionArea(diamond, square);

        // Assert
        area.ShouldBe(64.0f); // 8x8 intersection area
    }
```

**Returns:** `void`

### DoesPolygonOverlapTile_SquarePolygonSquareTile_Integration_ReturnsTrue

```csharp
#endregion

    #region Tile Overlap Detection Integration Tests

    [Test]
    public void DoesPolygonOverlapTile_SquarePolygonSquareTile_Integration_ReturnsTrue()
    {
        // Arrange
        var polygon = new Vector2[]
        {
            new(4, 4), new(12, 4), new(12, 12), new(4, 12)
        };
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const TileShape tileShape = TileShape.Square;
        const float epsilon = 1.0f;

        // Act
        var overlaps = GeometryMath.DoesPolygonOverlapTile(polygon, tilePos, tileSize, tileShape, epsilon);

        // Assert
        overlaps.ShouldBeTrue();
    }
```

**Returns:** `void`

### DoesPolygonOverlapTile_SquarePolygonIsometricTile_Integration_ReturnsTrue

```csharp
[Test]
    public void DoesPolygonOverlapTile_SquarePolygonIsometricTile_Integration_ReturnsTrue()
    {
        // Arrange
        var polygon = new Vector2[]
        {
            new(4, 4), new(12, 4), new(12, 12), new(4, 12)
        };
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const TileShape tileShape = TileShape.Isometric;
        const float epsilon = 1.0f;

        // Act
        var overlaps = GeometryMath.DoesPolygonOverlapTile(polygon, tilePos, tileSize, tileShape, epsilon);

        // Assert
        overlaps.ShouldBeTrue();
    }
```

**Returns:** `void`

### DoesPolygonOverlapTile_NonOverlappingPolygon_Integration_ReturnsFalse

```csharp
[Test]
    public void DoesPolygonOverlapTile_NonOverlappingPolygon_Integration_ReturnsFalse()
    {
        // Arrange
        var polygon = new Vector2[]
        {
            new(20, 20), new(24, 20), new(24, 24), new(20, 24)
        };
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const TileShape tileShape = TileShape.Square;
        const float epsilon = 1.0f;

        // Act
        var overlaps = GeometryMath.DoesPolygonOverlapTile(polygon, tilePos, tileSize, tileShape, epsilon);

        // Assert
        overlaps.ShouldBeFalse();
    }
```

**Returns:** `void`

### DoesPolygonOverlapTile_TrianglePolygonSquareTile_Integration_ReturnsTrue

```csharp
[Test]
    public void DoesPolygonOverlapTile_TrianglePolygonSquareTile_Integration_ReturnsTrue()
    {
        // Arrange
        var triangle = new Vector2[]
        {
            new(0, 0), new(16, 0), new(8, 16)
        };
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const TileShape tileShape = TileShape.Square;
        const float epsilon = 1.0f;

        // Act
        var overlaps = GeometryMath.DoesPolygonOverlapTile(triangle, tilePos, tileSize, tileShape, epsilon);

        // Assert
        overlaps.ShouldBeTrue();
    }
```

**Returns:** `void`

### IntersectionAreaWithTile_SquarePolygonSquareTile_Integration_ReturnsCorrectArea

```csharp
#endregion

    #region Tile Intersection Area Integration Tests

    [Test]
    public void IntersectionAreaWithTile_SquarePolygonSquareTile_Integration_ReturnsCorrectArea()
    {
        // Arrange
        var polygon = new Vector2[]
        {
            new(4, 4), new(12, 4), new(12, 12), new(4, 12)
        };
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const TileShape tileShape = TileShape.Square;

        // Act
        var area = GeometryMath.IntersectionAreaWithTile(polygon, tilePos, tileSize, tileShape);

        // Assert
        area.InRange(60.0f, 70.0f); // 8x8 = 64, with tolerance
    }
```

**Returns:** `void`

### IntersectionAreaWithTile_SquarePolygonIsometricTile_Integration_ReturnsCorrectArea

```csharp
[Test]
    public void IntersectionAreaWithTile_SquarePolygonIsometricTile_Integration_ReturnsCorrectArea()
    {
        // Arrange
        var polygon = new Vector2[]
        {
            new(4, 4), new(12, 4), new(12, 12), new(4, 12)
        };
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const TileShape tileShape = TileShape.Isometric;

        // Act
        var area = GeometryMath.IntersectionAreaWithTile(polygon, tilePos, tileSize, tileShape);

        // Assert
        area.InRange(40.0f, 70.0f); // Diamond intersection area
    }
```

**Returns:** `void`

### IntersectionAreaWithTile_NonOverlappingPolygon_Integration_ReturnsZero

```csharp
[Test]
    public void IntersectionAreaWithTile_NonOverlappingPolygon_Integration_ReturnsZero()
    {
        // Arrange
        var polygon = new Vector2[]
        {
            new(20, 20), new(24, 20), new(24, 24), new(20, 24)
        };
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const TileShape tileShape = TileShape.Square;

        // Act
        var area = GeometryMath.IntersectionAreaWithTile(polygon, tilePos, tileSize, tileShape);

        // Assert
        area.ShouldBe(0.0f);
    }
```

**Returns:** `void`

### ConvertRectangleToPolygon_UnitSquare_Integration_ReturnsCorrectVertices

```csharp
#endregion

    #region Shape Conversion Integration Tests

    [Test]
    public void ConvertRectangleToPolygon_UnitSquare_Integration_ReturnsCorrectVertices()
    {
        // Arrange
        var size = new Vector2(16, 16);
        var transform = Transform2D.Identity;

        // Act
        var polygon = GeometryMath.ConvertRectangleToPolygon(size, transform);

        // Assert
        polygon.ShouldNotBeNull();
        polygon.Length.ShouldBe(4);
        
        var halfSize = size / 2f;
        var expectedVertices = new[]
        {
            new Vector2(-halfSize.X, -halfSize.Y),  // Bottom-left
            new Vector2(halfSize.X, -halfSize.Y),   // Bottom-right
            new Vector2(halfSize.X, halfSize.Y),    // Top-right
            new Vector2(-halfSize.X, halfSize.Y)    // Top-left
        };

        for (int i = 0; i < expectedVertices.Length; i++)
        {
            polygon[i].ShouldBeApproximately(expectedVertices[i], 0.001f);
        }
    }
```

**Returns:** `void`

### ConvertCircleToPolygon_UnitRadius_Integration_ReturnsCorrectVertices

```csharp
[Test]
    public void ConvertCircleToPolygon_UnitRadius_Integration_ReturnsCorrectVertices()
    {
        // Arrange
        const float radius = 8f;
        var transform = Transform2D.Identity;

        // Act
        var polygon = GeometryMath.ConvertCircleToPolygon(radius, transform);

        // Assert
        polygon.ShouldNotBeNull();
        polygon.Length.ShouldBe(16); // Default circle vertices
        
        // Verify all vertices are at correct distance from center
        foreach (var vertex in polygon)
        {
            vertex.Length().ShouldBeApproximately(radius, 0.1f);
        }
    }
```

**Returns:** `void`

### ConvertCapsuleToPolygon_StandardCapsule_Integration_ReturnsCorrectVertices

```csharp
[Test]
    public void ConvertCapsuleToPolygon_StandardCapsule_Integration_ReturnsCorrectVertices()
    {
        // Arrange
        const float radius = 8f;
        const float height = 16f;
        var transform = Transform2D.Identity;

        // Act
        var polygon = GeometryMath.ConvertCapsuleToPolygon(radius, height, transform);

        // Assert
        polygon.ShouldNotBeNull();
        polygon.Length.ShouldBe(24); // Default capsule vertices
        
        // Verify polygon bounds are reasonable
        var bounds = GeometryMath.GetPolygonBounds(polygon);
        bounds.Size.X.ShouldBeGreaterThan(radius * 2);
        bounds.Size.Y.ShouldBeGreaterThan(height);
    }
```

**Returns:** `void`

### DoesRectangleOverlapTileOptimized_OverlappingRectangle_Integration_ReturnsTrue

```csharp
#endregion

    #region Optimized Shape Overlap Integration Tests

    [Test]
    public void DoesRectangleOverlapTileOptimized_OverlappingRectangle_Integration_ReturnsTrue()
    {
        // Arrange
        var shapeSize = new Vector2(8, 8);
        var shapeTransform = new Transform2D(0, new Vector2(8, 8));
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const TileShape tileShape = TileShape.Square;
        const float epsilon = 0.01f;

        // Act
        var overlaps = GeometryMath.DoesRectangleOverlapTileOptimized(
            shapeSize, shapeTransform, tilePos, tileSize, tileShape, epsilon);

        // Assert
        overlaps.ShouldBeTrue();
    }
```

**Returns:** `void`

### DoesCircleOverlapTileOptimized_OverlappingCircle_Integration_ReturnsTrue

```csharp
[Test]
    public void DoesCircleOverlapTileOptimized_OverlappingCircle_Integration_ReturnsTrue()
    {
        // Arrange
        const float radius = 6f;
        var shapeTransform = new Transform2D(0, new Vector2(8, 8));
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const TileShape tileShape = TileShape.Square;
        const float epsilon = 0.01f;

        // Act
        var overlaps = GeometryMath.DoesCircleOverlapTileOptimized(
            radius, shapeTransform, tilePos, tileSize, tileShape, epsilon);

        // Assert
        overlaps.ShouldBeTrue();
    }
```

**Returns:** `void`

### DoesRectangleOverlapTileOptimized_NonOverlappingRectangle_Integration_ReturnsFalse

```csharp
[Test]
    public void DoesRectangleOverlapTileOptimized_NonOverlappingRectangle_Integration_ReturnsFalse()
    {
        // Arrange
        var shapeSize = new Vector2(4, 4);
        var shapeTransform = new Transform2D(0, new Vector2(20, 20));
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const TileShape tileShape = TileShape.Square;
        const float epsilon = 0.01f;

        // Act
        var overlaps = GeometryMath.DoesRectangleOverlapTileOptimized(
            shapeSize, shapeTransform, tilePos, tileSize, tileShape, epsilon);

        // Assert
        overlaps.ShouldBeFalse();
    }
```

**Returns:** `void`

### ComplexPolygonTileMapping_StarShape_Integration_ReturnsCorrectOffsets

```csharp
#endregion

    #region Complex Scenario Integration Tests

    [Test]
    public void ComplexPolygonTileMapping_StarShape_Integration_ReturnsCorrectOffsets()
    {
        // Arrange
        var starPolygon = new Vector2[]
        {
            new(8, 0), new(10, 6), new(16, 6), new(11, 10),
            new(13, 16), new(8, 12), new(3, 16), new(5, 10),
            new(0, 6), new(6, 6)
        };
        var tileSize = DEFAULT_TILE_SIZE;
        var centerTile = new Vector2I(0, 0);
        const TileShape tileShape = TileShape.Square;

        // Act
        var overlaps = new List<Vector2I>();
        for (int x = -2; x <= 2; x++)
        {
            for (int y = -2; y <= 2; y++)
            {
                var tilePos = new Vector2(x * tileSize.X, y * tileSize.Y);
                if (GeometryMath.DoesPolygonOverlapTile(starPolygon, tilePos, tileSize, tileShape, 1.0f))
                {
                    overlaps.Add(new Vector2I(x, y));
                }
            }
        }

        // Assert
        overlaps.Count.ShouldBeGreaterThan(0);
        overlaps.ShouldContain(Vector2I.Zero); // Should include center tile
    }
```

**Returns:** `void`

### RotatedShapeTileMapping_RotatedRectangle_Integration_ReturnsCorrectCoverage

```csharp
[Test]
    public void RotatedShapeTileMapping_RotatedRectangle_Integration_ReturnsCorrectCoverage()
    {
        // Arrange
        var rotatedRect = new Vector2[]
        {
            new(-11.3, -11.3), new(11.3, -11.3), new(11.3, 11.3), new(-11.3, 11.3)
        };
        var tileSize = DEFAULT_TILE_SIZE;
        var centerTile = new Vector2I(0, 0);
        const TileShape tileShape = TileShape.Square;

        // Act
        var overlaps = new List<Vector2I>();
        for (int x = -2; x <= 2; x++)
        {
            for (int y = -2; y <= 2; y++)
            {
                var tilePos = new Vector2(x * tileSize.X, y * tileSize.Y);
                if (GeometryMath.DoesPolygonOverlapTile(rotatedRect, tilePos, tileSize, tileShape, 1.0f))
                {
                    overlaps.Add(new Vector2I(x, y));
                }
            }
        }

        // Assert
        overlaps.Count.ShouldBeGreaterThan(4); // Rotated rectangle should cover more tiles
        overlaps.ShouldContain(Vector2I.Zero);
    }
```

**Returns:** `void`

### MultipleTileShapeComparison_SamePolygonDifferentTiles_Integration_ReturnsDifferentResults

```csharp
[Test]
    public void MultipleTileShapeComparison_SamePolygonDifferentTiles_Integration_ReturnsDifferentResults()
    {
        // Arrange
        var testPolygon = new Vector2[]
        {
            new(4, 4), new(12, 4), new(12, 12), new(4, 12)
        };
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const float epsilon = 1.0f;

        // Act
        var squareOverlap = GeometryMath.DoesPolygonOverlapTile(
            testPolygon, tilePos, tileSize, TileShape.Square, epsilon);
        var isometricOverlap = GeometryMath.DoesPolygonOverlapTile(
            testPolygon, tilePos, tileSize, TileShape.Isometric, epsilon);
        var halfOffsetOverlap = GeometryMath.DoesPolygonOverlapTile(
            testPolygon, tilePos, tileSize, TileShape.HalfOffsetSquare, epsilon);

        // Assert
        squareOverlap.ShouldBeTrue();
        isometricOverlap.ShouldBeTrue();
        halfOffsetOverlap.ShouldBeTrue();
        
        // Intersection areas should differ
        var squareArea = GeometryMath.IntersectionAreaWithTile(
            testPolygon, tilePos, tileSize, TileShape.Square);
        var isometricArea = GeometryMath.IntersectionAreaWithTile(
            testPolygon, tilePos, tileSize, TileShape.Isometric);
        var halfOffsetArea = GeometryMath.IntersectionAreaWithTile(
            testPolygon, tilePos, tileSize, TileShape.HalfOffsetSquare);
        
        squareArea.ShouldBeGreaterThan(0);
        isometricArea.ShouldBeGreaterThan(0);
        halfOffsetArea.ShouldBeGreaterThan(0);
        
        // Areas should be different for different tile shapes
        Math.Abs(squareArea - isometricArea).ShouldBeGreaterThan(1.0f);
    }
```

**Returns:** `void`

### LargePolygonTileMapping_PerformanceTest_Integration_CompletesQuickly

```csharp
#endregion

    #region Performance and Edge Case Integration Tests

    [Test]
    public void LargePolygonTileMapping_PerformanceTest_Integration_CompletesQuickly()
    {
        // Arrange
        var largePolygon = new Vector2[50]; // 50-vertex polygon
        for (int i = 0; i < 50; i++)
        {
            var angle = (float)(2 * Math.PI * i / 50);
            largePolygon[i] = new Vector2(
                50 * Mathf.Cos(angle),
                50 * Mathf.Sin(angle)
            );
        }
        var tileSize = DEFAULT_TILE_SIZE;
        var centerTile = new Vector2I(0, 0);
        const TileShape tileShape = TileShape.Square;

        // Act
        var startTime = Time.GetUnixTimeFromSystem();
        var overlaps = new List<Vector2I>();
        for (int x = -4; x <= 4; x++)
        {
            for (int y = -4; y <= 4; y++)
            {
                var tilePos = new Vector2(x * tileSize.X, y * tileSize.Y);
                if (GeometryMath.DoesPolygonOverlapTile(largePolygon, tilePos, tileSize, tileShape, 1.0f))
                {
                    overlaps.Add(new Vector2I(x, y));
                }
            }
        }
        var endTime = Time.GetUnixTimeFromSystem();

        // Assert
        overlaps.Count.ShouldBeGreaterThan(0);
        var duration = endTime - startTime;
        duration.ShouldBeLessThan(0.1); // Should complete in less than 100ms
    }
```

**Returns:** `void`

### EdgeCasePolygon_DegenerateCases_Integration_HandlesGracefully

```csharp
[Test]
    public void EdgeCasePolygon_DegenerateCases_Integration_HandlesGracefully()
    {
        // Arrange
        var emptyPolygon = Array.Empty<Vector2>();
        var singlePointPolygon = new Vector2[] { new(8, 8) };
        var linePolygon = new Vector2[] { new(0, 0), new(16, 0) };
        var tileSize = DEFAULT_TILE_SIZE;
        var tilePos = new Vector2(0, 0);
        const TileShape tileShape = TileShape.Square;
        const float epsilon = 1.0f;

        // Act & Assert
        GeometryMath.DoesPolygonOverlapTile(emptyPolygon, tilePos, tileSize, tileShape, epsilon)
            .ShouldBeFalse();
        GeometryMath.DoesPolygonOverlapTile(singlePointPolygon, tilePos, tileSize, tileShape, epsilon)
            .ShouldBeFalse();
        GeometryMath.DoesPolygonOverlapTile(linePolygon, tilePos, tileSize, tileShape, epsilon)
            .ShouldBeFalse();
    }
```

**Returns:** `void`

### PrecisionEdgeCase_VerySmallOverlap_Integration_HandlesCorrectly

```csharp
[Test]
    public void PrecisionEdgeCase_VerySmallOverlap_Integration_HandlesCorrectly()
    {
        // Arrange
        var tinyPolygon = new Vector2[]
        {
            new(15.9f, 15.9f), new(16.1f, 15.9f), new(16.1f, 16.1f), new(15.9f, 16.1f)
        };
        var tilePos = new Vector2(0, 0);
        var tileSize = DEFAULT_TILE_SIZE;
        const TileShape tileShape = TileShape.Square;

        // Act
        var area = GeometryMath.IntersectionAreaWithTile(tinyPolygon, tilePos, tileSize, tileShape);

        // Assert
        area.ShouldBeGreaterThanOrEqualTo(0.0f);
        area.ShouldBeLessThan(1.0f); // Very small area
    }
```

**Returns:** `void`

