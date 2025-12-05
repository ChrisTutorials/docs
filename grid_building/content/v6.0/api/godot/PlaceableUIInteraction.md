---
title: "PlaceableUIInteraction"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/placeableuiinteraction/"
---

# PlaceableUIInteraction

```csharp
GridBuilding.Godot.Systems.UI.Placeable
class PlaceableUIInteraction
{
    // Members...
}
```

Shared UI interaction helper for placeable UI components.
Provides consistent pressed/hover/normal state interaction for placeable views and list entries.
Handles mouse interactions and visual feedback to ensure consistent user experience.
Uses theme file for style definitions while managing state transitions.
The theme resource can be overridden by calling SetThemeOverride() before Init().

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/UI/Placeable/PlaceableUIInteraction.cs`  
**Namespace:** `GridBuilding.Godot.Systems.UI.Placeable`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Init

```csharp
#endregion

        /// <summary>
        /// Initialize the style helper with a control reference.
        /// </summary>
        /// <param name="control">The control to apply styles to</param>
        /// <param name="theme">Optional theme resource. Uses ThemeConstants.PlaceableUiTheme if not provided.</param>
        public void Init(Control control, Theme theme = null)
        {
            _control = control;
            _LoadThemeStyles(theme);
            _ConnectSignals();
            _ApplyNormalStyle();
        }
```

Initialize the style helper with a control reference.

**Returns:** `void`

**Parameters:**
- `Control control`
- `Theme theme`

### SetThemeOverride

```csharp
/// <summary>
        /// Override the default theme with a custom theme resource.
        /// </summary>
        /// <param name="theme">Custom theme resource. If null, reverts to default.</param>
        public void SetThemeOverride(Theme theme)
        {
            _themeOverride = theme;
        }
```

Override the default theme with a custom theme resource.

**Returns:** `void`

**Parameters:**
- `Theme theme`

### Cleanup

```csharp
/// <summary>
        /// Cleanup method to disconnect signals when no longer needed.
        /// </summary>
        public void Cleanup()
        {
            if (_control != null && IsInstanceValid(_control))
            {
                if (_control.MouseEntered.IsConnected(_OnMouseEntered))
                {
                    _control.MouseEntered -= _OnMouseEntered;
                }
                if (_control.MouseExited.IsConnected(_OnMouseExited))
                {
                    _control.MouseExited -= _OnMouseExited;
                }
                if (_control.GuiInput.IsConnected(_OnGuiInput))
                {
                    _control.GuiInput -= _OnGuiInput;
                }
            }
        }
```

Cleanup method to disconnect signals when no longer needed.

**Returns:** `void`

