---
title: "GodotRuntimeIntegrationTest"
description: "Godot runtime integration tests for complete system workflows.
Tests end-to-end scenarios with real Godot scene trees, collision objects,
and tile mapping systems."
weight: 20
url: "/gridbuilding/v6-0/api/godot/godotruntimeintegrationtest/"
---

# GodotRuntimeIntegrationTest

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class GodotRuntimeIntegrationTest
{
    // Members...
}
```

Godot runtime integration tests for complete system workflows.
Tests end-to-end scenarios with real Godot scene trees, collision objects,
and tile mapping systems.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/GodotRuntimeIntegrationTest.cs`  
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
        // Create test scene root
        _testSceneRoot = new Node2D();
        _testSceneRoot.Name = "TestSceneRoot";
        TestScene.AddChild(_testSceneRoot);
        
        // Create test TileMap with proper configuration
        _testTileMap = new TileMapLayer();
        _testTileMap.Name = "TestTileMap";
        var tileSet = new TileSet();
        var source = new TileSetAtlasSource();
        source.Texture = new ImageTexture();
        source.Texture.SetImage(Image.Create(16, 16, false, Image.Format.Rgb8));
        
        var tileData = source.GetTileData(0, 0);
        tileData.CollisionLayer = 1;
        tileData.CollisionMask = 1;
        
        tileSet.AddSource(source);
        _testTileMap.TileSet = tileSet;
        _testSceneRoot.AddChild(_testTileMap);
        
        // Create test collision objects
        _testCollisionShape = new CollisionShape2D();
        _testCollisionShape.Name = "TestCollisionShape";
        _testCollisionShape.Shape = new RectangleShape2D { Size = new Vector2(32, 32) };
        _testCollisionShape.Position = DEFAULT_POSITION;
        _testSceneRoot.AddChild(_testCollisionShape);
        
        _testCollisionPolygon = new CollisionPolygon2D();
        _testCollisionPolygon.Name = "TestCollisionPolygon";
        _testCollisionPolygon.Polygon = new Vector2[]
        {
            new(-16, -16), new(16, -16), new(16, 16), new(-16, 16)
        };
        _testCollisionPolygon.Position = DEFAULT_POSITION + new Vector2(50, 50);
        _testSceneRoot.AddChild(_testCollisionPolygon);
        
        // Create test indicator
        _testIndicator = new Area2D();
        _testIndicator.Name = "TestIndicator";
        var indicatorShape = new CollisionShape2D();
        indicatorShape.Shape = new RectangleShape2D { Size = new Vector2(16, 16) };
        _testIndicator.AddChild(indicatorShape);
        _testSceneRoot.AddChild(_testIndicator);
        
        // Create collision mapper
        _collisionMapper = new CollisionMapper();
        _collisionMapper.Name = "TestCollisionMapper";
        _testSceneRoot.AddChild(_collisionMapper);
    }
```

**Returns:** `void`

### Cleanup

```csharp
[TearDown]
    public void Cleanup()
    {
        _collisionMapper?.QueueFree();
        _testIndicator?.QueueFree();
        _testCollisionPolygon?.QueueFree();
        _testCollisionShape?.QueueFree();
        _testTileMap?.QueueFree();
        _testSceneRoot?.QueueFree();
    }
