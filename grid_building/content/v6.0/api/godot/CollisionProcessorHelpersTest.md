---
title: "CollisionProcessorHelpersTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionprocessorhelperstest/"
---

# CollisionProcessorHelpersTest

```csharp
GridBuilding.Godot.Tests.Placement
class CollisionProcessorHelpersTest
{
    // Members...
}
```

Unit tests for CollisionProcessor helper classes.
Tests TileRangeCalculator, ShapeTileOffsetCalculator, and CollisionPositionMerger.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/CollisionProcessorHelpersTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "CollisionProcessor Helpers Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests for collision processing helper utilities";
```


## Methods

### SetUp

```csharp
[SetUp]
    public void SetUp()
    {
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
        _tileMap?.QueueFree();
        _positioner?.QueueFree();
        _tileMap = null;
        _positioner = null;
    }
```

**Returns:** `void`

### TileRangeCalculator_CalculateTileRange_WithRectangleShape_ShouldReturnCorrectRange

```csharp
#endregion

    #region TileRangeCalculator Tests

    [Test]
    public void TileRangeCalculator_CalculateTileRange_WithRectangleShape_ShouldReturnCorrectRange()
    {
        // Given
        var shape = new RectangleShape2D();
        shape.Size = new Vector2(32, 32);
        var bounds = new Rect2(new Vector2(-16, -16), new Vector2(32, 32));
        var transform = new Transform2D(0, Vector2.Zero);
        var tileSize = new Vector2(16, 16);

        // When
        var result = TileRangeCalculator.CalculateTileRange(shape, bounds, _tileMap!, tileSize, transform);

        // Then
        result.ShouldNotBeNull();
        result.ShouldContainKey("start");
        result.ShouldContainKey("end_exclusive");
        
        var start = (Vector2I)result["start"];
        var endExclusive = (Vector2I)result["end_exclusive"];
        
        start.X.ShouldBeLessThanOrEqualTo(endExclusive.X);
        start.Y.ShouldBeLessThanOrEqualTo(endExclusive.Y);
        
        // 32x32 rectangle with 16x16 tiles should cover 2x2 tiles
        (endExclusive.X - start.X).ShouldBeGreaterThanOrEqualTo(2);
        (endExclusive.Y - start.Y).ShouldBeGreaterThanOrEqualTo(2);
    }
```

**Returns:** `void`

### TileRangeCalculator_CalculateTileRange_WithCircleShape_ShouldAdjustForSymmetry

```csharp
[Test]
    public void TileRangeCalculator_CalculateTileRange_WithCircleShape_ShouldAdjustForSymmetry()
    {
        // Given
        var shape = new CircleShape2D();
        shape.Radius = 16f;
        var bounds = new Rect2(new Vector2(-16, -16), new Vector2(32, 32));
        var transform = new Transform2D(0, new Vector2(32, 32)); // Offset from origin
        var tileSize = new Vector2(16, 16);

        // When
        var result = TileRangeCalculator.CalculateTileRange(shape, bounds, _tileMap!, tileSize, transform);

        // Then
        result.ShouldNotBeNull();
        var start = (Vector2I)result["start"];
        var endExclusive = (Vector2I)result["end_exclusive"];
        
        // Circle should have symmetric range around its center
        var centerTile = _tileMap!.LocalToMap(_tileMap.ToLocal(transform.Origin));
        var leftSpan = centerTile.X - start.X;
        var rightSpan = endExclusive.X - centerTile.X;
        
        leftSpan.ShouldBe(rightSpan);
    }
```

**Returns:** `void`

### TileRangeCalculator_CalculateTileRange_WithCapsuleShape_ShouldAdjustForSymmetry

```csharp
[Test]
    public void TileRangeCalculator_CalculateTileRange_WithCapsuleShape_ShouldAdjustForSymmetry()
    {
        // Given
        var shape = new CapsuleShape2D();
        shape.Height = 32f;
        shape.Radius = 8f;
        var bounds = new Rect2(new Vector2(-8, -16), new Vector2(16, 32));
        var transform = new Transform2D(0, new Vector2(48, 48));
        var tileSize = new Vector2(16, 16);

        // When
        var result = TileRangeCalculator.CalculateTileRange(shape, bounds, _tileMap!, tileSize, transform);

        // Then
        result.ShouldNotBeNull();
        var start = (Vector2I)result["start"];
        var endExclusive = (Vector2I)result["end_exclusive"];
        
        // Capsule should have symmetric horizontal range
        var centerTile = _tileMap!.LocalToMap(_tileMap.ToLocal(transform.Origin));
        var leftSpan = centerTile.X - start.X;
        var rightSpan = endExclusive.X - centerTile.X;
        
        leftSpan.ShouldBe(rightSpan);
    }
