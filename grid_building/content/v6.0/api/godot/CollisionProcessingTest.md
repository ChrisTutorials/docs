---
title: "CollisionProcessingTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionprocessingtest/"
---

# CollisionProcessingTest

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class CollisionProcessingTest
{
    // Members...
}
```

Collision processing test cases ported from GDScript.
Ports the comprehensive CollisionUtilities test suite that validates:
- Rectangle tile position calculations for collision detection
- Handling of invalid/null tile maps gracefully
- Indicator-shape overlap detection for placement validation
These tests catch utility method failures that could cause issues in higher-level
collision mapping and placement validation tests.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/CollisionProcessingTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Integration.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetRectTilePositions_ValidTileMap_ReturnsPositions

```csharp
#endregion

    #region Test Functions

    /// <summary>
    /// Test rectangle tile position calculations.
    /// Ports the core CollisionUtilities.get_rect_tile_positions test.
    /// </summary>
    [Test]
    public void GetRectTilePositions_ValidTileMap_ReturnsPositions()
    {
        // Arrange
        var mockMap = CreateMockTileMap();
        var centerPos = DEFAULT_POSITION;
        var rectSize = new Vector2(TILE_SIZE, TILE_SIZE); // Single tile

        // Act
        var result = CollisionUtilities.GetRectTilePositions(
            mockMap, centerPos, rectSize);

        // Assert
        AssertArrayNotNullAndType(result, "Should return valid tile positions");

        // Should contain at least the center tile
        AssertContainsPosition(result, ORIGIN_TILE, "Should contain center tile (0,0)");
    }
```

Test rectangle tile position calculations.
Ports the core CollisionUtilities.get_rect_tile_positions test.

**Returns:** `void`

### GetRectTilePositions_InvalidTileMap_ReturnsEmpty

```csharp
/// <summary>
    /// Test handling of invalid tile map.
    /// Ports the error handling test from GDScript.
    /// </summary>
    [Test]
    public void GetRectTilePositions_InvalidTileMap_ReturnsEmpty()
    {
        // Arrange
        TileMapLayer invalidMap = null;
        var centerPos = DEFAULT_POSITION;
        var rectSize = new Vector2(TILE_SIZE, TILE_SIZE);

        // Act
        var result = CollisionUtilities.GetRectTilePositions(
            invalidMap, centerPos, rectSize);

        // Assert
        AssertArrayNotNullAndType(result, "Should handle invalid tile map gracefully");
        result.ShouldBeEmpty("Should return empty array for invalid tile map");
    }
```

Test handling of invalid tile map.
Ports the error handling test from GDScript.

**Returns:** `void`

### DoesIndicatorOverlapShape_ValidShapes_ReturnsBoolean

```csharp
/// <summary>
    /// Test indicator-shape overlap detection.
    /// Ports the collision detection test from GDScript.
    /// </summary>
    [Test]
    public void DoesIndicatorOverlapShape_ValidShapes_ReturnsBoolean()
    {
        // Arrange
        var indicator = CreateMockIndicator(DEFAULT_POSITION);
        var rectShape = CreateRectangleShape(new Vector2(TILE_SIZE, TILE_SIZE));
        indicator.Shape = rectShape;

        var shapeOwner = CreateMockShapeOwner(DEFAULT_POSITION);
        var targetShape = CreateRectangleShape(new Vector2(TILE_SIZE, TILE_SIZE));

        // Act
        var result = CollisionUtilities.DoesIndicatorOverlapShape(
            indicator, targetShape, shapeOwner);

        // Assert
        result.ShouldBeOfType<bool>("Should return boolean result");
    }
```

Test indicator-shape overlap detection.
Ports the collision detection test from GDScript.

**Returns:** `void`

### DoesIndicatorOverlapShape_NullShape_HandlesGracefully

```csharp
/// <summary>
    /// Test indicator-shape overlap with null shapes.
    /// Ports the null handling test from GDScript.
    /// </summary>
    [Test]
    public void DoesIndicatorOverlapShape_NullShape_HandlesGracefully()
    {
        // Arrange
        var indicator = CreateMockIndicator(DEFAULT_POSITION);
        var shapeOwner = CreateMockShapeOwner(DEFAULT_POSITION);

        // Act
        var nullResult = CollisionUtilities.DoesIndicatorOverlapShape(
            indicator, null, shapeOwner);

        // Assert
        nullResult.ShouldBeOfType<bool>("Should handle null target shape gracefully");
    }
```

Test indicator-shape overlap with null shapes.
Ports the null handling test from GDScript.

**Returns:** `void`

### GetRectTilePositions_MultiTile_ReturnsCorrectCount

```csharp
/// <summary>
    /// Test rectangle tile positions with multiple tiles.
    /// Extends the basic test with multi-tile scenarios.
    /// </summary>
    [Test]
    public void GetRectTilePositions_MultiTile_ReturnsCorrectCount()
    {
        // Arrange
        var mockMap = CreateMockTileMap();
        var centerPos = DEFAULT_POSITION;
        var rectSize = new Vector2(TILE_SIZE * 2, TILE_SIZE * 2); // 2x2 tiles

        // Act
        var result = CollisionUtilities.GetRectTilePositions(
            mockMap, centerPos, rectSize);

        // Assert
        AssertArrayNotNullAndType(result, "Should return valid tile positions");
        result.Count().ShouldBeGreaterThanOrEqualTo(4, "2x2 tile area should cover at least 4 tiles");

        // Should contain center tile and surrounding tiles
        AssertContainsPosition(result, ORIGIN_TILE, "Should contain center tile (0,0)");
        AssertContainsPosition(result, new Vector2i(1, 0), "Should contain tile (1,0)");
        AssertContainsPosition(result, new Vector2i(0, 1), "Should contain tile (0,1)");
        AssertContainsPosition(result, new Vector2i(1, 1), "Should contain tile (1,1)");
    }
