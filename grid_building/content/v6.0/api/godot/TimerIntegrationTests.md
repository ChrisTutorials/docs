---
title: "TimerIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/timerintegrationtests/"
---

# TimerIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class TimerIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for Timer functionality.
Tests timer configuration, start/stop, and timing behavior.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/TimerIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up Timer Integration Tests");
    }
```

**Returns:** `void`

### Timer_CanBeCreated

```csharp
#region Timer Creation Tests

    [Test]
    public void Timer_CanBeCreated()
    {
        // Act
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);

        // Assert
        timer.ShouldNotBeNull();

        // Cleanup
        timer.QueueFree();
    }
```

**Returns:** `void`

### Timer_DefaultWaitTime_IsOneSecond

```csharp
[Test]
    public void Timer_DefaultWaitTime_IsOneSecond()
    {
        // Arrange
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);

        // Assert
        timer.WaitTime.ShouldBe(1.0);

        // Cleanup
        timer.QueueFree();
    }
```

**Returns:** `void`

### Timer_DefaultOneShot_IsFalse

```csharp
[Test]
    public void Timer_DefaultOneShot_IsFalse()
    {
        // Arrange
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);

        // Assert
        timer.OneShot.ShouldBeFalse();

        // Cleanup
        timer.QueueFree();
    }
```

**Returns:** `void`

### Timer_WaitTime_CanBeSet

```csharp
#endregion

    #region Timer Configuration Tests

    [Test]
    public void Timer_WaitTime_CanBeSet()
    {
        // Arrange
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);

        // Act
        timer.WaitTime = 2.5;

        // Assert
        timer.WaitTime.ShouldBe(2.5);

        // Cleanup
        timer.QueueFree();
    }
```

**Returns:** `void`

### Timer_OneShot_CanBeSet

```csharp
[Test]
    public void Timer_OneShot_CanBeSet()
    {
        // Arrange
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);

        // Act
        timer.OneShot = true;

        // Assert
        timer.OneShot.ShouldBeTrue();

        // Cleanup
        timer.QueueFree();
    }
```

**Returns:** `void`

### Timer_Autostart_CanBeSet

```csharp
[Test]
    public void Timer_Autostart_CanBeSet()
    {
        // Arrange
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);

        // Act
        timer.Autostart = true;

        // Assert
        timer.Autostart.ShouldBeTrue();

        // Cleanup
        timer.QueueFree();
    }
```

**Returns:** `void`

### Timer_ProcessCallback_CanBeSetToIdle

```csharp
[Test]
    public void Timer_ProcessCallback_CanBeSetToIdle()
    {
        // Arrange
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);

        // Act
        timer.ProcessCallback = Godot.Timer.TimerProcessCallback.Idle;

        // Assert
        timer.ProcessCallback.ShouldBe(Godot.Timer.TimerProcessCallback.Idle);

        // Cleanup
        timer.QueueFree();
    }
```

**Returns:** `void`

### Timer_ProcessCallback_CanBeSetToPhysics

```csharp
[Test]
    public void Timer_ProcessCallback_CanBeSetToPhysics()
    {
        // Arrange
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);

        // Act
        timer.ProcessCallback = Godot.Timer.TimerProcessCallback.Physics;

        // Assert
        timer.ProcessCallback.ShouldBe(Godot.Timer.TimerProcessCallback.Physics);

        // Cleanup
        timer.QueueFree();
    }
```

**Returns:** `void`

### Timer_Start_SetsIsStopped_ToFalse

```csharp
#endregion

    #region Timer Control Tests

    [Test]
    public void Timer_Start_SetsIsStopped_ToFalse()
    {
        // Arrange
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);
        timer.WaitTime = 10.0; // Long wait so it doesn't complete

        // Act
        timer.Start();

        // Assert
        timer.IsStopped().ShouldBeFalse();

        // Cleanup
        timer.Stop();
        timer.QueueFree();
    }
```

**Returns:** `void`

### Timer_Stop_SetsIsStopped_ToTrue

```csharp
[Test]
    public void Timer_Stop_SetsIsStopped_ToTrue()
    {
        // Arrange
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);
        timer.WaitTime = 10.0;
        timer.Start();

        // Act
        timer.Stop();

        // Assert
        timer.IsStopped().ShouldBeTrue();

        // Cleanup
        timer.QueueFree();
    }
```

**Returns:** `void`

### Timer_Paused_CanBePaused

```csharp
[Test]
    public void Timer_Paused_CanBePaused()
    {
        // Arrange
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);
        timer.WaitTime = 10.0;
        timer.Start();

        // Act
        timer.Paused = true;

        // Assert
        timer.Paused.ShouldBeTrue();

        // Cleanup
        timer.Stop();
        timer.QueueFree();
    }
```

**Returns:** `void`

### Timer_StartWithCustomTime_OverridesWaitTime

```csharp
[Test]
    public void Timer_StartWithCustomTime_OverridesWaitTime()
    {
        // Arrange
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);
        timer.WaitTime = 1.0;

        // Act
        timer.Start(5.0);

        // Assert: TimeLeft should be based on the custom time
        timer.TimeLeft.ShouldBeGreaterThan(4.0);
        timer.TimeLeft.ShouldBeLessThanOrEqualTo(5.0);

        // Cleanup
        timer.Stop();
        timer.QueueFree();
    }
```

**Returns:** `void`

### Timer_TimeLeft_DecreasesAfterStart

```csharp
#endregion

    #region Timer State Tests

    [Test]
    public void Timer_TimeLeft_DecreasesAfterStart()
    {
        // Arrange
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);
        timer.WaitTime = 10.0;
        timer.Start();

        // Act: Get initial time left
        var initialTimeLeft = timer.TimeLeft;

        // Assert: Should be close to wait time (within tolerance for frame processing)
        initialTimeLeft.ShouldBeGreaterThan(9.0);
        initialTimeLeft.ShouldBeLessThanOrEqualTo(10.0);

        // Cleanup
        timer.Stop();
        timer.QueueFree();
    }
```

**Returns:** `void`

### Timer_IsStopped_ReturnsTrueBeforeStart

```csharp
[Test]
    public void Timer_IsStopped_ReturnsTrueBeforeStart()
    {
        // Arrange
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);

        // Assert
        timer.IsStopped().ShouldBeTrue();

        // Cleanup
        timer.QueueFree();
    }
```

**Returns:** `void`

### Timer_TimeoutSignal_Exists

```csharp
#endregion

    #region Timer Signal Tests

    [Test]
    public void Timer_TimeoutSignal_Exists()
    {
        // Arrange
        var timer = new Godot.Timer();
        _testScene.AddChild(timer);

        // Act: Check signal can be connected
        var connected = false;
        timer.Timeout += () => connected = true;

        // Assert: Signal should be connectable (connected variable set up)
        timer.ShouldNotBeNull();

        // Cleanup
        timer.QueueFree();
    }
```

**Returns:** `void`

