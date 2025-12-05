---
title: "CollisionIntegrationTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionintegrationtest/"
---

# CollisionIntegrationTest

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class CollisionIntegrationTest
{
    // Members...
}
```

Integration tests for collision processing pipeline.
Tests complete collision workflows including shape conversion,
tile mapping, and multi-system interactions.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/CollisionIntegrationTest.cs`  
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
        
        // Create test positioner
        _testPositioner = new Node2D();
        _testPositioner.Name = "TestPositioner";
        _testPositioner.GlobalPosition = DEFAULT_POSITION;
        TestScene.AddChild(_testPositioner);
        
        // Create test collision shape
        _testCollisionShape = new CollisionShape2D();
        _testCollisionShape.Name = "TestCollisionShape";
        _testCollisionShape.Shape = new RectangleShape2D { Size = new Vector2(32, 32) };
        _testPositioner.AddChild(_testCollisionShape);
        
        // Create test collision polygon
        _testCollisionPolygon = new CollisionPolygon2D();
        _testCollisionPolygon.Name = "TestCollisionPolygon";
        _testCollisionPolygon.Polygon = new Vector2[]
        {
            new(-16, -16), new(16, -16), new(16, 16), new(-16, 16)
        };
        _testPositioner.AddChild(_testCollisionPolygon);
    }
```

**Returns:** `void`

### Cleanup

```csharp
[TearDown]
    public void Cleanup()
    {
        _testCollisionPolygon?.QueueFree();
        _testCollisionShape?.QueueFree();
        _testPositioner?.QueueFree();
        _testTileMap?.QueueFree();
    }
```

**Returns:** `void`

### GetRectTilePositions_Integration_ReturnsCorrectTiles

```csharp
#endregion

    #region Collision Utilities Integration Tests

    [Test]
    public void GetRectTilePositions_Integration_ReturnsCorrectTiles()
    {
        // Arrange
        var globalCenterPosition = new Vector2(100, 100);
        var transformedRectSize = new Vector2(32, 32);

        // Act
        var tilePositions = CollisionUtilities.GetRectTilePositions(
            _testTileMap, globalCenterPosition, transformedRectSize);

        // Assert
        tilePositions.ShouldNotBeNull();
        tilePositions.Count.ShouldBeGreaterThanOrEqualTo(4); // 32x32 rectangle should cover at least 4 tiles
        
        // Verify tiles are within reasonable bounds
        foreach (var tilePos in tilePositions)
        {
            tilePos.X.ShouldBeGreaterThanOrEqualTo(0);
            tilePos.Y.ShouldBeGreaterThanOrEqualTo(0);
        }
    }
```

**Returns:** `void`

### DoesIndicatorOverlapShape_Integration_ReturnsCorrectResult

```csharp
[Test]
    public void DoesIndicatorOverlapShape_Integration_ReturnsCorrectResult()
    {
        // Arrange
        var tileIndicator = new Area2D();
        tileIndicator.Name = "TestIndicator";
        var indicatorShape = new CollisionShape2D();
        indicatorShape.Shape = new RectangleShape2D { Size = new Vector2(16, 16) };
        tileIndicator.AddChild(indicatorShape);
        TestScene.AddChild(tileIndicator);

        // Act
        var overlaps = CollisionUtilities.DoesIndicatorOverlapShape(
            tileIndicator, _testCollisionShape!.Shape, _testPositioner);

        // Assert
        overlaps.ShouldBeTrue(); // Overlapping shapes should return true

        // Cleanup
        tileIndicator.QueueFree();
    }
