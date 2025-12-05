---
title: "ManipulationLogic"
description: "Simplified state machine for building manipulation
Replaces LogicBlocks with a more direct implementation"
weight: 10
url: "/gridbuilding/v6-0/api/core/manipulationlogic/"
---

# ManipulationLogic

```csharp
GridBuilding.Core.State.Manipulation
class ManipulationLogic
{
    // Members...
}
```

Simplified state machine for building manipulation
Replaces LogicBlocks with a more direct implementation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationLogic.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetCurrentStateName

```csharp
/// <summary>
        /// Gets the current state name
        /// </summary>
        public string GetCurrentStateName() => _currentState?.Mode switch
        {
            ManipulationMode.Idle => "Idle",
            ManipulationMode.Place => "Building",
            ManipulationMode.Move => "Dragging",
            ManipulationMode.Rotate => "Rotating",
            ManipulationMode.Delete => "Deleting",
            _ => "Unknown"
        };
```

Gets the current state name

**Returns:** `string`

### GetCurrentData

```csharp
/// <summary>
        /// Gets the current manipulation data
        /// </summary>
        public ManipulationState? GetCurrentData() => _currentState;
```

Gets the current manipulation data

**Returns:** `ManipulationState?`

### IsInManipulationState

```csharp
/// <summary>
        /// Checks if currently in an active manipulation state
        /// </summary>
        public bool IsInManipulationState() => _currentState?.Mode switch
        {
            ManipulationMode.Place or ManipulationMode.Move or ManipulationMode.Rotate or ManipulationMode.Delete => true,
            _ => false
        };
```

Checks if currently in an active manipulation state

**Returns:** `bool`

### StartBuilding

```csharp
/// <summary>
        /// Start building a new structure
        /// </summary>
        public void StartBuilding(Vector2I position, BuildingData? buildingData)
        {
            _currentState = new ManipulationState(ManipulationMode.Place, position);
            if (buildingData != null)
            {
                _currentState.SetContextData("buildingData", buildingData);
            }
        }
```

Start building a new structure

**Returns:** `void`

**Parameters:**
- `Vector2I position`
- `BuildingData? buildingData`

### StartDragging

```csharp
/// <summary>
        /// Start dragging an object
        /// </summary>
        public void StartDragging(Vector2I position, object? draggedObject)
        {
            _currentState = new ManipulationState(ManipulationMode.Move, position);
            _currentState.SetContextData("draggedObject", draggedObject);
        }
```

Start dragging an object

**Returns:** `void`

**Parameters:**
- `Vector2I position`
- `object? draggedObject`

### StartRotating

```csharp
/// <summary>
        /// Start rotating an object
        /// </summary>
        public void StartRotating(Vector2I position, object? rotatingObject)
        {
            _currentState = new ManipulationState(ManipulationMode.Rotate, position);
            _currentState.SetContextData("rotatingObject", rotatingObject);
        }
```

Start rotating an object

**Returns:** `void`

**Parameters:**
- `Vector2I position`
- `object? rotatingObject`

### StartDeleting

```csharp
/// <summary>
        /// Start deleting objects
        /// </summary>
        public void StartDeleting()
        {
            _currentState = new ManipulationState(ManipulationMode.Delete, Vector2I.Zero);
        }
```

Start deleting objects

**Returns:** `void`

### Cancel

```csharp
/// <summary>
        /// Cancel the current manipulation
        /// </summary>
        public void Cancel()
        {
            _currentState?.CancelManipulation();
            _currentState = new ManipulationState(ManipulationMode.Idle, Vector2I.Zero);
        }
```

Cancel the current manipulation

**Returns:** `void`

### Finish

```csharp
/// <summary>
        /// Finish the current manipulation
        /// </summary>
        public void Finish()
        {
            _currentState?.CompleteManipulation();
            _currentState = new ManipulationState(ManipulationMode.Idle, Vector2I.Zero);
        }
```

Finish the current manipulation

**Returns:** `void`

### UpdateTarget

```csharp
/// <summary>
        /// Update the target position
        /// </summary>
        public void UpdateTarget(Vector2I position)
        {
            if (_currentState != null)
            {
                _currentState.UpdateTarget(position);
            }
        }
```

Update the target position

**Returns:** `void`

**Parameters:**
- `Vector2I position`

