---
title: "CollisionScenarioBuilderTest"
description: "Collision scenario builder test cases ported from GDScript.
Tests the CollisionScenarioBuilder2D functionality for building test parameters
from collision objects, including validation and resource management.
This test suite validates:
- Test setup creation for CollisionObject2D and CollisionPolygon2D
- Shape processing and validation
- Resource management and cleanup
- Comprehensive issue reporting"
weight: 20
url: "/gridbuilding/v6-0/api/godot/collisionscenariobuildertest/"
---

# CollisionScenarioBuilderTest

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class CollisionScenarioBuilderTest
{
    // Members...
}
```

Collision scenario builder test cases ported from GDScript.
Tests the CollisionScenarioBuilder2D functionality for building test parameters
from collision objects, including validation and resource management.
This test suite validates:
- Test setup creation for CollisionObject2D and CollisionPolygon2D
- Shape processing and validation
- Resource management and cleanup
- Comprehensive issue reporting

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/CollisionScenarioBuilderTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Integration.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CreateTestSetupsForCollisionOwners_ValidOwners_ReturnsSetups

```csharp
#endregion

    #region Test Functions

    /// <summary>
    /// Test creating test setups for collision owners.
    /// Ports the core CollisionScenarioBuilder2D functionality test.
    /// </summary>
    [Test]
    public void CreateTestSetupsForCollisionOwners_ValidOwners_ReturnsSetups()
    {
        // Arrange
        var collisionOwners = CreateMockCollisionOwners(2);
        var tileMap = CreateMockTileMap();
        var positioner = CreateMockPositioner();

        // Act
        var result = CollisionScenarioBuilder2D.CreateTestSetupsForCollisionOwners(
            collisionOwners, tileMap, positioner);

        // Assert
        result.ShouldNotBeNull("Should return test setups");
        result.Count.ShouldBeGreaterThanOrEqualTo(2, "Should create setups for all collision owners");
        
        // Each setup should have valid properties
        foreach (var setup in result)
        {
            setup.ShapeOwner.ShouldNotBeNull("Setup should have a shape owner");
            setup.TestingRect.Size.X.ShouldBeGreaterThan(0, "Testing rect should have positive size");
            setup.TestingRect.Size.Y.ShouldBeGreaterThan(0, "Testing rect should have positive size");
        }
    }
```

Test creating test setups for collision owners.
Ports the core CollisionScenarioBuilder2D functionality test.

**Returns:** `void`

### CreateTestSetupsFromTestNode_ValidNode_ReturnsSetups

```csharp
/// <summary>
    /// Test creating test setups from test node.
    /// Tests the alternative factory method.
    /// </summary>
    [Test]
    public void CreateTestSetupsFromTestNode_ValidNode_ReturnsSetups()
    {
        // Arrange
        var testNode = CreateMockCollisionObject2D();
        var tileMap = CreateMockTileMap();
        var positioner = CreateMockPositioner();

        // Act
        var result = CollisionScenarioBuilder2D.CreateTestSetupsFromTestNode(
            testNode, tileMap, positioner);

        // Assert
        result.ShouldNotBeNull("Should return test setups");
        result.Count.ShouldBeGreaterThan(0, "Should create at least one setup");
        
        // Setup should have valid properties
        var setup = result.First();
        setup.ShapeOwner.ShouldNotBeNull("Setup should have a shape owner");
        setup.TestingRect.Size.X.ShouldBeGreaterThan(0, "Testing rect should have positive size");
    }
```

Test creating test setups from test node.
Tests the alternative factory method.

**Returns:** `void`

### TestSetupValidation_ValidSetup_ReturnsNoIssues

```csharp
/// <summary>
    /// Test setup validation.
    /// Tests the validation functionality of test setups.
    /// </summary>
    [Test]
    public void TestSetupValidation_ValidSetup_ReturnsNoIssues()
    {
        // Arrange
        var collisionOwners = CreateMockCollisionOwners(1);
        var tileMap = CreateMockTileMap();
        var positioner = CreateMockPositioner();

        var setups = CollisionScenarioBuilder2D.CreateTestSetupsForCollisionOwners(
            collisionOwners, tileMap, positioner);
        var setup = setups.First();

        // Act
        var validationIssues = setup.Validate();

        // Assert
        validationIssues.ShouldBeEmpty("Valid setup should have no validation issues");
    }