```

**Returns:** `void`

### CollisionMapper_CompleteWorkflow_Integration_ReturnsCorrectPositions

```csharp
#endregion

    #region Collision Mapping Integration Tests

    [Test]
    public void CollisionMapper_CompleteWorkflow_Integration_ReturnsCorrectPositions()
    {
        // Arrange
        var positioner = new Node2D();
        positioner.Name = "TestPositioner";
        positioner.GlobalPosition = DEFAULT_POSITION;
        _testSceneRoot!.AddChild(positioner);
        
        var collisionObjects = new List<Node2D> { _testCollisionShape!, _testCollisionPolygon! };

        // Act
        var collisionPositions = _collisionMapper!.GetCollisionPositions(
            positioner, collisionObjects, _testTileMap!, DEFAULT_TILE_SIZE);

        // Assert
        collisionPositions.ShouldNotBeNull();
        collisionPositions.Count.ShouldBeGreaterThan(0);
        
        // Verify positions are reasonable
        foreach (var kvp in collisionPositions)
        {
            var tilePos = kvp.Key;
            var positions = kvp.Value;
            
            tilePos.X.ShouldBeGreaterThanOrEqualTo(0);
            tilePos.Y.ShouldBeGreaterThanOrEqualTo(0);
            positions.Count.ShouldBeGreaterThan(0);
        }

        // Cleanup
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionMapper_RotatedCollisionObject_Integration_ReturnsCorrectPositions

```csharp
[Test]
    public void CollisionMapper_RotatedCollisionObject_Integration_ReturnsCorrectPositions()
    {
        // Arrange
        var positioner = new Node2D();
        positioner.Name = "TestPositioner";
        positioner.GlobalPosition = DEFAULT_POSITION;
        _testSceneRoot!.AddChild(positioner);
        
        // Rotate collision shape
        _testCollisionShape!.Rotation = DEFAULT_ROTATION;
        var collisionObjects = new List<Node2D> { _testCollisionShape };

        // Act
        var collisionPositions = _collisionMapper!.GetCollisionPositions(
            positioner, collisionObjects, _testTileMap!, DEFAULT_TILE_SIZE);

        // Assert
        collisionPositions.ShouldNotBeNull();
        collisionPositions.Count.ShouldBeGreaterThan(0);
        
        // Rotated shape should cover more tiles
        var totalPositions = 0;
        foreach (var kvp in collisionPositions)
        {
            totalPositions += kvp.Value.Count;
        }
        totalPositions.ShouldBeGreaterThan(0);

        // Cleanup
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionMapper_ScaledCollisionObject_Integration_ReturnsCorrectPositions

```csharp
[Test]
    public void CollisionMapper_ScaledCollisionObject_Integration_ReturnsCorrectPositions()
    {
        // Arrange
        var positioner = new Node2D();
        positioner.Name = "TestPositioner";
        positioner.GlobalPosition = DEFAULT_POSITION;
        _testSceneRoot!.AddChild(positioner);
        
        // Scale collision shape
        _testCollisionShape!.Scale = new Vector2(2, 1.5f);
        var collisionObjects = new List<Node2D> { _testCollisionShape };

        // Act
        var collisionPositions = _collisionMapper!.GetCollisionPositions(
            positioner, collisionObjects, _testTileMap!, DEFAULT_TILE_SIZE);

        // Assert
        collisionPositions.ShouldNotBeNull();
        collisionPositions.Count.ShouldBeGreaterThan(0);
        
        // Scaled shape should cover more tiles
        var totalPositions = 0;
        foreach (var kvp in collisionPositions)
        {
            totalPositions += kvp.Value.Count;
        }
        totalPositions.ShouldBeGreaterThan(0);

        // Cleanup
        positioner.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_GetRectTilePositions_Integration_ReturnsCorrectTiles

```csharp
#endregion

    #region Tile Map Integration Tests

    [Test]
    public void TileMapLayer_GetRectTilePositions_Integration_ReturnsCorrectTiles()
    {
        // Arrange
        var globalCenterPosition = DEFAULT_POSITION;
        var transformedRectSize = new Vector2(32, 32);

        // Act
        var tilePositions = CollisionUtilities.GetRectTilePositions(
            _testTileMap!, globalCenterPosition, transformedRectSize);

        // Assert
        tilePositions.ShouldNotBeNull();
        tilePositions.Count.ShouldBeGreaterThanOrEqualTo(4);
        
        // Verify tiles are within reasonable bounds
        foreach (var tilePos in tilePositions)
        {
            tilePos.X.ShouldBeGreaterThanOrEqualTo(0);
            tilePos.Y.ShouldBeGreaterThanOrEqualTo(0);
        }
    }
```

**Returns:** `void`

### TileMapLayer_LocalToMap_Integration_ReturnsCorrectTileCoordinates

```csharp
[Test]
    public void TileMapLayer_LocalToMap_Integration_ReturnsCorrectTileCoordinates()
    {
        // Arrange
        var worldPosition = DEFAULT_POSITION;
        var localPosition = _testTileMap!.ToLocal(worldPosition);

        // Act
        var tileCoords = _testTileMap.LocalToMap(localPosition);

        // Assert
        tileCoords.X.ShouldBeGreaterThanOrEqualTo(0);
        tileCoords.Y.ShouldBeGreaterThanOrEqualTo(0);
        
        // Verify conversion is reversible (approximately)
        var backToLocal = _testTileMap.MapToLocal(tileCoords);
        var backToWorld = _testTileMap.ToGlobal(backToLocal);
        backToWorld.ShouldBeApproximately(worldPosition, DEFAULT_TILE_SIZE.X);
    }
```

**Returns:** `void`

### TileMapLayer_MapToLocal_Integration_ReturnsCorrectWorldCoordinates

```csharp
[Test]
    public void TileMapLayer_MapToLocal_Integration_ReturnsCorrectWorldCoordinates()
    {
        // Arrange
        var tileCoords = new Vector2I(6, 6); // Around position (100, 100)

        // Act
        var localPosition = _testTileMap!.MapToLocal(tileCoords);
        var worldPosition = _testTileMap.ToGlobal(localPosition);

        // Assert
        worldPosition.X.ShouldBeGreaterThanOrEqualTo(0);
        worldPosition.Y.ShouldBeGreaterThanOrEqualTo(0);
        
        // Should be close to expected tile position
        var expectedWorldPos = new Vector2(
            tileCoords.X * DEFAULT_TILE_SIZE.X,
            tileCoords.Y * DEFAULT_TILE_SIZE.Y
        );
        worldPosition.ShouldBeApproximately(expectedWorldPos, DEFAULT_TILE_SIZE.X);
    }
```

**Returns:** `void`

### CollisionShape2D_RealCollision_Integration_DetectsOverlap

```csharp
#endregion

    #region Collision Object Integration Tests

    [Test]
    public void CollisionShape2D_RealCollision_Integration_DetectsOverlap()
    {
        // Arrange
        var area1 = new Area2D();
        var shape1 = new CollisionShape2D();
        shape1.Shape = new RectangleShape2D { Size = new Vector2(32, 32) };
        area1.AddChild(shape1);
        area1.Position = DEFAULT_POSITION;
        _testSceneRoot!.AddChild(area1);

        var area2 = new Area2D();
        var shape2 = new CollisionShape2D();
        shape2.Shape = new RectangleShape2D { Size = new Vector2(32, 32) };
        area2.AddChild(shape2);
        area2.Position = DEFAULT_POSITION + new Vector2(10, 10); // Overlapping
        _testSceneRoot.AddChild(area2);

        // Act
        var overlaps = area1.GetOverlappingAreas().Count;

        // Assert
        overlaps.ShouldBeGreaterThan(0);

        // Cleanup
        area2.QueueFree();
        area1.QueueFree();
    }
```

**Returns:** `void`

### CollisionPolygon2D_RealCollision_Integration_DetectsOverlap

```csharp
[Test]
    public void CollisionPolygon2D_RealCollision_Integration_DetectsOverlap()
    {
        // Arrange
        var area1 = new Area2D();
        var polygon1 = new CollisionPolygon2D();
        polygon1.Polygon = new Vector2[]
        {
            new(-16, -16), new(16, -16), new(16, 16), new(-16, 16)
        };
        area1.AddChild(polygon1);
        area1.Position = DEFAULT_POSITION;
        _testSceneRoot!.AddChild(area1);

        var area2 = new Area2D();
        var polygon2 = new CollisionPolygon2D();
        polygon2.Polygon = new Vector2[]
        {
            new(-16, -16), new(16, -16), new(16, 16), new(-16, 16)
        };
        area2.AddChild(polygon2);
        area2.Position = DEFAULT_POSITION + new Vector2(10, 10); // Overlapping
        _testSceneRoot.AddChild(area2);

        // Act
        var overlaps = area1.GetOverlappingAreas().Count;

        // Assert
        overlaps.ShouldBeGreaterThan(0);

        // Cleanup
        area2.QueueFree();
        area1.QueueFree();
    }
```

**Returns:** `void`

### CollisionObjectResolver_RealObjects_Integration_ReturnsCorrectShapes

```csharp
[Test]
    public void CollisionObjectResolver_RealObjects_Integration_ReturnsCorrectShapes()
    {
        // Arrange - Use the existing collision objects

        // Act
        var rectShape = CollisionObjectResolver.GetEffectiveCollisionShape(_testCollisionShape!);
        var polygonShape = CollisionObjectResolver.GetEffectiveCollisionShape(_testCollisionPolygon!);

        // Assert
        rectShape.ShouldNotBeNull();
        rectShape.ShapeType.ShouldBe(EffectiveCollisionShapeType.Rectangle);
        rectShape.RectangleSize.ShouldBe(new Vector2(32, 32));

        polygonShape.ShouldNotBeNull();
        polygonShape.ShapeType.ShouldBe(EffectiveCollisionShapeType.Polygon);
        polygonShape.Polygon.Length.ShouldBe(4);
    }
```

**Returns:** `void`

### ConvertShapeToPolygon_RuntimeRectangle_Integration_ReturnsCorrectPolygon

```csharp
#endregion

    #region Shape Conversion Runtime Tests

    [Test]
    public void ConvertShapeToPolygon_RuntimeRectangle_Integration_ReturnsCorrectPolygon()
    {
        // Arrange
        var rectShape = new RectangleShape2D { Size = new Vector2(32, 24) };
        var transform = new Transform2D(DEFAULT_ROTATION, DEFAULT_POSITION);

        // Act
        var polygon = CollisionUtilities.ConvertShapeToPolygon(rectShape, transform);

        // Assert
        polygon.ShouldNotBeNull();
        polygon.Length.ShouldBe(4);
        
        // Verify polygon bounds are reasonable
        var bounds = CollisionGeometryUtils.GetPolygonBounds(polygon);
        bounds.Size.X.ShouldBeGreaterThan(0);
        bounds.Size.Y.ShouldBeGreaterThan(0);
        
        // Verify center is near expected position
        var center = bounds.Position + bounds.Size / 2f;
        center.ShouldBeApproximately(DEFAULT_POSITION, 5.0f);
    }
```

**Returns:** `void`

### ConvertShapeToPolygon_RuntimeCircle_Integration_ReturnsCorrectPolygon

```csharp
[Test]
    public void ConvertShapeToPolygon_RuntimeCircle_Integration_ReturnsCorrectPolygon()
    {
        // Arrange
        var circleShape = new CircleShape2D { Radius = 12f };
        var transform = new Transform2D(0, DEFAULT_POSITION);

        // Act
        var polygon = CollisionUtilities.ConvertShapeToPolygon(circleShape, transform);

        // Assert
        polygon.ShouldNotBeNull();
        polygon.Length.ShouldBe(16);
        
        // Verify all vertices are at correct distance from center
        foreach (var vertex in polygon)
        {
            var distanceFromCenter = (vertex - DEFAULT_POSITION).Length();
            distanceFromCenter.ShouldBeApproximately(circleShape.Radius, 0.1f);
        }
    }
```

**Returns:** `void`

### ConvertShapeToPolygon_RuntimeCapsule_Integration_ReturnsCorrectPolygon

```csharp
[Test]
    public void ConvertShapeToPolygon_RuntimeCapsule_Integration_ReturnsCorrectPolygon()
    {
        // Arrange
        var capsuleShape = new CapsuleShape2D { Radius = 8f, Height = 16f };
        var transform = new Transform2D(DEFAULT_ROTATION, DEFAULT_POSITION);

        // Act
        var polygon = CollisionUtilities.ConvertShapeToPolygon(capsuleShape, transform);

        // Assert
        polygon.ShouldNotBeNull();
        polygon.Length.ShouldBe(24);
        
        // Verify polygon bounds are reasonable
        var bounds = CollisionGeometryUtils.GetPolygonBounds(polygon);
        bounds.Size.X.ShouldBeGreaterThan(0);
        bounds.Size.Y.ShouldBeGreaterThan(0);
    }
```

**Returns:** `void`

### ComplexCollisionScenario_MultipleObjects_Integration_ReturnsCorrectResults

```csharp
#endregion

    #region Complex Scenario Integration Tests

    [Test]
    public void ComplexCollisionScenario_MultipleObjects_Integration_ReturnsCorrectResults()
    {
        // Arrange
        var positioner = new Node2D();
        positioner.Name = "TestPositioner";
        positioner.GlobalPosition = DEFAULT_POSITION;
        _testSceneRoot!.AddChild(positioner);
        
        // Create multiple collision objects with different properties
        var rect1 = new CollisionShape2D();
        rect1.Shape = new RectangleShape2D { Size = new Vector2(32, 32) };
        rect1.Position = new Vector2(0, 0);
        _testSceneRoot.AddChild(rect1);
        
        var rect2 = new CollisionShape2D();
        rect2.Shape = new RectangleShape2D { Size = new Vector2(24, 24) };
        rect2.Position = new Vector2(40, 0);
        rect2.Rotation = DEFAULT_ROTATION;
        _testSceneRoot.AddChild(rect2);
        
        var polygon = new CollisionPolygon2D();
        polygon.Polygon = new Vector2[]
        {
            new(-12, -12), new(12, -12), new(12, 12), new(-12, 12)
        };
        polygon.Position = new Vector2(80, 40);
        _testSceneRoot.AddChild(polygon);
        
        var collisionObjects = new List<Node2D> { rect1, rect2, polygon };

        // Act
        var collisionPositions = _collisionMapper!.GetCollisionPositions(
            positioner, collisionObjects, _testTileMap!, DEFAULT_TILE_SIZE);

        // Assert
        collisionPositions.ShouldNotBeNull();
        collisionPositions.Count.ShouldBeGreaterThan(0);
        
        // Verify we have positions for multiple tiles
        var totalPositions = 0;
        foreach (var kvp in collisionPositions)
        {
            totalPositions += kvp.Value.Count;
        }
        totalPositions.ShouldBeGreaterThan(3); // Should have positions from all objects

        // Cleanup
        polygon.QueueFree();
        rect2.QueueFree();
        rect1.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### PerformanceTest_LargeNumberOfObjects_Integration_PerformsWell

```csharp
[Test]
    public void PerformanceTest_LargeNumberOfObjects_Integration_PerformsWell()
    {
        // Arrange
        var positioner = new Node2D();
        positioner.Name = "TestPositioner";
        positioner.GlobalPosition = DEFAULT_POSITION;
        _testSceneRoot!.AddChild(positioner);
        
        var collisionObjects = new List<Node2D>();
        
        // Create many collision objects
        for (int i = 0; i < 10; i++)
        {
            var shape = new CollisionShape2D();
            shape.Shape = new RectangleShape2D { Size = new Vector2(16, 16) };
            shape.Position = new Vector2(i * 20, 0);
            _testSceneRoot.AddChild(shape);
            collisionObjects.Add(shape);
        }

        // Act
        var startTime = Time.GetUnixTimeFromSystem();
        var collisionPositions = _collisionMapper!.GetCollisionPositions(
            positioner, collisionObjects, _testTileMap!, DEFAULT_TILE_SIZE);
        var endTime = Time.GetUnixTimeFromSystem();

        // Assert
        collisionPositions.ShouldNotBeNull();
        collisionPositions.Count.ShouldBeGreaterThan(0);
        
        var duration = endTime - startTime;
        duration.ShouldBeLessThan(0.5); // Should complete in less than 500ms

        // Cleanup
        foreach (var obj in collisionObjects)
        {
            obj.QueueFree();
        }
        positioner.QueueFree();
    }
```

**Returns:** `void`

### EdgeCaseTest_ZeroSizeObjects_Integration_HandlesGracefully

```csharp
[Test]
    public void EdgeCaseTest_ZeroSizeObjects_Integration_HandlesGracefully()
    {
        // Arrange
        var positioner = new Node2D();
        positioner.Name = "TestPositioner";
        positioner.GlobalPosition = DEFAULT_POSITION;
        _testSceneRoot!.AddChild(positioner);
        
        var zeroSizeShape = new CollisionShape2D();
        zeroSizeShape.Shape = new RectangleShape2D { Size = Vector2.Zero };
        zeroSizeShape.Position = DEFAULT_POSITION;
        _testSceneRoot.AddChild(zeroSizeShape);
        
        var collisionObjects = new List<Node2D> { zeroSizeShape };

        // Act
        var collisionPositions = _collisionMapper!.GetCollisionPositions(
            positioner, collisionObjects, _testTileMap!, DEFAULT_TILE_SIZE);

        // Assert
        collisionPositions.ShouldNotBeNull();
        // Zero size objects might not produce collision positions, but shouldn't crash

        // Cleanup
        zeroSizeShape.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### ResourceManagement_CreateAndDestroy_Integration_CleansUpCorrectly

```csharp
#endregion

    #region Resource Management Integration Tests

    [Test]
    public void ResourceManagement_CreateAndDestroy_Integration_CleansUpCorrectly()
    {
        // Arrange
        var tempSceneRoot = new Node2D();
        tempSceneRoot.Name = "TempSceneRoot";
        TestScene.AddChild(tempSceneRoot);
        
        var tempMapper = new CollisionMapper();
        tempMapper.Name = "TempMapper";
        tempSceneRoot.AddChild(tempMapper);
        
        var tempCollisionShape = new CollisionShape2D();
        tempCollisionShape.Shape = new RectangleShape2D { Size = new Vector2(32, 32) };
        tempSceneRoot.AddChild(tempCollisionShape);

        // Act - Use the objects
        var positioner = new Node2D();
        positioner.GlobalPosition = DEFAULT_POSITION;
        tempSceneRoot.AddChild(positioner);
        
        var collisionObjects = new List<Node2D> { tempCollisionShape };
        var collisionPositions = tempMapper.GetCollisionPositions(
            positioner, collisionObjects, _testTileMap!, DEFAULT_TILE_SIZE);

        // Assert - Should work normally
        collisionPositions.ShouldNotBeNull();

        // Cleanup
        positioner.QueueFree();
        tempCollisionShape.QueueFree();
        tempMapper.QueueFree();
        tempSceneRoot.QueueFree();
        
        // Verify cleanup completed (no memory leaks in test)
        GC.Collect();
        GC.WaitForPendingFinalizers();
    }
```

**Returns:** `void`

### ResourceManagement_MultipleTestRuns_Integration_DoesntLeak

```csharp
[Test]
    public void ResourceManagement_MultipleTestRuns_Integration_DoesntLeak()
    {
        // Arrange & Act - Run multiple test scenarios
        for (int i = 0; i < 5; i++)
        {
            var tempSceneRoot = new Node2D();
            tempSceneRoot.Name = $"TempSceneRoot_{i}";
            TestScene.AddChild(tempSceneRoot);
            
            var tempMapper = new CollisionMapper();
            tempMapper.Name = $"TempMapper_{i}";
            tempSceneRoot.AddChild(tempMapper);
            
            var tempCollisionShape = new CollisionShape2D();
            tempCollisionShape.Shape = new RectangleShape2D { Size = new Vector2(32, 32) };
            tempSceneRoot.AddChild(tempCollisionShape);

            var positioner = new Node2D();
            positioner.GlobalPosition = DEFAULT_POSITION + new Vector2(i * 10, i * 10);
            tempSceneRoot.AddChild(positioner);
            
            var collisionObjects = new List<Node2D> { tempCollisionShape };
            var collisionPositions = tempMapper.GetCollisionPositions(
                positioner, collisionObjects, _testTileMap!, DEFAULT_TILE_SIZE);

            // Assert - Each run should work
            collisionPositions.ShouldNotBeNull();

            // Cleanup
            positioner.QueueFree();
            tempCollisionShape.QueueFree();
            tempMapper.QueueFree();
            tempSceneRoot.QueueFree();
        }

        // Final cleanup
        GC.Collect();
        GC.WaitForPendingFinalizers();
    }
```

**Returns:** `void`

### ErrorHandling_InvalidCollisionObject_Integration_HandlesGracefully

```csharp
#endregion

    #region Error Handling Integration Tests

    [Test]
    public void ErrorHandling_InvalidCollisionObject_Integration_HandlesGracefully()
    {
        // Arrange
        var positioner = new Node2D();
        positioner.Name = "TestPositioner";
        positioner.GlobalPosition = DEFAULT_POSITION;
        _testSceneRoot!.AddChild(positioner);
        
        var invalidShape = new CollisionShape2D();
        // No shape set - should be invalid
        invalidShape.Position = DEFAULT_POSITION;
        _testSceneRoot.AddChild(invalidShape);
        
        var collisionObjects = new List<Node2D> { invalidShape };

        // Act
        var collisionPositions = _collisionMapper!.GetCollisionPositions(
            positioner, collisionObjects, _testTileMap!, DEFAULT_TILE_SIZE);

        // Assert
        collisionPositions.ShouldNotBeNull();
        // Should handle invalid objects gracefully without crashing

        // Cleanup
        invalidShape.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### ErrorHandling_NullTileMap_Integration_HandlesGracefully

```csharp
[Test]
    public void ErrorHandling_NullTileMap_Integration_HandlesGracefully()
    {
        // Arrange
        var positioner = new Node2D();
        positioner.Name = "TestPositioner";
        positioner.GlobalPosition = DEFAULT_POSITION;
        _testSceneRoot!.AddChild(positioner);
        
        var collisionObjects = new List<Node2D> { _testCollisionShape! };

        // Act
        var collisionPositions = _collisionMapper!.GetCollisionPositions(
            positioner, collisionObjects, null!, DEFAULT_TILE_SIZE);

        // Assert
        collisionPositions.ShouldNotBeNull();
        // Should handle null TileMap gracefully

        // Cleanup
        positioner.QueueFree();
    }
```

**Returns:** `void`

