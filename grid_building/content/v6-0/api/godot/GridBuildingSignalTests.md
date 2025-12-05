---
title: "GridBuildingSignalTests"
description: "Simple GridBuilding signal tests for GoDotTest framework.
Tests basic Godot signal functionality with supported types."
weight: 20
url: "/gridbuilding/v6-0/api/godot/gridbuildingsignaltests/"
---

# GridBuildingSignalTests

```csharp
GridBuilding.Tests.Godot
class GridBuildingSignalTests
{
    // Members...
}
```

Simple GridBuilding signal tests for GoDotTest framework.
Tests basic Godot signal functionality with supported types.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/SimpleSignalTests.cs`  
**Namespace:** `GridBuilding.Tests.Godot`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetUp

```csharp
[SetUp]
    public void SetUp()
    {
        _emitter = new SimpleSignalEmitter();
        TestScene.AddChild(_emitter);
    }
```

**Returns:** `void`

### TearDown

```csharp
[TearDown]
    public void TearDown()
    {
        _emitter?.QueueFree();
    }
```

**Returns:** `void`

### BasicSignals_ShouldEmitSuccessfully_WithoutErrors

```csharp
/// <summary>
    /// Tests basic signal emission with supported Godot types
    /// </summary>
    [Test]
    public void BasicSignals_ShouldEmitSuccessfully_WithoutErrors()
    {
        // Test string signals
        var exception = Record.Exception(() =>
        {
            _emitter.EmitBuildingStateChanged("Active");
        });
        Assert.Null(exception);

        // Test float signals  
        exception = Record.Exception(() =>
        {
            _emitter.EmitBuildingProgressUpdated(0.85f);
        });
        Assert.Null(exception);

        // Test bool signals
        exception = Record.Exception(() =>
        {
            _emitter.EmitReadyChanged(true);
        });
        Assert.Null(exception);

        // Test int signals
        exception = Record.Exception(() =>
        {
            _emitter.EmitMapsChanged(3);
        });
        Assert.Null(exception);
    }
```

Tests basic signal emission with supported Godot types

**Returns:** `void`

### Vector2ISignals_ShouldWork_Correctly

```csharp
/// <summary>
    /// Tests Vector2I signals with Godot's built-in type
    /// </summary>
    [Test]
    public void Vector2ISignals_ShouldWork_Correctly()
    {
        var position = new GodotVector2I(5, 10);
        
        var exception = Record.Exception(() =>
        {
            _emitter.EmitTargetPositionChanged(position);
        });
        Assert.Null(exception);
    }
```

Tests Vector2I signals with Godot's built-in type

**Returns:** `void`

### NodeSignals_ShouldWork_Correctly

```csharp
/// <summary>
    /// Tests Node signals with Godot Node types
    /// </summary>
    [Test]
    public void NodeSignals_ShouldWork_Correctly()
    {
        var targetNode = new Node2D();
        TestScene.AddChild(targetNode);

        var exception = Record.Exception(() =>
        {
            _emitter.EmitTargetChanged(targetNode);
        });
        Assert.Null(exception);

        // Cleanup
        targetNode.QueueFree();
    }
```

Tests Node signals with Godot Node types

**Returns:** `void`

