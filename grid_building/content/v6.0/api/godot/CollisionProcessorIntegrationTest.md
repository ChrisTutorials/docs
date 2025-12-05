---
title: "CollisionProcessorIntegrationTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionprocessorintegrationtest/"
---

# CollisionProcessorIntegrationTest

```csharp
GridBuilding.Godot.Tests.Placement
class CollisionProcessorIntegrationTest
{
    // Members...
}
```

Integration tests for CollisionProcessor with real collision scenarios.
Tests the complete collision processing pipeline with various shape types.
Updated to use GoDotTest framework for proper test discovery.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/CollisionProcessorIntegrationTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "CollisionProcessor Integration Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Integration tests for collision processing pipeline";
```


## Methods

### SetUp

```csharp
[SetUp]
    public void SetUp()
    {
        _logger = new Logger();
        _processor = new CollisionProcessor(_logger);
        
        // Create test tile map
        _tileMap = new TileMapLayer();
        _tileMap.TileSet = new TileSet();
        _tileMap.TileSet.TileSize = new Vector2(16, 16);
        AddChild(_tileMap);
        
        // Create positioner
        _positioner = new Node2D();
        _positioner.Position = new Vector2(100, 100);
        AddChild(_positioner);
    }
```

**Returns:** `void`

### TearDown

```csharp
[TearDown]
    public void TearDown()
    {
        _processor?.InvalidateCache();
        _tileMap?.QueueFree();
        _positioner?.QueueFree();
        _processor = null;
        _logger = null;
        _tileMap = null;
        _positioner = null;
    }
```

**Returns:** `void`

### CollisionProcessor_CollisionPolygon2D_SimpleTriangle_ShouldReturnCorrectOffsets

```csharp
#endregion

    #region CollisionPolygon2D Integration Tests

    [Test]
    public void CollisionProcessor_CollisionPolygon2D_SimpleTriangle_ShouldReturnCorrectOffsets()
    {
        // Given
        var collisionPolygon = new CollisionPolygon2D();
        collisionPolygon.Polygon = new Vector2[]
        {
            new(0, 0), new(32, 0), new(16, 24)
        };
        collisionPolygon.Position = new Vector2(100, 100);
        AddChild(collisionPolygon);

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionPolygon, null!, _tileMap!, _positioner!);

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0);
        
        // Verify offsets are relative to positioner
        var centerTile = _tileMap!.LocalToMap(_tileMap.ToLocal(_positioner!.GlobalPosition));
        foreach (var offset in result.Keys)
        {
            // Offsets should be reasonable (not too large)
            Math.Abs(offset.X).ShouldBeLessThanOrEqualTo(5);
            Math.Abs(offset.Y).ShouldBeLessThanOrEqualTo(5);
        }

        // Cleanup
        collisionPolygon.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_CollisionPolygon2D_ComplexShape_ShouldReturnMultipleOffsets

```csharp
[Test]
    public void CollisionProcessor_CollisionPolygon2D_ComplexShape_ShouldReturnMultipleOffsets()
    {
        // Given
        var collisionPolygon = new CollisionPolygon2D();
        collisionPolygon.Polygon = new Vector2[]
        {
            new(0, 0), new(48, 0), new(48, 32), new(24, 48), new(0, 32)
        };
        collisionPolygon.Position = new Vector2(50, 50);
        AddChild(collisionPolygon);

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionPolygon, null!, _tileMap!, _positioner!);

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(3); // Complex shape should cover multiple tiles
        
        // Verify each offset has the collision polygon as value
        foreach (var entry in result)
        {
            entry.Value.Count.ShouldBe(1);
            entry.Value[0].ShouldBe(collisionPolygon);
        }

        // Cleanup
        collisionPolygon.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_CollisionPolygon2D_RotatedPolygon_ShouldHandleRotationCorrectly

```csharp
[Test]
    public void CollisionProcessor_CollisionPolygon2D_RotatedPolygon_ShouldHandleRotationCorrectly()
    {
        // Given
        var collisionPolygon = new CollisionPolygon2D();
        collisionPolygon.Polygon = new Vector2[]
        {
            new(-16, -16), new(16, -16), new(16, 16), new(-16, 16)
        };
        collisionPolygon.Position = new Vector2(100, 100);
        collisionPolygon.Rotation = Mathf.Pi / 4f; // 45 degrees
        AddChild(collisionPolygon);

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionPolygon, null!, _tileMap!, _positioner!);

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0);
        
        // Rotated square should still cover tiles around its center
        var centerTile = _tileMap!.LocalToMap(_tileMap.ToLocal(_positioner!.GlobalPosition));
        result.ShouldContainKey(new Vector2I(0, 0)); // Center tile

        // Cleanup
        collisionPolygon.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_CollisionObject2D_SingleRectangleShape_ShouldReturnCorrectOffsets

