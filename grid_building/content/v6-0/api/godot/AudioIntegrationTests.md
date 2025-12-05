---
title: "AudioIntegrationTests"
description: "GoDotTest integration tests for AudioStreamPlayer2D and audio functionality.
Tests audio playback, volume, pitch, and bus routing."
weight: 20
url: "/gridbuilding/v6-0/api/godot/audiointegrationtests/"
---

# AudioIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class AudioIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for AudioStreamPlayer2D and audio functionality.
Tests audio playback, volume, pitch, and bus routing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/AudioIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up Audio Integration Tests");
    }
```

**Returns:** `void`

### AudioStreamPlayer_CanBeCreated

```csharp
#region AudioStreamPlayer Creation Tests

    [Test]
    public void AudioStreamPlayer_CanBeCreated()
    {
        // Act
        var player = new AudioStreamPlayer();
        _testScene.AddChild(player);

        // Assert
        player.ShouldNotBeNull();

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer_DefaultAutoplay_IsFalse

```csharp
[Test]
    public void AudioStreamPlayer_DefaultAutoplay_IsFalse()
    {
        // Arrange
        var player = new AudioStreamPlayer();
        _testScene.AddChild(player);

        // Assert
        player.Autoplay.ShouldBeFalse();

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer_IsPlaying_ReturnsFalseByDefault

```csharp
[Test]
    public void AudioStreamPlayer_IsPlaying_ReturnsFalseByDefault()
    {
        // Arrange
        var player = new AudioStreamPlayer();
        _testScene.AddChild(player);

        // Assert
        player.Playing.ShouldBeFalse();

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer_VolumeDb_CanBeSet

```csharp
#endregion

    #region AudioStreamPlayer Configuration Tests

    [Test]
    public void AudioStreamPlayer_VolumeDb_CanBeSet()
    {
        // Arrange
        var player = new AudioStreamPlayer();
        _testScene.AddChild(player);

        // Act
        player.VolumeDb = -10.0f;

        // Assert
        player.VolumeDb.ShouldBe(-10.0f);

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer_PitchScale_CanBeSet

```csharp
[Test]
    public void AudioStreamPlayer_PitchScale_CanBeSet()
    {
        // Arrange
        var player = new AudioStreamPlayer();
        _testScene.AddChild(player);

        // Act
        player.PitchScale = 1.5f;

        // Assert
        player.PitchScale.ShouldBe(1.5f);

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer_Autoplay_CanBeEnabled

```csharp
[Test]
    public void AudioStreamPlayer_Autoplay_CanBeEnabled()
    {
        // Arrange
        var player = new AudioStreamPlayer();
        _testScene.AddChild(player);

        // Act
        player.Autoplay = true;

        // Assert
        player.Autoplay.ShouldBeTrue();

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer_StreamPaused_CanBeSet

```csharp
[Test]
    public void AudioStreamPlayer_StreamPaused_CanBeSet()
    {
        // Arrange
        var player = new AudioStreamPlayer();
        _testScene.AddChild(player);

        // Act
        player.StreamPaused = true;

        // Assert
        player.StreamPaused.ShouldBeTrue();

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer_Bus_CanBeSet

```csharp
[Test]
    public void AudioStreamPlayer_Bus_CanBeSet()
    {
        // Arrange
        var player = new AudioStreamPlayer();
        _testScene.AddChild(player);

        // Act
        player.Bus = "Master";

        // Assert
        player.Bus.ToString().ShouldBe("Master");

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer_MaxPolyphony_CanBeSet

```csharp
[Test]
    public void AudioStreamPlayer_MaxPolyphony_CanBeSet()
    {
        // Arrange
        var player = new AudioStreamPlayer();
        _testScene.AddChild(player);

        // Act
        player.MaxPolyphony = 4;

        // Assert
        player.MaxPolyphony.ShouldBe(4);

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer2D_CanBeCreated

```csharp
#endregion

    #region AudioStreamPlayer2D Creation Tests

    [Test]
    public void AudioStreamPlayer2D_CanBeCreated()
    {
        // Act
        var player = new AudioStreamPlayer2D();
        _testScene.AddChild(player);

        // Assert
        player.ShouldNotBeNull();

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer2D_DefaultPosition_IsZero

```csharp
[Test]
    public void AudioStreamPlayer2D_DefaultPosition_IsZero()
    {
        // Arrange
        var player = new AudioStreamPlayer2D();
        _testScene.AddChild(player);

        // Assert
        player.Position.ShouldBe(Vector2.Zero);

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer2D_VolumeDb_CanBeSet

```csharp
#endregion

    #region AudioStreamPlayer2D Configuration Tests

    [Test]
    public void AudioStreamPlayer2D_VolumeDb_CanBeSet()
    {
        // Arrange
        var player = new AudioStreamPlayer2D();
        _testScene.AddChild(player);

        // Act
        player.VolumeDb = -5.0f;

        // Assert
        player.VolumeDb.ShouldBe(-5.0f);

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer2D_MaxDistance_CanBeSet

```csharp
[Test]
    public void AudioStreamPlayer2D_MaxDistance_CanBeSet()
    {
        // Arrange
        var player = new AudioStreamPlayer2D();
        _testScene.AddChild(player);

        // Act
        player.MaxDistance = 500.0f;

        // Assert
        player.MaxDistance.ShouldBe(500.0f);

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer2D_Attenuation_CanBeSet

```csharp
[Test]
    public void AudioStreamPlayer2D_Attenuation_CanBeSet()
    {
        // Arrange
        var player = new AudioStreamPlayer2D();
        _testScene.AddChild(player);

        // Act
        player.Attenuation = 2.0f;

        // Assert
        player.Attenuation.ShouldBe(2.0f);

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer2D_AreaMask_CanBeSet

```csharp
[Test]
    public void AudioStreamPlayer2D_AreaMask_CanBeSet()
    {
        // Arrange
        var player = new AudioStreamPlayer2D();
        _testScene.AddChild(player);

        // Act
        player.AreaMask = 0b1111;

        // Assert
        player.AreaMask.ShouldBe(0b1111u);

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamPlayer2D_PanningStrength_CanBeSet

```csharp
[Test]
    public void AudioStreamPlayer2D_PanningStrength_CanBeSet()
    {
        // Arrange
        var player = new AudioStreamPlayer2D();
        _testScene.AddChild(player);

        // Act
        player.PanningStrength = 0.5f;

        // Assert
        player.PanningStrength.ShouldBe(0.5f);

        // Cleanup
        player.QueueFree();
    }
```

**Returns:** `void`

### AudioStreamWav_CanBeCreated

```csharp
#endregion

    #region AudioStream Tests

    [Test]
    public void AudioStreamWav_CanBeCreated()
    {
        // Act
        var stream = new AudioStreamWav();

        // Assert
        stream.ShouldNotBeNull();
    }
```

**Returns:** `void`

### AudioStreamWav_Format_DefaultIsPcm8Bits

```csharp
[Test]
    public void AudioStreamWav_Format_DefaultIsPcm8Bits()
    {
        // Arrange
        var stream = new AudioStreamWav();

        // Assert
        stream.Format.ShouldBe(AudioStreamWav.FormatEnum.Format8Bits);
    }
```

**Returns:** `void`

### AudioStreamWav_Format_CanBeSetTo16Bits

```csharp
[Test]
    public void AudioStreamWav_Format_CanBeSetTo16Bits()
    {
        // Arrange
        var stream = new AudioStreamWav();

        // Act
        stream.Format = AudioStreamWav.FormatEnum.Format16Bits;

        // Assert
        stream.Format.ShouldBe(AudioStreamWav.FormatEnum.Format16Bits);
    }
```

**Returns:** `void`

### AudioStreamWav_MixRate_CanBeSet

```csharp
[Test]
    public void AudioStreamWav_MixRate_CanBeSet()
    {
        // Arrange
        var stream = new AudioStreamWav();

        // Act
        stream.MixRate = 44100;

        // Assert
        stream.MixRate.ShouldBe(44100);
    }
```

**Returns:** `void`

### AudioStreamWav_Stereo_CanBeSet

```csharp
[Test]
    public void AudioStreamWav_Stereo_CanBeSet()
    {
        // Arrange
        var stream = new AudioStreamWav();

        // Act
        stream.Stereo = true;

        // Assert
        stream.Stereo.ShouldBeTrue();
    }
```

**Returns:** `void`

### AudioStreamWav_LoopMode_CanBeSet

```csharp
[Test]
    public void AudioStreamWav_LoopMode_CanBeSet()
    {
        // Arrange
        var stream = new AudioStreamWav();

        // Act
        stream.LoopMode = AudioStreamWav.LoopModeEnum.Forward;

        // Assert
        stream.LoopMode.ShouldBe(AudioStreamWav.LoopModeEnum.Forward);
    }
```

**Returns:** `void`

### AudioStreamRandomizer_CanBeCreated

```csharp
#endregion

    #region AudioStreamRandomizer Tests

    [Test]
    public void AudioStreamRandomizer_CanBeCreated()
    {
        // Act
        var randomizer = new AudioStreamRandomizer();

        // Assert
        randomizer.ShouldNotBeNull();
    }
```

**Returns:** `void`

### AudioStreamRandomizer_RandomPitch_CanBeSet

```csharp
[Test]
    public void AudioStreamRandomizer_RandomPitch_CanBeSet()
    {
        // Arrange
        var randomizer = new AudioStreamRandomizer();

        // Act
        randomizer.RandomPitch = 1.2f;

        // Assert
        randomizer.RandomPitch.ShouldBe(1.2f);
    }
```

**Returns:** `void`

### AudioStreamRandomizer_RandomVolumeOffsetDb_CanBeSet

```csharp
[Test]
    public void AudioStreamRandomizer_RandomVolumeOffsetDb_CanBeSet()
    {
        // Arrange
        var randomizer = new AudioStreamRandomizer();

        // Act
        randomizer.RandomVolumeOffsetDb = 3.0f;

        // Assert
        randomizer.RandomVolumeOffsetDb.ShouldBe(3.0f);
    }
```

**Returns:** `void`

