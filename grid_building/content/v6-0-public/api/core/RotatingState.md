---
title: "RotatingState"
description: "Rotating state - active when rotating an object"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/rotatingstate/"
---

# RotatingState

```csharp
GridBuilding.Core.State.Manipulation
class RotatingState
{
    // Members...
}
```

Rotating state - active when rotating an object

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationStates.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### RotatingObject

```csharp
public object RotatingObject => _rotatingObject;
```

### StartRotation

```csharp
public float StartRotation => _startRotation;
```


## Methods

### EnterState

```csharp
public override void EnterState()
        {
            base.EnterState();
            
            if (_rotatingObject != null)
            {
                _startRotation = StateMachine.GetObjectRotation(_rotatingObject);
                _rotationCenter = StateMachine.GetObjectWorldPosition(_rotatingObject);
            }
        }
```

**Returns:** `void`

### UpdateState

```csharp
public override void UpdateState(double delta)
        {
            base.UpdateState(delta);
            
            if (_rotatingObject != null)
            {
                var mousePosition = StateMachine.GetMouseWorldPosition();
                var angleToMouse = CalculateAngle(_rotationCenter, mousePosition);
                StateMachine.SetObjectRotation(_rotatingObject, angleToMouse);
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
                    // Finish rotating
                    var endRotation = StateMachine.GetObjectRotation(_rotatingObject);
                    StateMachine.FinishRotating(_rotatingObject, _startRotation, endRotation);
                    StateMachine.TransitionToState(new IdleState());
                }
            }
            else if (inputEvent.EventType == InputEventType.Key && inputEvent.Pressed)
            {
                if (inputEvent.KeyCode == KeyCode.Escape)
                {
                    // Cancel rotating
                    StateMachine.CancelRotating(_rotatingObject, _startRotation);
                    StateMachine.TransitionToState(new IdleState());
                }
            }
        }
```

**Returns:** `void`

**Parameters:**
- `InputEventData inputEvent`

