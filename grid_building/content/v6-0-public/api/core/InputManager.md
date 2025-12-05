---
title: "InputManager"
description: "Pure C# input manager for building systems
Handles input state management, gesture detection, and input mappings
Extracted from GBInputManager to enable unit testing and reusability"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/inputmanager/"
---

# InputManager

```csharp
GridBuilding.Core.Systems
class InputManager
{
    // Members...
}
```

Pure C# input manager for building systems
Handles input state management, gesture detection, and input mappings
Extracted from GBInputManager to enable unit testing and reusability

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/InputManager.cs`  
**Namespace:** `GridBuilding.Core.Systems`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### InputEnabled

```csharp
#endregion
        
        #region Public Properties
        
        public bool InputEnabled 
        { 
            get => _inputEnabled; 
            set => _inputEnabled = value; 
        }
```

### GestureTimeout

```csharp
public double GestureTimeout 
        { 
            get => _gestureTimeout; 
            set => _gestureTimeout = System.Math.Max(0.1, value); 
        }
```

### GestureThreshold

```csharp
public float GestureThreshold 
        { 
            get => _gestureThreshold; 
            set => _gestureThreshold = System.Math.Max(1.0f, value); 
        }
```

### MouseDelta

```csharp
public Vector2 MouseDelta => _mouseDelta;
```

### LastMousePosition

```csharp
public Vector2 LastMousePosition => _lastMousePosition;
```


## Methods

### ProcessInput

```csharp
#endregion
        
        #region Public Methods
        
        /// <summary>
        /// Processes an input event and updates internal state
        /// </summary>
        /// <param name="inputEvent">Input event data</param>
        public void ProcessInput(InputEventData inputEvent)
        {
            if (!_inputEnabled)
                return;
                
            switch (inputEvent.Type)
            {
                case InputEventType.ActionPress:
                    ProcessActionPress(inputEvent.ActionName, inputEvent.Position);
                    break;
                    
                case InputEventType.ActionRelease:
                    ProcessActionRelease(inputEvent.ActionName, inputEvent.Position);
                    break;
                    
                case InputEventType.Axis:
                    ProcessAxisInput(inputEvent.ActionName, inputEvent.AxisValue);
                    break;
                    
                case InputEventType.MouseMove:
                    ProcessMouseMove(inputEvent.Position);
                    break;
                    
                case InputEventType.Gesture:
                    ProcessGesture(inputEvent.GestureType, inputEvent.Position, inputEvent.GesturePoints);
                    break;
            }
        }
```

Processes an input event and updates internal state

**Returns:** `void`

**Parameters:**
- `InputEventData inputEvent`

### Update

```csharp
/// <summary>
        /// Updates axis states and gesture timeouts
        /// </summary>
        /// <param name="deltaTime">Time since last update</param>
        public void Update(double deltaTime)
        {
            UpdateGestureTimeouts(deltaTime);
        }
```

Updates axis states and gesture timeouts

**Returns:** `void`

**Parameters:**
- `double deltaTime`

### IsActionPressed

```csharp
/// <summary>
        /// Checks if an action is currently pressed
        /// </summary>
        /// <param name="actionName">Action name to check</param>
        /// <returns>True if action is pressed</returns>
        public bool IsActionPressed(string actionName)
        {
            return _actionStates.TryGetValue(actionName, out var pressed) && pressed;
        }
```

Checks if an action is currently pressed

**Returns:** `bool`

**Parameters:**
- `string actionName`

### GetAxis

```csharp
/// <summary>
        /// Gets the current value of an axis
        /// </summary>
        /// <param name="axisName">Axis name to check</param>
        /// <returns>Axis value (-1 to 1)</returns>
        public float GetAxis(string axisName)
        {
            return _axisStates.TryGetValue(axisName, out var value) ? value : 0.0f;
        }
```

Gets the current value of an axis

**Returns:** `float`

**Parameters:**
- `string axisName`

### AddInputMapping

```csharp
/// <summary>
        /// Adds an input mapping
        /// </summary>
        /// <param name="actionName">Action name</param>
        /// <param name="mapping">Input mapping</param>
        public void AddInputMapping(string actionName, InputMapping mapping)
        {
            if (!_inputMappings.ContainsKey(actionName))
                _inputMappings[actionName] = new List<InputMapping>();
                
            _inputMappings[actionName].Add(mapping);
        }
```

Adds an input mapping

**Returns:** `void`

**Parameters:**
- `string actionName`
- `InputMapping mapping`

### RemoveInputMappings

```csharp
/// <summary>
        /// Removes input mappings for an action
        /// </summary>
        /// <param name="actionName">Action name</param>
        public void RemoveInputMappings(string actionName)
        {
            _inputMappings.Remove(actionName);
        }
```

Removes input mappings for an action

**Returns:** `void`

**Parameters:**
- `string actionName`

### ClearInputState

```csharp
/// <summary>
        /// Clears all input state
        /// </summary>
        public void ClearInputState()
        {
            _actionStates.Clear();
            _axisStates.Clear();
            _activeGestures.Clear();
            _mouseDelta = Vector2.Zero;
        }
```

Clears all input state

**Returns:** `void`

### GetPressedActions

```csharp
/// <summary>
        /// Gets all currently pressed actions
        /// </summary>
        /// <returns>Array of pressed action names</returns>
        public string[] GetPressedActions()
        {
            return _actionStates.Where(kvp => kvp.Value)
                               .Select(kvp => kvp.Key)
                               .ToArray();
        }
```

Gets all currently pressed actions

**Returns:** `string[]`

### GetActiveGestures

```csharp
/// <summary>
        /// Gets all active gestures
        /// </summary>
        /// <returns>Array of active gesture types</returns>
        public GestureType[] GetActiveGestures()
        {
            return _activeGestures.Keys.ToArray();
        }
```

Gets all active gestures

**Returns:** `GestureType[]`

