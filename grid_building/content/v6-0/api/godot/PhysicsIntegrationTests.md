---
title: "PhysicsIntegrationTests"
description: "GoDotTest integration tests for physics and collision shapes.
Tests StaticBody2D, CollisionShape2D, and shape detection."
weight: 20
url: "/gridbuilding/v6-0/api/godot/physicsintegrationtests/"
---

# PhysicsIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class PhysicsIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for physics and collision shapes.
Tests StaticBody2D, CollisionShape2D, and shape detection.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/PhysicsIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up Physics Integration Tests");
    }
```

**Returns:** `void`

### CollisionShape2D_WithRectangle_HasCorrectSize

```csharp
#region CollisionShape2D Tests

    [Test]
    public void CollisionShape2D_WithRectangle_HasCorrectSize()
    {
        // Arrange
        var body = new StaticBody2D();
        var shape = new CollisionShape2D();
        var rectShape = new RectangleShape2D();
        rectShape.Size = new Vector2(64, 32);
        shape.Shape = rectShape;
        body.AddChild(shape);
        _testScene.AddChild(body);

        // Act
        var retrievedShape = shape.Shape as RectangleShape2D;

        // Assert
        retrievedShape.ShouldNotBeNull();
        retrievedShape!.Size.ShouldBe(new Vector2(64, 32));

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CollisionShape2D_WithCircle_HasCorrectRadius

```csharp
[Test]
    public void CollisionShape2D_WithCircle_HasCorrectRadius()
    {
        // Arrange
        var body = new StaticBody2D();
        var shape = new CollisionShape2D();
        var circleShape = new CircleShape2D();
        circleShape.Radius = 25.0f;
        shape.Shape = circleShape;
        body.AddChild(shape);
        _testScene.AddChild(body);

        // Act
        var retrievedShape = shape.Shape as CircleShape2D;

        // Assert
        retrievedShape.ShouldNotBeNull();
        retrievedShape!.Radius.ShouldBe(25.0f);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CollisionShape2D_WithConvexPolygon_HasCorrectPoints

```csharp
[Test]
    public void CollisionShape2D_WithConvexPolygon_HasCorrectPoints()
    {
        // Arrange: Create a trapezoid shape
        var body = new StaticBody2D();
        var shape = new CollisionShape2D();
        var polygonShape = new ConvexPolygonShape2D();
        polygonShape.Points = new Vector2[]
        {
            new(-32, 12),
            new(-16, -12),
            new(17, -12),
            new(32, 12)
        };
        shape.Shape = polygonShape;
        body.AddChild(shape);
        _testScene.AddChild(body);

        // Act
        var retrievedShape = shape.Shape as ConvexPolygonShape2D;

        // Assert
        retrievedShape.ShouldNotBeNull();
        retrievedShape!.Points.Length.ShouldBe(4);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CollisionShape2D_GlobalPosition_ReflectsParentTransform

```csharp
[Test]
    public void CollisionShape2D_GlobalPosition_ReflectsParentTransform()
    {
        // Arrange
        var body = new StaticBody2D();
        var shape = new CollisionShape2D();
        var rectShape = new RectangleShape2D();
        rectShape.Size = new Vector2(32, 32);
        shape.Shape = rectShape;
        body.AddChild(shape);
        _testScene.AddChild(body);

        body.GlobalPosition = new Vector2(100, 200);
        shape.Position = new Vector2(10, 10);

        // Assert
        shape.GlobalPosition.ShouldBe(new Vector2(110, 210));

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### StaticBody2D_CollisionLayer_CanBeSet

```csharp
#endregion

    #region StaticBody2D Tests

    [Test]
    public void StaticBody2D_CollisionLayer_CanBeSet()
    {
        // Arrange
        var body = new StaticBody2D();
        _testScene.AddChild(body);

        // Act
        body.CollisionLayer = 0b0101; // Layers 1 and 3

        // Assert
        body.CollisionLayer.ShouldBe(0b0101u);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### StaticBody2D_CollisionMask_CanBeSet

```csharp
[Test]
    public void StaticBody2D_CollisionMask_CanBeSet()
    {
        // Arrange
        var body = new StaticBody2D();
        _testScene.AddChild(body);

        // Act
        body.CollisionMask = 0b1010; // Masks 2 and 4

        // Assert
        body.CollisionMask.ShouldBe(0b1010u);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### StaticBody2D_MultipleShapes_AllAccessible

```csharp
[Test]
    public void StaticBody2D_MultipleShapes_AllAccessible()
    {
        // Arrange
        var body = new StaticBody2D();
        var shape1 = new CollisionShape2D();
        var shape2 = new CollisionShape2D();
        var rectShape1 = new RectangleShape2D { Size = new Vector2(32, 32) };
        var rectShape2 = new RectangleShape2D { Size = new Vector2(64, 64) };
        shape1.Shape = rectShape1;
        shape2.Shape = rectShape2;
        body.AddChild(shape1);
        body.AddChild(shape2);
        _testScene.AddChild(body);

        // Act
        var children = body.GetChildren();
        var collisionShapes = children.Where(c => c is CollisionShape2D).ToList();

        // Assert
        collisionShapes.Count.ShouldBe(2);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### Area2D_WithShape_CanBeCreated

```csharp
#endregion

    #region Area2D Tests

    [Test]
    public void Area2D_WithShape_CanBeCreated()
    {
        // Arrange
        var area = new Area2D();
        var shape = new CollisionShape2D();
        var rectShape = new RectangleShape2D { Size = new Vector2(48, 48) };
        shape.Shape = rectShape;
        area.AddChild(shape);
        _testScene.AddChild(area);

        // Assert
        area.GetChildCount().ShouldBe(1);
        var childShape = area.GetChild(0) as CollisionShape2D;
        childShape.ShouldNotBeNull();
        (childShape!.Shape as RectangleShape2D)!.Size.ShouldBe(new Vector2(48, 48));

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### Area2D_Monitorable_CanBeToggled

```csharp
[Test]
    public void Area2D_Monitorable_CanBeToggled()
    {
        // Arrange
        var area = new Area2D();
        _testScene.AddChild(area);

        // Act & Assert
        area.Monitorable = true;
        area.Monitorable.ShouldBeTrue();

        area.Monitorable = false;
        area.Monitorable.ShouldBeFalse();

        // Cleanup
        area.QueueFree();
    }
```

**Returns:** `void`

### CollisionShape2D_Rotation_AppliesCorrectly

```csharp
#endregion

    #region Shape Transform Tests

    [Test]
    public void CollisionShape2D_Rotation_AppliesCorrectly()
    {
        // Arrange
        var body = new StaticBody2D();
        var shape = new CollisionShape2D();
        var rectShape = new RectangleShape2D { Size = new Vector2(32, 16) };
        shape.Shape = rectShape;
        body.AddChild(shape);
        _testScene.AddChild(body);

        // Act
        shape.Rotation = Mathf.Pi / 2; // 90 degrees

        // Assert
        shape.Rotation.ShouldBe(Mathf.Pi / 2, 0.001f);
        shape.RotationDegrees.ShouldBe(90f, 0.1f);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CollisionShape2D_Scale_AppliesCorrectly

```csharp
[Test]
    public void CollisionShape2D_Scale_AppliesCorrectly()
    {
        // Arrange
        var body = new StaticBody2D();
        var shape = new CollisionShape2D();
        var rectShape = new RectangleShape2D { Size = new Vector2(32, 32) };
        shape.Shape = rectShape;
        body.AddChild(shape);
        _testScene.AddChild(body);

        // Act
        shape.Scale = new Vector2(2, 2);

        // Assert
        shape.Scale.ShouldBe(new Vector2(2, 2));

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