```

**Returns:** `void`

### TileRangeCalculator_CalculateTileRange_WithRectangleShapeAndFilter_ShouldAdjustRange

```csharp
[Test]
    public void TileRangeCalculator_CalculateTileRange_WithRectangleShapeAndFilter_ShouldAdjustRange()
    {
        // Given
        var shape = new RectangleShape2D();
        shape.Size = new Vector2(40, 40); // Not a multiple of tile size
        var bounds = new Rect2(new Vector2(-20, -20), new Vector2(40, 40));
        var transform = new Transform2D(0, Vector2.Zero);
        var tileSize = new Vector2(16, 16);

        // When
        var result = TileRangeCalculator.CalculateTileRange(shape, bounds, _tileMap!, tileSize, transform);

        // Then
        result.ShouldNotBeNull();
        var start = (Vector2I)result["start"];
        var endExclusive = (Vector2I)result["end_exclusive"];
        
        // Should cover at least 3x3 tiles for 40x40 rectangle
        (endExclusive.X - start.X).ShouldBeGreaterThanOrEqualTo(3);
        (endExclusive.Y - start.Y).ShouldBeGreaterThanOrEqualTo(3);
    }
```

**Returns:** `void`

### ShapeTileOffsetCalculator_ComputeShapeTileOffsets_WithValidInputs_ShouldReturnOffsets

```csharp
#endregion

    #region ShapeTileOffsetCalculator Tests

    [Test]
    public void ShapeTileOffsetCalculator_ComputeShapeTileOffsets_WithValidInputs_ShouldReturnOffsets()
    {
        // Given
        var shape = new RectangleShape2D();
        shape.Size = new Vector2(32, 32);
        var transform = new Transform2D(0, Vector2.Zero);
        var startTile = new Vector2I(-1, -1);
        var endExclusive = new Vector2I(2, 2);
        var centerTile = new Vector2I(0, 0);
        var shapeEpsilon = 0.035f;
        var tileSize = new Vector2(16, 16);
        
        // Create a simple rectangle polygon
        var polygon = new Vector2[]
        {
            new(-16, -16), new(16, -16), new(16, 16), new(-16, 16)
        };

        // When
        var result = ShapeTileOffsetCalculator.ComputeShapeTileOffsets(
            shape, transform, _tileMap!, tileSize, shapeEpsilon, startTile, endExclusive, centerTile, polygon);

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0);
        
        // Should include center tile for rectangle covering it
        result.ShouldContain(new Vector2I(0, 0));
    }
```

**Returns:** `void`

### ShapeTileOffsetCalculator_ComputeShapeTileOffsets_WithCircleShape_ShouldReturnCircularPattern

```csharp
[Test]
    public void ShapeTileOffsetCalculator_ComputeShapeTileOffsets_WithCircleShape_ShouldReturnCircularPattern()
    {
        // Given
        var shape = new CircleShape2D();
        shape.Radius = 16f;
        var transform = new Transform2D(0, Vector2.Zero);
        var startTile = new Vector2I(-2, -2);
        var endExclusive = new Vector2I(3, 3);
        var centerTile = new Vector2I(0, 0);
        var shapeEpsilon = 0.035f;
        var tileSize = new Vector2(16, 16);
        
        // Approximate circle as octagon
        var polygon = new Vector2[]
        {
            new(0, -16), new(11, -11), new(16, 0), new(11, 11),
            new(0, 16), new(-11, 11), new(-16, 0), new(-11, -11)
        };

        // When
        var result = ShapeTileOffsetCalculator.ComputeShapeTileOffsets(
            shape, transform, _tileMap!, tileSize, shapeEpsilon, startTile, endExclusive, centerTile, polygon);

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0);
        
        // Should include center tile
        result.ShouldContain(new Vector2I(0, 0));
        
        // Should have roughly circular pattern (more tiles near center)
        var distances = result.Select(offset => 
            Math.Sqrt(offset.X * offset.X + offset.Y * offset.Y)).ToList();
        var maxDistance = distances.Max();
        maxDistance.ShouldBeLessThanOrEqualTo(2); // Shouldn't extend too far
    }
