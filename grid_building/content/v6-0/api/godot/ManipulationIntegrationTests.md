---
title: "ManipulationIntegrationTests"
description: "GoDotTest integration tests for manipulation system
These will be backported to GDUnit GDScript tests (NOT GDUnit C#)"
weight: 20
url: "/gridbuilding/v6-0/api/godot/manipulationintegrationtests/"
---

# ManipulationIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class ManipulationIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for manipulation system
These will be backported to GDUnit GDScript tests (NOT GDUnit C#)

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ManipulationIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up Manipulation Integration Tests with GoDotTest");
    }
```

**Returns:** `void`

### Setup

```csharp
[Setup]
    public void Setup()
    {
        // Create manipulation system nodes
        _previewNode = new Node2D();
        _parentNode = new Node2D();
        _manipulationParent = new Node2D();
        
        // Configure scene hierarchy
        _testScene.AddChild(_parentNode);
        _parentNode.AddChild(_manipulationParent);
        _manipulationParent.AddChild(_previewNode);
        
        // Set initial positions
        _parentNode.Position = new Vector2(0, 0);
        _manipulationParent.GlobalPosition = new Vector2(100, 200);
    }
```

**Returns:** `void`

### TestManipulationTransformCalculation

```csharp
[Test]
    public void TestManipulationTransformCalculation()
    {
        // Arrange: Set up manipulation scenario
        _manipulationParent.GlobalPosition = new Vector2(300, 400);
        _manipulationParent.Rotation = Mathf.DegToRad(45);
        _manipulationParent.Scale = new Vector2(2.0f, 1.5f);
        
        // Act: Calculate final transform (simulating ManipulationTransformCalculator)
        var finalPosition = _manipulationParent.GlobalPosition;
        var finalRotation = _manipulationParent.Rotation;
        var finalScale = _manipulationParent.Scale;
        
        // Assert: Transform should match manipulation parent
        ;
        ;
        ;
    }
```

**Returns:** `void`

### TestManipulationFlipHorizontal

```csharp
[Test]
    public void TestManipulationFlipHorizontal()
    {
        // Arrange: Set up horizontal flip scenario
        _manipulationParent.Scale = new Vector2(-1.0f, 1.0f);
        _manipulationParent.GlobalPosition = new Vector2(150, 250);
        
        // Act: Check flip preservation
        var scale = _manipulationParent.Scale;
        var position = _manipulationParent.GlobalPosition;
        
        // Assert: Flip should be preserved
        ;
        ;
        ;
    }
```

**Returns:** `void`

### TestManipulationFlipVertical

```csharp
[Test]
    public void TestManipulationFlipVertical()
    {
        // Arrange: Set up vertical flip scenario
        _manipulationParent.Scale = new Vector2(1.0f, -1.0f);
        _manipulationParent.GlobalPosition = new Vector2(200, 300);
        
        // Act: Check flip preservation
        var scale = _manipulationParent.Scale;
        var position = _manipulationParent.GlobalPosition;
        
        // Assert: Vertical flip should be preserved
        ;
        ;
        ;
    }
```

**Returns:** `void`

### TestManipulationFlipBothAxes

```csharp
[Test]
    public void TestManipulationFlipBothAxes()
    {
        // Arrange: Set up both axes flip scenario
        _manipulationParent.Scale = new Vector2(-2.0f, -1.5f);
        _manipulationParent.GlobalPosition = new Vector2(175, 275);
        _manipulationParent.Rotation = Mathf.DegToRad(90);
        
        // Act: Check all properties preservation
        var scale = _manipulationParent.Scale;
        var position = _manipulationParent.GlobalPosition;
        var rotation = _manipulationParent.Rotation;
        
        // Assert: All transformations should be preserved
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### TestManipulationZeroScaleHandling

```csharp
[Test]
    public void TestManipulationZeroScaleHandling()
    {
        // Arrange: Set up zero scale scenario
        _manipulationParent.Scale = new Vector2(0.001f, 0.001f); // Near-zero scale
        
        // Act: Check zero scale handling
        var scale = _manipulationParent.Scale;
        
        // Assert: Should handle near-zero scale gracefully
        ;
        ;
        ; // Not exactly zero
    }
```

**Returns:** `void`

### TestManipulationInvalidValues

```csharp
[Test]
    public void TestManipulationInvalidValues()
    {
        // Arrange: Test invalid value scenarios
        var invalidPosition = new Vector2(float.NaN, float.PositiveInfinity);
        var invalidRotation = float.NaN;
        var invalidScale = new Vector2(float.NegativeInfinity, float.NaN);
        
        // Act & Assert: Should detect invalid values
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### TestManipulationTransformValidation

```csharp
[Test]
    public void TestManipulationTransformValidation()
    {
        // Arrange: Create valid transform
        _manipulationParent.GlobalPosition = new Vector2(100, 200);
        _manipulationParent.Rotation = Mathf.DegToRad(30);
        _manipulationParent.Scale = new Vector2(1.5f, 2.0f);
        
        // Act: Validate transform
        var position = _manipulationParent.GlobalPosition;
        var rotation = _manipulationParent.Rotation;
        var scale = _manipulationParent.Scale;
        
        // Assert: All components should be valid
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### TestManipulationParentHierarchy

```csharp
[Test]
    public void TestManipulationParentHierarchy()
    {
        // Arrange: Test parent-child relationships
        _parentNode.Position = new Vector2(50, 75);
        _manipulationParent.Position = new Vector2(25, 50);
        
        // Act: Check global positions
        var parentGlobal = _parentNode.GlobalPosition;
        var manipulationGlobal = _manipulationParent.GlobalPosition;
        var previewGlobal = _previewNode.GlobalPosition;
        
        // Assert: Global positions should be correctly calculated
        ;
        ; // parent + manipulation offset
        ; // preview follows manipulation parent
    }
```

**Returns:** `void`

### TestManipulationAsyncFrameOperations

```csharp
[Test]
    public async Task TestManipulationAsyncFrameOperations()
    {
        // Arrange: Set up async operation
        _manipulationParent.Position = new Vector2(0, 0);
        
        // Act: Change position and wait for frame
        _manipulationParent.Position = new Vector2(100, 150);
        await Task.Delay(16); // Simulate one frame at ~60fps
        
        // Assert: Position should be updated
        ;
    }
```

**Returns:** `Task`

### TestManipulationSignalEmission

```csharp
[Test]
    public void TestManipulationSignalEmission()
    {
        // Arrange: Set up signal tracking
        bool signalReceived = false;
        _manipulationParent.TreeEntered += () => signalReceived = true;
        
        // Act: Re-add node to trigger signal
        _parentNode.RemoveChild(_manipulationParent);
        _parentNode.AddChild(_manipulationParent);
        
        // Assert: Signal should be received
        ;
    }
```

**Returns:** `void`

### TestManipulationSceneTreeOperations

```csharp
[Test]
    public void TestManipulationSceneTreeOperations()
    {
        // Arrange: Create additional nodes
        var extraNode = new Node2D();
        var childNode = new Node2D();
        
        // Act: Add to scene tree
        _manipulationParent.AddChild(extraNode);
        extraNode.AddChild(childNode);
        
        // Assert: Scene tree relationships should be correct
        ;
        ;
        ;
        ;
        
        // Cleanup
        extraNode.RemoveChild(childNode);
        _manipulationParent.RemoveChild(extraNode);
        childNode.QueueFree();
        extraNode.QueueFree();
    }
```

**Returns:** `void`

### Cleanup

```csharp
[Cleanup]
    public void Cleanup()
    {
        // Clean up test nodes
        if (_previewNode != null && GodotObject.IsInstanceValid(_previewNode))
        {
            _previewNode.QueueFree();
        }
        if (_manipulationParent != null && GodotObject.IsInstanceValid(_manipulationParent))
        {
            _manipulationParent.QueueFree();
        }
        if (_parentNode != null && GodotObject.IsInstanceValid(_parentNode))
        {
            _parentNode.QueueFree();
        }
    }
```

**Returns:** `void`

### CleanupAll

```csharp
[CleanupAll]
    public void CleanupAll()
    {
        GD.Print("Cleaning up Manipulation Integration Tests");
    }
```

**Returns:** `void`

### TestFailure

```csharp
[Failure]
    public void TestFailure()
    {
        GD.Print("A test failed in the Manipulation Integration Tests suite");
    }
```

**Returns:** `void`

