---
title: "SignalIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/signalintegrationtests/"
---

# SignalIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class SignalIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for Godot signals and async operations.
Tests signal emission, connection, and async await patterns.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/SignalIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up Signal Integration Tests");
    }
```

**Returns:** `void`

### Signal_CanBeConnected

```csharp
#region Basic Signal Tests

    [Test]
    public void Signal_CanBeConnected()
    {
        // Arrange
        var emitter = new TestSignalEmitter();
        _testScene.AddChild(emitter);
        var received = false;

        // Act: Use Callable for signal connection
        emitter.Connect(TestSignalEmitter.SignalName.TestSignal, Callable.From(() => received = true));
        emitter.EmitTestSignal();

        // Assert
        received.ShouldBeTrue("Signal should have been received");

        // Cleanup
        emitter.QueueFree();
    }
```

**Returns:** `void`

### Signal_WithParameters_PassesData

```csharp
[Test]
    public void Signal_WithParameters_PassesData()
    {
        // Arrange
        var emitter = new TestSignalEmitter();
        _testScene.AddChild(emitter);
        string? receivedValue = null;

        // Act
        emitter.Connect(TestSignalEmitter.SignalName.DataSignal, Callable.From((string value) => receivedValue = value));
        emitter.EmitDataSignal("test_data");

        // Assert
        receivedValue.ShouldBe("test_data");

        // Cleanup
        emitter.QueueFree();
    }
```

**Returns:** `void`

### Signal_MultipleListeners_AllReceive

```csharp
[Test]
    public void Signal_MultipleListeners_AllReceive()
    {
        // Arrange
        var emitter = new TestSignalEmitter();
        _testScene.AddChild(emitter);
        var count = 0;

        // Act
        emitter.Connect(TestSignalEmitter.SignalName.TestSignal, Callable.From(() => count++));
        emitter.Connect(TestSignalEmitter.SignalName.TestSignal, Callable.From(() => count++));
        emitter.Connect(TestSignalEmitter.SignalName.TestSignal, Callable.From(() => count++));
        emitter.EmitTestSignal();

        // Assert
        count.ShouldBe(3, "All listeners should have received the signal");

        // Cleanup
        emitter.QueueFree();
    }
```

**Returns:** `void`

### TreeEntered_FiredWhenAddedToScene

```csharp
#endregion

    #region Node Lifecycle Signal Tests

    [Test]
    public void TreeEntered_FiredWhenAddedToScene()
    {
        // Arrange
        var node = new Node();
        var treeEntered = false;
        node.TreeEntered += () => treeEntered = true;

        // Act
        _testScene.AddChild(node);

        // Assert
        treeEntered.ShouldBeTrue("TreeEntered should fire when added to scene");

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### TreeExiting_FiredWhenRemoved

```csharp
[Test]
    public void TreeExiting_FiredWhenRemoved()
    {
        // Arrange
        var node = new Node();
        var treeExiting = false;
        _testScene.AddChild(node);
        node.TreeExiting += () => treeExiting = true;

        // Act
        _testScene.RemoveChild(node);

        // Assert
        treeExiting.ShouldBeTrue("TreeExiting should fire when removed from scene");

        // Cleanup
        node.Free();
    }
```

**Returns:** `void`

### Ready_FiredAfterEnteringTree

```csharp
[Test]
    public void Ready_FiredAfterEnteringTree()
    {
        // Arrange
        var node = new TestReadyNode();
        
        // Act
        _testScene.AddChild(node);

        // Assert
        node.ReadyCalled.ShouldBeTrue("_Ready should be called after entering tree");

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### Timer_Timeout_FiredAfterWait

```csharp
#endregion

    #region Timer Signal Tests

    [Test]
    public async void Timer_Timeout_FiredAfterWait()
    {
        // Arrange
        var timer = new Godot.Timer();
        timer.OneShot = true;
        timer.WaitTime = 0.1; // 100ms
        _testScene.AddChild(timer);
        var timeoutFired = false;
        timer.Timeout += () => timeoutFired = true;

        // Act
        timer.Start();
        await _testScene.ToSignal(timer, Godot.Timer.SignalName.Timeout);

        // Assert
        timeoutFired.ShouldBeTrue("Timeout signal should have fired");

        // Cleanup
        timer.QueueFree();
    }
```

**Returns:** `void`

### Signal_WithMultipleParameters_AllReceived

```csharp
#endregion

    #region Custom Signal Value Tests

    [Test]
    public void Signal_WithMultipleParameters_AllReceived()
    {
        // Arrange
        var emitter = new TestSignalEmitter();
        _testScene.AddChild(emitter);
        Vector2 receivedPos = Vector2.Zero;
        int receivedId = -1;

        // Act
        emitter.Connect(TestSignalEmitter.SignalName.ComplexSignal, 
            Callable.From((Vector2 pos, int id) => 
            {
                receivedPos = pos;
                receivedId = id;
            }));
        emitter.EmitComplexSignal(new Vector2(100, 200), 42);

        // Assert
        receivedPos.ShouldBe(new Vector2(100, 200));
        receivedId.ShouldBe(42);

        // Cleanup
        emitter.QueueFree();
    }
```

**Returns:** `void`

