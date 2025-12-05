---
title: "BuildingManipulationState"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/buildingmanipulationstate/"
---

# BuildingManipulationState

```csharp
GridBuilding.Core.State.Manipulation
class BuildingManipulationState
{
    // Members...
}
```

Building manipulation state - active when placing a new building

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationStates.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CurrentBuilding

```csharp
public BuildingData CurrentBuilding => _currentBuilding;
```

### CurrentGridPosition

```csharp
public Vector2I CurrentGridPosition => _currentGridPosition;
```

### IsValidPlacement

```csharp
public bool IsValidPlacement => _isValidPlacement;
```


## Methods

### EnterState

```csharp
public override void EnterState()
        {
            base.EnterState();
            // Set cursor to building cursor - handled by Godot wrapper
        }
```

**Returns:** `void`

### UpdateState

```csharp
public override void UpdateState(double delta)
        {
            base.UpdateState(delta);
            
            // Update building position based on mouse
            var worldPosition = StateMachine.GetMouseWorldPosition();
            var gridPosition = StateMachine.WorldToGrid(worldPosition);
            
            if (gridPosition != _currentGridPosition)
            {
                _currentGridPosition = gridPosition;
                UpdatePlacementValidity();
                StateMachine.UpdateBuildingPreview(gridPosition, _isValidPlacement);
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
                if (inputEvent.Pressed && inputEvent.MouseButton == MouseButton.Left)
                {
                    if (_isValidPlacement)
                    {
                        // Place the building
                        StateMachine.PlaceBuilding(_currentBuilding, _currentGridPosition);
                        StateMachine.TransitionToState(new IdleState());
                    }
                }
                else if (inputEvent.Pressed && inputEvent.MouseButton == MouseButton.Right)
                {
                    // Cancel building
                    StateMachine.CancelBuilding();
                    StateMachine.TransitionToState(new IdleState());
                }
            }
            else if (inputEvent.EventType == InputEventType.Key && inputEvent.Pressed)
            {
                switch (inputEvent.KeyCode)
                {
                    case KeyCode.Escape:
                        StateMachine.CancelBuilding();
                        StateMachine.TransitionToState(new IdleState());
                        break;
                    case KeyCode.R:
                        // Rotate building
                        StateMachine.RotateBuilding();
                        break;
                }
            }
        }
```

**Returns:** `void`

**Parameters:**
- `InputEventData inputEvent`

### SetBuilding

```csharp
public void SetBuilding(BuildingData building)
        {
            _currentBuilding = building;
        }
```

**Returns:** `void`

**Parameters:**
- `BuildingData building`

