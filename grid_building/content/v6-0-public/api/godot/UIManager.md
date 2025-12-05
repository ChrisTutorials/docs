---
title: "UIManager"
description: "Central UI manager for GridBuilding system
Coordinates UI components, handles user interactions, and manages UI state"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/uimanager/"
---

# UIManager

```csharp
GridBuilding.Godot.UI
class UIManager
{
    // Members...
}
```

Central UI manager for GridBuilding system
Coordinates UI components, handles user interactions, and manages UI state

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/UIManager.cs`  
**Namespace:** `GridBuilding.Godot.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### UIUpdateInterval

```csharp
#endregion

        #region Exported Properties

        /// <summary>
        /// UI update interval in seconds
        /// </summary>
        [Export]
        public float UIUpdateInterval { get; set; } = 0.1f;
```

UI update interval in seconds

### EnableAnimations

```csharp
/// <summary>
        /// Whether to enable UI animations
        /// </summary>
        [Export]
        public bool EnableAnimations { get; set; } = true;
```

Whether to enable UI animations

### AnimationDuration

```csharp
/// <summary>
        /// Animation duration in seconds
        /// </summary>
        [Export]
        public float AnimationDuration { get; set; } = 0.3f;
```

Animation duration in seconds

### ShowDebugInfo

```csharp
/// <summary>
        /// Whether to show debug information
        /// </summary>
        [Export]
        public bool ShowDebugInfo { get; set; } = false;
```

Whether to show debug information

### CurrentState

```csharp
#endregion

        #region Public Properties

        /// <summary>
        /// Current UI state
        /// </summary>
        public UIState CurrentState => _currentState;
```

Current UI state

### CurrentPlacementMode

```csharp
/// <summary>
        /// Current placement mode
        /// </summary>
        public PlacementMode CurrentPlacementMode => _currentPlacementMode;
```

Current placement mode

### SelectedPlaceableId

```csharp
/// <summary>
        /// Currently selected placeable ID
        /// </summary>
        public string SelectedPlaceableId => _selectedPlaceableId;
```

Currently selected placeable ID

### IsInitialized

```csharp
/// <summary>
        /// Whether the UI manager is initialized
        /// </summary>
        public bool IsInitialized => _isInitialized;
```

Whether the UI manager is initialized


## Methods

### _Ready

```csharp
#endregion

        #region Godot Methods

        public override void _Ready()
        {
            InitializeUIManager();
        }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
        {
            if (!_isInitialized)
                return;

            UpdateUIComponents((float)delta);
            HandleInput();
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### _Notification

```csharp
public override void _Notification(int what)
        {
            base._Notification(what);

            switch ((long)what)
            {
                case NotificationWMSizeChanged:
                    HandleScreenSizeChanged();
                    break;
                case NotificationTranslationChanged:
                    HandleTranslationChanged();
                    break;
            }
        }
```

**Returns:** `void`

**Parameters:**
- `int what`

### RegisterUIComponent

```csharp
/// <summary>
        /// Registers a UI component
        /// </summary>
        public void RegisterUIComponent(string name, IUIComponent component, Control control)
        {
            if (string.IsNullOrWhiteSpace(name))
            {
                GD.PrintErr("Cannot register UI component with null or empty name");
                return;
            }

            if (component == null)
            {
                GD.PrintErr($"Cannot register UI component '{name}': component is null");
                return;
            }

            if (control == null)
            {
                GD.PrintErr($"Cannot register UI component '{name}': control is null");
                return;
            }

            _uiComponents[name] = control;
            _uiComponentInterfaces[name] = component;

            // Connect to component events if possible
            if (component is Node componentNode)
            {
                ConnectComponentEvents(name, componentNode);
            }

            GD.Print($"Registered UI component: {name}");
        }
```

Registers a UI component

**Returns:** `void`

**Parameters:**
- `string name`
- `IUIComponent component`
- `Control control`

### UnregisterUIComponent

```csharp
/// <summary>
        /// Unregisters a UI component
        /// </summary>
        public void UnregisterUIComponent(string name)
        {
            if (_uiComponents.ContainsKey(name))
            {
                _uiComponents.Remove(name);
                _uiComponentInterfaces.Remove(name);
                GD.Print($"Unregistered UI component: {name}");
            }
        }
