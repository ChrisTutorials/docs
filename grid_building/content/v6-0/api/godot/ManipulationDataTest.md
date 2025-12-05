---
title: "ManipulationDataTest"
description: "Unit tests for ManipulationData.
Tests data management, signal emission, and validation.
Validates:
- Constructor initialization
- Status property and signal emission
- Object cleanup methods
- Validation logic
- Safe accessors"
weight: 20
url: "/gridbuilding/v6-0/api/godot/manipulationdatatest/"
---

# ManipulationDataTest

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class ManipulationDataTest
{
    // Members...
}
```

Unit tests for ManipulationData.
Tests data management, signal emission, and validation.
Validates:
- Constructor initialization
- Status property and signal emission
- Object cleanup methods
- Validation logic
- Safe accessors

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ManipulationDataTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Integration.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_SetsProperties_Correctly

```csharp
#region Constructor Tests

    /// <summary>
    /// Test: Constructor sets properties correctly
    /// </summary>
    [Test]
    public void Constructor_SetsProperties_Correctly()
    {
        var manipulator = new Node();
        TestScene.AddChild(manipulator);
        
        var source = new Manipulatable();
        TestScene.AddChild(source);
        
        var moveCopy = new Manipulatable();
        TestScene.AddChild(moveCopy);
        
        var action = ManipulationAction.MOVE;
        
        var data = new ManipulationData(manipulator, source, moveCopy, action);

        data.Manipulator.ShouldBe(manipulator, "Should set manipulator");
        data.Source.ShouldBe(source, "Should set source");
        data.MoveCopy.ShouldBe(moveCopy, "Should set move_copy");
        data.Action.ShouldBe(action, "Should set action");
        
        // Cleanup
        manipulator.QueueFree();
        source.QueueFree();
        moveCopy.QueueFree();
    }
```

Test: Constructor sets properties correctly

**Returns:** `void`

### DefaultStatus_IsCreated

```csharp
/// <summary>
    /// Test: Default status is CREATED
    /// </summary>
    [Test]
    public void DefaultStatus_IsCreated()
    {
        var data = new ManipulationData(null, null, null, ManipulationAction.MOVE);
        
        data.Status.ShouldBe(ManipulationStatus.CREATED, "Default status should be CREATED");
    }
```

Test: Default status is CREATED

**Returns:** `void`

### Constructor_WithNullValues_HandlesCorrectly

```csharp
/// <summary>
    /// Test: Constructor with null values
    /// </summary>
    [Test]
    public void Constructor_WithNullValues_HandlesCorrectly()
    {
        var data = new ManipulationData(null, null, null, ManipulationAction.DEMOLISH);
        
        data.Manipulator.ShouldBeNull();
        data.Source.ShouldBeNull();
        data.MoveCopy.ShouldBeNull();
        data.Action.ShouldBe(ManipulationAction.DEMOLISH);
    }
```

Test: Constructor with null values

**Returns:** `void`

### SettingStatus_EmitsSignal

```csharp
#endregion

    #region Status Signal Tests

    /// <summary>
    /// Test: Setting status emits status_changed signal
    /// </summary>
    [Test]
    public async Task SettingStatus_EmitsSignal()
    {
        var data = new ManipulationData(null, null, null, ManipulationAction.MOVE);
        
        var signalReceived = false;
        data.StatusChanged += () => signalReceived = true;
        
        data.Status = ManipulationStatus.STARTED;
        
        // Wait a bit for signal processing
        await TestScene.ToSignal(TestScene.GetTree().CreateTimer(0.1f), SceneTree.Timer.SignalName.Timeout);
        
        signalReceived.ShouldBeTrue("Setting status should emit status_changed signal");
    }
```

Test: Setting status emits status_changed signal

**Returns:** `Task`

### SettingSameStatus_DoesNotEmitSignal

```csharp
/// <summary>
    /// Test: Setting same status does not emit signal
    /// </summary>
    [Test]
    public async Task SettingSameStatus_DoesNotEmitSignal()
    {
        var data = new ManipulationData(null, null, null, ManipulationAction.MOVE);
        
        var signalCount = 0;
        data.StatusChanged += () => signalCount++;
        
        data.Status = ManipulationStatus.STARTED;
        
        // Wait a bit for signal processing
        await TestScene.ToSignal(TestScene.GetTree().CreateTimer(0.1f), SceneTree.Timer.SignalName.Timeout);
        
        var countAfterFirstSet = signalCount;
        
        data.Status = ManipulationStatus.STARTED; // Set same status again
        
        // Wait a bit for signal processing
        await TestScene.ToSignal(TestScene.GetTree().CreateTimer(0.1f), SceneTree.Timer.SignalName.Timeout);
        
        signalCount.ShouldBe(countAfterFirstSet, "Setting same status should not emit signal again");
    }
