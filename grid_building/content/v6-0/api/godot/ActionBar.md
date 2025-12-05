---
title: "ActionBar"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/actionbar/"
---

# ActionBar

```csharp
GridBuilding.Godot.UI
class ActionBar
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/ActionBar.cs`  
**Namespace:** `GridBuilding.Godot.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### MaxActions

```csharp
[Export] public int MaxActions { get; set; } = 8;
```

### ActionSpacing

```csharp
[Export] public float ActionSpacing { get; set; } = 5.0f;
```

### AllowMultiSelect

```csharp
[Export] public bool AllowMultiSelect { get; set; } = false;
```

### ShowBackground

```csharp
[Export] public bool ShowBackground { get; set; } = true;
```

### ActionButtonSize

```csharp
[Export] public Vector2I ActionButtonSize { get; set; } = new Vector2I(64, 64);
```

### SelectedAction

```csharp
public ActionButton SelectedAction => _selectedAction;
```

### ActionCount

```csharp
public int ActionCount => _actions?.Count ?? 0;
```

### HasSelection

```csharp
public bool HasSelection => _selectedAction != null;
```


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            base._Ready();
            
            _actions = new Dictionary<string, ActionButton>();
            
            // Create UI structure
            CreateUI();
            
            // Set up styling
            SetupStyling();
            
            // Set up layout
            UpdateLayout();
        }
```

**Returns:** `void`

### _Notification

```csharp
public override void _Notification(int what)
        {
            base._Notification(what);
            
            if (what == NotificationResized)
            {
                UpdateLayout();
            }
            else if (what == NotificationThemeChanged)
            {
                SetupStyling();
            }
        }
```

**Returns:** `void`

**Parameters:**
- `int what`

### AddAction

```csharp
/// <summary>
        /// Adds an action to the action bar
        /// </summary>
        /// <param name="actionId">Unique identifier for the action</param>
        /// <param name="text">Display text for the action</param>
        /// <param name="icon">Optional icon for the action</param>
        /// <param name="tooltip">Optional tooltip text</param>
        /// <returns>True if action was added successfully</returns>
        public bool AddAction(string actionId, string text, Texture2D icon = null, string tooltip = null)
        {
            if (string.IsNullOrEmpty(actionId))
            {
                GD.PrintErr("Action ID cannot be null or empty");
                return false;
            }
            
            if (_actions.ContainsKey(actionId))
            {
                GD.PrintErr($"Action '{actionId}' already exists in action bar");
                return false;
            }
            
            if (_actions.Count >= MaxActions)
            {
                GD.PrintErr($"Maximum actions ({MaxActions}) reached in action bar");
                return false;
            }
            
            // Create action button
            var button = new ActionButton(actionId, text, icon);
            button.CustomMinimumSize = ActionButtonSize.ToGodot();
            button.TooltipText = tooltip ?? text;
            
            // Connect button signals
            button.Pressed += () => OnActionPressed(actionId);
            button.MouseEntered += () => OnActionHovered(actionId);
            button.MouseExited += () => OnActionUnhovered(actionId);
            button.Selected += () => OnActionSelected(actionId);
            button.Deselected += () => OnActionDeselected(actionId);
            
            // Add to container
            _actionContainer.AddChild(button);
            _actions[actionId] = button;
            
            // Update layout
            UpdateLayout();
            
            return true;
        }
```

Adds an action to the action bar

**Returns:** `bool`

**Parameters:**
- `string actionId`
- `string text`
- `Texture2D icon`
- `string tooltip`

### RemoveAction

```csharp
/// <summary>
        /// Removes an action from the action bar
        /// </summary>
        /// <param name="actionId">ID of the action to remove</param>
        /// <returns>True if action was removed successfully</returns>
        public bool RemoveAction(string actionId)
        {
            if (!_actions.ContainsKey(actionId))
                return false;
                
            var button = _actions[actionId];
            
            // Deselect if this was the selected action
            if (_selectedAction == button)
            {
                DeselectAction(actionId);
            }
            
            // Remove from container and dictionary
            _actionContainer.RemoveChild(button);
            button.QueueFree();
            _actions.Remove(actionId);
            
            // Update layout
            UpdateLayout();
            
            return true;
        }
```

Removes an action from the action bar

**Returns:** `bool`

**Parameters:**
- `string actionId`

### ClearActions

