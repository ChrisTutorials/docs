---
title: "TweenIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/tweenintegrationtests/"
---

# TweenIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class TweenIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for Tween and animation functionality.
Tests property tweening and animation behaviors.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/TweenIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up Tween Integration Tests");
    }
```

**Returns:** `void`

### Tween_CanBeCreated

```csharp
#region Tween Creation Tests

    [Test]
    public void Tween_CanBeCreated()
    {
        // Act
        var tween = _testScene.CreateTween();

        // Assert
        tween.ShouldNotBeNull();

        // Cleanup
        tween.Kill();
    }
```

**Returns:** `void`

### Tween_IsValid_AfterCreation

```csharp
[Test]
    public void Tween_IsValid_AfterCreation()
    {
        // Act
        var tween = _testScene.CreateTween();

        // Assert
        tween.IsValid().ShouldBeTrue();

        // Cleanup
        tween.Kill();
    }
```

**Returns:** `void`

### Tween_IsNotValid_AfterKill

```csharp
[Test]
    public void Tween_IsNotValid_AfterKill()
    {
        // Arrange
        var tween = _testScene.CreateTween();

        // Act
        tween.Kill();

        // Assert
        tween.IsValid().ShouldBeFalse();
    }
```

**Returns:** `void`

### Tween_TweenProperty_CreatesPropertyTweener

```csharp
#endregion

    #region Property Tweening Tests

    [Test]
    public void Tween_TweenProperty_CreatesPropertyTweener()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);
        var tween = _testScene.CreateTween();

        // Act
        var tweener = tween.TweenProperty(node, "position", new Vector2(100, 100), 1.0);

        // Assert
        tweener.ShouldNotBeNull();

        // Cleanup
        tween.Kill();
        node.QueueFree();
    }
```

**Returns:** `void`

### Tween_TweenProperty_FromValue_Works

```csharp
[Test]
    public void Tween_TweenProperty_FromValue_Works()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);
        node.Position = Vector2.Zero;
        var tween = _testScene.CreateTween();

        // Act
        var tweener = tween.TweenProperty(node, "position", new Vector2(100, 100), 0.1)
            .From(new Vector2(-50, -50));

        // Assert
        tweener.ShouldNotBeNull();

        // Cleanup
        tween.Kill();
        node.QueueFree();
    }
```

**Returns:** `void`

### Tween_SetLoops_ConfiguresLooping

```csharp
#endregion

    #region Tween Configuration Tests

    [Test]
    public void Tween_SetLoops_ConfiguresLooping()
    {
        // Arrange
        var tween = _testScene.CreateTween();

        // Act
        var result = tween.SetLoops(3);

        // Assert
        result.ShouldBe(tween); // Returns self for chaining

        // Cleanup
        tween.Kill();
    }
```

**Returns:** `void`

### Tween_SetParallel_ConfiguresParallel

```csharp
[Test]
    public void Tween_SetParallel_ConfiguresParallel()
    {
        // Arrange
        var tween = _testScene.CreateTween();

        // Act
        var result = tween.SetParallel(true);

        // Assert
        result.ShouldBe(tween);

        // Cleanup
        tween.Kill();
    }
```

**Returns:** `void`

### Tween_SetSpeedScale_ConfiguresSpeed

```csharp
[Test]
    public void Tween_SetSpeedScale_ConfiguresSpeed()
    {
        // Arrange
        var tween = _testScene.CreateTween();

        // Act
        var result = tween.SetSpeedScale(2.0f);

        // Assert
        result.ShouldBe(tween);

        // Cleanup
        tween.Kill();
    }
```

**Returns:** `void`

### Tween_SetEase_ConfiguresEasing

```csharp
[Test]
    public void Tween_SetEase_ConfiguresEasing()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);
        var tween = _testScene.CreateTween();

        // Act
        var tweener = tween.TweenProperty(node, "position", new Vector2(100, 100), 1.0)
            .SetEase(Tween.EaseType.InOut);

        // Assert
        tweener.ShouldNotBeNull();

        // Cleanup
        tween.Kill();
        node.QueueFree();
    }
