---
title: "ActionTooltip"
description: "Action tooltip component for displaying contextual information
Provides hover tooltips for UI actions with customizable content and styling
Ported from: godot/addons/grid_building/ui/action_tooltip.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/actiontooltip/"
---

# ActionTooltip

```csharp
GridBuilding.Godot.UI
class ActionTooltip
{
    // Members...
}
```

Action tooltip component for displaying contextual information
Provides hover tooltips for UI actions with customizable content and styling
Ported from: godot/addons/grid_building/ui/action_tooltip.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/ActionTooltip.cs`  
**Namespace:** `GridBuilding.Godot.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### AutoShow

```csharp
#endregion

        #region Exported Properties

        /// <summary>
        /// Whether to automatically show on hover
        /// </summary>
        [Export]
        public bool AutoShow { get; set; } = true;
```

Whether to automatically show on hover

### ShowDelay

```csharp
/// <summary>
        /// Delay before showing tooltip (seconds)
        /// </summary>
        [Export]
        public float ShowDelay { get; set; } = 0.5f;
```

Delay before showing tooltip (seconds)

### HideDelay

```csharp
/// <summary>
        /// Delay before hiding tooltip (seconds)
        /// </summary>
        public float HideDelay
        {
            get => _hideDelay;
            set => SetHideDelay(value);
        }
```

Delay before hiding tooltip (seconds)

### FollowMouse

```csharp
/// <summary>
        /// Whether to follow mouse position
        /// </summary>
        [Export]
        public bool FollowMouse { get; set; } = true;
```

Whether to follow mouse position

### MaxWidth

```csharp
/// <summary>
        /// Maximum width of tooltip
        /// </summary>
        [Export]
        public float MaxWidth { get; set; } = 300.0f;
```

Maximum width of tooltip

### AutoWrap

```csharp
/// <summary>
        /// Whether to wrap text automatically
        /// </summary>
        [Export]
        public bool AutoWrap { get; set; } = true;
```

Whether to wrap text automatically

### CursorMargin

```csharp
/// <summary>
        /// Margin from cursor position
        /// </summary>
        [Export]
        public Vector2 CursorMargin { get; set; } = new Vector2(10, 10);
```

Margin from cursor position

### BackgroundColor

```csharp
/// <summary>
        /// Background color
        /// </summary>
        [Export]
        public Color BackgroundColor { get; set; } = new Color(0.1f, 0.1f, 0.1f, 0.9f);
```

Background color

### TextColor

```csharp
/// <summary>
        /// Text color
        /// </summary>
        [Export]
        public Color TextColor { get; set; } = Colors.White;
```

Text color

### TitleColor

```csharp
/// <summary>
        /// Title color
        /// </summary>
        [Export]
        public Color TitleColor { get; set; } = new Color(1.0f, 0.8f, 0.4f, 1.0f);
```

Title color

### CurrentActionId

```csharp
#endregion

        #region Public Properties

        /// <summary>
        /// Current action ID being displayed
        /// </summary>
        public string CurrentActionId => _currentActionId;
```

Current action ID being displayed

### IsVisible

```csharp
/// <summary>
        /// Whether tooltip is currently visible
        /// </summary>
        public bool IsVisible => _isVisible;
```

Whether tooltip is currently visible

### RegisteredCount

```csharp
/// <summary>
        /// Number of registered tooltip data entries
        /// </summary>
        public int RegisteredCount => _tooltipData.Count;
```

Number of registered tooltip data entries


## Methods

### _Ready

```csharp
#endregion

        #region Godot Methods

        public override void _Ready()
        {
            InitializeTooltip();
        }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
        {
            if (_isVisible && FollowMouse)
            {
                UpdatePosition();
            }
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### _ExitTree

```csharp
public override void _ExitTree()
        {
            CleanupTooltip();
        }
```

**Returns:** `void`

### ShowTooltip

```csharp
#endregion

        #region Tooltip Management

        /// <summary>
        /// Shows tooltip for specified action
        /// </summary>
        /// <param name="actionId">Action ID to display</param>
        /// <param name="position">Optional position override</param>
        public void ShowTooltip(string actionId, Vector2? position = null)
        {
            if (string.IsNullOrWhiteSpace(actionId))
                return;

            if (!_tooltipData.TryGetValue(actionId, out var data))
            {
                GD.PrintErr($"No tooltip data registered for action: {actionId}");
                return;
            }

            _currentActionId = actionId;
            UpdateContent(data);

            if (position.HasValue)
            {
                GlobalPosition = position.Value;
            }
            else if (FollowMouse)
            {
                UpdatePosition();
            }

            Visible = true;
            _isVisible = true;

            // Cancel any pending hide
            _hideTimer.Stop();

            EmitSignal(SignalName.TooltipShown, actionId);
        }
