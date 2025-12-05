---
title: "InputManagerNode"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/inputmanagernode/"
---

# InputManagerNode

```csharp
GridBuilding.Godot.Input
class InputManagerNode
{
    // Members...
}
```

Godot node wrapper for Core InputManager
Bridges Godot input events to Core POCS logic
Maintains scene tree integration while using pure C# input management

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Input/InputManagerNode.cs`  
**Namespace:** `GridBuilding.Godot.Input`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### InputEnabled

```csharp
#endregion
        
        #region Export Properties
        
        [Export] public bool InputEnabled 
        { 
            get => _inputManager.InputEnabled; 
            set => _inputManager.InputEnabled = value; 
        }
```

### GestureTimeout

```csharp
[Export] public double GestureTimeout 
        { 
            get => _inputManager.GestureTimeout; 
            set => _inputManager.GestureTimeout = value; 
        }
```

### GestureThreshold

```csharp
[Export] public float GestureThreshold 
        { 
            get => _inputManager.GestureThreshold; 
            set => _inputManager.GestureThreshold = value; 
        }
```

### InputManager

```csharp
#endregion
        
        #region Public Properties
        
        /// <summary>
        /// Access to the core input manager
        /// </summary>
        public InputManager InputManager => _inputManager;
```

Access to the core input manager

### MouseDelta

```csharp
public Vector2 MouseDelta => _inputManager.MouseDelta.ToGodot();
```

### LastMousePosition

```csharp
public Vector2 LastMousePosition => _inputManager.LastMousePosition.ToGodot();
```


## Methods

### _Ready

```csharp
#endregion
        
        #region Godot Lifecycle
        
        public override void _Ready()
        {
            base._Ready();
            
            // Subscribe to Core events
            _inputManager.ActionPressed += OnCoreActionPressed;
            _inputManager.ActionReleased += OnCoreActionReleased;
            _inputManager.AxisChanged += OnCoreAxisChanged;
            _inputManager.GestureDetected += OnCoreGestureDetected;
            
            // Initialize input mappings
            InitializeInputMappings();
        }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
        {
            // Unsubscribe from Core events
            _inputManager.ActionPressed -= OnCoreActionPressed;
            _inputManager.ActionReleased -= OnCoreActionReleased;
            _inputManager.AxisChanged -= OnCoreAxisChanged;
            _inputManager.GestureDetected -= OnCoreGestureDetected;
            
            base._ExitTree();
        }
```

**Returns:** `void`

### _Input

```csharp
public override void _Input(InputEvent @event)
        {
            base._Input(@event);
            
            if (!_inputManager.InputEnabled)
                return;
                
            ProcessGodotInputEvent(@event);
        }
```

**Returns:** `void`

**Parameters:**
- `InputEvent event`

### _Process

```csharp
public override void _Process(double delta)
        {
            base._Process(delta);
            
            // Update Core input manager
            _inputManager.Update(delta);
            
            // Update mouse delta tracking
            UpdateMouseTracking();
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### IsActionPressed

```csharp
#endregion
        
        #region Public Methods
        
        /// <summary>
        /// Checks if an action is currently pressed
        /// </summary>
        /// <param name="actionName">Action name to check</param>
        /// <returns>True if action is pressed</returns>
        public bool IsActionPressed(string actionName)
        {
            return _inputManager.IsActionPressed(actionName);
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
            return _inputManager.GetAxis(axisName);
        }
```

Gets the current value of an axis

**Returns:** `float`

**Parameters:**
- `string axisName`

### AddGodotInputMapping

```csharp
/// <summary>
        /// Adds an input mapping from Godot input to Core action
        /// </summary>
        /// <param name="actionName">Core action name</param>
        /// <param name="godotAction">Godot input action name</param>
        public void AddGodotInputMapping(string actionName, string godotAction)
        {
            var mapping = new InputMapping
            {
                InputName = godotAction,
                InputType = DetermineInputType(godotAction)
            };
            
            _inputManager.AddInputMapping(actionName, mapping);
        }
```

Adds an input mapping from Godot input to Core action

**Returns:** `void`

**Parameters:**
- `string actionName`
- `string godotAction`

### ClearInputState

```csharp
/// <summary>
        /// Clears all input state
        /// </summary>
        public void ClearInputState()
        {
            _inputManager.ClearInputState();
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
            return _inputManager.GetPressedActions();
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
            var coreGestures = _inputManager.GetActiveGestures();
            return Array.ConvertAll(coreGestures, g => (int)g);
        }
```

Gets all active gestures

**Returns:** `int[]`

