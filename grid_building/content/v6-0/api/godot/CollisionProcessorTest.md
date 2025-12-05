---
title: "CollisionProcessorTest"
description: "Integration tests for CollisionProcessor Godot integration.
Tests the bridge between Godot runtime and Core collision processing."
weight: 20
url: "/gridbuilding/v6-0/api/godot/collisionprocessortest/"
---

# CollisionProcessorTest

```csharp
GridBuilding.Godot.Tests.Placement
class CollisionProcessorTest
{
    // Members...
}
```

Integration tests for CollisionProcessor Godot integration.
Tests the bridge between Godot runtime and Core collision processing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/CollisionProcessorTest.cs`  
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
    public string TestDescription => "Tests collision processing Godot integration with Core logic";
```


## Methods

### SetUp

```csharp
[SetUp]
    public void SetUp()
    {
        _logger = new Logger();
        _coreProcessor = new CollisionProcessor();
        _godotProcessor = new GridBuilding.Systems.Placement.Processors.CollisionProcessor();
    }
```

**Returns:** `void`

### TearDown

```csharp
[TearDown]
    public void TearDown()
    {
        _coreProcessor = null;
        _godotProcessor = null;
        _logger = null;
    }
```

**Returns:** `void`

### CollisionProcessor_Creation_WithLogger_ShouldInitializeSuccessfully

```csharp
#endregion

    #region Tests

    [Test]
    public void CollisionProcessor_Creation_WithLogger_ShouldInitializeSuccessfully()
    {
        // Given
        var logger = new Logger();

        // When
        var processor = new CollisionProcessor(logger);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### CollisionProcessor_Creation_WithNullLogger_ShouldReportIssues

```csharp
[Test]
    public void CollisionProcessor_Creation_WithNullLogger_ShouldReportIssues()
    {
        // When
        var processor = new CollisionProcessor(null);

        // Then
        ;
        var issues = processor.GetRuntimeIssues();
        ;
        ;
    }