```csharp
/// <summary>
        /// Clears all actions from the action bar
        /// </summary>
        public void ClearActions()
        {
            foreach (var action in _actions.Values)
            {
                _actionContainer.RemoveChild(action);
                action.QueueFree();
            }
            
            _actions.Clear();
            _selectedAction = null;
            
            UpdateLayout();
        }
```

Clears all actions from the action bar

**Returns:** `void`

### SelectAction

```csharp
/// <summary>
        /// Selects an action
        /// </summary>
        /// <param name="actionId">ID of the action to select</param>
        /// <returns>True if action was selected successfully</returns>
        public bool SelectAction(string actionId)
        {
            if (!_actions.ContainsKey(actionId))
                return false;
                
            var button = _actions[actionId];
            
            // If multi-select is not allowed, deselect current action
            if (!AllowMultiSelect && _selectedAction != null && _selectedAction != button)
            {
                _selectedAction.IsSelected = false;
                EmitSignal(SignalName.ActionDeselected, _selectedAction.ActionId);
            }
            
            // Select the new action
            _selectedAction = button;
            button.IsSelected = true;
            
            EmitSignal(SignalName.ActionSelected, actionId);
            
            return true;
        }
```

Selects an action

**Returns:** `bool`

**Parameters:**
- `string actionId`

### DeselectAction

```csharp
/// <summary>
        /// Deselects an action
        /// </summary>
        /// <param name="actionId">ID of the action to deselect</param>
        /// <returns>True if action was deselected successfully</returns>
        public bool DeselectAction(string actionId)
        {
            if (!_actions.ContainsKey(actionId))
                return false;
                
            var button = _actions[actionId];
            
            if (_selectedAction == button)
            {
                _selectedAction = null;
                button.IsSelected = false;
                
                EmitSignal(SignalName.ActionDeselected, actionId);
            }
            
            return true;
        }
```

Deselects an action

**Returns:** `bool`

**Parameters:**
- `string actionId`

### DeselectAllActions

```csharp
/// <summary>
        /// Deselects all actions
        /// </summary>
        public void DeselectAllActions()
        {
            if (_selectedAction != null)
            {
                var previousSelected = _selectedAction;
                _selectedAction = null;
                previousSelected.IsSelected = false;
                
                EmitSignal(SignalName.ActionDeselected, previousSelected.ActionId);
            }
        }
```

Deselects all actions

**Returns:** `void`

### GetAction

```csharp
/// <summary>
        /// Gets an action by ID
        /// </summary>
        /// <param name="actionId">ID of the action to get</param>
        /// <returns>The action button, or null if not found</returns>
        public ActionButton GetAction(string actionId)
        {
            return _actions.TryGetValue(actionId, out var action) ? action : null;
        }
```

Gets an action by ID

**Returns:** `ActionButton`

**Parameters:**
- `string actionId`

### HasAction

```csharp
/// <summary>
        /// Checks if an action exists
        /// </summary>
        /// <param name="actionId">ID of the action to check</param>
        /// <returns>True if the action exists</returns>
        public bool HasAction(string actionId)
        {
            return _actions.ContainsKey(actionId);
        }
```

Checks if an action exists

**Returns:** `bool`

**Parameters:**
- `string actionId`

### SetActionEnabled

```csharp
/// <summary>
        /// Enables or disables an action
        /// </summary>
        /// <param name="actionId">ID of the action to enable/disable</param>
        /// <param name="enabled">Whether the action should be enabled</param>
        /// <returns>True if the action state was set successfully</returns>
        public bool SetActionEnabled(string actionId, bool enabled)
        {
            var action = GetAction(actionId);
            if (action != null)
            {
                action.Disabled = !enabled;
                return true;
            }
            return false;
        }
```

Enables or disables an action

**Returns:** `bool`

**Parameters:**
- `string actionId`
- `bool enabled`

### SetActionVisible

```csharp
/// <summary>
        /// Shows or hides an action
        /// </summary>
        /// <param name="actionId">ID of the action to show/hide</param>
        /// <param name="visible">Whether the action should be visible</param>
        /// <returns>True if the action visibility was set successfully</returns>
        public bool SetActionVisible(string actionId, bool visible)
        {
            var action = GetAction(actionId);
            if (action != null)
            {
                action.Visible = visible;
                UpdateLayout();
                return true;
            }
            return false;
        }
```

Shows or hides an action

**Returns:** `bool`

**Parameters:**
- `string actionId`
- `bool visible`