```

Test: Setting same status does not emit signal

**Returns:** `Task`

### StatusTransitions_EmitSignals

```csharp
/// <summary>
    /// Test: Status transitions emit signals
    /// </summary>
    [Test]
    public async Task StatusTransitions_EmitSignals()
    {
        var data = new ManipulationData(null, null, null, ManipulationAction.MOVE);
        
        var signalCount = 0;
        data.StatusChanged += () => signalCount++;
        
        data.Status = ManipulationStatus.STARTED;
        
        // Wait a bit for signal processing
        await TestScene.ToSignal(TestScene.GetTree().CreateTimer(0.1f), SceneTree.Timer.SignalName.Timeout);
        
        signalCount.ShouldBe(1, "First status change should emit signal");
        
        data.Status = ManipulationStatus.FINISHED;
        
        // Wait a bit for signal processing
        await TestScene.ToSignal(TestScene.GetTree().CreateTimer(0.1f), SceneTree.Timer.SignalName.Timeout);
        
        signalCount.ShouldBe(2, "Second status change should emit signal");
    }
```

Test: Status transitions emit signals

**Returns:** `Task`

### Cleanup_DisposesResources

```csharp
#endregion

    #region Cleanup Tests

    /// <summary>
    /// Test: Cleanup method properly disposes resources
    /// </summary>
    [Test]
    public void Cleanup_DisposesResources()
    {
        var manipulator = new Node();
        TestScene.AddChild(manipulator);
        
        var source = new Manipulatable();
        TestScene.AddChild(source);
        
        var moveCopy = new Manipulatable();
        TestScene.AddChild(moveCopy);
        
        var data = new ManipulationData(manipulator, source, moveCopy, ManipulationAction.MOVE);
        
        // Verify objects are set
        data.Manipulator.ShouldNotBeNull();
        data.Source.ShouldNotBeNull();
        data.MoveCopy.ShouldNotBeNull();
        
        // Call cleanup
        data.Cleanup();
        
        // After cleanup, references should be cleared
        data.Manipulator.ShouldBeNull();
        data.Source.ShouldBeNull();
        data.MoveCopy.ShouldBeNull();
        
        // Objects should still exist in the tree (cleanup doesn't queue free automatically)
        manipulator.IsInsideTree().ShouldBeTrue();
        source.IsInsideTree().ShouldBeTrue();
        moveCopy.IsInsideTree().ShouldBeTrue();
        
        // Manual cleanup for test
        manipulator.QueueFree();
        source.QueueFree();
        moveCopy.QueueFree();
    }
```

Test: Cleanup method properly disposes resources

**Returns:** `void`

### Validation_WorksCorrectly

```csharp
#endregion

    #region Validation Tests

    /// <summary>
    /// Test: Validation logic works correctly
    /// </summary>
    [Test]
    public void Validation_WorksCorrectly()
    {
        var manipulator = new Node();
        TestScene.AddChild(manipulator);
        
        var source = new Manipulatable();
        TestScene.AddChild(source);
        
        var data = new ManipulationData(manipulator, source, null, ManipulationAction.MOVE);
        
        // Valid data should pass validation
        data.IsValid().ShouldBeTrue("Data with required fields should be valid");
        
        // Test invalid data
        var invalidData = new ManipulationData(null, null, null, ManipulationAction.MOVE);
        invalidData.IsValid().ShouldBeFalse("Data without required fields should be invalid");
        
        // Cleanup
        manipulator.QueueFree();
        source.QueueFree();
    }
```

Test: Validation logic works correctly

**Returns:** `void`

### SafeAccessors_HandleNull

```csharp
#endregion

    #region Safe Accessor Tests

    /// <summary>
    /// Test: Safe accessors handle null correctly
    /// </summary>
    [Test]
    public void SafeAccessors_HandleNull()
    {
        var data = new ManipulationData(null, null, null, ManipulationAction.MOVE);
        
        // Safe accessors should not throw exceptions
        var manipulator = data.GetManipulatorSafely();
        var source = data.GetSourceSafely();
        var moveCopy = data.GetMoveCopySafely();
        
        manipulator.ShouldBeNull();
        source.ShouldBeNull();
        moveCopy.ShouldBeNull();
    }
```

Test: Safe accessors handle null correctly

**Returns:** `void`

### SafeAccessors_ReturnValidObjects

```csharp
/// <summary>
    /// Test: Safe accessors return valid objects
    /// </summary>
    [Test]
    public void SafeAccessors_ReturnValidObjects()
    {
        var manipulator = new Node();
        TestScene.AddChild(manipulator);
        
        var source = new Manipulatable();
        TestScene.AddChild(source);
        
        var data = new ManipulationData(manipulator, source, null, ManipulationAction.MOVE);
        
        // Safe accessors should return the correct objects
        var safeManipulator = data.GetManipulatorSafely();
        var safeSource = data.GetSourceSafely();
        var safeMoveCopy = data.GetMoveCopySafely();
        
        safeManipulator.ShouldBe(manipulator);
        safeSource.ShouldBe(source);
        safeMoveCopy.ShouldBeNull();
        
        // Cleanup
        manipulator.QueueFree();
        source.QueueFree();
    }
```

Test: Safe accessors return valid objects

**Returns:** `void`

