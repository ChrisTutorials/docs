---
title: "CollisionExclusionTest"
description: "C# integration tests for collision exclusion utilities.
Requires Godot runtime - uses Godot.Vector2 and other types.
Mirrors GDScript tests in collision_exclusion_test_helpers.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/collisionexclusiontest/"
---

# CollisionExclusionTest

```csharp
GridBuilding.Godot.Tests.GoDotTest
class CollisionExclusionTest
{
    // Members...
}
```

C# integration tests for collision exclusion utilities.
Requires Godot runtime - uses Godot.Vector2 and other types.
Mirrors GDScript tests in collision_exclusion_test_helpers.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/CollisionExclusionTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CollisionsCheckRule_WithDefaultConfiguration_ShouldInitializeCorrectly

```csharp
[Fact]
    public void CollisionsCheckRule_WithDefaultConfiguration_ShouldInitializeCorrectly()
    {
        // Test default rule configuration
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CollisionsCheckRule_WithCustomConfiguration_ShouldSetupCorrectly

```csharp
[Theory]
    [InlineData(1, 1, false)]
    [InlineData(2, 4, true)]
    [InlineData(8, 16, false)]
    [InlineData(32, 64, true)]
    public void CollisionsCheckRule_WithCustomConfiguration_ShouldSetupCorrectly(
        int collisionMask, int collisionLayer, bool passOnCollision)
    {
        // Arrange
        var rule = new CollisionsCheckRule
        {
            CollisionMask = collisionMask,
            CollisionLayer = collisionLayer,
            PassOnCollision = passOnCollision
        };

        // Act
        var setupIssues = rule.Setup(_targetingState);

        // Assert
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `int collisionMask`
- `int collisionLayer`
- `bool passOnCollision`

### CreateCollisionBody_WithStandardParameters_ShouldCreateValidBody

```csharp
[Fact]
    public void CreateCollisionBody_WithStandardParameters_ShouldCreateValidBody()
    {
        // Arrange
        var position = new Vector2(100, 100);
        var size = new Vector2(32, 32);
        var collisionLayer = 1;

        // Act
        var body = CollisionExclusionTestHelpers.CreateCollisionBody(
            position, size, collisionLayer);

        // Assert
        ;
        ;
        Assert.IsType<CollisionShape2D>(body.GetChild(0));
        
        var shape = (CollisionShape2D)body.GetChild(0);
        Assert.IsType<RectangleShape2D>(shape.Shape);
        
        var rectShape = (RectangleShape2D)shape.Shape;
        ;
    }
```

**Returns:** `void`

### CreateCollisionBody_WithCustomLayer_ShouldRespectLayerSettings

```csharp
[Fact]
    public void CreateCollisionBody_WithCustomLayer_ShouldRespectLayerSettings()
    {
        // Arrange
        var customLayer = 4;

        // Act
        var body = CollisionExclusionTestHelpers.CreateCollisionBody(
            Vector2.Zero, Vector2.One * 32, customLayer);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### ExclusionPattern_WithNoCollisions_ShouldPass

```csharp
[Fact]
    public void ExclusionPattern_WithNoCollisions_ShouldPass()
    {
        // Arrange
        var body1 = CollisionExclusionTestHelpers.CreateCollisionBody(
            new Vector2(0, 0), new Vector2(32, 32), 1);
        var body2 = CollisionExclusionTestHelpers.CreateCollisionBody(
            new Vector2(100, 100), new Vector2(32, 32), 2);

        // Act
        var isColliding = _rule.CheckCollision(body1, body2);

        // Assert
        ;
    }
```

**Returns:** `void`

### ExclusionPattern_WithOverlappingBodies_ShouldDetectCollision

```csharp
[Fact]
    public void ExclusionPattern_WithOverlappingBodies_ShouldDetectCollision()
    {
        // Arrange
        var body1 = CollisionExclusionTestHelpers.CreateCollisionBody(
            new Vector2(0, 0), new Vector2(32, 32), 1);
        var body2 = CollisionExclusionTestHelpers.CreateCollisionBody(
            new Vector2(16, 16), new Vector2(32, 32), 1);

        // Act
        var isColliding = _rule.CheckCollision(body1, body2);

        // Assert
        ;
    }
```

**Returns:** `void`

### ExclusionClearingPattern_WithClearMethod_ShouldRemoveExclusions

```csharp
[Fact]
    public void ExclusionClearingPattern_WithClearMethod_ShouldRemoveExclusions()
    {
        // Arrange
        var body = CollisionExclusionTestHelpers.CreateCollisionBody(
            Vector2.Zero, Vector2.One * 32, 1);
        _rule.AddExclusion(body);

        // Act
        _rule.ClearExclusions();

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### ContinuousExclusionPattern_WithMultipleBodies_ShouldHandleCorrectly

```csharp
[Fact]
    public void ContinuousExclusionPattern_WithMultipleBodies_ShouldHandleCorrectly()
    {
        // Arrange
        var bodies = new CharacterBody2D[3];
        for (int i = 0; i < 3; i++)
        {
            bodies[i] = CollisionExclusionTestHelpers.CreateCollisionBody(
                new Vector2(i * 50, 0), Vector2.One * 32, 1);
        }

        // Act - Add continuous exclusion
        _rule.AddContinuousExclusion(bodies);

        // Assert
        ;
        foreach (var body in bodies)
        {
            ;
        }
    }
```

**Returns:** `void`

### CollisionDetection_WithVariousPositions_ShouldDetectCorrectly

```csharp
[Theory]
    [InlineData(0, 0, 32, 32, true)]   // Overlapping at origin
    [InlineData(100, 100, 32, 32, false)] // Isolated bodies
    [InlineData(0, 0, 64, 64, true)]   // Larger overlapping area
    [InlineData(-16, -16, 32, 32, true)] // Partial overlap
    public void CollisionDetection_WithVariousPositions_ShouldDetectCorrectly(
        float x1, float y1, float size1, float size2, bool expectedCollision)
    {
        // Arrange
        var body1 = CollisionExclusionTestHelpers.CreateCollisionBody(
            new Vector2(0, 0), new Vector2(size1, size1), 1);
        var body2 = CollisionExclusionTestHelpers.CreateCollisionBody(
            new Vector2(x1, y1), new Vector2(size2, size2), 1);

        // Act
        var isColliding = _rule.CheckCollision(body1, body2);

        // Assert
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `float x1`
- `float y1`
- `float size1`
- `float size2`
- `bool expectedCollision`

### SetupIssues_WithInvalidConfiguration_ShouldReportProblems

```csharp
[Fact]
    public void SetupIssues_WithInvalidConfiguration_ShouldReportProblems()
    {
        // Arrange
        var invalidRule = new CollisionsCheckRule
        {
            CollisionMask = -1, // Invalid mask
        };

        // Act
        var setupIssues = invalidRule.Setup(_targetingState);

        // Assert
        ;
        Assert.NotEmpty(setupIssues);
        ;
    }
```

**Returns:** `void`

### PassOnCollision_WithTrueSetting_ShouldInvertBehavior

```csharp
[Fact]
    public void PassOnCollision_WithTrueSetting_ShouldInvertBehavior()
    {
        // Arrange
        var passRule = new CollisionsCheckRule { PassOnCollision = true };
        var failRule = new CollisionsCheckRule { PassOnCollision = false };
        
        var body1 = CollisionExclusionTestHelpers.CreateCollisionBody(
            Vector2.Zero, Vector2.One * 32, 1);
        var body2 = CollisionExclusionTestHelpers.CreateCollisionBody(
            Vector2.One * 16, Vector2.One * 32, 1);

        // Act
        var passResult = passRule.ValidateCollision(body1, body2);
        var failResult = failRule.ValidateCollision(body1, body2);

        // Assert
        ; // Pass on collision
        ; // Fail on collision
    }
```

**Returns:** `void`

