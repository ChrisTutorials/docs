---
title: "ManipulationStateMachineLogicBlocks"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/manipulationstatemachinelogicblocks/"
---

# ManipulationStateMachineLogicBlocks

```csharp
GridBuilding.Core.State.Manipulation
class ManipulationStateMachineLogicBlocks
{
    // Members...
}
```

LogicBlocks-based state machine for building manipulation
Provides the same public API as the original ManipulationStateMachine
but uses LogicBlocks internally for state management

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationStateMachineLogicBlocks.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### EnableStateHistory

```csharp
public bool EnableStateHistory { get; set; } = true;
```

### MaxHistorySize

```csharp
public int MaxHistorySize { get; set; } = 10;
```

### CurrentState

```csharp
// Public properties that map to LogicBlocks
        public ManipulationState? CurrentState => _logic.GetCurrentData();
```

### CurrentStateName

```csharp
public string CurrentStateName => _logic.GetCurrentStateName();
```

### HasStateHistory

```csharp
public bool HasStateHistory => _stateHistory?.Count > 0;
```


## Methods

### Update

```csharp
/// <summary>
        /// Updates the current state (for time-based operations)
        /// </summary>
        /// <param name="delta">Time since last update</param>
        public void Update(double delta)
        {
            // LogicBlocks doesn't have built-in update, but we can handle time-based logic here
            var currentState = _logic.GetCurrentData();
            if (currentState != null)
            {
                currentState.UpdateTimestamp();
            }
        }
```

Updates the current state (for time-based operations)

**Returns:** `void`

**Parameters:**
- `double delta`

### HandleInput

```csharp
/// <summary>
        /// Handles input events
        /// </summary>
        /// <param name="inputEvent">Input event data</param>
        public void HandleInput(InputEventData inputEvent)
        {
            var previousState = _logic.GetCurrentData();
            var previousStateName = _logic.GetCurrentStateName();
            
            // Send input to LogicBlocks
            _logic.Input(new ManipulationLogic.HandleInput(inputEvent));
            
            // Check for state changes and emit events
            HandleStateChange(previousState, previousStateName);
        }
```

Handles input events

**Returns:** `void`

**Parameters:**
- `InputEventData inputEvent`

### StartBuilding

```csharp
/// <summary>
        /// Starts a building manipulation
        /// </summary>
        /// <param name="position">Position to start building</param>
        /// <param name="buildingData">Building data to place</param>
        public void StartBuilding(Vector2I position, BuildingData? buildingData = null)
        {
            var previousState = _logic.GetCurrentData();
            var previousStateName = _logic.GetCurrentStateName();
            
            _logic.Input(new ManipulationLogic.StartBuilding(position, buildingData));
            
            HandleStateChange(previousState, previousStateName);
        }
```

Starts a building manipulation

**Returns:** `void`

**Parameters:**
- `Vector2I position`
- `BuildingData? buildingData`

### StartDragging

```csharp
/// <summary>
        /// Starts a dragging manipulation
        /// </summary>
        /// <param name="position">Position to start dragging</param>
        /// <param name="draggedObject">Object being dragged</param>
        public void StartDragging(Vector2I position, object? draggedObject = null)
        {
            var previousState = _logic.GetCurrentData();
            var previousStateName = _logic.GetCurrentStateName();
            
            _logic.Input(new ManipulationLogic.StartDragging(position, draggedObject));
            
            HandleStateChange(previousState, previousStateName);
        }
```

Starts a dragging manipulation

**Returns:** `void`

**Parameters:**
- `Vector2I position`
- `object? draggedObject`

### StartRotating

```csharp
/// <summary>
        /// Starts a rotating manipulation
        /// </summary>
        /// <param name="position">Position to start rotating</param>
        /// <param name="rotatingObject">Object being rotated</param>
        public void StartRotating(Vector2I position, object? rotatingObject = null)
        {
            var previousState = _logic.GetCurrentData();
            var previousStateName = _logic.GetCurrentStateName();
            
            _logic.Input(new ManipulationLogic.StartRotating(position, rotatingObject));
            
            HandleStateChange(previousState, previousStateName);
        }
```

Starts a rotating manipulation

**Returns:** `void`

**Parameters:**
- `Vector2I position`
- `object? rotatingObject`

### StartDeleting

```csharp
/// <summary>
        /// Starts a deleting manipulation
        /// </summary>
        public void StartDeleting()
        {
            var previousState = _logic.GetCurrentData();
            var previousStateName = _logic.GetCurrentStateName();
            
            _logic.Input(new ManipulationLogic.StartDeleting());
            
            HandleStateChange(previousState, previousStateName);
        }
```

Starts a deleting manipulation

**Returns:** `void`

### UpdateTarget

```csharp
/// <summary>
        /// Updates the target position
        /// </summary>
        /// <param name="position">New target position</param>
        public void UpdateTarget(Vector2I position)
        {
            _logic.Input(new ManipulationLogic.UpdateTarget(position));
        }
```

