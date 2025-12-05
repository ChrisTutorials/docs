---
title: "DraggingState"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/draggingstate/"
---

# DraggingState

```csharp
GridBuilding.Core.State.Manipulation
class DraggingState
{
    // Members...
}
```

Dragging state - active when dragging an object

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationStates.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DraggedObject

```csharp
public object DraggedObject => _draggedObject;
```

### StartGridPosition

```csharp
public Vector2I StartGridPosition => _startGridPosition;
```


## Methods

### EnterState

```csharp
public override void EnterState()
        {
            base.EnterState();
            
            if (_draggedObject != null)
            {
                var objectPosition = StateMachine.GetObjectWorldPosition(_draggedObject);
                var mousePosition = StateMachine.GetMouseWorldPosition();
                _dragOffset = objectPosition - mousePosition;
                _startGridPosition = StateMachine.WorldToGrid(objectPosition);
            }
        }
```

**Returns:** `void`

### UpdateState

```csharp
public override void UpdateState(double delta)
        {
            base.UpdateState(delta);
            
            if (_draggedObject != null)
            {
                var mousePosition = StateMachine.GetMouseWorldPosition();
                var newPosition = mousePosition + _dragOffset;
                StateMachine.SetObjectWorldPosition(_draggedObject, newPosition);
            }
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### HandleInput

```csharp
public override void HandleInput(InputEventData inputEvent)
        {
            base.HandleInput(inputEvent);
            
            if (inputEvent.EventType == InputEventType.MouseButton)
            {
                if (!inputEvent.Pressed && inputEvent.MouseButton == MouseButton.Left)
                {
                    // Finish dragging
                    var objectPosition = StateMachine.GetObjectWorldPosition(_draggedObject);
                    var endGridPosition = StateMachine.WorldToGrid(objectPosition);
                    StateMachine.FinishDragging(_draggedObject, _startGridPosition, endGridPosition);
                    StateMachine.TransitionToState(new IdleState());
                }
            }
            else if (inputEvent.EventType == InputEventType.Key && inputEvent.Pressed)
            {
                if (inputEvent.KeyCode == KeyCode.Escape)
                {
                    // Cancel dragging
                    StateMachine.CancelDragging(_draggedObject, _startGridPosition);
                    StateMachine.TransitionToState(new IdleState());
                }
            }
        }
```

**Returns:** `void`

**Parameters:**
- `InputEventData inputEvent`