```

**Returns:** `void`

### BuildShapeTransform_Integration_ReturnsCorrectTransform

```csharp
[Test]
    public void BuildShapeTransform_Integration_ReturnsCorrectTransform()
    {
        // Arrange
        var colObj = new Node2D();
        colObj.GlobalPosition = new Vector2(200, 200);
        colObj.Rotation = DEFAULT_ROTATION;
        colObj.Scale = new Vector2(2, 1.5f);
        TestScene.AddChild(colObj);

        var shapeOwner = new Node2D();
        shapeOwner.Position = new Vector2(16, 16);
        colObj.AddChild(shapeOwner);

        // Act
        var transform = CollisionUtilities.BuildShapeTransform(
            colObj.GlobalPosition, colObj.Rotation, colObj.Scale, shapeOwner.Position);

        // Assert
        transform.ShouldNotBeNull();
        
        // Verify transform components
        var expectedOrigin = colObj.GlobalPosition + shapeOwner.Position;
        transform.Origin.ShouldBeApproximately(expectedOrigin, 0.01f);

        // Cleanup
        colObj.QueueFree();
    }
```

**Returns:** `void`

### ToWorldPolygon_Integration_ReturnsCorrectWorldPoints

```csharp
#endregion

    #region Shape Conversion Integration Tests

    [Test]
    public void ToWorldPolygon_Integration_ReturnsCorrectWorldPoints()
    {
        // Arrange
        var expectedLocalPoints = new Vector2[]
        {
            new(-16, -16), new(16, -16), new(16, 16), new(-16, 16)
        };

        // Act
        var worldPoints = CollisionUtilities.ToWorldPolygon(_testCollisionPolygon!);

        // Assert
        worldPoints.ShouldNotBeNull();
        worldPoints.Length.ShouldBe(expectedLocalPoints.Length);
        
        // Verify points are transformed to world space
        for (int i = 0; i < worldPoints.Length; i++)
        {
            var expectedWorldPoint = _testPositioner!.GlobalPosition + expectedLocalPoints[i];
            worldPoints[i].ShouldBeApproximately(expectedWorldPoint, 0.01f);
        }
    }
```

**Returns:** `void`

### ConvertShapeToPolygon_RectangleShape_Integration_ReturnsCorrectPolygon

```csharp
[Test]
    public void ConvertShapeToPolygon_RectangleShape_Integration_ReturnsCorrectPolygon()
    {
        // Arrange
        var rectShape = new RectangleShape2D { Size = new Vector2(32, 24) };
        var transform = new Transform2D(DEFAULT_ROTATION, DEFAULT_POSITION);

        // Act
        var polygon = CollisionUtilities.ConvertShapeToPolygon(rectShape, transform);

        // Assert
        polygon.ShouldNotBeNull();
        polygon.Length.ShouldBe(4); // Rectangle should have 4 vertices
        
        // Verify polygon bounds are reasonable
        var bounds = CollisionGeometryUtils.GetPolygonBounds(polygon);
        bounds.Size.X.ShouldBeGreaterThan(0);
        bounds.Size.Y.ShouldBeGreaterThan(0);
    }
```

**Returns:** `void`

### ConvertShapeToPolygon_CircleShape_Integration_ReturnsCorrectPolygon

```csharp
[Test]
    public void ConvertShapeToPolygon_CircleShape_Integration_ReturnsCorrectPolygon()
    {
        // Arrange
        var circleShape = new CircleShape2D { Radius = 12f };
        var transform = new Transform2D(0, DEFAULT_POSITION);

        // Act
        var polygon = CollisionUtilities.ConvertShapeToPolygon(circleShape, transform);

        // Assert
        polygon.ShouldNotBeNull();
        polygon.Length.ShouldBe(16); // Circle should have 16 vertices
        
        // Verify all vertices are at correct distance from center
        foreach (var vertex in polygon)
        {
            var distanceFromCenter = (vertex - DEFAULT_POSITION).Length();
            distanceFromCenter.ShouldBeApproximately(circleShape.Radius, 0.1f);
        }
    }
