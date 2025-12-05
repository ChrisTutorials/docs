---
title: "ModeTransitionManager"
description: "Manages mode transitions and transition history
Handles validation, constraints, and transition logic"
weight: 10
url: "/gridbuilding/v6-0/api/core/modetransitionmanager/"
---

# ModeTransitionManager

```csharp
GridBuilding.Core.State.Mode
class ModeTransitionManager
{
    // Members...
}
```

Manages mode transitions and transition history
Handles validation, constraints, and transition logic

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Mode/ModeTransitionManager.cs`  
**Namespace:** `GridBuilding.Core.State.Mode`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TransitionHistory

```csharp
/// <summary>
        /// Gets the transition history
        /// </summary>
        public List<ModeTransition> TransitionHistory => new List<ModeTransition>(_transitionHistory);
```

Gets the transition history

### LastTransitionTime

```csharp
/// <summary>
        /// Gets the last transition time
        /// </summary>
        public double LastTransitionTime => _lastTransitionTime;
```

Gets the last transition time

### CurrentModeContext

```csharp
/// <summary>
        /// Gets the current mode context
        /// </summary>
        public string CurrentModeContext => _currentModeContext;
```

Gets the current mode context

### IsTransitioning

```csharp
/// <summary>
        /// Whether currently transitioning
        /// </summary>
        public bool IsTransitioning => _isTransitioning;
```

Whether currently transitioning

### AllowModeTransitions

```csharp
/// <summary>
        /// Whether mode transitions are allowed
        /// </summary>
        public bool AllowModeTransitions
        {
            get => _allowModeTransitions;
            set => _allowModeTransitions = value;
        }
```

Whether mode transitions are allowed

### Permissions

```csharp
/// <summary>
        /// Current mode permissions
        /// </summary>
        public ModePermissions Permissions
        {
            get => _permissions;
            set => _permissions = value;
        }
```

Current mode permissions


## Methods

### RecordTransition

```csharp
/// <summary>
        /// Records a mode transition
        /// </summary>
        public void RecordTransition(string modeType, string fromMode, string toMode)
        {
            var transition = new ModeTransition
            {
                ModeType = modeType,
                FromMode = fromMode,
                ToMode = toMode,
                Timestamp = Time.GetUnixTimeFromSystem(),
                Context = _currentModeContext
            };
            
            _transitionHistory.Add(transition);
            _lastTransitionTime = transition.Timestamp;
            
            // Keep history size manageable
            if (_transitionHistory.Count > 100)
            {
                _transitionHistory.RemoveAt(0);
            }
        }
```

Records a mode transition

**Returns:** `void`

**Parameters:**
- `string modeType`
- `string fromMode`
- `string toMode`

### CanTransitionTo

```csharp
/// <summary>
        /// Checks if can transition to a mode
        /// </summary>
        public bool CanTransitionTo<T>(T mode) where T : System.Enum
        {
            // Check if transitions are allowed
            if (!_allowModeTransitions || _isTransitioning)
                return false;
                
            // Check permissions
            if (!HasPermissionForMode(mode))
                return false;
                
            // Check constraints
            foreach (var constraint in _constraints)
            {
                if (!constraint.AllowsTransition(mode))
                {
                    return false;
                }
            }
            
            return true;
        }
```

Checks if can transition to a mode

**Returns:** `bool`

**Parameters:**
- `T mode`

### StartTransition

```csharp
/// <summary>
        /// Starts a mode transition
        /// </summary>
        public void StartTransition()
        {
            _isTransitioning = true;
        }
```

Starts a mode transition

**Returns:** `void`

### EndTransition

```csharp
/// <summary>
        /// Ends a mode transition
        /// </summary>
        public void EndTransition()
        {
            _isTransitioning = false;
            _lastTransitionTime = Time.GetUnixTimeFromSystem();
        }
```

Ends a mode transition

**Returns:** `void`

### GetTransitionHistory

```csharp
/// <summary>
        /// Gets transition history for a specific mode type
        /// </summary>
        public List<ModeTransition> GetTransitionHistory(string modeType)
        {
            return _transitionHistory.FindAll(t => t.ModeType == modeType);
        }
```

Gets transition history for a specific mode type

**Returns:** `List<ModeTransition>`

**Parameters:**
- `string modeType`

### ClearTransitionHistory

```csharp
/// <summary>
        /// Clears transition history
        /// </summary>
        public void ClearTransitionHistory()
        {
            _transitionHistory.Clear();
        }
```

Clears transition history

**Returns:** `void`

### GetLastTransition

```csharp
/// <summary>
        /// Gets the most recent transition
        /// </summary>
        public ModeTransition? GetLastTransition()
        {
            if (_transitionHistory.Count == 0)
                return null;
                
            return _transitionHistory[_transitionHistory.Count - 1];
        }
```

Gets the most recent transition

**Returns:** `ModeTransition?`

### AddConstraint

```csharp
/// <summary>
        /// Adds a constraint
        /// </summary>
        public void AddConstraint(ModeConstraint constraint)
        {
            if (constraint != null && !_constraints.Contains(constraint))
            {
                _constraints.Add(constraint);
            }
        }
```

Adds a constraint

**Returns:** `void`

**Parameters:**
- `ModeConstraint constraint`

### RemoveConstraint

```csharp
/// <summary>
        /// Removes a constraint
        /// </summary>
        public bool RemoveConstraint(ModeConstraint constraint)
        {
            return _constraints.Remove(constraint);
        }
```

Removes a constraint

**Returns:** `bool`

**Parameters:**
- `ModeConstraint constraint`

### UpdateModeContext

```csharp
/// <summary>
        /// Updates the mode context
        /// </summary>
        public void UpdateModeContext(string context)
        {
            _currentModeContext = context ?? string.Empty;
        }
```

Updates the mode context

**Returns:** `void`

**Parameters:**
- `string context`

### GetAvailableModes

```csharp
/// <summary>
        /// Gets available modes
        /// </summary>
        public List<string> GetAvailableModes()
        {
            return new List<string>(_availableModes);
        }
```

Gets available modes

**Returns:** `List<string>`

### SetAvailableModes

```csharp
/// <summary>
        /// Sets available modes
        /// </summary>
        public void SetAvailableModes(List<string> modes)
        {
            _availableModes = modes ?? new List<string>();
        }
```

Sets available modes

**Returns:** `void`

**Parameters:**
- `List<string> modes`