```

Test rectangle tile positions with multiple tiles.
Extends the basic test with multi-tile scenarios.

**Returns:** `void`

### GetRectTilePositions_OffsetPosition_ReturnsCorrectTiles

```csharp
/// <summary>
    /// Test rectangle tile positions with offset position.
    /// Tests coordinate transformation accuracy.
    /// </summary>
    [Test]
    public void GetRectTilePositions_OffsetPosition_ReturnsCorrectTiles()
    {
        // Arrange
        var mockMap = CreateMockTileMap();
        var centerPos = new Vector2(TILE_SIZE * 1.5f, TILE_SIZE * 1.5f); // Offset to tile (1,1)
        var rectSize = new Vector2(TILE_SIZE, TILE_SIZE); // Single tile

        // Act
        var result = CollisionUtilities.GetRectTilePositions(
            mockMap, centerPos, rectSize);

        // Assert
        AssertArrayNotNullAndType(result, "Should return valid tile positions");
        
        // Should contain tile (1,1) due to position offset
        AssertContainsPosition(result, new Vector2i(1, 1), "Should contain tile (1,1) due to position offset");
    }
```

Test rectangle tile positions with offset position.
Tests coordinate transformation accuracy.

**Returns:** `void`

### DoesIndicatorOverlapShape_NonOverlapping_ReturnsFalse

```csharp
/// <summary>
    /// Test indicator overlap with non-overlapping shapes.
    /// Tests the negative case for overlap detection.
    /// </summary>
    [Test]
    public void DoesIndicatorOverlapShape_NonOverlapping_ReturnsFalse()
    {
        // Arrange
        var indicator = CreateMockIndicator(DEFAULT_POSITION);
        var indicatorShape = CreateRectangleShape(new Vector2(16, 16));
        indicator.Shape = indicatorShape;

        var shapeOwner = CreateMockShapeOwner(new Vector2(100, 100)); // Far away
        var targetShape = CreateRectangleShape(new Vector2(16, 16));

        // Act
        var result = CollisionUtilities.DoesIndicatorOverlapShape(
            indicator, targetShape, shapeOwner);

        // Assert
        result.ShouldBeFalse("Non-overlapping shapes should return false");
    }
```

Test indicator overlap with non-overlapping shapes.
Tests the negative case for overlap detection.

**Returns:** `void`

### DoesIndicatorOverlapShape_PartiallyOverlapping_ReturnsTrue

```csharp
/// <summary>
    /// Test indicator overlap with partially overlapping shapes.
    /// Tests the partial overlap case.
    /// </summary>
    [Test]
    public void DoesIndicatorOverlapShape_PartiallyOverlapping_ReturnsTrue()
    {
        // Arrange
        var indicator = CreateMockIndicator(DEFAULT_POSITION);
        var indicatorShape = CreateRectangleShape(new Vector2(32, 32));
        indicator.Shape = indicatorShape;

        var shapeOwner = CreateMockShapeOwner(new Vector2(16, 16)); // Partially overlapping
        var targetShape = CreateRectangleShape(new Vector2(32, 32));

        // Act
        var result = CollisionUtilities.DoesIndicatorOverlapShape(
            indicator, targetShape, shapeOwner);

        // Assert
        result.ShouldBeTrue("Partially overlapping shapes should return true");
    }
```

Test indicator overlap with partially overlapping shapes.
Tests the partial overlap case.

**Returns:** `void`

### GetRectTilePositions_ZeroSize_ReturnsMinimal

```csharp
/// <summary>
    /// Test rectangle tile positions with zero-size rectangle.
    /// Tests edge case handling.
    /// </summary>
    [Test]
    public void GetRectTilePositions_ZeroSize_ReturnsMinimal()
    {
        // Arrange
        var mockMap = CreateMockTileMap();
        var centerPos = DEFAULT_POSITION;
        var rectSize = Vector2.Zero; // Zero size

        // Act
        var result = CollisionUtilities.GetRectTilePositions(
            mockMap, centerPos, rectSize);

        // Assert
        AssertArrayNotNullAndType(result, "Should handle zero size gracefully");
        
        // Zero size should still result in at least one tile at the center position
        result.Count().ShouldBeGreaterThanOrEqualTo(1, "Zero size should still register at least one tile");
        AssertContainsPosition(result, ORIGIN_TILE, "Should contain center tile even with zero size");
    }
```

Test rectangle tile positions with zero-size rectangle.
Tests edge case handling.

**Returns:** `void`

### GetRectTilePositions_LargeRectangle_ReturnsManyTiles

```csharp
/// <summary>
    /// Test rectangle tile positions with very large rectangle.
    /// Tests performance and bounds handling.
    /// </summary>
    [Test]
    public void GetRectTilePositions_LargeRectangle_ReturnsManyTiles()
    {
        // Arrange
        var mockMap = CreateMockTileMap();
        var centerPos = DEFAULT_POSITION;
        var rectSize = new Vector2(TILE_SIZE * 10, TILE_SIZE * 10); // 10x10 tiles

        // Act
        var result = CollisionUtilities.GetRectTilePositions(
            mockMap, centerPos, rectSize);

        // Assert
        AssertArrayNotNullAndType(result, "Should handle large rectangle gracefully");
        result.Count().ShouldBeGreaterThanOrEqualTo(100, "10x10 tile area should cover at least 100 tiles");
    }
```

Test rectangle tile positions with very large rectangle.
Tests performance and bounds handling.

**Returns:** `void`

