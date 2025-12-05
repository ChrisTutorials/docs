---
title: "IntegratedServicesDemo"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/integratedservicesdemo/"
---

# IntegratedServicesDemo

```csharp
GridBuilding.Godot.Demos
class IntegratedServicesDemo
{
    // Members...
}
```

Demo script showing how to use the integrated Indicator/Preview services.
This script demonstrates the new integrated services that use Core business logic
through interfaces while maintaining the same Godot API.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Demos/IntegratedServicesDemo.cs`  
**Namespace:** `GridBuilding.Godot.Demos`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _Ready

```csharp
#endregion

    #region Godot Lifecycle

    public override void _Ready()
    {
        base._Ready();
        
        GD.Print("=== Integrated Services Demo Starting ===");
        
        // Initialize dependencies
        InitializeDependencies();
        
        // Create test data
        CreateTestData();
        
        // Run demo scenarios
        RunDemoScenarios();
    }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
    {
        Cleanup();
        base._ExitTree();
    }
```

**Returns:** `void`

### _Input

```csharp
#endregion

    #region Input Handling

    /// <summary>
    /// Handles input for interactive demo features.
    /// </summary>
    public override void _Input(InputEvent @event)
    {
        if (@event is InputEventKey keyEvent && keyEvent.Pressed)
        {
            switch (keyEvent.Keycode)
            {
                case Key.I:
                    // Re-run indicator setup
                    GD.Print("Re-running indicator setup...");
                    DemoIndicatorSetup();
                    break;
                    
                case Key.P:
                    // Re-run preview creation
                    GD.Print("Re-running preview creation...");
                    DemoPreviewCreation();
                    break;
                    
                case Key.V:
                    // Re-run validation
                    GD.Print("Re-running validation...");
                    DemoValidation();
                    break;
                    
                case Key.Escape:
                    // Clean up and exit
                    Cleanup();
                    GetTree().Quit();
                    break;
            }
        }
    }
```

Handles input for interactive demo features.

**Returns:** `void`

**Parameters:**
- `InputEvent event`