```

**Returns:** `void`

### ComputePolygonTileOffsets_SquarePolygon_Integration_ReturnsCorrectOffsets

```csharp
#endregion

    #region Polygon Tile Offset Integration Tests

    [Test]
    public void ComputePolygonTileOffsets_SquarePolygon_Integration_ReturnsCorrectOffsets()
    {
        // Arrange
        var worldPoints = new Vector2[]
        {
            new(84, 84), new(116, 84), new(116, 116), new(84, 116) // 32x32 square centered at (100,100)
        };
        var tileSize = DEFAULT_TILE_SIZE;
        var centerTile = new Vector2I(6, 6); // 100/16 = 6.25 -> floor to 6
        var tileShape = TileSet.TileShapeEnum.Square;

        // Act
        var offsets = CollisionUtilities.ComputePolygonTileOffsets(
            worldPoints, tileSize, centerTile, tileShape);

        // Assert
        offsets.ShouldNotBeNull();
        offsets.Count.ShouldBeGreaterThanOrEqualTo(4); // Should cover at least 4 tiles
        
        // Verify offsets are reasonable
        foreach (var offset in offsets)
        {
            Math.Abs(offset.X).ShouldBeLessThanOrEqualTo(2);
            Math.Abs(offset.Y).ShouldBeLessThanOrEqualTo(2);
        }
    }
```

**Returns:** `void`

### ComputePolygonTileOffsets_ComplexPolygon_Integration_ReturnsCorrectOffsets

```csharp
[Test]
    public void ComputePolygonTileOffsets_ComplexPolygon_Integration_ReturnsCorrectOffsets()
    {
        // Arrange
        var worldPoints = new Vector2[]
        {
            new(68, 84), new(132, 84), new(132, 116), new(100, 132), new(68, 116) // Trapezoid
        };
        var tileSize = DEFAULT_TILE_SIZE;
        var centerTile = new Vector2I(6, 6);
        var tileShape = TileSet.TileShapeEnum.Square;

        // Act
        var offsets = CollisionUtilities.ComputePolygonTileOffsets(
            worldPoints, tileSize, centerTile, tileShape);

        // Assert
        offsets.ShouldNotBeNull();
        offsets.Count.ShouldBeGreaterThanOrEqualTo(4); // Trapezoid should cover multiple tiles
        
        // Verify offsets are reasonable
        foreach (var offset in offsets)
        {
            Math.Abs(offset.X).ShouldBeLessThanOrEqualTo(3);
            Math.Abs(offset.Y).ShouldBeLessThanOrEqualTo(3);
        }
    }
```

**Returns:** `void`

### ComputePolygonTileOffsets_IsometricTiles_Integration_ReturnsCorrectOffsets

```csharp
[Test]
    public void ComputePolygonTileOffsets_IsometricTiles_Integration_ReturnsCorrectOffsets()
    {
        // Arrange
        var worldPoints = new Vector2[]
        {
            new(84, 84), new(116, 84), new(116, 116), new(84, 116)
        };
        var tileSize = DEFAULT_TILE_SIZE;
        var centerTile = new Vector2I(6, 6);
        var tileShape = TileSet.TileShapeEnum.Isometric;

        // Act
        var offsets = CollisionUtilities.ComputePolygonTileOffsets(
            worldPoints, tileSize, centerTile, tileShape);

        // Assert
        offsets.ShouldNotBeNull();
        offsets.Count.ShouldBeGreaterThanOrEqualTo(1); // Should cover at least 1 tile
        
        // Verify offsets are reasonable
        foreach (var offset in offsets)
        {
            Math.Abs(offset.X).ShouldBeLessThanOrEqualTo(3);
            Math.Abs(offset.Y).ShouldBeLessThanOrEqualTo(3);
        }
    }
