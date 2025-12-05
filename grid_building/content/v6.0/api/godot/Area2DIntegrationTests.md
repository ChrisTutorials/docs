---
title: "Area2DIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/area2dintegrationtests/"
---

# Area2DIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class Area2DIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for Area2D and collision detection.
Tests body/area detection, monitoring, and collision shapes.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Area2DIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up Area2D Integration Tests");
    }
```

**Returns:** `void`

### Area2D_CanBeCreated

```csharp
#region Area2D Creation Tests

    [Test]
    public void Area2D_CanBeCreated()
    {
        // Act
        var area = new Area2D();
        _testScene.AddChild(area);

        // Assert
        area.ShouldNotBeNull();

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_Monitoring_DefaultIsTrue

```csharp
[Test]
    public void Area2D_Monitoring_DefaultIsTrue()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);

        // Assert
        area.Monitoring.ShouldBeTrue();

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_Monitorable_DefaultIsTrue

```csharp
[Test]
    public void Area2D_Monitorable_DefaultIsTrue()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);

        // Assert
        area.Monitorable.ShouldBeTrue();

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_CollisionLayer_CanBeSet

```csharp
#endregion

    #region Collision Layer/Mask Tests

    [Test]
    public void Area2D_CollisionLayer_CanBeSet()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);

        // Act
        area.CollisionLayer = 0b0101;

        // Assert
        area.CollisionLayer.ShouldBe(0b0101u);

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_CollisionMask_CanBeSet

```csharp
[Test]
    public void Area2D_CollisionMask_CanBeSet()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);

        // Act
        area.CollisionMask = 0b1010;

        // Assert
        area.CollisionMask.ShouldBe(0b1010u);

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_SetCollisionLayerValue_SetsSpecificBit

```csharp
[Test]
    public void Area2D_SetCollisionLayerValue_SetsSpecificBit()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);
        area.CollisionLayer = 0;

        // Act
        area.SetCollisionLayerValue(3, true);

        // Assert
        area.GetCollisionLayerValue(3).ShouldBeTrue();
        area.GetCollisionLayerValue(1).ShouldBeFalse();

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_SetCollisionMaskValue_SetsSpecificBit

```csharp
[Test]
    public void Area2D_SetCollisionMaskValue_SetsSpecificBit()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);
        area.CollisionMask = 0;

        // Act
        area.SetCollisionMaskValue(5, true);

        // Assert
        area.GetCollisionMaskValue(5).ShouldBeTrue();
        area.GetCollisionMaskValue(1).ShouldBeFalse();

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_Monitoring_CanBeDisabled

```csharp
#endregion

    #region Monitoring Configuration Tests

    [Test]
    public void Area2D_Monitoring_CanBeDisabled()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);

        // Act
        area.Monitoring = false;

        // Assert
        area.Monitoring.ShouldBeFalse();

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_Monitorable_CanBeDisabled

```csharp
[Test]
    public void Area2D_Monitorable_CanBeDisabled()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);

        // Act
        area.Monitorable = false;

        // Assert
        area.Monitorable.ShouldBeFalse();

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_Priority_CanBeSet

```csharp
[Test]
    public void Area2D_Priority_CanBeSet()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);

        // Act
        area.Priority = 10;

        // Assert
        area.Priority.ShouldBe(10);

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_WithCollisionShape_HasShape

```csharp
#endregion

    #region Collision Shape Configuration Tests

    [Test]
    public void Area2D_WithCollisionShape_HasShape()
    {
        // Arrange
        var area = new Area2D();
        var collisionShape = new CollisionShape2D();
        var shape = new RectangleShape2D();
        shape.Size = new Vector2(50, 50);
        collisionShape.Shape = shape;
        area.AddChild(collisionShape);
        _testScene.AddChild(area);

        // Assert
        area.GetChildCount().ShouldBe(1);
        area.GetChild(0).ShouldBeOfType<CollisionShape2D>();

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### CollisionShape2D_Disabled_CanBeSet

```csharp
[Test]
    public void CollisionShape2D_Disabled_CanBeSet()
    {
        // Arrange
        var collisionShape = new CollisionShape2D();
        _testScene.AddChild(collisionShape);

        // Act
        collisionShape.Disabled = true;

        // Assert
        collisionShape.Disabled.ShouldBeTrue();

        // Cleanup
        collisionShape.QueueFree();
    }
```

**Returns:** `void`

### CollisionShape2D_OneWayCollision_CanBeEnabled

```csharp
[Test]
    public void CollisionShape2D_OneWayCollision_CanBeEnabled()
    {
        // Arrange
        var collisionShape = new CollisionShape2D();
        _testScene.AddChild(collisionShape);

        // Act
        collisionShape.OneWayCollision = true;

        // Assert
        collisionShape.OneWayCollision.ShouldBeTrue();

        // Cleanup
        collisionShape.QueueFree();
    }
```

**Returns:** `void`

### Area2D_GravitySpaceOverride_CanBeSet

```csharp
#endregion

    #region Physics Override Tests

    [Test]
    public void Area2D_GravitySpaceOverride_CanBeSet()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);

        // Act
        area.GravitySpaceOverride = Area2D.SpaceOverride.Replace;

        // Assert
        area.GravitySpaceOverride.ShouldBe(Area2D.SpaceOverride.Replace);

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_GravityPoint_CanBeEnabled

```csharp
[Test]
    public void Area2D_GravityPoint_CanBeEnabled()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);

        // Act
        area.GravityPoint = true;

        // Assert
        area.GravityPoint.ShouldBeTrue();

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_Gravity_CanBeSet

