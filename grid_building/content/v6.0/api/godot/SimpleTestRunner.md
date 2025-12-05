---
title: "SimpleTestRunner"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/simpletestrunner/"
---

# SimpleTestRunner

```csharp
GridBuilding.Tests.Godot
class SimpleTestRunner
{
    // Members...
}
```

Simple test runner to verify GoDotTest framework works.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/SimpleTestRunner.cs`  
**Namespace:** `GridBuilding.Tests.Godot`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _Ready

```csharp
public override void _Ready()
    {
        GD.Print("=== GoDotTest Framework Verification ===");
        
        try
        {
            // Test basic functionality
            var testNode = new Node();
            AddChild(testNode);
            
            GD.Print("✓ Node creation and scene tree integration works");
            GD.Print("✓ Godot runtime is accessible");
            GD.Print("✓ Test environment is ready");
            
            // Clean up
            testNode.QueueFree();
            
            GD.Print("=== GoDotTest Framework: WORKING ===");
        }
        catch (System.Exception ex)
        {
            GD.PrintErr($"✗ Test failed: {ex.Message}");
            GetTree().Quit(1);
            return;
        }
        
        GetTree().Quit(0);
    }
```

**Returns:** `void`

