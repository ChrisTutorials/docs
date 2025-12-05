---
title: "PhysicsBody2DIntegrationTests"
description: "GoDotTest integration tests for CharacterBody2D and RigidBody2D physics.
Tests movement, collisions, and physics properties."
weight: 20
url: "/gridbuilding/v6-0/api/godot/physicsbody2dintegrationtests/"
---

# PhysicsBody2DIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class PhysicsBody2DIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for CharacterBody2D and RigidBody2D physics.
Tests movement, collisions, and physics properties.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/PhysicsBody2DIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up PhysicsBody2D Integration Tests");
    }
```

**Returns:** `void`

### CharacterBody2D_CanBeCreated

```csharp
#region CharacterBody2D Creation Tests

    [Test]
    public void CharacterBody2D_CanBeCreated()
    {
        // Act
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Assert
        body.ShouldNotBeNull();

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CharacterBody2D_Velocity_DefaultIsZero

```csharp
[Test]
    public void CharacterBody2D_Velocity_DefaultIsZero()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Assert
        body.Velocity.ShouldBe(Vector2.Zero);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CharacterBody2D_Velocity_CanBeSet

```csharp
[Test]
    public void CharacterBody2D_Velocity_CanBeSet()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Act
        body.Velocity = new Vector2(100, 50);

        // Assert
        body.Velocity.ShouldBe(new Vector2(100, 50));

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CharacterBody2D_MotionMode_CanBeSetToGrounded

```csharp
#endregion

    #region CharacterBody2D Configuration Tests

    [Test]
    public void CharacterBody2D_MotionMode_CanBeSetToGrounded()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Act
        body.MotionMode = CharacterBody2D.MotionModeEnum.Grounded;

        // Assert
        body.MotionMode.ShouldBe(CharacterBody2D.MotionModeEnum.Grounded);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CharacterBody2D_MotionMode_CanBeSetToFloating

```csharp
[Test]
    public void CharacterBody2D_MotionMode_CanBeSetToFloating()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Act
        body.MotionMode = CharacterBody2D.MotionModeEnum.Floating;

        // Assert
        body.MotionMode.ShouldBe(CharacterBody2D.MotionModeEnum.Floating);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CharacterBody2D_UpDirection_CanBeSet

```csharp
[Test]
    public void CharacterBody2D_UpDirection_CanBeSet()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Act
        body.UpDirection = new Vector2(0, -1);

        // Assert
        body.UpDirection.ShouldBe(new Vector2(0, -1));

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CharacterBody2D_FloorMaxAngle_CanBeSet

```csharp
[Test]
    public void CharacterBody2D_FloorMaxAngle_CanBeSet()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Act
        body.FloorMaxAngle = Mathf.DegToRad(60);

        // Assert
        body.FloorMaxAngle.ShouldBe(Mathf.DegToRad(60), 0.001f);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CharacterBody2D_MaxSlides_CanBeSet

```csharp
[Test]
    public void CharacterBody2D_MaxSlides_CanBeSet()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Act
        body.MaxSlides = 8;

        // Assert
        body.MaxSlides.ShouldBe(8);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CharacterBody2D_FloorStopOnSlope_CanBeEnabled

```csharp
[Test]
    public void CharacterBody2D_FloorStopOnSlope_CanBeEnabled()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Act
        body.FloorStopOnSlope = true;

        // Assert
        body.FloorStopOnSlope.ShouldBeTrue();

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CharacterBody2D_FloorSnapLength_CanBeSet

```csharp
[Test]
    public void CharacterBody2D_FloorSnapLength_CanBeSet()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Act
        body.FloorSnapLength = 10.0f;

        // Assert
        body.FloorSnapLength.ShouldBe(10.0f);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CharacterBody2D_IsOnFloor_ReturnsFalseWhenNotOnFloor

```csharp
#endregion

    #region CharacterBody2D State Tests

    [Test]
    public void CharacterBody2D_IsOnFloor_ReturnsFalseWhenNotOnFloor()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Assert: Not on floor without physics simulation
        body.IsOnFloor().ShouldBeFalse();

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CharacterBody2D_IsOnWall_ReturnsFalseWhenNotOnWall

```csharp
[Test]
    public void CharacterBody2D_IsOnWall_ReturnsFalseWhenNotOnWall()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Assert
        body.IsOnWall().ShouldBeFalse();

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CharacterBody2D_IsOnCeiling_ReturnsFalseWhenNotOnCeiling

```csharp
[Test]
    public void CharacterBody2D_IsOnCeiling_ReturnsFalseWhenNotOnCeiling()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Assert
        body.IsOnCeiling().ShouldBeFalse();

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### CharacterBody2D_GetLastMotion_ReturnsZeroInitially

```csharp
[Test]
    public void CharacterBody2D_GetLastMotion_ReturnsZeroInitially()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Assert
        body.GetLastMotion().ShouldBe(Vector2.Zero);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### RigidBody2D_CanBeCreated

```csharp
#endregion

    #region RigidBody2D Creation Tests

    [Test]
    public void RigidBody2D_CanBeCreated()
    {
        // Act
        var body = new RigidBody2D();
        _testScene.AddChild(body);

        // Assert
        body.ShouldNotBeNull();

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### RigidBody2D_Mass_DefaultIsOne

```csharp
[Test]
    public void RigidBody2D_Mass_DefaultIsOne()
    {
        // Arrange
        var body = new RigidBody2D();
        _testScene.AddChild(body);

        // Assert
        body.Mass.ShouldBe(1.0f);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### RigidBody2D_Mass_CanBeSet

```csharp
[Test]
    public void RigidBody2D_Mass_CanBeSet()
    {
        // Arrange
        var body = new RigidBody2D();
        _testScene.AddChild(body);

        // Act
        body.Mass = 5.0f;

        // Assert
        body.Mass.ShouldBe(5.0f);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### RigidBody2D_GravityScale_CanBeSet

```csharp
#endregion

    #region RigidBody2D Configuration Tests

    [Test]
    public void RigidBody2D_GravityScale_CanBeSet()
    {
        // Arrange
        var body = new RigidBody2D();
        _testScene.AddChild(body);

        // Act
        body.GravityScale = 2.0f;

        // Assert
        body.GravityScale.ShouldBe(2.0f);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### RigidBody2D_LinearDamp_CanBeSet

```csharp
[Test]
    public void RigidBody2D_LinearDamp_CanBeSet()
    {
        // Arrange
        var body = new RigidBody2D();
        _testScene.AddChild(body);

        // Act
        body.LinearDamp = 1.5f;

        // Assert
        body.LinearDamp.ShouldBe(1.5f);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### RigidBody2D_AngularDamp_CanBeSet

```csharp
[Test]
    public void RigidBody2D_AngularDamp_CanBeSet()
    {
        // Arrange
        var body = new RigidBody2D();
        _testScene.AddChild(body);

        // Act
        body.AngularDamp = 0.5f;

        // Assert
        body.AngularDamp.ShouldBe(0.5f);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### RigidBody2D_PhysicsMaterialOverride_CanBeAssigned

```csharp
[Test]
    public void RigidBody2D_PhysicsMaterialOverride_CanBeAssigned()
    {
        // Arrange
        var body = new RigidBody2D();
        _testScene.AddChild(body);
        var material = new PhysicsMaterial();

        // Act
        body.PhysicsMaterialOverride = material;

        // Assert
        body.PhysicsMaterialOverride.ShouldNotBeNull();

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### RigidBody2D_FreezeMode_CanBeSetToStatic

```csharp
[Test]
    public void RigidBody2D_FreezeMode_CanBeSetToStatic()
    {
        // Arrange
        var body = new RigidBody2D();
        _testScene.AddChild(body);

        // Act
        body.Freeze = true;
        body.FreezeMode = RigidBody2D.FreezeModeEnum.Static;

        // Assert
        body.FreezeMode.ShouldBe(RigidBody2D.FreezeModeEnum.Static);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### RigidBody2D_FreezeMode_CanBeSetToKinematic

```csharp
[Test]
    public void RigidBody2D_FreezeMode_CanBeSetToKinematic()
    {
        // Arrange
        var body = new RigidBody2D();
        _testScene.AddChild(body);

        // Act
        body.Freeze = true;
        body.FreezeMode = RigidBody2D.FreezeModeEnum.Kinematic;

        // Assert
        body.FreezeMode.ShouldBe(RigidBody2D.FreezeModeEnum.Kinematic);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### RigidBody2D_LinearVelocity_CanBeSet

```csharp
#endregion

    #region RigidBody2D Velocity Tests

    [Test]
    public void RigidBody2D_LinearVelocity_CanBeSet()
    {
        // Arrange
        var body = new RigidBody2D();
        _testScene.AddChild(body);

        // Act
        body.LinearVelocity = new Vector2(100, 50);

        // Assert
        body.LinearVelocity.ShouldBe(new Vector2(100, 50));

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### RigidBody2D_AngularVelocity_CanBeSet

```csharp
[Test]
    public void RigidBody2D_AngularVelocity_CanBeSet()
    {
        // Arrange
        var body = new RigidBody2D();
        _testScene.AddChild(body);

        // Act
        body.AngularVelocity = Mathf.Pi;

        // Assert
        body.AngularVelocity.ShouldBe(Mathf.Pi, 0.001f);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### StaticBody2D_CanBeCreated

```csharp
#endregion

    #region StaticBody2D Tests

    [Test]
    public void StaticBody2D_CanBeCreated()
    {
        // Act
        var body = new StaticBody2D();
        _testScene.AddChild(body);

        // Assert
        body.ShouldNotBeNull();

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### StaticBody2D_ConstantLinearVelocity_CanBeSet

```csharp
[Test]
    public void StaticBody2D_ConstantLinearVelocity_CanBeSet()
    {
        // Arrange
        var body = new StaticBody2D();
        _testScene.AddChild(body);

        // Act
        body.ConstantLinearVelocity = new Vector2(10, 0);

        // Assert
        body.ConstantLinearVelocity.ShouldBe(new Vector2(10, 0));

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### StaticBody2D_ConstantAngularVelocity_CanBeSet

```csharp
[Test]
    public void StaticBody2D_ConstantAngularVelocity_CanBeSet()
    {
        // Arrange
        var body = new StaticBody2D();
        _testScene.AddChild(body);

        // Act
        body.ConstantAngularVelocity = 0.5f;

        // Assert
        body.ConstantAngularVelocity.ShouldBe(0.5f);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### PhysicsBody2D_CollisionLayer_CanBeSet

```csharp
#endregion

    #region Collision Layer/Mask Tests

    [Test]
    public void PhysicsBody2D_CollisionLayer_CanBeSet()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Act
        body.CollisionLayer = 0b1010;

        // Assert
        body.CollisionLayer.ShouldBe(0b1010u);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### PhysicsBody2D_CollisionMask_CanBeSet

```csharp
[Test]
    public void PhysicsBody2D_CollisionMask_CanBeSet()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);

        // Act
        body.CollisionMask = 0b0101;

        // Assert
        body.CollisionMask.ShouldBe(0b0101u);

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

### PhysicsBody2D_SetCollisionLayerValue_Works

```csharp
[Test]
    public void PhysicsBody2D_SetCollisionLayerValue_Works()
    {
        // Arrange
        var body = new CharacterBody2D();
        _testScene.AddChild(body);
        body.CollisionLayer = 0;

        // Act
        body.SetCollisionLayerValue(3, true);

        // Assert
        body.GetCollisionLayerValue(3).ShouldBeTrue();

        // Cleanup
        body.QueueFree();
    }
```

**Returns:** `void`