```

**Returns:** `void`

### CollisionProcessor_ResolveGbDependencies_WithValidContainer_ShouldSucceed

```csharp
[Test]
    public void CollisionProcessor_ResolveGbDependencies_WithValidContainer_ShouldSucceed()
    {
        // Given
        var container = new MockGBCompositionContainer();
        var logger = new Logger();
        container.SetLogger(logger);

        // When
        var result = _processor!.ResolveGbDependencies(container);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### CollisionProcessor_ResolveGbDependencies_WithNullContainer_ShouldFail

```csharp
[Test]
    public void CollisionProcessor_ResolveGbDependencies_WithNullContainer_ShouldFail()
    {
        // When
        var result = _processor!.ResolveGbDependencies(null!);

        // Then
        ;
    }
```

**Returns:** `void`

### CollisionProcessor_GetTileOffsetsForCollision_WithNullObject_ShouldReturnEmpty

```csharp
[Test]
    public void CollisionProcessor_GetTileOffsetsForCollision_WithNullObject_ShouldReturnEmpty()
    {
        // Given
        var map = new TileMapLayer();
        var positioner = new Node2D();

        // When
        var result = _processor!.GetTileOffsetsForCollision(null!, null!, map, positioner);

        // Then
        ;
        ;

        // Cleanup
        map.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_GetTileOffsetsForCollision_WithNullMap_ShouldReturnEmpty

```csharp
[Test]
    public void CollisionProcessor_GetTileOffsetsForCollision_WithNullMap_ShouldReturnEmpty()
    {
        // Given
        var collisionObj = new CollisionPolygon2D();
        var positioner = new Node2D();

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObj, null!, null!, positioner);

        // Then
        ;
        ;

        // Cleanup
        collisionObj.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_GetTileOffsetsForCollision_WithNullTileSet_ShouldReturnEmpty

```csharp
[Test]
    public void CollisionProcessor_GetTileOffsetsForCollision_WithNullTileSet_ShouldReturnEmpty()
    {
        // Given
        var collisionObj = new CollisionPolygon2D();
        var map = new TileMapLayer();
        var positioner = new Node2D();

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObj, null!, map, positioner);

        // Then
        ;
        ;

        // Cleanup
        collisionObj.QueueFree();
        map.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_GetTileOffsetsForCollision_WithCollisionPolygon_ShouldCallCorrectHandler

```csharp
[Test]
    public void CollisionProcessor_GetTileOffsetsForCollision_WithCollisionPolygon_ShouldCallCorrectHandler()
    {
        // Given
        var collisionObj = new CollisionPolygon2D();
        var map = new TileMapLayer();
        map.TileSet = new TileSet();
        var positioner = new Node2D();

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObj, null!, map, positioner);

        // Then
        ;
        // Should call the CollisionPolygon2D handler
        // Implementation is placeholder, so result will be empty

        // Cleanup
        collisionObj.QueueFree();
        map.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_GetTileOffsetsForCollision_WithCollisionObject_ShouldCallCorrectHandler

```csharp
[Test]
    public void CollisionProcessor_GetTileOffsetsForCollision_WithCollisionObject_ShouldCallCorrectHandler()
    {
        // Given
        var collisionObj = new CollisionObject2D();
        var testData = new CollisionScenarioBuilder2D(collisionObj, Vector2.One);
        var map = new TileMapLayer();
        map.TileSet = new TileSet();
        var positioner = new Node2D();

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObj, testData, map, positioner);

        // Then
        ;
        // Should call the CollisionObject2D handler
        // Implementation is placeholder, so result will be empty

        // Cleanup
        collisionObj.QueueFree();
        map.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_GetTileOffsetsForCollision_WithUnsupportedType_ShouldLogWarning

```csharp
[Test]
    public void CollisionProcessor_GetTileOffsetsForCollision_WithUnsupportedType_ShouldLogWarning()
    {
        // Given
        var collisionObj = new Node2D(); // Unsupported type
        var map = new TileMapLayer();
        map.TileSet = new TileSet();
        var positioner = new Node2D();

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObj, null!, map, positioner);

        // Then
        ;
        ;
        // Should log warning about unsupported type

        // Cleanup
        collisionObj.QueueFree();
        map.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_InvalidateCache_ShouldNotThrow

```csharp
[Test]
    public void CollisionProcessor_InvalidateCache_ShouldNotThrow()
    {
        // When/Then
        Assert.DoesNotThrow(() => _processor!.InvalidateCache());
    }
```

**Returns:** `void`

### CollisionProcessor_GetTileOffsetsForCollision_WithLargePolygon_ShouldHandleCorrectly

```csharp
[Test]
    public void CollisionProcessor_GetTileOffsetsForCollision_WithLargePolygon_ShouldHandleCorrectly()
    {
        // Given
        var collisionObj = new CollisionPolygon2D();
        // Create a large polygon covering many tiles
        collisionObj.Polygon = new Vector2[]
        {
            new(-64, -64), new(64, -64), new(64, 64), new(-64, 64)
        };
        collisionObj.Position = new Vector2(100, 100);
        var map = new TileMapLayer();
        map.TileSet = new TileSet();
        map.TileSet.TileSize = new Vector2(16, 16);
        var positioner = new Node2D();
        positioner.Position = new Vector2(100, 100);
        AddChild(collisionObj);
        AddChild(map);
        AddChild(positioner);

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObj, null!, map, positioner);

        // Then
        ;
        ; // Large polygon should cover many tiles

        // Cleanup
        collisionObj.QueueFree();
        map.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_GetTileOffsetsForCollision_WithDegeneratePolygon_ShouldHandleGracefully

```csharp
[Test]
    public void CollisionProcessor_GetTileOffsetsForCollision_WithDegeneratePolygon_ShouldHandleGracefully()
    {
        // Given
        var collisionObj = new CollisionPolygon2D();
        // Create a degenerate polygon (line)
        collisionObj.Polygon = new Vector2[] { new(0, 0), new(32, 0) };
        var map = new TileMapLayer();
        map.TileSet = new TileSet();
        map.TileSet.TileSize = new Vector2(16, 16);
        var positioner = new Node2D();
        AddChild(collisionObj);
        AddChild(map);
        AddChild(positioner);

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObj, null!, map, positioner);

        // Then
        ;
        // Degenerate polygon might not cover any tiles, but shouldn't crash

        // Cleanup
        collisionObj.QueueFree();
        map.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_GetTileOffsetsForCollision_WithConcavePolygon_ShouldHandleCorrectly

```csharp
[Test]
    public void CollisionProcessor_GetTileOffsetsForCollision_WithConcavePolygon_ShouldHandleCorrectly()
    {
        // Given
        var collisionObj = new CollisionPolygon2D();
        // Create a concave polygon (L-shape)
        collisionObj.Polygon = new Vector2[]
        {
            new(0, 0), new(32, 0), new(32, 16), new(16, 16), new(16, 32), new(0, 32)
        };
        var map = new TileMapLayer();
        map.TileSet = new TileSet();
        map.TileSet.TileSize = new Vector2(16, 16);
        var positioner = new Node2D();
        AddChild(collisionObj);
        AddChild(map);
        AddChild(positioner);

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObj, null!, map, positioner);

        // Then
        ;
        ;

        // Cleanup
        collisionObj.QueueFree();
        map.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_GetTileOffsetsForCollision_WithDifferentTileSizes_ShouldAdaptCorrectly

```csharp
[Test]
    public void CollisionProcessor_GetTileOffsetsForCollision_WithDifferentTileSizes_ShouldAdaptCorrectly()
    {
        // Given
        var collisionObj = new CollisionPolygon2D();
        collisionObj.Polygon = new Vector2[]
        {
            new(0, 0), new(32, 0), new(16, 24)
        };
        var map = new TileMapLayer();
        map.TileSet = new TileSet();
        map.TileSet.TileSize = new Vector2(8, 8); // Smaller tile size
        var positioner = new Node2D();
        AddChild(collisionObj);
        AddChild(map);
        AddChild(positioner);

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObj, null!, map, positioner);

        // Then
        ;
        ;
        // With smaller tiles, should cover more tiles for same polygon

        // Cleanup
        collisionObj.QueueFree();
        map.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_GetTileOffsetsForCollision_WithRotatedPositioner_ShouldHandleCorrectly

```csharp
[Test]
    public void CollisionProcessor_GetTileOffsetsForCollision_WithRotatedPositioner_ShouldHandleCorrectly()
    {
        // Given
        var collisionObj = new CollisionPolygon2D();
        collisionObj.Polygon = new Vector2[]
        {
            new(-16, -16), new(16, -16), new(16, 16), new(-16, 16)
        };
        var map = new TileMapLayer();
        map.TileSet = new TileSet();
        map.TileSet.TileSize = new Vector2(16, 16);
        var positioner = new Node2D();
        positioner.Rotation = Mathf.Pi / 4f; // 45 degrees rotation
        AddChild(collisionObj);
        AddChild(map);
        AddChild(positioner);

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObj, null!, map, positioner);

        // Then
        ;
        ;
        // Rotation shouldn't break the calculation

        // Cleanup
        collisionObj.QueueFree();
        map.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_GetTileOffsetsForCollision_WithScaledPositioner_ShouldHandleCorrectly

```csharp
[Test]
    public void CollisionProcessor_GetTileOffsetsForCollision_WithScaledPositioner_ShouldHandleCorrectly()
    {
        // Given
        var collisionObj = new CollisionPolygon2D();
        collisionObj.Polygon = new Vector2[]
        {
            new(-16, -16), new(16, -16), new(16, 16), new(-16, 16)
        };
        var map = new TileMapLayer();
        map.TileSet = new TileSet();
        map.TileSet.TileSize = new Vector2(16, 16);
        var positioner = new Node2D();
        positioner.Scale = new Vector2(2, 2); // 2x scale
        AddChild(collisionObj);
        AddChild(map);
        AddChild(positioner);

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObj, null!, map, positioner);

        // Then
        ;
        ;
        // Scale shouldn't break the calculation

        // Cleanup
        collisionObj.QueueFree();
        map.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_GetTileOffsetsForCollision_WithCollisionObjectAndNoShapes_ShouldReturnEmpty

```csharp
[Test]
    public void CollisionProcessor_GetTileOffsetsForCollision_WithCollisionObjectAndNoShapes_ShouldReturnEmpty()
    {
        // Given
        var collisionObj = new CollisionObject2D();
        // No shapes added
        var testData = new CollisionScenarioBuilder2D(collisionObj, Vector2.One);
        var map = new TileMapLayer();
        map.TileSet = new TileSet();
        var positioner = new Node2D();
        AddChild(collisionObj);
        AddChild(map);
        AddChild(positioner);

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObj, testData, map, positioner);

        // Then
        ;
        ;

        // Cleanup
        collisionObj.QueueFree();
        map.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

### CollisionProcessor_GetTileOffsetsForCollision_WithCollisionObjectAndNullShape_ShouldHandleGracefully

```csharp
[Test]
    public void CollisionProcessor_GetTileOffsetsForCollision_WithCollisionObjectAndNullShape_ShouldHandleGracefully()
    {
        // Given
        var collisionObj = new CollisionObject2D();
        var collisionShape = new CollisionShape2D();
        // Shape property is null
        collisionObj.AddChild(collisionShape);
        var testData = new CollisionScenarioBuilder2D(collisionObj, Vector2.One);
        var map = new TileMapLayer();
        map.TileSet = new TileSet();
        var positioner = new Node2D();
        AddChild(collisionObj);
        AddChild(map);
        AddChild(positioner);

        // When
        var result = _processor!.GetTileOffsetsForCollision(collisionObj, testData, map, positioner);

        // Then
        ;
        // Should handle null shape gracefully without crashing

        // Cleanup
        collisionObj.QueueFree();
        map.QueueFree();
        positioner.QueueFree();
    }
```

**Returns:** `void`