```

Unregisters a UI component

**Returns:** `void`

**Parameters:**
- `string name`

### SetUIState

```csharp
#endregion

        #region UI State Management

        /// <summary>
        /// Sets the current UI state
        /// </summary>
        public void SetUIState(UIState newState)
        {
            if (_currentState == newState)
                return;

            var previousState = _currentState;
            _currentState = newState;

            // Notify components of state change
            NotifyComponentsOfStateChange(previousState, newState);

            // Emit signal
            EmitSignal(SignalName.UIStateChanged, (int)newState);

            GD.Print($"UI state changed: {previousState} -> {newState}");
        }
```

Sets the current UI state

**Returns:** `void`

**Parameters:**
- `UIState newState`

### SetPlacementMode

```csharp
/// <summary>
        /// Sets the current placement mode
        /// </summary>
        public void SetPlacementMode(PlacementMode newMode)
        {
            if (_currentPlacementMode == newMode)
                return;

            var previousMode = _currentPlacementMode;
            _currentPlacementMode = newMode;

            // Update UI state based on placement mode
            UpdateUIStateFromPlacementMode();

            // Emit signal
            EmitSignal(SignalName.PlacementModeChanged, (int)newMode);

            GD.Print($"Placement mode changed: {previousMode} -> {newMode}");
        }
```

Sets the current placement mode

**Returns:** `void`

**Parameters:**
- `PlacementMode newMode`

### SelectPlaceable

```csharp
#endregion

        #region Placeable Selection

        /// <summary>
        /// Selects a placeable for placement
        /// </summary>
        public void SelectPlaceable(string placeableId)
        {
            if (string.IsNullOrWhiteSpace(placeableId))
            {
                GD.PrintErr("Cannot select placeable: ID is null or empty");
                return;
            }

            _selectedPlaceableId = placeableId;
            SetPlacementMode(PlacementMode.Place);

            // Emit signal
            EmitSignal(SignalName.PlaceableSelected, placeableId);

            GD.Print($"Selected placeable: {placeableId}");
        }
```

Selects a placeable for placement

**Returns:** `void`

**Parameters:**
- `string placeableId`

### ClearPlaceableSelection

```csharp
/// <summary>
        /// Clears the current placeable selection
        /// </summary>
        public void ClearPlaceableSelection()
        {
            _selectedPlaceableId = string.Empty;
            SetPlacementMode(PlacementMode.None);

            GD.Print("Cleared placeable selection");
        }
```

Clears the current placeable selection

**Returns:** `void`

### GetUIComponent

```csharp
#endregion

        #region UI Component Management

        /// <summary>
        /// Gets a UI component by name
        /// </summary>
        public T GetUIComponent<T>(string name) where T : class
        {
            if (_uiComponentInterfaces.TryGetValue(name, out var component))
            {
                return component as T;
            }
            return null;
        }
```

Gets a UI component by name

**Returns:** `T`

**Parameters:**
- `string name`

### GetUIControl

```csharp
/// <summary>
        /// Gets a UI control by name
        /// </summary>
        public Control GetUIControl(string name)
        {
            return _uiComponents.TryGetValue(name, out var control) ? control : null;
        }
```

Gets a UI control by name

**Returns:** `Control`

**Parameters:**
- `string name`

### ShowUIComponent

```csharp
/// <summary>
        /// Shows a UI component
        /// </summary>
        public void ShowUIComponent(string name, bool animate = true)
        {
            var control = GetUIControl(name);
            if (control == null)
            {
                GD.PrintErr($"UI component not found: {name}");
                return;
            }

            if (animate && EnableAnimations)
            {
                AnimateUIComponentIn(control);
            }
            else
            {
                control.Visible = true;
            }
        }
