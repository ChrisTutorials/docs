---
title: "CollisionUtilitiesTest"
description: "Unit tests for CollisionUtilities functionality.
This test suite validates the CollisionUtilities class functionality that supports
collision detection and mapping operations in the grid building system. It tests:
- Rectangle tile position calculations for collision detection
- Handling of invalid/null tile maps gracefully
- Indicator-shape overlap detection for placement validation
These tests catch utility method failures that could cause issues in higher-level
collision mapping and placement validation tests."
weight: 20
url: "/gridbuilding/v6-0/api/godot/collisionutilitiestest/"
---

# CollisionUtilitiesTest

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class CollisionUtilitiesTest
{
    // Members...
}
```

Unit tests for CollisionUtilities functionality.
This test suite validates the CollisionUtilities class functionality that supports
collision detection and mapping operations in the grid building system. It tests:
- Rectangle tile position calculations for collision detection
- Handling of invalid/null tile maps gracefully
- Indicator-shape overlap detection for placement validation
These tests catch utility method failures that could cause issues in higher-level
collision mapping and placement validation tests.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/CollisionUtilitiesTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Integration.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        // One-time setup if needed
    }
```

**Returns:** `void`

### Setup

```csharp
[Setup]
    public void Setup()
    {
        _targetingState = new GridTargetingState(new GBOwnerContext(null));
    }
```

**Returns:** `void`

### Cleanup

```csharp
[Cleanup]
    public void Cleanup()
    {
        // Cleanup after each test
        _targetingState = null;
    }
```

**Returns:** `void`

### CollisionUtilities_RectTilePositions_ReturnsValidPositions

```csharp
#endregion

    #region Test Functions

    [Test]
    public void CollisionUtilities_RectTilePositions_ReturnsValidPositions()
    {
        // Create and setup mock tile map
        var mockMap = CreateMockTileMap();
        SetupTargetingStateWithMap(mockMap);

        // Test rectangle at origin
        var centerPos = DEFAULT_POSITION;
        var rectSize = TILE_SIZE; // Single tile

        var result = CollisionUtilities.GetRectTilePositions(
            _targetingState!.TargetMap!, centerPos, rectSize
        );
        
        AssertArrayNotNullAndType(result, "Should return valid tile positions");

        // Should contain at least the center tile
        AssertContainsPosition(result, ORIGIN_TILE, "Should contain center tile (0,0)");
    }
```

**Returns:** `void`

### CollisionUtilities_InvalidTileMap_HandlesGracefully

```csharp
[Test]
    public void CollisionUtilities_InvalidTileMap_HandlesGracefully()
    {
        // Set up targeting state with invalid map
        _targetingState!.TargetMap = null;

        var centerPos = DEFAULT_POSITION;
        var rectSize = TILE_SIZE;

        var result = CollisionUtilities.GetRectTilePositions(
            _targetingState.TargetMap!, centerPos, rectSize
        );
        
        AssertArrayNotNullAndType(result, "Should handle invalid tile map gracefully");
        result.ShouldBeEmpty("Should return empty array for invalid tile map");
    }
```

**Returns:** `void`

### CollisionUtilities_IndicatorOverlap_ReturnsBoolean

```csharp
[Test]
    public void CollisionUtilities_IndicatorOverlap_ReturnsBoolean()
    {
        // Create mock indicator with rectangle shape
        var indicator = CreateMockIndicator(DEFAULT_POSITION);
        var rectShape = CreateRectangleShape(TILE_SIZE);
        indicator.Shape = rectShape;

        // Create mock shape owner
        var shapeOwner = CreateMockShapeOwner(DEFAULT_POSITION);
        var targetShape = CreateRectangleShape(TILE_SIZE);

        // Test overlapping shapes
        var result = CollisionUtilities.DoesIndicatorOverlapShape(
            indicator, targetShape, shapeOwner
        );
        
        result.ShouldBeOfType<bool>("Should return boolean result");

        // Test with null shapes (should not crash)
        var nullResult = CollisionUtilities.DoesIndicatorOverlapShape(
            indicator, null, shapeOwner
        );
        
        nullResult.ShouldBeOfType<bool>("Should handle null target shape gracefully");
    }
```

**Returns:** `void`

