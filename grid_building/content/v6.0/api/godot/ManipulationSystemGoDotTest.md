---
title: "ManipulationSystemGoDotTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/manipulationsystemgodottest/"
---

# ManipulationSystemGoDotTest

```csharp
GridBuilding.Godot.Tests.GoDotTest
class ManipulationSystemGoDotTest
{
    // Members...
}
```

Advanced example showing integration with your manipulation system
Demonstrates how GoDotTest handles complex Godot object interactions

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GoDotTestExamples.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Setup

```csharp
[Setup]
    public void Setup()
    {
        _previewNode = new Node2D();
        _parentNode = new Node2D();
        
        _testScene.AddChild(_previewNode);
        _testScene.AddChild(_parentNode);
    }
```

**Returns:** `void`

### TestManipulationTransform_Calculation

```csharp
[Test]
    public void TestManipulationTransform_Calculation()
    {
        // Setup manipulation scenario
        _parentNode.GlobalPosition = new Vector2(200, 300);
        _parentNode.Rotation = Mathf.DegToRad(90);
        _parentNode.Scale = new Vector2(-1, 1); // Flipped horizontally

        // Simulate transform calculation (similar to your ManipulationTransformCalculator)
        var finalPosition = _parentNode.GlobalPosition;
        var finalRotation = _parentNode.Rotation;
        var finalScale = _parentNode.Scale;

        ;
        ;
        ;
    }
```

**Returns:** `void`

### TestManipulation_State_Validation

```csharp
[Test]
    public void TestManipulation_State_Validation()
    {
        // Test manipulation state validation
        var isValid = _parentNode != null && _previewNode != null;
        var hasValidTransform = _parentNode.Scale != Vector2.Zero;
        var hasValidPosition = !float.IsInfinity(_parentNode.Position.X) && 
                              !float.IsInfinity(_parentNode.Position.Y);

        ;
        ;
        ;
    }
```

**Returns:** `void`

### TestManipulation_Flip_Semantics

```csharp
[Test]
    public void TestManipulation_Flip_Semantics()
    {
        // Test flip semantics preservation
        _parentNode.Scale = new Vector2(-1, -2); // Flipped both axes
        
        var scaleX = _parentNode.Scale.X;
        var scaleY = _parentNode.Scale.Y;
        
        ;
        ;
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
        if (_previewNode != null && IsInstanceValid(_previewNode))
        {
            _previewNode.QueueFree();
        }
        if (_parentNode != null && IsInstanceValid(_parentNode))
        {
            _parentNode.QueueFree();
        }
    }
```

**Returns:** `void`