```csharp
[Test]
    public void Area2D_Gravity_CanBeSet()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);

        // Act
        area.Gravity = 500.0f;

        // Assert
        area.Gravity.ShouldBe(500.0f);

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_GravityDirection_CanBeSet

```csharp
[Test]
    public void Area2D_GravityDirection_CanBeSet()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);

        // Act
        area.GravityDirection = new Vector2(1, 0);

        // Assert
        area.GravityDirection.ShouldBe(new Vector2(1, 0));

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_LinearDamp_CanBeSet

```csharp
[Test]
    public void Area2D_LinearDamp_CanBeSet()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);

        // Act
        area.LinearDamp = 1.5f;

        // Assert
        area.LinearDamp.ShouldBe(1.5f);

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_AngularDamp_CanBeSet

```csharp
[Test]
    public void Area2D_AngularDamp_CanBeSet()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);

        // Act
        area.AngularDamp = 2.0f;

        // Assert
        area.AngularDamp.ShouldBe(2.0f);

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_GetOverlappingAreas_ReturnsEmptyWhenNone

```csharp
#endregion

    #region Query Tests

    [Test]
    public void Area2D_GetOverlappingAreas_ReturnsEmptyWhenNone()
    {
        // Arrange
        var area = new Area2D();
        var shape = new CollisionShape2D();
        shape.Shape = new RectangleShape2D();
        area.AddChild(shape);
        _testScene.AddChild(area);

        // Act
        var overlapping = area.GetOverlappingAreas();

        // Assert: No overlapping areas
        overlapping.Count.ShouldBe(0);

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_GetOverlappingBodies_ReturnsEmptyWhenNone

```csharp
[Test]
    public void Area2D_GetOverlappingBodies_ReturnsEmptyWhenNone()
    {
        // Arrange
        var area = new Area2D();
        var shape = new CollisionShape2D();
        shape.Shape = new RectangleShape2D();
        area.AddChild(shape);
        _testScene.AddChild(area);

        // Act
        var overlapping = area.GetOverlappingBodies();

        // Assert: No overlapping bodies
        overlapping.Count.ShouldBe(0);

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_HasOverlappingAreas_ReturnsFalseWhenNone

```csharp
[Test]
    public void Area2D_HasOverlappingAreas_ReturnsFalseWhenNone()
    {
        // Arrange
        var area = new Area2D();
        var shape = new CollisionShape2D();
        shape.Shape = new RectangleShape2D();
        area.AddChild(shape);
        _testScene.AddChild(area);

        // Act
        var hasOverlapping = area.HasOverlappingAreas();

        // Assert
        hasOverlapping.ShouldBeFalse();

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_HasOverlappingBodies_ReturnsFalseWhenNone

```csharp
[Test]
    public void Area2D_HasOverlappingBodies_ReturnsFalseWhenNone()
    {
        // Arrange
        var area = new Area2D();
        var shape = new CollisionShape2D();
        shape.Shape = new RectangleShape2D();
        area.AddChild(shape);
        _testScene.AddChild(area);

        // Act
        var hasOverlapping = area.HasOverlappingBodies();

        // Assert
        hasOverlapping.ShouldBeFalse();

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