```

**Returns:** `void`

### CalculateTileRange_RectangleShape_Integration_ReturnsCorrectRange

```csharp
#endregion

    #region Geometry Utils Integration Tests

    [Test]
    public void CalculateTileRange_RectangleShape_Integration_ReturnsCorrectRange()
    {
        // Arrange
        var size = new Vector2(32, 32);
        var transform = new Transform2D(0, DEFAULT_POSITION);
        var tileSize = DEFAULT_TILE_SIZE;

        // Act
        var tileRange = CollisionGeometryUtils.CalculateTileRange(size, transform, tileSize);

        // Assert
        tileRange.ShouldNotBeNull();
        
        // Verify range covers expected tiles
        var width = tileRange.MaxTile.X - tileRange.MinTile.X + 1;
        var height = tileRange.MaxTile.Y - tileRange.MinTile.Y + 1;
        
        width.ShouldBeGreaterThanOrEqualTo(2);
        height.ShouldBeGreaterThanOrEqualTo(2);
    }
```

**Returns:** `void`

### CalculateTileRange_RotatedRectangle_Integration_ReturnsExpandedRange

```csharp
[Test]
    public void CalculateTileRange_RotatedRectangle_Integration_ReturnsExpandedRange()
    {
        // Arrange
        var size = new Vector2(32, 32);
        var transform = new Transform2D(DEFAULT_ROTATION, DEFAULT_POSITION);
        var tileSize = DEFAULT_TILE_SIZE;

        // Act
        var rotatedRange = CollisionGeometryUtils.CalculateTileRange(size, transform, tileSize);
        var axisAlignedRange = CollisionGeometryUtils.CalculateTileRange(
            size, new Transform2D(0, DEFAULT_POSITION), tileSize);

        // Assert
        rotatedRange.ShouldNotBeNull();
        axisAlignedRange.ShouldNotBeNull();
        
        // Rotated rectangle should cover more tiles
        var rotatedWidth = rotatedRange.MaxTile.X - rotatedRange.MinTile.X + 1;
        var axisAlignedWidth = axisAlignedRange.MaxTile.X - axisAlignedRange.MinTile.X + 1;
        
        rotatedWidth.ShouldBeGreaterThanOrEqualTo(axisAlignedWidth);
    }
```

**Returns:** `void`

### IsPolygonConvex_SquarePolygon_Integration_ReturnsTrue

```csharp
[Test]
    public void IsPolygonConvex_SquarePolygon_Integration_ReturnsTrue()
    {
        // Arrange
        var square = new Vector2[]
        {
            new(-8, -8), new(8, -8), new(8, 8), new(-8, 8)
        };

        // Act
        var isConvex = CollisionGeometryUtils.IsPolygonConvex(square);

        // Assert
        isConvex.ShouldBeTrue();
    }
```

**Returns:** `void`

### IsPolygonConvex_ConcavePolygon_Integration_ReturnsFalse

```csharp
[Test]
    public void IsPolygonConvex_ConcavePolygon_Integration_ReturnsFalse()
    {
        // Arrange
        var lShape = new Vector2[]
        {
            new(-12, -12), new(4, -12), new(4, -4), new(12, -4),
            new(12, 12), new(-12, 12)
        };

        // Act
        var isConvex = CollisionGeometryUtils.IsPolygonConvex(lShape);

        // Assert
        isConvex.ShouldBeFalse();
    }
```

**Returns:** `void`

### ValidateCollisionObject_ValidCollisionShape_Integration_ReturnsEmptyList

```csharp
#endregion

    #region Collision Object Resolver Integration Tests

    [Test]
    public void ValidateCollisionObject_ValidCollisionShape_Integration_ReturnsEmptyList()
    {
        // Arrange
        var validShape = new CollisionShape2D();
        validShape.Shape = new RectangleShape2D { Size = new Vector2(32, 32) };
        _testPositioner!.AddChild(validShape);

        // Act
        var issues = CollisionObjectResolver.ValidateCollisionObject(validShape);

        // Assert
        issues.ShouldNotBeNull();
        issues.Count.ShouldBe(0);

        // Cleanup
        validShape.QueueFree();
    }