```csharp
#endregion

    #region CollisionObject2D Integration Tests

    [Test]
    public void CollisionProcessor_CollisionObject2D_SingleRectangleShape_ShouldReturnCorrectOffsets()
    {
        // Given
        var collisionObject = new Area2D();
        var collisionShape = new CollisionShape2D();
        var rectangleShape = new RectangleShape2D();
        rectangleShape.Size = new Vector2(32, 32);
        collisionShape.Shape = rectangleShape;
        collisionObject.AddChild(collisionShape);
        collisionObject.Position = new Vector2(100, 100);
        AddChild(collisionObject);

        var testData = new CollisionScenarioBuilder2D(collisionObject, new Vector2(16, 16));

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObject, testData, _tileMap!, _positioner!);

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0);
        
        // Should cover at least the center tile
        result.ShouldContainKey(new Vector2I(0, 0));

        // Cleanup
        collisionObject.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_CollisionObject2D_MultipleShapes_ShouldMergeOffsetsCorrectly

```csharp
[Test]
    public void CollisionProcessor_CollisionObject2D_MultipleShapes_ShouldMergeOffsetsCorrectly()
    {
        // Given
        var collisionObject = new Area2D();
        
        // Add rectangle shape
        var rectangleShape = new CollisionShape2D();
        var rectShape = new RectangleShape2D();
        rectShape.Size = new Vector2(32, 32);
        rectangleShape.Shape = rectShape;
        rectangleShape.Position = new Vector2(-16, 0);
        collisionObject.AddChild(rectangleShape);
        
        // Add circle shape
        var circleShape = new CollisionShape2D();
        var circle = new CircleShape2D();
        circle.Radius = 16f;
        circleShape.Shape = circle;
        circleShape.Position = new Vector2(16, 0);
        collisionObject.AddChild(circleShape);
        
        collisionObject.Position = new Vector2(100, 100);
        AddChild(collisionObject);

        var testData = new CollisionScenarioBuilder2D(collisionObject, new Vector2(16, 16));

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObject, testData, _tileMap!, _positioner!);

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0);
        
        // Should have overlapping tiles where shapes intersect
        var overlappingTiles = result.Where(kvp => kvp.Value.Count > 1).ToList();
        overlappingTiles.Count.ShouldBeGreaterThan(0);

        // Cleanup
        collisionObject.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_CollisionObject2D_CircleShape_ShouldReturnCircularOffsets

```csharp
[Test]
    public void CollisionProcessor_CollisionObject2D_CircleShape_ShouldReturnCircularOffsets()
    {
        // Given
        var collisionObject = new Area2D();
        var collisionShape = new CollisionShape2D();
        var circleShape = new CircleShape2D();
        circleShape.Radius = 24f;
        collisionShape.Shape = circleShape;
        collisionObject.AddChild(collisionShape);
        collisionObject.Position = new Vector2(100, 100);
        AddChild(collisionObject);

        var testData = new CollisionScenarioBuilder2D(collisionObject, new Vector2(16, 16));

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObject, testData, _tileMap!, _positioner!);

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0);
        
        // Circle should cover tiles in a roughly circular pattern
        var centerTile = new Vector2I(0, 0);
        result.ShouldContainKey(centerTile);
        
        // Should have tiles around center but not too far
        var maxDistance = result.Keys.Max(offset => 
            Math.Max(Math.Abs(offset.X), Math.Abs(offset.Y)));
        maxDistance.ShouldBeLessThanOrEqualTo(3); // Circle radius 24 / tile size 16 ≈ 1.5 tiles

        // Cleanup
        collisionObject.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_CollisionObject2D_CapsuleShape_ShouldReturnCapsuleOffsets

```csharp
[Test]
    public void CollisionProcessor_CollisionObject2D_CapsuleShape_ShouldReturnCapsuleOffsets()
    {
        // Given
        var collisionObject = new Area2D();
        var collisionShape = new CollisionShape2D();
        var capsuleShape = new CapsuleShape2D();
        capsuleShape.Height = 32f;
        capsuleShape.Radius = 8f;
        collisionShape.Shape = capsuleShape;
        collisionObject.AddChild(collisionShape);
        collisionObject.Position = new Vector2(100, 100);
        AddChild(collisionObject);

        var testData = new CollisionScenarioBuilder2D(collisionObject, new Vector2(16, 16));

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObject, testData, _tileMap!, _positioner!);

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0);
        
        // Capsule should cover tiles in an elongated pattern
        result.ShouldContainKey(new Vector2I(0, 0)); // Center

        // Cleanup
        collisionObject.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_InvalidTileMap_ShouldReturnEmptyResult

