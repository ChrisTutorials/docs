---
title: "DragManagerGoDotTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/dragmanagergodottests/"
---

# DragManagerGoDotTests

```csharp
GridBuilding.Godot.Tests.Building
class DragManagerGoDotTests
{
    // Members...
}
```

GoDotTest-based integration tests for the Godot DragManager node.
Focuses on behavior that requires real Godot node lifecycle:
- Input processing toggling via SetTestMode.
- Physics and input processing enabled on _Ready.
These tests are a C# GoDotTest counterpart to the legacy
GdUnit DragManager tests in the grid_building GDScript suite.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Building/DragManagerGoDotTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Building`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Setup

```csharp
[Setup]
    public void Setup()
    {
        _dragManager = new DragManager();
        _testScene.AddChild(_dragManager);
    }
```

**Returns:** `void`

### Cleanup

```csharp
[Cleanup]
    public void Cleanup()
    {
        if (_dragManager is not null && IsInstanceValid(_dragManager))
        {
            _dragManager.QueueFree();
        }
    }
```

**Returns:** `void`

### DragManager_Ready_EnablesPhysicsAndInputProcessing

```csharp
/// <summary>
    /// Verifies that DragManager enables physics and input processing
    /// when added to the scene tree and _Ready is called.
    /// </summary>
    [Test]
    public void DragManager_Ready_EnablesPhysicsAndInputProcessing()
    {
        _dragManager.IsProcessingInput().ShouldBeTrue();
        _dragManager.IsPhysicsProcessing().ShouldBeTrue();
    }
```

Verifies that DragManager enables physics and input processing
when added to the scene tree and _Ready is called.

**Returns:** `void`

### SetTestMode_ControlsInputProcessing

```csharp
/// <summary>
    /// Mirrors legacy GDScript test_set_test_mode_controls_input_processing:
    /// - Input processing enabled by default
    /// - Disabled when SetTestMode(true)
    /// - Re-enabled when SetTestMode(false)
    /// </summary>
    [Test]
    public void SetTestMode_ControlsInputProcessing()
    {
        _dragManager.IsProcessingInput().ShouldBeTrue();

        _dragManager.SetTestMode(true);
        _dragManager.IsProcessingInput().ShouldBeFalse();

        _dragManager.SetTestMode(false);
        _dragManager.IsProcessingInput().ShouldBeTrue();
    }
```

Mirrors legacy GDScript test_set_test_mode_controls_input_processing:
- Input processing enabled by default
- Disabled when SetTestMode(true)
- Re-enabled when SetTestMode(false)

**Returns:** `void`

### ResetPhysicsFrameGate_IsCallableInScene

```csharp
/// <summary>
    /// Smoke test for ResetPhysicsFrameGate to ensure it is callable
    /// in a real Godot scene without throwing or corrupting state.
    /// More detailed behavior tests will be added when the
    /// DragManager physics-gated build logic is implemented.
    /// </summary>
    [Test]
    public void ResetPhysicsFrameGate_IsCallableInScene()
    {
        _dragManager.ResetPhysicsFrameGate();
    }
```

Smoke test for ResetPhysicsFrameGate to ensure it is callable
in a real Godot scene without throwing or corrupting state.
More detailed behavior tests will be added when the
DragManager physics-gated build logic is implemented.

**Returns:** `void`

