---
title: "CollisionUtilitiesIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionutilitiesintegrationtests/"
---

# CollisionUtilitiesIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class CollisionUtilitiesIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for CollisionUtilities.
Ported from: shared/utils/collision/detection/collision_utilities_unit_test.gd
Tests collision detection utilities that require Godot TileMapLayer and physics shapes.
Validates:
- Rectangle tile position calculations
- TileMap coordinate conversions
- Shape overlap detection

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/CollisionUtilitiesIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up CollisionUtilities Integration Tests");
    }
```

**Returns:** `void`

### Setup

```csharp
[Setup]
    public void Setup()
    {
        _tileMap = CreateMockTileMap();
        _testScene.AddChild(_tileMap);
    }
```

**Returns:** `void`

### Cleanup

```csharp
[Cleanup]
    public void Cleanup()
    {
        _tileMap?.QueueFree();
        _tileMap = null;
    }
```

**Returns:** `void`

### GetRectTilePositions_SingleTileAtOrigin_ReturnsOriginTile

```csharp
#region Tile Position Calculation Tests

    [Test]
    public void GetRectTilePositions_SingleTileAtOrigin_ReturnsOriginTile()
    {
        // Arrange: Rectangle centered at origin, size of one tile
        var centerPos = DefaultPosition;
        var rectSize = new Vector2(TileSize.X, TileSize.Y);

        // Act
        var result = GetRectTilePositions(_tileMap!, centerPos, rectSize);

        // Assert
        result.ShouldNotBeNull("Should return valid tile positions");
        result.Count.ShouldBeGreaterThan(0, "Should contain at least one tile");
        result.ShouldContain(OriginTile, "Should contain origin tile");
    }
```

**Returns:** `void`

### GetRectTilePositions_LargerRectangle_ReturnsMultipleTiles

```csharp
[Test]
    public void GetRectTilePositions_LargerRectangle_ReturnsMultipleTiles()
    {
        // Arrange: Rectangle spanning 2x2 tiles
        var centerPos = new Vector2(TileSize.X, TileSize.Y); // Center at (32, 32)
        var rectSize = new Vector2(TileSize.X * 2, TileSize.Y * 2); // 64x64

        // Act
        var result = GetRectTilePositions(_tileMap!, centerPos, rectSize);

        // Assert
        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThanOrEqualTo(4, "2x2 tile rect should contain at least 4 tiles");
    }
```

**Returns:** `void`

### GetRectTilePositions_OffsetPosition_ReturnsCorrectTiles

```csharp
[Test]
    public void GetRectTilePositions_OffsetPosition_ReturnsCorrectTiles()
    {
        // Arrange: Rectangle at offset position
        var centerPos = new Vector2(TileSize.X * 3 + TileSize.X / 2, TileSize.Y * 2 + TileSize.Y / 2);
        var rectSize = new Vector2(TileSize.X, TileSize.Y);

        // Act
        var result = GetRectTilePositions(_tileMap!, centerPos, rectSize);

        // Assert
        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0);
        // Should contain tile at approximately (3, 2)
        result.ShouldContain(new Vector2I(3, 2), "Should contain expected offset tile");
    }
```

**Returns:** `void`

### GetRectTilePositions_NegativePosition_ReturnsNegativeTiles

```csharp
[Test]
    public void GetRectTilePositions_NegativePosition_ReturnsNegativeTiles()
    {
        // Arrange: Rectangle in negative coordinate space
        var centerPos = new Vector2(-TileSize.X * 2, -TileSize.Y * 2);
        var rectSize = new Vector2(TileSize.X, TileSize.Y);

        // Act
        var result = GetRectTilePositions(_tileMap!, centerPos, rectSize);

        // Assert
        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0);
        // All tiles should be in negative coordinate space
        foreach (var tile in result)
        {
            tile.X.ShouldBeLessThanOrEqualTo(0, "Tile X should be negative or zero");
            tile.Y.ShouldBeLessThanOrEqualTo(0, "Tile Y should be negative or zero");
        }
    }
