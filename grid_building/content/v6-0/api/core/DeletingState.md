---
title: "DeletingState"
description: "Deleting state - active when deleting objects"
weight: 10
url: "/gridbuilding/v6-0/api/core/deletingstate/"
---

# DeletingState

```csharp
GridBuilding.Core.State.Manipulation
class DeletingState
{
    // Members...
}
```

Deleting state - active when deleting objects

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationStates.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ObjectsToDelete

```csharp
public List<object> ObjectsToDelete => _objectsToDelete;
```


## Methods

### EnterState

```csharp
public override void EnterState()
        {
            base.EnterState();
            _objectsToDelete = new List<object>();
            _confirmDelete = false;
            // Set cursor to delete cursor - handled by Godot wrapper
        }
```

**Returns:** `void`

### HandleInput

```csharp
public override void HandleInput(InputEventData inputEvent)
        {
            base.HandleInput(inputEvent);
            
            if (inputEvent.EventType == InputEventType.MouseButton && inputEvent.Pressed)
            {
                if (inputEvent.MouseButton == MouseButton.Left)
                {
                    var worldPosition = inputEvent.Position;
                    var targetObject = StateMachine.GetObjectAtPosition(worldPosition);
                    
                    if (targetObject != null && StateMachine.CanDeleteObject(targetObject))
                    {
                        if (_confirmDelete)
                        {
                            // Delete the object
                            StateMachine.DeleteObject(targetObject);
                            _objectsToDelete.Remove(targetObject);
                        }
                        else
                        {
                            // Mark for deletion
                            _objectsToDelete.Add(targetObject);
                            StateMachine.MarkForDeletion(targetObject);
                        }
                    }
                }
            }
            else if (inputEvent.EventType == InputEventType.Key && inputEvent.Pressed)
            {
                switch (inputEvent.KeyCode)
                {
                    case KeyCode.Escape:
                        // Cancel deletion
                        StateMachine.CancelDeletion(_objectsToDelete);
                        StateMachine.TransitionToState(new IdleState());
                        break;
                    case KeyCode.Enter:
                        // Confirm deletion
                        _confirmDelete = true;
                        StateMachine.ConfirmDeletion(_objectsToDelete);
                        StateMachine.TransitionToState(new IdleState());
                        break;
                }
            }
        }
```

**Returns:** `void`

**Parameters:**
- `InputEventData inputEvent`

