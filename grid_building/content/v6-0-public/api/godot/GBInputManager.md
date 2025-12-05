---
title: "GBInputManager"
description: ""
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/gbinputmanager/"
---

# GBInputManager

```csharp
GridBuilding.Godot.Input
class GBInputManager
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Input/InputManager.cs`  
**Namespace:** `GridBuilding.Godot.Input`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### InputEnabled

```csharp
// Legacy properties for backward compatibility
        [Export] public bool InputEnabled 
        { 
            get => _inputManagerNode?.InputEnabled ?? true; 
            set 
            { 
                if (_inputManagerNode != null)
                    _inputManagerNode.InputEnabled = value; 
            } 
        }
```

### EnableGestures

```csharp
[Export] public bool EnableGestures 
        { 
            get => _inputManagerNode?.GestureTimeout > 0 ?? false; 
            set 
            { 
                if (_inputManagerNode != null)
                    _inputManagerNode.GestureTimeout = value ? 1.0 : 0.0; 
            } 
        }
```

### GestureTimeout

```csharp
[Export] public double GestureTimeout 
        { 
            get => _inputManagerNode?.GestureTimeout ?? 1.0; 
            set 
            { 
                if (_inputManagerNode != null)
                    _inputManagerNode.GestureTimeout = value; 
            } 
        }
```

### GestureThreshold

```csharp
[Export] public float GestureThreshold 
        { 
            get => _inputManagerNode?.GestureThreshold ?? 50.0f; 
            set 
            { 
                if (_inputManagerNode != null)
                    _inputManagerNode.GestureThreshold = value; 
            } 
        }
```

### MouseDelta

```csharp
public Vector2 MouseDelta => _inputManagerNode?.MouseDelta ?? Vector2.Zero;
```

### LastMousePosition

```csharp
public Vector2 LastMousePosition => _inputManagerNode?.LastMousePosition ?? Vector2.Zero;
```

### IsGestureActive

```csharp
public bool IsGestureActive => _isGestureActive;
```

### CurrentGesture

```csharp
public GestureType CurrentGesture => _currentGesture;
```


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            base._Ready();
            
            // Create the new InputManagerNode
            _inputManagerNode = new InputManagerNode();
            _inputManagerNode.Name = "InputManagerNode";
            AddChild(_inputManagerNode);
            
            // Connect signals for backward compatibility
            _inputManagerNode.ActionPressed += OnActionPressed;
            _inputManagerNode.ActionReleased += OnActionReleased;
            _inputManagerNode.AxisChanged += OnAxisChanged;
            _inputManagerNode.GestureDetected += OnGestureDetected;
        }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
        {
            // Disconnect signals
            if (_inputManagerNode != null)
            {
                _inputManagerNode.ActionPressed -= OnActionPressed;
                _inputManagerNode.ActionReleased -= OnActionReleased;
                _inputManagerNode.AxisChanged -= OnAxisChanged;
                _inputManagerNode.GestureDetected -= OnGestureDetected;
            }
            
            base._ExitTree();
        }
```

**Returns:** `void`

### IsActionPressed

```csharp
#region Legacy API Methods
        
        /// <summary>
        /// Checks if an action is currently pressed
        /// </summary>
        /// <param name="actionName">Action name to check</param>
        /// <returns>True if action is pressed</returns>
        public bool IsActionPressed(string actionName)
        {
            return _inputManagerNode?.IsActionPressed(actionName) ?? false;
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
            return _inputManagerNode?.GetAxis(axisName) ?? 0.0f;
        }
```

Gets the current value of an axis

**Returns:** `float`

**Parameters:**
- `string axisName`

### GetPressedActions

```csharp
/// <summary>
        /// Gets all currently pressed actions
        /// </summary>
        /// <returns>Array of pressed action names</returns>
        public string[] GetPressedActions()
        {
            return _inputManagerNode?.GetPressedActions() ?? Array.Empty<string>();
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
        public int[] GetActiveGestures()
        {
            return _inputManagerNode?.GetActiveGestures() ?? Array.Empty<int>();
        }
```

Gets all active gestures

**Returns:** `int[]`

### ClearInputState

```csharp
/// <summary>
        /// Clears all input state
        /// </summary>
        public void ClearInputState()
        {
            _inputManagerNode?.ClearInputState();
        }
```

Clears all input state

**Returns:** `void`

### AddInputMapping

```csharp
/// <summary>
        /// Adds an input mapping
        /// </summary>
        /// <param name="actionName">Action name</param>
        /// <param name="godotAction">Godot input action name</param>
        public void AddInputMapping(string actionName, string godotAction)
        {
            _inputManagerNode?.AddGodotInputMapping(actionName, godotAction);
        }
```

Adds an input mapping

**Returns:** `void`

**Parameters:**
- `string actionName`
- `string godotAction`