```

**Returns:** `void`

### LocalToMap_CenterOfTile_ReturnsCorrectTileCoord

```csharp
#endregion

    #region TileMap Coordinate Conversion Tests

    [Test]
    public void LocalToMap_CenterOfTile_ReturnsCorrectTileCoord()
    {
        // Arrange: Position at center of tile (1, 1)
        var worldPos = new Vector2(TileSize.X + TileSize.X / 2, TileSize.Y + TileSize.Y / 2);

        // Act
        var tileCoord = _tileMap!.LocalToMap(worldPos);

        // Assert
        tileCoord.ShouldBe(new Vector2I(1, 1), "Center of tile (1,1) should map to (1,1)");
    }
```

**Returns:** `void`

### LocalToMap_EdgeOfTile_ReturnsCorrectTileCoord

```csharp
[Test]
    public void LocalToMap_EdgeOfTile_ReturnsCorrectTileCoord()
    {
        // Arrange: Position at edge of tile (boundary case)
        var worldPos = new Vector2(TileSize.X, TileSize.Y);

        // Act
        var tileCoord = _tileMap!.LocalToMap(worldPos);

        // Assert: Should be tile (1, 1) since position is at the top-left of that tile
        tileCoord.ShouldBe(new Vector2I(1, 1));
    }
```

**Returns:** `void`

### MapToLocal_TileCoord_ReturnsCenterOfTile

```csharp
[Test]
    public void MapToLocal_TileCoord_ReturnsCenterOfTile()
    {
        // Arrange: Tile coordinate
        var tileCoord = new Vector2I(2, 3);

        // Act
        var worldPos = _tileMap!.MapToLocal(tileCoord);

        // Assert: Should return center of the tile
        var expectedCenter = new Vector2(
            tileCoord.X * TileSize.X + TileSize.X / 2,
            tileCoord.Y * TileSize.Y + TileSize.Y / 2
        );
        worldPos.X.ShouldBe(expectedCenter.X, 0.1f, "X should match tile center");
        worldPos.Y.ShouldBe(expectedCenter.Y, 0.1f, "Y should match tile center");
    }
```

**Returns:** `void`

### RoundTrip_LocalToMapToLocal_PreservesTileCenter

```csharp
[Test]
    public void RoundTrip_LocalToMapToLocal_PreservesTileCenter()
    {
        // Arrange: Start at a tile center
        var originalTile = new Vector2I(5, 7);
        
        // Act: Round trip through conversions
        var worldPos = _tileMap!.MapToLocal(originalTile);
        var resultTile = _tileMap.LocalToMap(worldPos);

        // Assert
        resultTile.ShouldBe(originalTile, "Round trip should preserve tile coordinate");
    }
```

**Returns:** `void`

### RectangleShape_Size_IsCorrect

```csharp
#endregion

    #region Shape Detection Tests

    [Test]
    public void RectangleShape_Size_IsCorrect()
    {
        // Arrange
        var shape = new RectangleShape2D();
        shape.Size = new Vector2(64, 32);

        // Act & Assert
        shape.Size.ShouldBe(new Vector2(64, 32));
        
        // Cleanup
        shape.Dispose();
    }
```

**Returns:** `void`

### CollisionShape2D_WithRectangle_HasCorrectShape

```csharp
[Test]
    public void CollisionShape2D_WithRectangle_HasCorrectShape()
    {
        // Arrange
        var collisionShape = new CollisionShape2D();
        var rectShape = new RectangleShape2D();
        rectShape.Size = new Vector2(48, 48);
        collisionShape.Shape = rectShape;
        _testScene.AddChild(collisionShape);

        // Act
        var retrievedShape = collisionShape.Shape as RectangleShape2D;

        // Assert
        retrievedShape.ShouldNotBeNull();
        retrievedShape!.Size.ShouldBe(new Vector2(48, 48));

        // Cleanup
        collisionShape.QueueFree();
    }
```

**Returns:** `void`

### CircleShape_Radius_IsCorrect

```csharp
[Test]
    public void CircleShape_Radius_IsCorrect()
    {
        // Arrange
        var shape = new CircleShape2D();
        shape.Radius = 25.0f;

        // Act & Assert
        shape.Radius.ShouldBe(25.0f);
        
        // Cleanup
        shape.Dispose();
    }
```

**Returns:** `void`

