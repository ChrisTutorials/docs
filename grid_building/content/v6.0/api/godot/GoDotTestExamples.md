---
title: "GoDotTestExamples"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/godottestexamples/"
---

# GoDotTestExamples

```csharp
GridBuilding.Godot.Tests.GoDotTest
class GoDotTestExamples
{
    // Members...
}
```

Example tests demonstrating GoDotTest capabilities for Godot object integration
Shows how GoDotTest provides superior C# testing experience with full Godot access

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GoDotTestExamples.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up GoDotTest examples");
    }
```

**Returns:** `void`

### Setup

```csharp
[Setup]
    public void Setup()
    {
        // Create test nodes for each test
        _testNode2D = new Node2D();
        _testControl = new Control();
        
        _testScene.AddChild(_testNode2D);
        _testScene.AddChild(_testControl);
    }
```

**Returns:** `void`

### TestNode2D_Manipulation

```csharp
[Test]
    public void TestNode2D_Manipulation()
    {
        // Test direct Godot Node2D manipulation
        _testNode2D.Position = new Vector2(100, 200);
        _testNode2D.Rotation = Mathf.DegToRad(45);
        _testNode2D.Scale = new Vector2(2, 3);

        ;
        ;
        ;
    }
```

**Returns:** `void`

### TestControl_Layout

```csharp
[Test]
    public void TestControl_Layout()
    {
        // Test Control node layout properties
        _testControl.Position = new Vector2I(50, 75);
        _testControl.Size = new Vector2I(300, 200);
        _testControl.AnchorPreset = Control.Preset.FullRect;

        ;
        ;
        ;
    }
```

**Returns:** `void`

### TestSceneTree_Operations

```csharp
[Test]
    public void TestSceneTree_Operations()
    {
        // Test scene tree operations
        var childNode = new Node2D();
        _testNode2D.AddChild(childNode);
        
        ;
        Assert.IsType<Node2D>(childNode.GetParent());
        
        // Test node removal
        _testNode2D.RemoveChild(childNode);
        ;
    }
```

**Returns:** `void`

### TestSignal_Connection

```csharp
[Test]
    public void TestSignal_Connection()
    {
        // Test signal connection and emission
        bool signalReceived = false;
        
        _testNode2D.TreeEntered += () => signalReceived = true;
        
        // Re-add node to trigger signal
        _testScene.RemoveChild(_testNode2D);
        _testScene.AddChild(_testNode2D);
        
        ;
    }
```

**Returns:** `void`

### TestAsync_Operations

```csharp
[Test]
    public async void TestAsync_Operations()
    {
        // Test async operations with frame waiting
        var initialPosition = _testNode2D.Position;
        _testNode2D.Position = new Vector2(150, 250);
        
        // Wait for next frame
        await ToSignal(TestScene.GetTree().SceneTree, SceneTree.SignalName.ProcessFrame);
        
        ;
    }
```

**Returns:** `void`

### TestResource_Management

```csharp
[Test]
    public void TestResource_Management()
    {
        // Test resource creation and management
        var packedScene = new PackedScene();
        var testResource = new Resource();
        
        ;
        ;
        
        // Test resource properties
        testResource.SetMeta("test_key", "test_value");
        ;
    }
```

**Returns:** `void`

### TestInput_Event_Simulation

```csharp
[Test]
    public void TestInput_Event_Simulation()
    {
        // Test input event simulation
        var inputEvent = new InputEventMouseButton();
        inputEvent.ButtonIndex = MouseButton.Left;
        inputEvent.Pressed = true;
        inputEvent.Position = new Vector2I(100, 100);
        
        ;
        ;
        ;
    }
```

**Returns:** `void`

### TestPhysics_Calculations

```csharp
[Test]
    public void TestPhysics_Calculations()
    {
        // Test physics calculations with Godot types
        var rect1 = new Rect2(new Vector2(0, 0), new Vector2(100, 100));
        var rect2 = new Rect2(new Vector2(50, 50), new Vector2(100, 100));
        
        ;
        
        var intersection = rect1.Intersection(rect2);
        ;
    }
```

**Returns:** `void`

### TestTransform_Manipulation

```csharp
[Test]
    public void TestTransform_Manipulation()
    {
        // Test transform manipulation (similar to your use case)
        var transform = new Transform2D();
        transform = transform.Rotated(Mathf.DegToRad(45));
        transform = transform.Scaled(new Vector2(2, 2));
        transform = transform.Translated(new Vector2(100, 100));
        
        ;
        ;
    }
```

**Returns:** `void`

### Cleanup

```csharp
[Cleanup]
    public void Cleanup()
    {
        // Clean up test nodes
        if (_testNode2D != null && IsInstanceValid(_testNode2D))
        {
            _testNode2D.QueueFree();
        }
        if (_testControl != null && IsInstanceValid(_testControl))
        {
            _testControl.QueueFree();
        }
    }
```

**Returns:** `void`

### CleanupAll

```csharp
[CleanupAll]
    public void CleanupAll()
    {
        GD.Print("Cleaning up GoDotTest examples");
    }
```

**Returns:** `void`

### TestFailure

```csharp
[Failure]
    public void TestFailure()
    {
        GD.Print("A test failed in the GoDotTest examples suite");
    }
```

**Returns:** `void`