Updates the target position

**Returns:** `void`

**Parameters:**
- `Vector2I position`

### CancelManipulation

```csharp
/// <summary>
        /// Cancels the current manipulation
        /// </summary>
        public void CancelManipulation()
        {
            var previousState = _logic.GetCurrentData();
            var previousStateName = _logic.GetCurrentStateName();
            
            _logic.Input(new ManipulationLogic.Cancel());
            
            HandleStateChange(previousState, previousStateName);
        }
```

Cancels the current manipulation

**Returns:** `void`

### FinishManipulation

```csharp
/// <summary>
        /// Finishes the current manipulation
        /// </summary>
        public void FinishManipulation()
        {
            var previousState = _logic.GetCurrentData();
            var previousStateName = _logic.GetCurrentStateName();
            
            _logic.Input(new ManipulationLogic.Finish());
            
            HandleStateChange(previousState, previousStateName);
        }
```

Finishes the current manipulation

**Returns:** `void`

### GetCurrentCommand

```csharp
/// <summary>
        /// Gets the current command from the LogicBlocks state machine
        /// </summary>
        /// <returns>Current command or null if none</returns>
        public IManipulationCommand? GetCurrentCommand()
        {
            return _logic.CurrentState.Command;
        }
```

Gets the current command from the LogicBlocks state machine

**Returns:** `IManipulationCommand?`

### GetCurrentCommand

```csharp
/// <summary>
        /// Gets the current command, safely typed
        /// </summary>
        /// <typeparam name="T">Command type</typeparam>
        /// <returns>Command of specified type or null</returns>
        public T? GetCurrentCommand<T>() where T : class, IManipulationCommand
        {
            return _logic.CurrentState.GetCommand<T>();
        }
```

Gets the current command, safely typed

**Returns:** `T?`

### HasCurrentCommand

```csharp
/// <summary>
        /// Checks if the current state has a specific command type
        /// </summary>
        /// <typeparam name="T">Command type</typeparam>
        /// <returns>True if current state has the command</returns>
        public bool HasCurrentCommand<T>() where T : class, IManipulationCommand
        {
            return _logic.CurrentState.HasCommand<T>();
        }
```

Checks if the current state has a specific command type

**Returns:** `bool`

### RevertToPreviousState

```csharp
/// <summary>
        /// Reverts to the previous state
        /// </summary>
        /// <returns>True if revert was successful</returns>
        public bool RevertToPreviousState()
        {
            if (_stateHistory.Count == 0)
                return false;
                
            var previousState = _stateHistory.Pop();
            // LogicBlocks doesn't have direct state restoration, so we'd need to 
            // implement this based on the specific requirements
            return false;
        }
```

Reverts to the previous state

**Returns:** `bool`

### GetStateHistory

```csharp
/// <summary>
        /// Gets the state history
        /// </summary>
        /// <returns>List of previous state names</returns>
        public List<string> GetStateHistory()
        {
            var history = new List<string>();
            var tempStack = new Stack<ManipulationLogic.State>();
            
            // Copy stack to list
            while (_stateHistory.Count > 0)
            {
                var state = _stateHistory.Pop();
                history.Add(state.GetType().Name);
                tempStack.Push(state);
            }
            
            // Restore original stack
            while (tempStack.Count > 0)
            {
                _stateHistory.Push(tempStack.Pop());
            }
            
            return history;
        }
```

Gets the state history

**Returns:** `List<string>`

### ClearStateHistory

```csharp
/// <summary>
        /// Clears the state history
        /// </summary>
        public void ClearStateHistory()
        {
            _stateHistory.Clear();
        }
```

Clears the state history

**Returns:** `void`

### CanTransitionTo

```csharp
/// <summary>
        /// Checks if a transition is possible
        /// </summary>
        /// <param name="targetStateName">Name of target state</param>
        /// <returns>True if transition is possible</returns>
        public bool CanTransitionTo(string targetStateName)
        {
            // LogicBlocks handles transition validation internally
            // This would need to be implemented based on specific transition rules
            return true;
        }
```

Checks if a transition is possible

**Returns:** `bool`

**Parameters:**
- `string targetStateName`

### IsInManipulationState

```csharp
/// <summary>
        /// Checks if currently in an active manipulation state
        /// </summary>
        /// <returns>True if in manipulation state</returns>
        public bool IsInManipulationState()
        {
            return _logic.IsInManipulationState();
        }
```

Checks if currently in an active manipulation state

**Returns:** `bool`

### GetLogicBlocks

```csharp
/// <summary>
        /// Gets the LogicBlocks instance for advanced usage
        /// </summary>
        /// <returns>Internal LogicBlocks instance</returns>
        public ManipulationLogic GetLogicBlocks()
        {
            return _logic;
        }
```

Gets the LogicBlocks instance for advanced usage

**Returns:** `ManipulationLogic`