```

Shows tooltip for specified action

**Returns:** `void`

**Parameters:**
- `string actionId`
- `Vector2? position`

### HideTooltip

```csharp
/// <summary>
        /// Hides the tooltip
        /// </summary>
        /// <param name="delay">Optional delay before hiding</param>
        public void HideTooltip(float delay = -1)
        {
            if (!_isVisible)
                return;

            if (delay < 0)
            {
                // Hide immediately
                Visible = false;
                _isVisible = false;
                _currentActionId = string.Empty;

                EmitSignal(SignalName.TooltipHidden, _currentActionId);
            }
            else
            {
                // Hide with delay
                _hideTimer.WaitTime = delay;
                _hideTimer.Start();
            }
        }
```

Hides the tooltip

**Returns:** `void`

**Parameters:**
- `float delay`

### RegisterTooltipData

```csharp
/// <summary>
        /// Registers tooltip data for an action
        /// </summary>
        /// <param name="actionId">Action ID</param>
        /// <param name="data">Tooltip data</param>
        public void RegisterTooltipData(string actionId, TooltipData data)
        {
            if (string.IsNullOrWhiteSpace(actionId) || data == null)
                return;

            _tooltipData[actionId] = data;
        }
```

Registers tooltip data for an action

**Returns:** `void`

**Parameters:**
- `string actionId`
- `TooltipData data`

### UnregisterTooltipData

```csharp
/// <summary>
        /// Unregisters tooltip data for an action
        /// </summary>
        /// <param name="actionId">Action ID</param>
        public void UnregisterTooltipData(string actionId)
        {
            _tooltipData.Remove(actionId);
        }
```

Unregisters tooltip data for an action

**Returns:** `void`

**Parameters:**
- `string actionId`

### GetTooltipData

```csharp
/// <summary>
        /// Gets tooltip data for an action
        /// </summary>
        /// <param name="actionId">Action ID</param>
        /// <returns>Tooltip data or null if not found</returns>
        public TooltipData GetTooltipData(string actionId)
        {
            return _tooltipData.TryGetValue(actionId, out var data) ? data : null;
        }
```

Gets tooltip data for an action

**Returns:** `TooltipData`

**Parameters:**
- `string actionId`

### CreateSimpleData

```csharp
#endregion

        #region Utility Methods

        /// <summary>
        /// Creates tooltip data from simple strings
        /// </summary>
        public static TooltipData CreateSimpleData(string title, string description = "")
        {
            return new TooltipData
            {
                Title = title,
                Description = description
            };
        }
```

Creates tooltip data from simple strings

**Returns:** `TooltipData`

**Parameters:**
- `string title`
- `string description`

### CreateRichData

```csharp
/// <summary>
        /// Creates tooltip data with rich content
        /// </summary>
        public static TooltipData CreateRichData(string title, string description, string richContent)
        {
            return new TooltipData
            {
                Title = title,
                Description = description,
                RichContent = richContent
            };
        }
```

Creates tooltip data with rich content

**Returns:** `TooltipData`

**Parameters:**
- `string title`
- `string description`
- `string richContent`

### GetRegisteredActionIds

```csharp
/// <summary>
        /// Gets all registered action IDs
        /// </summary>
        public string[] GetRegisteredActionIds()
        {
            var ids = new string[_tooltipData.Count];
            _tooltipData.Keys.CopyTo(ids, 0);
            return ids;
        }
```

Gets all registered action IDs

**Returns:** `string[]`

### ClearAllData

```csharp
/// <summary>
        /// Clears all registered tooltip data
        /// </summary>
        public void ClearAllData()
        {
            _tooltipData.Clear();
            HideTooltip(0);
        }
```

Clears all registered tooltip data

**Returns:** `void`

### GetDebugInfo

```csharp
#endregion

        #region Debug and Diagnostics

        /// <summary>
        /// Gets debug information
        /// </summary>
        public string GetDebugInfo()
        {
            var info = $"ActionTooltip Debug Info:\n";
            info += $"Current Action ID: {_currentActionId}\n";
            info += $"Is Visible: {_isVisible}\n";
            info += $"Registered Count: {_tooltipData.Count}\n";
            info += $"Auto Show: {AutoShow}\n";
            info += $"Show Delay: {ShowDelay}\n";
            info += $"Hide Delay: {_hideDelay}\n";
            info += $"Follow Mouse: {FollowMouse}\n";
            info += $"Max Width: {MaxWidth}\n";
            info += $"Auto Wrap: {AutoWrap}\n";

            if (_tooltipData.Count > 0)
            {
                info += "\nRegistered Actions:\n";
                foreach (var kvp in _tooltipData)
                {
                    info += $"  {kvp.Key}: \"{kvp.Value.Title}\"\n";
                }
            }

            return info;
        }
```

Gets debug information

**Returns:** `string`

### PrintDebugInfo

```csharp
/// <summary>
        /// Prints debug information
        /// </summary>
        public void PrintDebugInfo()
        {
            GD.Print(GetDebugInfo());
        }
```

Prints debug information

**Returns:** `void`