```

**Returns:** `void`

### ValidateCollisionObject_InvalidCollisionShape_Integration_ReturnsIssues

```csharp
[Test]
    public void ValidateCollisionObject_InvalidCollisionShape_Integration_ReturnsIssues()
    {
        // Arrange
        var invalidShape = new CollisionShape2D();
        // No shape set - should be invalid
        _testPositioner!.AddChild(invalidShape);

        // Act
        var issues = CollisionObjectResolver.ValidateCollisionObject(invalidShape);

        // Assert
        issues.ShouldNotBeNull();
        issues.Count.ShouldBeGreaterThan(0);

        // Cleanup
        invalidShape.QueueFree();
    }
```

**Returns:** `void`

### GetEffectiveCollisionShape_CollisionShape_Integration_ReturnsCorrectShape

```csharp
[Test]
    public void GetEffectiveCollisionShape_CollisionShape_Integration_ReturnsCorrectShape()
    {
        // Arrange
        var expectedShape = new RectangleShape2D { Size = new Vector2(32, 32) };
        _testCollisionShape!.Shape = expectedShape;

        // Act
        var effectiveShape = CollisionObjectResolver.GetEffectiveCollisionShape(_testCollisionShape);

        // Assert
        effectiveShape.ShouldNotBeNull();
        effectiveShape.ShapeType.ShouldBe(EffectiveCollisionShapeType.Rectangle);
        effectiveShape.RectangleSize.ShouldBe(expectedShape.Size);
    }
```

**Returns:** `void`

### GetEffectiveCollisionShape_CollisionPolygon_Integration_ReturnsCorrectShape

```csharp
[Test]
    public void GetEffectiveCollisionShape_CollisionPolygon_Integration_ReturnsCorrectShape()
    {
        // Arrange
        var expectedPolygon = new Vector2[]
        {
            new(-16, -16), new(16, -16), new(16, 16), new(-16, 16)
        };
        _testCollisionPolygon!.Polygon = expectedPolygon;

        // Act
        var effectiveShape = CollisionObjectResolver.GetEffectiveCollisionShape(_testCollisionPolygon);

        // Assert
        effectiveShape.ShouldNotBeNull();
        effectiveShape.ShapeType.ShouldBe(EffectiveCollisionShapeType.Polygon);
        effectiveShape.Polygon.Length.ShouldBe(expectedPolygon.Length);
    }
```

**Returns:** `void`

### GetPolygonArea_SquarePolygon_Integration_ReturnsCorrectArea

```csharp
#endregion

    #region Advanced Geometry Integration Tests

    [Test]
    public void GetPolygonArea_SquarePolygon_Integration_ReturnsCorrectArea()
    {
        // Arrange
        var square = new Vector2[]
        {
            new(0, 0), new(10, 0), new(10, 10), new(0, 10)
        };

        // Act
        var area = CollisionGeometryUtils.GetPolygonArea(square);

        // Assert
        area.ShouldBe(100.0f);
    }
```

**Returns:** `void`

### GetPolygonCentroid_SquarePolygon_Integration_ReturnsCorrectCentroid

```csharp
[Test]
    public void GetPolygonCentroid_SquarePolygon_Integration_ReturnsCorrectCentroid()
    {
        // Arrange
        var square = new Vector2[]
        {
            new(0, 0), new(10, 0), new(10, 10), new(0, 10)
        };

        // Act
        var centroid = CollisionGeometryUtils.GetPolygonCentroid(square);

        // Assert
        centroid.ShouldBe(new Vector2(5, 5));
    }
