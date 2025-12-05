---
title: "RayCast2DIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/raycast2dintegrationtests/"
---

# RayCast2DIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class RayCast2DIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for RayCast2D and shape casting.
Tests ray configuration, collision detection, and exclusions.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/RayCast2DIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up RayCast2D Integration Tests");
    }
```

**Returns:** `void`

### RayCast2D_CanBeCreated

```csharp
#region RayCast2D Creation Tests

    [Test]
    public void RayCast2D_CanBeCreated()
    {
        // Act
        var raycast = new RayCast2D();
        _testScene.AddChild(raycast);

        // Assert
        raycast.ShouldNotBeNull();

        // Cleanup
        raycast.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_DefaultEnabled_IsTrue

```csharp
[Test]
    public void RayCast2D_DefaultEnabled_IsTrue()
    {
        // Arrange
        var raycast = new RayCast2D();
        _testScene.AddChild(raycast);

        // Assert
        raycast.Enabled.ShouldBeTrue();

        // Cleanup
        raycast.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_TargetPosition_CanBeSet

```csharp
#endregion

    #region RayCast2D Configuration Tests

    [Test]
    public void RayCast2D_TargetPosition_CanBeSet()
    {
        // Arrange
        var raycast = new RayCast2D();
        _testScene.AddChild(raycast);

        // Act
        raycast.TargetPosition = new Vector2(100, 50);

        // Assert
        raycast.TargetPosition.ShouldBe(new Vector2(100, 50));

        // Cleanup
        raycast.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_Enabled_CanBeDisabled

```csharp
[Test]
    public void RayCast2D_Enabled_CanBeDisabled()
    {
        // Arrange
        var raycast = new RayCast2D();
        _testScene.AddChild(raycast);

        // Act
        raycast.Enabled = false;

        // Assert
        raycast.Enabled.ShouldBeFalse();

        // Cleanup
        raycast.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_ExcludeParent_CanBeSet

```csharp
[Test]
    public void RayCast2D_ExcludeParent_CanBeSet()
    {
        // Arrange
        var raycast = new RayCast2D();
        _testScene.AddChild(raycast);

        // Act
        raycast.ExcludeParent = false;

        // Assert
        raycast.ExcludeParent.ShouldBeFalse();

        // Cleanup
        raycast.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_CollideWithAreas_CanBeEnabled

```csharp
[Test]
    public void RayCast2D_CollideWithAreas_CanBeEnabled()
    {
        // Arrange
        var raycast = new RayCast2D();
        _testScene.AddChild(raycast);

        // Act
        raycast.CollideWithAreas = true;

        // Assert
        raycast.CollideWithAreas.ShouldBeTrue();

        // Cleanup
        raycast.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_CollideWithBodies_CanBeDisabled

```csharp
[Test]
    public void RayCast2D_CollideWithBodies_CanBeDisabled()
    {
        // Arrange
        var raycast = new RayCast2D();
        _testScene.AddChild(raycast);

        // Act
        raycast.CollideWithBodies = false;

        // Assert
        raycast.CollideWithBodies.ShouldBeFalse();

        // Cleanup
        raycast.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_CollisionMask_CanBeSet

```csharp
#endregion

    #region Collision Mask Tests

    [Test]
    public void RayCast2D_CollisionMask_CanBeSet()
    {
        // Arrange
        var raycast = new RayCast2D();
        _testScene.AddChild(raycast);

        // Act
        raycast.CollisionMask = 0b1111;

        // Assert
        raycast.CollisionMask.ShouldBe(0b1111u);

        // Cleanup
        raycast.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_SetCollisionMaskValue_SetsSpecificBit

```csharp
[Test]
    public void RayCast2D_SetCollisionMaskValue_SetsSpecificBit()
    {
        // Arrange
        var raycast = new RayCast2D();
        _testScene.AddChild(raycast);
        raycast.CollisionMask = 0;

        // Act
        raycast.SetCollisionMaskValue(2, true);

        // Assert
        raycast.GetCollisionMaskValue(2).ShouldBeTrue();
        raycast.GetCollisionMaskValue(1).ShouldBeFalse();

        // Cleanup
        raycast.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_IsColliding_ReturnsFalseWhenNoCollision

```csharp
#endregion

    #region Collision Query Tests

    [Test]
    public void RayCast2D_IsColliding_ReturnsFalseWhenNoCollision()
    {
        // Arrange
        var raycast = new RayCast2D();
        _testScene.AddChild(raycast);
        raycast.TargetPosition = new Vector2(100, 0);
        raycast.ForceRaycastUpdate();

        // Assert
        raycast.IsColliding().ShouldBeFalse();

        // Cleanup
        raycast.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_GetCollider_ReturnsNullWhenNoCollision

```csharp
[Test]
    public void RayCast2D_GetCollider_ReturnsNullWhenNoCollision()
    {
        // Arrange
        var raycast = new RayCast2D();
        _testScene.AddChild(raycast);
        raycast.TargetPosition = new Vector2(100, 0);
        raycast.ForceRaycastUpdate();

        // Assert
        raycast.GetCollider().ShouldBeNull();

        // Cleanup
        raycast.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_GetCollisionPoint_ReturnsZeroWhenNoCollision

```csharp
[Test]
    public void RayCast2D_GetCollisionPoint_ReturnsZeroWhenNoCollision()
    {
        // Arrange
        var raycast = new RayCast2D();
        _testScene.AddChild(raycast);
        raycast.TargetPosition = new Vector2(100, 0);
        raycast.ForceRaycastUpdate();

        // Assert
        raycast.GetCollisionPoint().ShouldBe(Vector2.Zero);

        // Cleanup
        raycast.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_GetCollisionNormal_ReturnsZeroWhenNoCollision

```csharp
[Test]
    public void RayCast2D_GetCollisionNormal_ReturnsZeroWhenNoCollision()
    {
        // Arrange
        var raycast = new RayCast2D();
        _testScene.AddChild(raycast);
        raycast.TargetPosition = new Vector2(100, 0);
        raycast.ForceRaycastUpdate();

        // Assert
        raycast.GetCollisionNormal().ShouldBe(Vector2.Zero);

        // Cleanup
        raycast.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_AddException_AddsObjectToExclusions

```csharp
#endregion

    #region Exclusion Tests

    [Test]
    public void RayCast2D_AddException_AddsObjectToExclusions()
    {
        // Arrange
        var raycast = new RayCast2D();
        var body = new CharacterBody2D();
        _testScene.AddChild(raycast);
        _testScene.AddChild(body);

        // Act: Add exception (no immediate verification method, but should not throw)
        raycast.AddException(body);

        // Assert: Method executed without error
        raycast.ShouldNotBeNull();

        // Cleanup
        raycast.QueueFree();
        body.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_RemoveException_RemovesObjectFromExclusions

```csharp
[Test]
    public void RayCast2D_RemoveException_RemovesObjectFromExclusions()
    {
        // Arrange
        var raycast = new RayCast2D();
        var body = new CharacterBody2D();
        _testScene.AddChild(raycast);
        _testScene.AddChild(body);
        raycast.AddException(body);

        // Act
        raycast.RemoveException(body);

        // Assert: Method executed without error
        raycast.ShouldNotBeNull();

        // Cleanup
        raycast.QueueFree();
        body.QueueFree();
    }
```

**Returns:** `void`

### RayCast2D_ClearExceptions_ClearsAllExclusions

```csharp
[Test]
    public void RayCast2D_ClearExceptions_ClearsAllExclusions()
    {
        // Arrange
        var raycast = new RayCast2D();
        var body1 = new CharacterBody2D();
        var body2 = new CharacterBody2D();
        _testScene.AddChild(raycast);
        _testScene.AddChild(body1);
        _testScene.AddChild(body2);
        raycast.AddException(body1);
        raycast.AddException(body2);

        // Act
        raycast.ClearExceptions();

        // Assert: Method executed without error
        raycast.ShouldNotBeNull();

        // Cleanup
        raycast.QueueFree();
        body1.QueueFree();
        body2.QueueFree();
    }
```

**Returns:** `void`

### ShapeCast2D_CanBeCreated

```csharp
#endregion

    #region ShapeCast2D Tests

    [Test]
    public void ShapeCast2D_CanBeCreated()
    {
        // Act
        var shapecast = new ShapeCast2D();
        _testScene.AddChild(shapecast);

        // Assert
        shapecast.ShouldNotBeNull();

        // Cleanup
        shapecast.QueueFree();
    }
```

**Returns:** `void`

### ShapeCast2D_Shape_CanBeAssigned

```csharp
[Test]
    public void ShapeCast2D_Shape_CanBeAssigned()
    {
        // Arrange
        var shapecast = new ShapeCast2D();
        _testScene.AddChild(shapecast);
        var shape = new CircleShape2D();
        shape.Radius = 25.0f;

        // Act
        shapecast.Shape = shape;

        // Assert
        shapecast.Shape.ShouldNotBeNull();
        shapecast.Shape.ShouldBeOfType<CircleShape2D>();

        // Cleanup
        shapecast.QueueFree();
    }
```

**Returns:** `void`

### ShapeCast2D_TargetPosition_CanBeSet

```csharp
[Test]
    public void ShapeCast2D_TargetPosition_CanBeSet()
    {
        // Arrange
        var shapecast = new ShapeCast2D();
        _testScene.AddChild(shapecast);

        // Act
        shapecast.TargetPosition = new Vector2(50, 100);

        // Assert
        shapecast.TargetPosition.ShouldBe(new Vector2(50, 100));

        // Cleanup
        shapecast.QueueFree();
    }
```

**Returns:** `void`

### ShapeCast2D_MaxResults_CanBeSet

```csharp
[Test]
    public void ShapeCast2D_MaxResults_CanBeSet()
    {
        // Arrange
        var shapecast = new ShapeCast2D();
        _testScene.AddChild(shapecast);

        // Act
        shapecast.MaxResults = 5;

        // Assert
        shapecast.MaxResults.ShouldBe(5);

        // Cleanup
        shapecast.QueueFree();
    }
```

**Returns:** `void`

### ShapeCast2D_CollisionResult_IsEmptyWhenNoCollision

```csharp
[Test]
    public void ShapeCast2D_CollisionResult_IsEmptyWhenNoCollision()
    {
        // Arrange
        var shapecast = new ShapeCast2D();
        shapecast.Shape = new CircleShape2D();
        _testScene.AddChild(shapecast);
        shapecast.ForceShapecastUpdate();

        // Assert
        shapecast.GetCollisionCount().ShouldBe(0);

        // Cleanup
        shapecast.QueueFree();
    }
```

**Returns:** `void`

