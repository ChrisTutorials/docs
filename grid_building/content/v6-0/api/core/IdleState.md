---
title: "IdleState"
description: "Core manipulation state implementations
Pure C# implementations without Godot dependencies"
weight: 10
url: "/gridbuilding/v6-0/api/core/idlestate/"
---

# IdleState

```csharp
GridBuilding.Core.State.Manipulation
class IdleState
{
    // Members...
}
```

Core manipulation state implementations
Pure C# implementations without Godot dependencies

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationStates.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### EnterState

```csharp
public override void EnterState()
        {
            base.EnterState();
            // Set cursor to default - handled by Godot wrapper
        }
```

**Returns:** `void`

### HandleInput

```csharp
public override void HandleInput(InputEventData inputEvent)
        {
            base.HandleInput(inputEvent);
            
            // Check for building selection
            if (inputEvent.EventType == InputEventType.MouseButton && 
                inputEvent.Pressed && 
                inputEvent.MouseButton == MouseButton.Left)
            {
                // Try to select a building or start building
                var worldPosition = inputEvent.Position;
                StateMachine.TryStartBuilding(worldPosition);
            }
        }
```

**Returns:** `void`

**Parameters:**
- `InputEventData inputEvent`

