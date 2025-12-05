---
title: "ManipulationStateMachine"
description: "Core state machine for managing manipulation modes.
Uses string-based mode identifiers instead of concrete state classes,
following composition over inheritance pattern for AOT compatibility.
This is the pure C# implementation - the Godot layer wraps this with
Node-based states if needed."
weight: 10
url: "/gridbuilding/v6-0/api/core/manipulationstatemachine/"
---

# ManipulationStateMachine

```csharp
GridBuilding.Core.State.Manipulation
class ManipulationStateMachine
{
    // Members...
}
```

Core state machine for managing manipulation modes.
Uses string-based mode identifiers instead of concrete state classes,
following composition over inheritance pattern for AOT compatibility.
This is the pure C# implementation - the Godot layer wraps this with
Node-based states if needed.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/State/Manipulation/ManipulationStateMachine.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CurrentMode

```csharp
#endregion
        
        #region Properties
        
        /// <summary>
        /// Current manipulation mode
        /// </summary>
        public string CurrentMode => _currentMode;
```

Current manipulation mode

### IsIdle

```csharp
/// <summary>
        /// Whether the state machine is in idle mode
        /// </summary>
        public bool IsIdle => _currentMode == ModeIdle;
```

Whether the state machine is in idle mode

### EnableHistory

```csharp
/// <summary>
        /// Whether state history tracking is enabled
        /// </summary>
        public bool EnableHistory { get; set; } = true;
```

Whether state history tracking is enabled

### MaxHistorySize

```csharp
/// <summary>
        /// Maximum history size
        /// </summary>
        public int MaxHistorySize { get; set; } = 10;
```

Maximum history size

### HasHistory

```csharp
/// <summary>
        /// Whether the state machine has mode history
        /// </summary>
        public bool HasHistory => _modeHistory.Count > 0;
```

Whether the state machine has mode history

### ModeDuration

```csharp
/// <summary>
        /// Time spent in current mode (seconds)
        /// </summary>
        public double ModeDuration { get; private set; }
```

Time spent in current mode (seconds)

### CurrentData

```csharp
/// <summary>
        /// Current manipulation data
        /// </summary>
        public ManipulationData? CurrentData
        {
            get => _currentData;
            set => _currentData = value;
        }
```

Current manipulation data


## Methods

### Update

```csharp
#endregion
        
        #region Public Methods
        
        /// <summary>
        /// Updates the state machine
        /// </summary>
        /// <param name="delta">Time since last update</param>
        public void Update(double delta)
        {
            ModeDuration = GetCurrentTime() - _modeStartTime;
        }
```

Updates the state machine

**Returns:** `void`

**Parameters:**
- `double delta`

### TransitionTo

```csharp
/// <summary>
        /// Transitions to a new mode
        /// </summary>
        /// <param name="newMode">Target mode</param>
        /// <returns>True if transition succeeded</returns>
        public bool TransitionTo(string newMode)
        {
            if (string.IsNullOrEmpty(newMode))
            {
                TransitionFailed?.Invoke(_currentMode, newMode ?? "", "Mode cannot be null or empty");
                return false;
            }
            
            if (!_validModes.Contains(newMode))
            {
                TransitionFailed?.Invoke(_currentMode, newMode, $"Invalid mode: {newMode}");
                return false;
            }
            
            if (!CanTransitionTo(newMode))
            {
                TransitionFailed?.Invoke(_currentMode, newMode, $"Transition from {_currentMode} to {newMode} not allowed");
                return false;
            }
            
            var previousMode = _currentMode;
            
            // Exit current mode
            ModeExited?.Invoke(_currentMode);
            
            // Add to history if enabled
            if (EnableHistory && _currentMode != ModeIdle)
            {
                _modeHistory.Push(_currentMode);
                
                // Trim history to max size
                while (_modeHistory.Count > MaxHistorySize)
                {
                    var tempStack = new Stack<string>();
                    while (_modeHistory.Count > 1)
                    {
                        tempStack.Push(_modeHistory.Pop());
                    }
                    _modeHistory.Pop(); // Remove oldest
                    while (tempStack.Count > 0)
                    {
                        _modeHistory.Push(tempStack.Pop());
                    }
                }
            }
            
            // Enter new mode
            _currentMode = newMode;
            _modeStartTime = GetCurrentTime();
            ModeDuration = 0;
            
            ModeChanged?.Invoke(previousMode, newMode);
            ModeEntered?.Invoke(newMode);
            
            return true;
        }
```