```

**Returns:** `void`

### Tween_SetTrans_ConfiguresTransition

```csharp
[Test]
    public void Tween_SetTrans_ConfiguresTransition()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);
        var tween = _testScene.CreateTween();

        // Act
        var tweener = tween.TweenProperty(node, "position", new Vector2(100, 100), 1.0)
            .SetTrans(Tween.TransitionType.Bounce);

        // Assert
        tweener.ShouldNotBeNull();

        // Cleanup
        tween.Kill();
        node.QueueFree();
    }
```

**Returns:** `void`

### Tween_TweenCallback_CanBeAdded

```csharp
#endregion

    #region Tween Callback Tests

    [Test]
    public void Tween_TweenCallback_CanBeAdded()
    {
        // Arrange
        var tween = _testScene.CreateTween();
        var called = false;

        // Act
        tween.TweenCallback(Callable.From(() => called = true));

        // Assert: Callback should be set up (not executed yet)
        tween.IsValid().ShouldBeTrue();

        // Cleanup
        tween.Kill();
    }
```

**Returns:** `void`

### Tween_TweenInterval_CreatesDelay

```csharp
[Test]
    public void Tween_TweenInterval_CreatesDelay()
    {
        // Arrange
        var tween = _testScene.CreateTween();

        // Act
        var tweener = tween.TweenInterval(0.5);

        // Assert
        tweener.ShouldNotBeNull();

        // Cleanup
        tween.Kill();
    }
```

**Returns:** `void`

### Tween_Pause_StopsTween

```csharp
#endregion

    #region Tween Pause/Resume Tests

    [Test]
    public void Tween_Pause_StopsTween()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);
        var tween = _testScene.CreateTween();
        tween.TweenProperty(node, "position", new Vector2(100, 100), 1.0);

        // Act
        tween.Pause();

        // Assert
        tween.IsValid().ShouldBeTrue();

        // Cleanup
        tween.Kill();
        node.QueueFree();
    }
```

**Returns:** `void`

### Tween_Play_ResumesTween

```csharp
[Test]
    public void Tween_Play_ResumesTween()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);
        var tween = _testScene.CreateTween();
        tween.TweenProperty(node, "position", new Vector2(100, 100), 1.0);
        tween.Pause();

        // Act
        tween.Play();

        // Assert
        tween.IsValid().ShouldBeTrue();

        // Cleanup
        tween.Kill();
        node.QueueFree();
    }
```

**Returns:** `void`

### Tween_MultipleProperties_CanBeTweened

```csharp
#endregion

    #region Multi-Property Tweening Tests

    [Test]
    public void Tween_MultipleProperties_CanBeTweened()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);
        var tween = _testScene.CreateTween();

        // Act: Tween multiple properties in parallel
        tween.SetParallel(true);
        tween.TweenProperty(node, "position", new Vector2(100, 100), 1.0);
        tween.TweenProperty(node, "rotation", Mathf.Pi, 1.0);
        tween.TweenProperty(node, "scale", new Vector2(2, 2), 1.0);

        // Assert
        tween.IsValid().ShouldBeTrue();

        // Cleanup
        tween.Kill();
        node.QueueFree();
    }
```

**Returns:** `void`

### Tween_Chain_ExecutesSequentially

```csharp
[Test]
    public void Tween_Chain_ExecutesSequentially()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);
        var tween = _testScene.CreateTween();

        // Act: Chain multiple property tweens (sequential by default)
        tween.TweenProperty(node, "position:x", 50.0, 0.5);
        tween.TweenProperty(node, "position:y", 50.0, 0.5);

        // Assert
        tween.IsValid().ShouldBeTrue();

        // Cleanup
        tween.Kill();
        node.QueueFree();
    }
```

**Returns:** `void`