```

**Returns:** `void`

### ShapeTileOffsetCalculator_ComputeShapeTileOffsets_WithEmptyPolygon_ShouldReturnEmpty

```csharp
[Test]
    public void ShapeTileOffsetCalculator_ComputeShapeTileOffsets_WithEmptyPolygon_ShouldReturnEmpty()
    {
        // Given
        var shape = new RectangleShape2D();
        shape.Size = new Vector2(32, 32);
        var transform = new Transform2D(0, Vector2.Zero);
        var startTile = new Vector2I(0, 0);
        var endExclusive = new Vector2I(2, 2);
        var centerTile = new Vector2I(1, 1);
        var shapeEpsilon = 0.035f;
        var tileSize = new Vector2(16, 16);
        var polygon = new Vector2[] { };

        // When
        var result = ShapeTileOffsetCalculator.ComputeShapeTileOffsets(
            shape, transform, _tileMap!, tileSize, shapeEpsilon, startTile, endExclusive, centerTile, polygon);

        // Then
        result.ShouldNotBeNull();
        result.Count.ShouldBe(0);
    }
```

**Returns:** `void`

### ShapeTileOffsetCalculator_ComputeShapeTileOffsets_WithNullMap_ShouldThrowException

```csharp
[Test]
    public void ShapeTileOffsetCalculator_ComputeShapeTileOffsets_WithNullMap_ShouldThrowException()
    {
        // Given
        var shape = new RectangleShape2D();
        shape.Size = new Vector2(32, 32);
        var transform = new Transform2D(0, Vector2.Zero);
        var startTile = new Vector2I(0, 0);
        var endExclusive = new Vector2I(2, 2);
        var centerTile = new Vector2I(1, 1);
        var shapeEpsilon = 0.035f;
        var tileSize = new Vector2(16, 16);
        var polygon = new Vector2[]
        {
            new(-16, -16), new(16, -16), new(16, 16), new(-16, 16)
        };

        // When/Then
        Should.Throw<ArgumentNullException>(() =>
        {
            ShapeTileOffsetCalculator.ComputeShapeTileOffsets(
                shape, transform, null!, tileSize, shapeEpsilon, startTile, endExclusive, centerTile, polygon);
        });
    }
```

**Returns:** `void`

### CollisionPositionMerger_MergeOffsetsIntoPositions_WithEmptyTarget_ShouldCreateNewEntries

```csharp
#endregion

    #region CollisionPositionMerger Tests

    [Test]
    public void CollisionPositionMerger_MergeOffsetsIntoPositions_WithEmptyTarget_ShouldCreateNewEntries()
    {
        // Given
        var targetPositions = new Godot.Collections.Dictionary<Vector2I, Godot.Collections.Array>();
        var sourceOffsets = new List<Vector2I> { new(0, 0), new(1, 0), new(0, 1) };
        var collisionObject = new Node2D();
        var centerTile = new Vector2I(5, 5);

        // When
        CollisionPositionMerger.MergeOffsetsIntoPositions(sourceOffsets, targetPositions, collisionObject, centerTile);

        // Then
        targetPositions.Count.ShouldBe(3);
        targetPositions.ShouldContainKey(new Vector2I(0, 0));
        targetPositions.ShouldContainKey(new Vector2I(1, 0));
        targetPositions.ShouldContainKey(new Vector2I(0, 1));
        
        foreach (var entry in targetPositions)
        {
            entry.Value.Count.ShouldBe(1);
            entry.Value[0].ShouldBe(collisionObject);
        }

        // Cleanup
        collisionObject.QueueFree();
    }