```

Shows a UI component

**Returns:** `void`

**Parameters:**
- `string name`
- `bool animate`

### HideUIComponent

```csharp
/// <summary>
        /// Hides a UI component
        /// </summary>
        public void HideUIComponent(string name, bool animate = true)
        {
            var control = GetUIControl(name);
            if (control == null)
            {
                GD.PrintErr($"UI component not found: {name}");
                return;
            }

            if (animate && EnableAnimations)
            {
                AnimateUIComponentOut(control);
            }
            else
            {
                control.Visible = false;
            }
        }
```

Hides a UI component

**Returns:** `void`

**Parameters:**
- `string name`
- `bool animate`

### ToggleUIComponent

```csharp
/// <summary>
        /// Toggles a UI component's visibility
        /// </summary>
        public void ToggleUIComponent(string name, bool animate = true)
        {
            var control = GetUIControl(name);
            if (control == null)
            {
                GD.PrintErr($"UI component not found: {name}");
                return;
            }

            if (control.Visible)
            {
                HideUIComponent(name, animate);
            }
            else
            {
                ShowUIComponent(name, animate);
            }
        }
```

Toggles a UI component's visibility

**Returns:** `void`

**Parameters:**
- `string name`
- `bool animate`

### TriggerUIAction

```csharp
#endregion

        #region UI Actions

        /// <summary>
        /// Triggers a UI action
        /// </summary>
        public void TriggerUIAction(string actionId, Variant data = default)
        {
            if (string.IsNullOrWhiteSpace(actionId))
            {
                GD.PrintErr("Cannot trigger UI action: ID is null or empty");
                return;
            }

            // Handle built-in actions
            HandleBuiltInAction(actionId, data);

            // Emit signal for external handling
            EmitSignal(SignalName.UIActionTriggered, actionId, data);

            GD.Print($"Triggered UI action: {actionId}");
        }
```

Triggers a UI action

**Returns:** `void`

**Parameters:**
- `string actionId`
- `Variant data`

### ToggleUIVisibility

```csharp
/// <summary>
        /// Toggles overall UI visibility
        /// </summary>
        public void ToggleUIVisibility()
        {
            Visible = !Visible;
            GD.Print($"UI visibility toggled: {Visible}");
        }
```

Toggles overall UI visibility

**Returns:** `void`

### GetDebugInfo

```csharp
#endregion

        #region Debug and Diagnostics

        /// <summary>
        /// Gets debug information about the UI manager
        /// </summary>
        public string GetDebugInfo()
        {
            var info = $"UIManager Debug Info:\n";
            info += $"State: {_currentState}\n";
            info += $"Placement Mode: {_currentPlacementMode}\n";
            info += $"Selected Placeable: {_selectedPlaceableId}\n";
            info += $"UI Components: {_uiComponents.Count}\n";
            info += $"Initialized: {_isInitialized}\n";
            info += $"Animations Enabled: {EnableAnimations}\n";

            if (ShowDebugInfo)
            {
                info += "\nRegistered Components:\n";
                foreach (var kvp in _uiComponents)
                {
                    var component = _uiComponentInterfaces[kvp.Key];
                    info += $"  {kvp.Key}: {component.GetType().Name} (Visible: {kvp.Value.Visible})\n";
                }
            }

            return info;
        }
```

Gets debug information about the UI manager

**Returns:** `string`

### PrintDebugInfo

```csharp
/// <summary>
        /// Prints debug information to the console
        /// </summary>
        public void PrintDebugInfo()
        {
            GD.Print(GetDebugInfo());
        }
```

Prints debug information to the console

**Returns:** `void`

### _ExitTree

```csharp
#endregion

        #region Cleanup

        /// <summary>
        /// Cleanup when the UI manager is destroyed
        /// </summary>
        public override void _ExitTree()
        {
            // Clean up timer
            if (_uiUpdateTimer != null)
            {
                _uiUpdateTimer.Timeout -= OnUIUpdateTimer;
                _uiUpdateTimer.QueueFree();
            }

            // Clear component references
            _uiComponents.Clear();
            _uiComponentInterfaces.Clear();

            _isInitialized = false;
        }
```

Cleanup when the UI manager is destroyed

**Returns:** `void`