```

**Returns:** `void`

### ExpandPolygon_SquarePolygon_Integration_ReturnsExpandedPolygon

```csharp
[Test]
    public void ExpandPolygon_SquarePolygon_Integration_ReturnsExpandedPolygon()
    {
        // Arrange
        var square = new Vector2[]
        {
            new(0, 0), new(10, 0), new(10, 10), new(0, 10)
        };
        const float expansion = 2.0f;

        // Act
        var expandedPolygon = CollisionGeometryUtils.ExpandPolygon(square, expansion);

        // Assert
        expandedPolygon.ShouldNotBeNull();
        expandedPolygon.Length.ShouldBe(square.Length);
        
        // Verify expanded polygon is larger
        var originalBounds = CollisionGeometryUtils.GetPolygonBounds(square);
        var expandedBounds = CollisionGeometryUtils.GetPolygonBounds(expandedPolygon);
        
        expandedBounds.Size.X.ShouldBeGreaterThan(originalBounds.Size.X);
        expandedBounds.Size.Y.ShouldBeGreaterThan(originalBounds.Size.Y);
    }
```

**Returns:** `void`

### SimplifyPolygon_CollinearPoints_Integration_RemovesCollinearPoints

```csharp
[Test]
    public void SimplifyPolygon_CollinearPoints_Integration_RemovesCollinearPoints()
    {
        // Arrange
        var polygonWithCollinear = new Vector2[]
        {
            new(0, 0), new(5, 0), new(10, 0), new(10, 10), new(0, 10)
        };

        // Act
        var simplifiedPolygon = CollisionGeometryUtils.SimplifyPolygon(polygonWithCollinear);

        // Assert
        simplifiedPolygon.ShouldNotBeNull();
        simplifiedPolygon.Length.ShouldBeLessThan(polygonWithCollinear.Length);
        simplifiedPolygon.Length.ShouldBe(4); // Should remove the collinear point
    }
```

**Returns:** `void`

### ComputePolygonTileOffsets_LargePolygon_Integration_PerformsWell

```csharp
#endregion

    #region Performance and Stress Tests

    [Test]
    public void ComputePolygonTileOffsets_LargePolygon_Integration_PerformsWell()
    {
        // Arrange
        var largePolygon = new Vector2[100]; // 100-vertex polygon
        for (int i = 0; i < 100; i++)
        {
            var angle = (float)(2 * Math.PI * i / 100);
            largePolygon[i] = new Vector2(
                100 * Mathf.Cos(angle) + DEFAULT_POSITION.X,
                100 * Mathf.Sin(angle) + DEFAULT_POSITION.Y
            );
        }
        var tileSize = DEFAULT_TILE_SIZE;
        var centerTile = new Vector2I(6, 6);
        var tileShape = TileSet.TileShapeEnum.Square;

        // Act
        var startTime = Time.GetUnixTimeFromSystem();
        var offsets = CollisionUtilities.ComputePolygonTileOffsets(
            largePolygon, tileSize, centerTile, tileShape);
        var endTime = Time.GetUnixTimeFromSystem();

        // Assert
        offsets.ShouldNotBeNull();
        offsets.Count.ShouldBeGreaterThan(0);
        
        // Performance check - should complete quickly
        var duration = endTime - startTime;
        duration.ShouldBeLessThan(0.1); // Should complete in less than 100ms
    }
```

**Returns:** `void`

### ConvertShapeToPolygon_ComplexShape_Integration_PerformsWell

```csharp
[Test]
    public void ConvertShapeToPolygon_ComplexShape_Integration_PerformsWell()
    {
        // Arrange
        var complexShape = new CapsuleShape2D { Radius = 50f, Height = 100f };
        var transform = new Transform2D(DEFAULT_ROTATION, DEFAULT_POSITION);

        // Act
        var startTime = Time.GetUnixTimeFromSystem();
        var polygon = CollisionUtilities.ConvertShapeToPolygon(complexShape, transform);
        var endTime = Time.GetUnixTimeFromSystem();

        // Assert
        polygon.ShouldNotBeNull();
        polygon.Length.ShouldBeGreaterThan(0);
        
        // Performance check - should complete quickly
        var duration = endTime - startTime;
        duration.ShouldBeLessThan(0.05); // Should complete in less than 50ms
    }
```

**Returns:** `void`