```

Test setup validation.
Tests the validation functionality of test setups.

**Returns:** `void`

### TestSetupValidation_InvalidSetup_ReturnsIssues

```csharp
/// <summary>
    /// Test setup validation with invalid data.
    /// Tests validation error detection.
    /// </summary>
    [Test]
    public void TestSetupValidation_InvalidSetup_ReturnsIssues()
    {
        // Arrange - create setup with missing required data
        var setup = new RectCollisionTestingSetup();
        // Intentionally leave ShapeOwner null to trigger validation

        // Act
        var validationIssues = setup.Validate();

        // Assert
        validationIssues.ShouldNotBeEmpty("Invalid setup should have validation issues");
        validationIssues.ShouldContain(issue => 
            issue.Contains("ShapeOwner") || issue.ToLower().Contains("null"),
            "Should report missing ShapeOwner");
    }
```

Test setup validation with invalid data.
Tests validation error detection.

**Returns:** `void`

### FreeTestingNodes_ValidSetup_CleansUpResources

```csharp
/// <summary>
    /// Test resource cleanup.
    /// Tests the FreeTestingNodes functionality.
    /// </summary>
    [Test]
    public void FreeTestingNodes_ValidSetup_CleansUpResources()
    {
        // Arrange
        var collisionOwners = CreateMockCollisionOwners(1);
        var tileMap = CreateMockTileMap();
        var positioner = CreateMockPositioner();

        var setups = CollisionScenarioBuilder2D.CreateTestSetupsForCollisionOwners(
            collisionOwners, tileMap, positioner);
        var setup = setups.First();

        // Verify testing nodes exist
        var initialTestingArea = setup.TestingArea;
        var initialTestingShape = setup.TestingCollisionShape;

        // Act
        setup.FreeTestingNodes();

        // Assert
        // After cleanup, testing nodes should be null or queued for deletion
        // Note: In GoDotTest, we can't easily test the actual queueing, but we can verify the method runs without error
        setup.TestingArea.ShouldBeNull("TestingArea should be null after cleanup");
        setup.TestingCollisionShape.ShouldBeNull("TestingCollisionShape should be null after cleanup");
    }
```

Test resource cleanup.
Tests the FreeTestingNodes functionality.

**Returns:** `void`

### CreateTestSetupsForCollisionOwners_PolygonShapes_ReturnsSetups

```csharp
/// <summary>
    /// Test with CollisionPolygon2D shapes.
    /// Tests polygon-specific processing.
    /// </summary>
    [Test]
    public void CreateTestSetupsForCollisionOwners_PolygonShapes_ReturnsSetups()
    {
        // Arrange
        var polygon = CreateMockCollisionPolygon2D();
        var collisionOwners = new List<Node2D> { polygon };
        var tileMap = CreateMockTileMap();
        var positioner = CreateMockPositioner();

        // Act
        var result = CollisionScenarioBuilder2D.CreateTestSetupsForCollisionOwners(
            collisionOwners, tileMap, positioner);

        // Assert
        result.ShouldNotBeNull("Should return test setups for polygon shapes");
        result.Count.ShouldBeGreaterThan(0, "Should create setup for polygon shape");
        
        var setup = result.First();
        setup.ShapeOwner.ShouldNotBeNull("Setup should have polygon as shape owner");
        setup.TestingRect.Size.X.ShouldBeGreaterThan(0, "Testing rect should have positive size");
    }
```

Test with CollisionPolygon2D shapes.
Tests polygon-specific processing.

**Returns:** `void`

### CreateTestSetupsForCollisionOwners_EmptyList_ReturnsEmpty

```csharp
/// <summary>
    /// Test with empty collision owners list.
    /// Tests edge case handling.
    /// </summary>
    [Test]
    public void CreateTestSetupsForCollisionOwners_EmptyList_ReturnsEmpty()
    {
        // Arrange
        var collisionOwners = new List<Node2D>();
        var tileMap = CreateMockTileMap();
        var positioner = CreateMockPositioner();

        // Act
        var result = CollisionScenarioBuilder2D.CreateTestSetupsForCollisionOwners(
            collisionOwners, tileMap, positioner);

        // Assert
        result.ShouldNotBeNull("Should return empty list, not null");
        result.ShouldBeEmpty("Should return empty list for no collision owners");
    }