```csharp
#endregion

    #region Edge Cases and Error Handling

    [Test]
    public void CollisionProcessor_InvalidTileMap_ShouldReturnEmptyResult()
    {
        // Given
        var collisionPolygon = new CollisionPolygon2D();
        collisionPolygon.Polygon = new Vector2[] { new(0, 0), new(32, 0), new(16, 24) };
        AddChild(collisionPolygon);

        var invalidTileMap = new TileMapLayer(); // No TileSet assigned

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionPolygon, null!, invalidTileMap, _positioner!);

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBe(0);

        // Cleanup
        collisionPolygon.QueueFree();
        invalidTileMap.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_NullPositioner_ShouldReturnEmptyResult

```csharp
[Test]
    public void CollisionProcessor_NullPositioner_ShouldReturnEmptyResult()
    {
        // Given
        var collisionPolygon = new CollisionPolygon2D();
        collisionPolygon.Polygon = new Vector2[] { new(0, 0), new(32, 0), new(16, 24) };
        AddChild(collisionPolygon);

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionPolygon, null!, _tileMap!, null!);

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBe(0);

        // Cleanup
        collisionPolygon.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_EmptyPolygon_ShouldReturnEmptyResult

```csharp
[Test]
    public void CollisionProcessor_EmptyPolygon_ShouldReturnEmptyResult()
    {
        // Given
        var collisionPolygon = new CollisionPolygon2D();
        collisionPolygon.Polygon = new Vector2[] { }; // Empty polygon
        AddChild(collisionPolygon);

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionPolygon, null!, _tileMap!, _positioner!);

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBe(0);

        // Cleanup
        collisionPolygon.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_CacheInvalidation_ShouldClearCachedData

```csharp
[Test]
    public void CollisionProcessor_CacheInvalidation_ShouldClearCachedData()
    {
        // Given
        var collisionPolygon = new CollisionPolygon2D();
        collisionPolygon.Polygon = new Vector2[] { new(0, 0), new(32, 0), new(16, 24) };
        collisionPolygon.Position = new Vector2(100, 100);
        AddChild(collisionPolygon);

        // First call to populate cache
        var result1 = _processor!.GetTileOffsetsForCollision(collisionPolygon, null!, _tileMap!, _positioner!);

        // When
        _processor.InvalidateCache();
        
        // Second call after cache invalidation
        var result2 = _processor!.GetTileOffsetsForCollision(collisionPolygon, null!, _tileMap!, _positioner!);

        // Then
        result1.ShouldNotBeNull();
        result2.ShouldNotBeNull();
        result1.Count.ShouldBe(result2.Count); // Should produce same results

        // Cleanup
        collisionPolygon.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_ComplexPolygonPerformance_ShouldCompleteInReasonableTime

```csharp
#endregion

    #region Performance Tests

    [Test]
    public void CollisionProcessor_ComplexPolygonPerformance_ShouldCompleteInReasonableTime()
    {
        // Given
        var collisionPolygon = new CollisionPolygon2D();
        
        // Create a complex polygon (many vertices)
        var vertices = new List<Vector2>();
        for (int i = 0; i < 20; i++)
        {
            var angle = (float)(2 * Math.PI * i / 20);
            vertices.Add(new Vector2(
                32 * Mathf.Cos(angle),
                32 * Mathf.Sin(angle)
            ));
        }
        collisionPolygon.Polygon = vertices.ToArray();
        collisionPolygon.Position = new Vector2(100, 100);
        AddChild(collisionPolygon);

        // When
        var startTime = Time.GetTicksMsec();
        var result = _processor!.GetTileOffsetsForCollision(collisionPolygon, null!, _tileMap!, _positioner!);
        var endTime = Time.GetTicksMsec();

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0);
        
        // Should complete within reasonable time (adjust threshold as needed)
        var processingTime = endTime - startTime;
        processingTime.ShouldBeLessThan(1000); // Less than 1 second

        // Cleanup
        collisionPolygon.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_PositionerOffset_ShouldReturnRelativeOffsets

```csharp
#endregion

    #region Coordinate System Tests

    [Test]
    public void CollisionProcessor_PositionerOffset_ShouldReturnRelativeOffsets()
    {
        // Given
        var collisionPolygon = new CollisionPolygon2D();
        collisionPolygon.Polygon = new Vector2[]
        {
            new(0, 0), new(32, 0), new(16, 24)
        };
        collisionPolygon.Position = new Vector2(150, 150); // Different from positioner
        AddChild(collisionPolygon);

        // Positioner at different location
        _positioner!.Position = new Vector2(100, 100);

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionPolygon, null!, _tileMap!, _positioner!);

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0);
        
        // Offsets should be relative to positioner, not collision object
        var expectedCenterOffset = new Vector2I(
            (int)((collisionPolygon.Position.X - _positioner.Position.X) / _tileMap!.TileSet.TileSize.X),
            (int)((collisionPolygon.Position.Y - _positioner.Position.Y) / _tileMap.TileSet.TileSize.Y)
        );
        
        // Should contain offset that accounts for position difference
        result.Keys.ShouldContain(offset => 
            Math.Abs(offset.X - expectedCenterOffset.X) <= 1 &&
            Math.Abs(offset.Y - expectedCenterOffset.Y) <= 1);

        // Cleanup
        collisionPolygon.QueueFree();
    }
```

**Returns:** `void`

