---
title: "AnimationIntegrationTests"
description: "GoDotTest integration tests for AnimatedSprite2D and AnimationPlayer.
Tests animation playback, frames, and animation configuration."
weight: 20
url: "/gridbuilding/v6-0/api/godot/animationintegrationtests/"
---

# AnimationIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class AnimationIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for AnimatedSprite2D and AnimationPlayer.
Tests animation playback, frames, and animation configuration.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/AnimationIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up Animation Integration Tests");
    }
```

**Returns:** `void`

### AnimatedSprite2D_CanBeCreated

```csharp
#region AnimatedSprite2D Creation Tests

    [Test]
    public void AnimatedSprite2D_CanBeCreated()
    {
        // Act
        var sprite = new AnimatedSprite2D();
        _testScene.AddChild(sprite);

        // Assert
        sprite.ShouldNotBeNull();

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### AnimatedSprite2D_DefaultPlaying_IsFalse

```csharp
[Test]
    public void AnimatedSprite2D_DefaultPlaying_IsFalse()
    {
        // Arrange
        var sprite = new AnimatedSprite2D();
        _testScene.AddChild(sprite);

        // Assert
        sprite.IsPlaying().ShouldBeFalse();

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### AnimatedSprite2D_SpriteFrames_CanBeAssigned

```csharp
#endregion

    #region AnimatedSprite2D Configuration Tests

    [Test]
    public void AnimatedSprite2D_SpriteFrames_CanBeAssigned()
    {
        // Arrange
        var sprite = new AnimatedSprite2D();
        _testScene.AddChild(sprite);
        var frames = new SpriteFrames();

        // Act
        sprite.SpriteFrames = frames;

        // Assert
        sprite.SpriteFrames.ShouldNotBeNull();

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### AnimatedSprite2D_Autoplay_CanBeSet

```csharp
[Test]
    public void AnimatedSprite2D_Autoplay_CanBeSet()
    {
        // Arrange
        var sprite = new AnimatedSprite2D();
        _testScene.AddChild(sprite);

        // Act
        sprite.Autoplay = "default";

        // Assert
        sprite.Autoplay.ShouldBe("default");

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### AnimatedSprite2D_Frame_CanBeSet

```csharp
[Test]
    public void AnimatedSprite2D_Frame_CanBeSet()
    {
        // Arrange
        var sprite = new AnimatedSprite2D();
        var frames = new SpriteFrames();
        sprite.SpriteFrames = frames;
        _testScene.AddChild(sprite);

        // Act
        sprite.Frame = 0;

        // Assert
        sprite.Frame.ShouldBe(0);

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### AnimatedSprite2D_SpeedScale_CanBeSet

```csharp
[Test]
    public void AnimatedSprite2D_SpeedScale_CanBeSet()
    {
        // Arrange
        var sprite = new AnimatedSprite2D();
        _testScene.AddChild(sprite);

        // Act
        sprite.SpeedScale = 2.0f;

        // Assert
        sprite.SpeedScale.ShouldBe(2.0f);

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### AnimatedSprite2D_FlipH_CanBeSet

```csharp
[Test]
    public void AnimatedSprite2D_FlipH_CanBeSet()
    {
        // Arrange
        var sprite = new AnimatedSprite2D();
        _testScene.AddChild(sprite);

        // Act
        sprite.FlipH = true;

        // Assert
        sprite.FlipH.ShouldBeTrue();

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### AnimatedSprite2D_FlipV_CanBeSet

```csharp
[Test]
    public void AnimatedSprite2D_FlipV_CanBeSet()
    {
        // Arrange
        var sprite = new AnimatedSprite2D();
        _testScene.AddChild(sprite);

        // Act
        sprite.FlipV = true;

        // Assert
        sprite.FlipV.ShouldBeTrue();

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### AnimatedSprite2D_Centered_CanBeDisabled

```csharp
[Test]
    public void AnimatedSprite2D_Centered_CanBeDisabled()
    {
        // Arrange
        var sprite = new AnimatedSprite2D();
        _testScene.AddChild(sprite);

        // Act
        sprite.Centered = false;

        // Assert
        sprite.Centered.ShouldBeFalse();

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### AnimatedSprite2D_Offset_CanBeSet

```csharp
[Test]
    public void AnimatedSprite2D_Offset_CanBeSet()
    {
        // Arrange
        var sprite = new AnimatedSprite2D();
        _testScene.AddChild(sprite);

        // Act
        sprite.Offset = new Vector2(10, 20);

        // Assert
        sprite.Offset.ShouldBe(new Vector2(10, 20));

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### SpriteFrames_CanBeCreated

```csharp
#endregion

    #region SpriteFrames Tests

    [Test]
    public void SpriteFrames_CanBeCreated()
    {
        // Act
        var frames = new SpriteFrames();

        // Assert
        frames.ShouldNotBeNull();
    }
```

**Returns:** `void`

### SpriteFrames_HasAnimation_ReturnsTrueForDefault

```csharp
[Test]
    public void SpriteFrames_HasAnimation_ReturnsTrueForDefault()
    {
        // Arrange
        var frames = new SpriteFrames();

        // Assert: Default animation exists
        frames.HasAnimation("default").ShouldBeTrue();
    }
```

**Returns:** `void`

### SpriteFrames_AddAnimation_CreatesNewAnimation

```csharp
[Test]
    public void SpriteFrames_AddAnimation_CreatesNewAnimation()
    {
        // Arrange
        var frames = new SpriteFrames();

        // Act
        frames.AddAnimation("walk");

        // Assert
        frames.HasAnimation("walk").ShouldBeTrue();
    }
```

**Returns:** `void`

### SpriteFrames_RemoveAnimation_RemovesAnimation

```csharp
[Test]
    public void SpriteFrames_RemoveAnimation_RemovesAnimation()
    {
        // Arrange
        var frames = new SpriteFrames();
        frames.AddAnimation("walk");

        // Act
        frames.RemoveAnimation("walk");

        // Assert
        frames.HasAnimation("walk").ShouldBeFalse();
    }
```

**Returns:** `void`

### SpriteFrames_RenameAnimation_ChangesName

```csharp
[Test]
    public void SpriteFrames_RenameAnimation_ChangesName()
    {
        // Arrange
        var frames = new SpriteFrames();
        frames.AddAnimation("walk");

        // Act
        frames.RenameAnimation("walk", "run");

        // Assert
        frames.HasAnimation("walk").ShouldBeFalse();
        frames.HasAnimation("run").ShouldBeTrue();
    }
```

**Returns:** `void`

### SpriteFrames_SetAnimationSpeed_ChangesSpeed

```csharp
[Test]
    public void SpriteFrames_SetAnimationSpeed_ChangesSpeed()
    {
        // Arrange
        var frames = new SpriteFrames();

        // Act
        frames.SetAnimationSpeed("default", 10.0);

        // Assert
        frames.GetAnimationSpeed("default").ShouldBe(10.0);
    }
```

**Returns:** `void`

### SpriteFrames_SetAnimationLoop_ChangesLoop

```csharp
[Test]
    public void SpriteFrames_SetAnimationLoop_ChangesLoop()
    {
        // Arrange
        var frames = new SpriteFrames();

        // Act
        frames.SetAnimationLoop("default", false);

        // Assert
        frames.GetAnimationLoop("default").ShouldBeFalse();
    }
```

**Returns:** `void`

### SpriteFrames_GetAnimationNames_ReturnsAnimations

```csharp
[Test]
    public void SpriteFrames_GetAnimationNames_ReturnsAnimations()
    {
        // Arrange
        var frames = new SpriteFrames();
        frames.AddAnimation("walk");
        frames.AddAnimation("run");

        // Act
        var names = frames.GetAnimationNames();

        // Assert
        names.Length.ShouldBeGreaterThanOrEqualTo(3); // default + walk + run

        // Cleanup
    }
```

**Returns:** `void`

### AnimationPlayer_CanBeCreated

```csharp
#endregion

    #region AnimationPlayer Creation Tests

    [Test]
    public void AnimationPlayer_CanBeCreated()
    {
        // Act
        var player = new AnimationPlayer();
        _testScene.AddChild(player);

        // Assert
        player.ShouldNotBeNull();

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AnimationPlayer_DefaultPlaying_IsFalse

```csharp
[Test]
    public void AnimationPlayer_DefaultPlaying_IsFalse()
    {
        // Arrange
        var player = new AnimationPlayer();
        _testScene.AddChild(player);

        // Assert
        player.IsPlaying().ShouldBeFalse();

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AnimationPlayer_SpeedScale_CanBeSet

```csharp
#endregion

    #region AnimationPlayer Configuration Tests

    [Test]
    public void AnimationPlayer_SpeedScale_CanBeSet()
    {
        // Arrange
        var player = new AnimationPlayer();
        _testScene.AddChild(player);

        // Act
        player.SpeedScale = 2.0f;

        // Assert
        player.SpeedScale.ShouldBe(2.0f);

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AnimationPlayer_Autoplay_CanBeSet

```csharp
[Test]
    public void AnimationPlayer_Autoplay_CanBeSet()
    {
        // Arrange
        var player = new AnimationPlayer();
        _testScene.AddChild(player);

        // Act
        player.Autoplay = "idle";

        // Assert
        player.Autoplay.ShouldBe("idle");

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AnimationPlayer_Active_CanBeDisabled

```csharp
[Test]
    public void AnimationPlayer_Active_CanBeDisabled()
    {
        // Arrange
        var player = new AnimationPlayer();
        _testScene.AddChild(player);

        // Act
        player.Active = false;

        // Assert
        player.Active.ShouldBeFalse();

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AnimationPlayer_PlaybackProcessMode_CanBeSetToPhysics

```csharp
[Test]
    public void AnimationPlayer_PlaybackProcessMode_CanBeSetToPhysics()
    {
        // Arrange
        var player = new AnimationPlayer();
        _testScene.AddChild(player);

        // Act
        player.PlaybackProcessMode = AnimationPlayer.AnimationProcessCallback.Physics;

        // Assert
        player.PlaybackProcessMode.ShouldBe(AnimationPlayer.AnimationProcessCallback.Physics);

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### Animation_CanBeCreated

```csharp
#endregion

    #region Animation Tests

    [Test]
    public void Animation_CanBeCreated()
    {
        // Act
        var animation = new Animation();

        // Assert
        animation.ShouldNotBeNull();
    }
```

**Returns:** `void`

### Animation_Length_CanBeSet

```csharp
[Test]
    public void Animation_Length_CanBeSet()
    {
        // Arrange
        var animation = new Animation();

        // Act
        animation.Length = 2.0f;

        // Assert
        ((double)animation.Length).ShouldBe(2.0);
    }
```

**Returns:** `void`

### Animation_LoopMode_CanBeSet

```csharp
[Test]
    public void Animation_LoopMode_CanBeSet()
    {
        // Arrange
        var animation = new Animation();

        // Act
        animation.LoopMode = Animation.LoopModeEnum.Linear;

        // Assert
        animation.LoopMode.ShouldBe(Animation.LoopModeEnum.Linear);
    }
```

**Returns:** `void`

### Animation_Step_CanBeSet

```csharp
[Test]
    public void Animation_Step_CanBeSet()
    {
        // Arrange
        var animation = new Animation();

        // Act
        animation.Step = 0.05f;

        // Assert
        ((double)animation.Step).ShouldBe(0.05);
    }
```

**Returns:** `void`

### Animation_AddTrack_ReturnsTrackIndex

```csharp
[Test]
    public void Animation_AddTrack_ReturnsTrackIndex()
    {
        // Arrange
        var animation = new Animation();

        // Act
        var trackIdx = animation.AddTrack(Animation.TrackType.Value);

        // Assert
        trackIdx.ShouldBeGreaterThanOrEqualTo(0);
    }
```

**Returns:** `void`

### Animation_GetTrackCount_ReturnsCount

```csharp
[Test]
    public void Animation_GetTrackCount_ReturnsCount()
    {
        // Arrange
        var animation = new Animation();
        animation.AddTrack(Animation.TrackType.Value);
        animation.AddTrack(Animation.TrackType.Method);

        // Act
        var count = animation.GetTrackCount();

        // Assert
        count.ShouldBe(2);
    }
```

**Returns:** `void`

### Animation_TrackSetPath_SetsPath

```csharp
[Test]
    public void Animation_TrackSetPath_SetsPath()
    {
        // Arrange
        var animation = new Animation();
        var trackIdx = animation.AddTrack(Animation.TrackType.Value);

        // Act
        animation.TrackSetPath(trackIdx, "Node2D:position");

        // Assert
        animation.TrackGetPath(trackIdx).ToString().ShouldBe("Node2D:position");
    }
```

**Returns:** `void`