```

Test with empty collision owners list.
Tests edge case handling.

**Returns:** `void`

### CreateTestSetupsForCollisionOwners_NullTileMap_HandlesGracefully

```csharp
/// <summary>
    /// Test with null tile map.
    /// Tests error handling for invalid parameters.
    /// </summary>
    [Test]
    public void CreateTestSetupsForCollisionOwners_NullTileMap_HandlesGracefully()
    {
        // Arrange
        var collisionOwners = CreateMockCollisionOwners(1);
        TileMapLayer nullTileMap = null;
        var positioner = CreateMockPositioner();

        // Act & Assert - should not throw exception
        Should.NotThrow(() => 
        {
            var result = CollisionScenarioBuilder2D.CreateTestSetupsForCollisionOwners(
                collisionOwners, nullTileMap, positioner);
            
            // Should return empty or handle gracefully
            result.ShouldNotBeNull("Should return result even with null tile map");
        });
    }
```

Test with null tile map.
Tests error handling for invalid parameters.

**Returns:** `void`

### CreateTestSetupsForCollisionOwners_NullPositioner_HandlesGracefully

```csharp
/// <summary>
    /// Test with null positioner.
    /// Tests error handling for invalid parameters.
    /// </summary>
    [Test]
    public void CreateTestSetupsForCollisionOwners_NullPositioner_HandlesGracefully()
    {
        // Arrange
        var collisionOwners = CreateMockCollisionOwners(1);
        var tileMap = CreateMockTileMap();
        Node2D nullPositioner = null;

        // Act & Assert - should not throw exception
        Should.NotThrow(() => 
        {
            var result = CollisionScenarioBuilder2D.CreateTestSetupsForCollisionOwners(
                collisionOwners, tileMap, nullPositioner);
            
            // Should return empty or handle gracefully
            result.ShouldNotBeNull("Should return result even with null positioner");
        });
    }
```

Test with null positioner.
Tests error handling for invalid parameters.

**Returns:** `void`

### CreateTestSetupsForCollisionOwners_MultiplePositions_ReturnsCorrectSetups

```csharp
/// <summary>
    /// Test multiple collision owners with different positions.
    /// Tests coordinate handling accuracy.
    /// </summary>
    [Test]
    public void CreateTestSetupsForCollisionOwners_MultiplePositions_ReturnsCorrectSetups()
    {
        // Arrange
        var collisionOwners = new List<Node2D>();
        for (int i = 0; i < 3; i++)
        {
            var owner = new Node2D();
            owner.Position = new Vector2(i * TILE_SIZE * 2, i * TILE_SIZE);
            TestScene.AddChild(owner);
            collisionOwners.Add(owner);
        }

        var tileMap = CreateMockTileMap();
        var positioner = CreateMockPositioner();

        // Act
        var result = CollisionScenarioBuilder2D.CreateTestSetupsForCollisionOwners(
            collisionOwners, tileMap, positioner);

        // Assert
        result.Count.ShouldBe(3, "Should create setup for each collision owner");
        
        // Each setup should have different testing rectangles based on position
        var distinctRects = result.Select(setup => setup.TestingRect.Position).Distinct().ToList();
        distinctRects.Count.ShouldBe(3, "Each setup should have distinct testing rectangle position");
    }
```

Test multiple collision owners with different positions.
Tests coordinate handling accuracy.

**Returns:** `void`

### ComprehensiveScenarioBuilding_MixedShapes_ReturnsCompleteSetups

```csharp
/// <summary>
    /// Test comprehensive scenario building.
    /// Tests the complete workflow with multiple shape types.
    /// </summary>
    [Test]
    public void ComprehensiveScenarioBuilding_MixedShapes_ReturnsCompleteSetups()
    {
        // Arrange
        var collisionObj = CreateMockCollisionObject2D();
        var collisionPoly = CreateMockCollisionPolygon2D();
        var collisionOwners = new List<Node2D> { collisionObj, collisionPoly };
        
        var tileMap = CreateMockTileMap();
        var positioner = CreateMockPositioner();

        // Act
        var result = CollisionScenarioBuilder2D.CreateTestSetupsForCollisionOwners(
            collisionOwners, tileMap, positioner);

        // Assert
        result.ShouldNotBeNull("Should return test setups");
        result.Count.ShouldBe(2, "Should create setup for each collision owner");
        
        // All setups should be valid
        foreach (var setup in result)
        {
            setup.ShapeOwner.ShouldNotBeNull("Setup should have a shape owner");
            setup.TestingRect.Size.X.ShouldBeGreaterThan(0, "Testing rect should have positive size");
            setup.TestingRect.Size.Y.ShouldBeGreaterThan(0, "Testing rect should have positive size");
            
            // Validation should pass
            var validationIssues = setup.Validate();
            validationIssues.ShouldBeEmpty("Setup should be valid");
        }
    }
```

Test comprehensive scenario building.
Tests the complete workflow with multiple shape types.

**Returns:** `void`