```

**Returns:** `void`

### CollisionPositionMerger_MergeOffsetsIntoPositions_WithExistingTarget_ShouldMergeEntries

```csharp
[Test]
    public void CollisionPositionMerger_MergeOffsetsIntoPositions_WithExistingTarget_ShouldMergeEntries()
    {
        // Given
        var existingObject = new Node2D();
        var targetPositions = new Godot.Collections.Dictionary<Vector2I, Godot.Collections.Array>
        {
            { new Vector2I(0, 0), new Godot.Collections.Array { existingObject } }
        };
        var sourceOffsets = new List<Vector2I> { new Vector2I(0, 0), new Vector2I(1, 0) };
        var collisionObject = new Node2D();
        var centerTile = new Vector2I(5, 5);

        // When
        CollisionPositionMerger.MergeOffsetsIntoPositions(sourceOffsets, targetPositions, collisionObject, centerTile);

        // Then
        targetPositions.Count.ShouldBe(2);
        
        // Existing entry should have both objects
        targetPositions[new Vector2I(0, 0)].Count.ShouldBe(2);
        targetPositions[new Vector2I(0, 0)].ShouldContain(existingObject);
        targetPositions[new Vector2I(0, 0)].ShouldContain(collisionObject);
        
        // New entry should have only new object
        targetPositions[new Vector2I(1, 0)].Count.ShouldBe(1);
        targetPositions[new Vector2I(1, 0)][0].ShouldBe(collisionObject);

        // Cleanup
        existingObject.QueueFree();
        collisionObject.QueueFree();
    }
```

**Returns:** `void`

### CollisionPositionMerger_MergeOffsetsIntoPositions_WithDuplicateObject_ShouldNotDuplicate

```csharp
[Test]
    public void CollisionPositionMerger_MergeOffsetsIntoPositions_WithDuplicateObject_ShouldNotDuplicate()
    {
        // Given
        var collisionObject = new Node2D();
        var targetPositions = new Godot.Collections.Dictionary<Vector2I, Godot.Collections.Array>
        {
            { new Vector2I(0, 0), new Godot.Collections.Array { collisionObject } }
        };
        var sourceOffsets = new List<Vector2I> { new Vector2I(0, 0) };
        var centerTile = new Vector2I(5, 5);

        // When
        CollisionPositionMerger.MergeOffsetsIntoPositions(sourceOffsets, targetPositions, collisionObject, centerTile);

        // Then
        targetPositions.Count.ShouldBe(1);
        targetPositions[new Vector2I(0, 0)].Count.ShouldBe(1);
        targetPositions[new Vector2I(0, 0)][0].ShouldBe(collisionObject);

        // Cleanup
        collisionObject.QueueFree();
    }
```

**Returns:** `void`

### CollisionPositionMerger_MergeOffsetsIntoPositions_WithNullCollisionObject_ShouldNotThrow

```csharp
[Test]
    public void CollisionPositionMerger_MergeOffsetsIntoPositions_WithNullCollisionObject_ShouldNotThrow()
    {
        // Given
        var targetPositions = new Godot.Collections.Dictionary<Vector2I, Godot.Collections.Array>();
        var sourceOffsets = new List<Vector2I> { new Vector2I(0, 0) };
        var centerTile = new Vector2I(5, 5);

        // When/Then - Should not throw
        Should.NotThrow(() =>
        {
            CollisionPositionMerger.MergeOffsetsIntoPositions(sourceOffsets, targetPositions, null!, centerTile);
        });
    }