Transitions to a new mode

**Returns:** `bool`

**Parameters:**
- `string newMode`

### TransitionToIdle

```csharp
/// <summary>
        /// Transitions to idle mode
        /// </summary>
        public bool TransitionToIdle() => TransitionTo(ModeIdle);
```

Transitions to idle mode

**Returns:** `bool`

### RevertToPrevious

```csharp
/// <summary>
        /// Reverts to the previous mode
        /// </summary>
        /// <returns>True if revert succeeded</returns>
        public bool RevertToPrevious()
        {
            if (_modeHistory.Count == 0)
            {
                return TransitionToIdle();
            }
            
            var previousMode = _modeHistory.Pop();
            return TransitionTo(previousMode);
        }
```

Reverts to the previous mode

**Returns:** `bool`

### CanTransitionTo

```csharp
/// <summary>
        /// Checks if a transition to the target mode is allowed
        /// </summary>
        /// <param name="targetMode">Target mode</param>
        /// <returns>True if transition is allowed</returns>
        public bool CanTransitionTo(string targetMode)
        {
            if (!_allowedTransitions.TryGetValue(_currentMode, out var allowed))
            {
                return true; // No restrictions configured
            }
            
            return allowed.Contains(targetMode);
        }
```

Checks if a transition to the target mode is allowed

**Returns:** `bool`

**Parameters:**
- `string targetMode`

### ConfigureTransitions

```csharp
/// <summary>
        /// Configures allowed transitions from a source mode
        /// </summary>
        /// <param name="fromMode">Source mode</param>
        /// <param name="toModes">Allowed target modes</param>
        public void ConfigureTransitions(string fromMode, params string[] toModes)
        {
            if (!_validModes.Contains(fromMode))
                return;
            
            _allowedTransitions[fromMode] = new HashSet<string>(toModes);
        }
```

Configures allowed transitions from a source mode

**Returns:** `void`

**Parameters:**
- `string fromMode`
- `string[] toModes`

### RegisterMode

```csharp
/// <summary>
        /// Registers a custom mode
        /// </summary>
        /// <param name="modeName">Mode name</param>
        public void RegisterMode(string modeName)
        {
            if (!string.IsNullOrEmpty(modeName))
            {
                _validModes.Add(modeName);
                _allowedTransitions[modeName] = new HashSet<string>(_validModes);
            }
        }
```

Registers a custom mode

**Returns:** `void`

**Parameters:**
- `string modeName`

### GetModeHistory

```csharp
/// <summary>
        /// Gets the mode history
        /// </summary>
        /// <returns>List of previous modes (most recent first)</returns>
        public List<string> GetModeHistory()
        {
            return new List<string>(_modeHistory);
        }
```

Gets the mode history

**Returns:** `List<string>`

### TryStartBuilding

```csharp
/// <summary>
        /// Attempts to start building at the specified position
        /// </summary>
        /// <param name="worldPosition">World position to start building</param>
        /// <returns>True if building started successfully</returns>
        public bool TryStartBuilding(Vector2I worldPosition)
        {
            // Transition to building mode if not already in it
            if (!TransitionTo(ModeBuilding))
                return false;
            
            // Store building position in current data
            _currentData = new ManipulationData
            {
                StartPosition = worldPosition,
                CurrentPosition = worldPosition
            };
            
            return true;
        }
```

Attempts to start building at the specified position

**Returns:** `bool`

**Parameters:**
- `Vector2I worldPosition`

### ClearHistory

```csharp
/// <summary>
        /// Clears the mode history
        /// </summary>
        public void ClearHistory()
        {
            _modeHistory.Clear();
        }
```

Clears the mode history

**Returns:** `void`

### Reset

```csharp
/// <summary>
        /// Resets the state machine to idle
        /// </summary>
        public void Reset()
        {
            _modeHistory.Clear();
            _currentMode = ModeIdle;
            _modeStartTime = GetCurrentTime();
            ModeDuration = 0;
            _currentData = null;
        }
```

Resets the state machine to idle

**Returns:** `void`