```

**Returns:** `void`

### CollisionProcessorHelpers_FullWorkflow_ShouldProcessShapeCorrectly

```csharp
#endregion

    #region Integration Tests

    [Test]
    public void CollisionProcessorHelpers_FullWorkflow_ShouldProcessShapeCorrectly()
    {
        // Given
        var shape = new RectangleShape2D();
        shape.Size = new Vector2(32, 32);
        var transform = new Transform2D(0, Vector2.Zero);
        var tileSize = new Vector2(16, 16);
        var shapeEpsilon = 0.035f;
        var centerTile = new Vector2I(5, 5);
        
        var polygon = new Vector2[]
        {
            new(-16, -16), new(16, -16), new(16, 16), new(-16, 16)
        };

        // When - Calculate tile range
        var bounds = new Rect2(new Vector2(-16, -16), new Vector2(32, 32));
        var range = TileRangeCalculator.CalculateTileRange(shape, bounds, _tileMap!, tileSize, transform);
        
        // When - Compute offsets
        var startTile = (Vector2I)range["start"];
        var endExclusive = (Vector2I)range["end_exclusive"];
        var offsets = ShapeTileOffsetCalculator.ComputeShapeTileOffsets(
            shape, transform, _tileMap!, tileSize, shapeEpsilon, startTile, endExclusive, centerTile, polygon);
        
        // When - Merge into positions
        var positions = new Godot.Collections.Dictionary<Vector2I, Godot.Collections.Array>();
        var collisionObject = new Node2D();
        CollisionPositionMerger.MergeOffsetsIntoPositions(offsets, positions, collisionObject, centerTile);

        // Then
        offsets.Count.ShouldBeGreaterThan(0);
        positions.Count.ShouldBeGreaterThan(0);
        
        // Verify all offsets correspond to positions
        foreach (var offset in offsets)
        {
            positions.ShouldContainKey(offset);
            positions[offset].ShouldContain(collisionObject);
        }

        // Cleanup
        collisionObject.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessorHelpers_MultipleShapes_ShouldMergeCorrectly

```csharp
[Test]
    public void CollisionProcessorHelpers_MultipleShapes_ShouldMergeCorrectly()
    {
        // Given
        var rectangleShape = new RectangleShape2D();
        rectangleShape.Size = new Vector2(32, 32);
        var circleShape = new CircleShape2D();
        circleShape.Radius = 16f;
        var transform = new Transform2D(0, Vector2.Zero);
        var tileSize = new Vector2(16, 16);
        var shapeEpsilon = 0.035f;
        var centerTile = new Vector2I(5, 5);
        
        var rectanglePolygon = new Vector2[]
        {
            new(-16, -16), new(16, -16), new(16, 16), new(-16, 16)
        };
        
        var circlePolygon = new Vector2[]
        {
            new(0, -16), new(11, -11), new(16, 0), new(11, 11),
            new(0, 16), new(-11, 11), new(-16, 0), new(-11, -11)
        };

        // When
        var rectangleBounds = new Rect2(new Vector2(-16, -16), new Vector2(32, 32));
        var rectangleRange = TileRangeCalculator.CalculateTileRange(rectangleShape, rectangleBounds, _tileMap!, tileSize, transform);
        var rectangleOffsets = ShapeTileOffsetCalculator.ComputeShapeTileOffsets(
            rectangleShape, transform, _tileMap!, tileSize, shapeEpsilon, 
            (Vector2I)rectangleRange["start"], (Vector2I)rectangleRange["end_exclusive"], centerTile, rectanglePolygon);
        
        var circleBounds = new Rect2(new Vector2(-16, -16), new Vector2(32, 32));
        var circleRange = TileRangeCalculator.CalculateTileRange(circleShape, circleBounds, _tileMap!, tileSize, transform);
        var circleOffsets = ShapeTileOffsetCalculator.ComputeShapeTileOffsets(
            circleShape, transform, _tileMap!, tileSize, shapeEpsilon, 
            (Vector2I)circleRange["start"], (Vector2I)circleRange["end_exclusive"], centerTile, circlePolygon);
        
        var positions = new Godot.Collections.Dictionary<Vector2I, Godot.Collections.Array>();
        var rectangleObject = new Node2D();
        var circleObject = new Node2D();
        
        CollisionPositionMerger.MergeOffsetsIntoPositions(rectangleOffsets, positions, rectangleObject, centerTile);
        CollisionPositionMerger.MergeOffsetsIntoPositions(circleOffsets, positions, circleObject, centerTile);

        // Then
        positions.Count.ShouldBeGreaterThan(0);
        
        // Find overlapping tiles
        var overlappingTiles = positions.Where(kvp => kvp.Value.Count > 1).ToList();
        overlappingTiles.Count.ShouldBeGreaterThan(0);
        
        // Verify overlapping tiles contain both objects
        foreach (var (tile, objects) in overlappingTiles)
        {
            objects.ShouldContain(rectangleObject);
            objects.ShouldContain(circleObject);
        }

        // Cleanup
        rectangleObject.QueueFree();
        circleObject.QueueFree();
    }
```

**Returns:** `void`

