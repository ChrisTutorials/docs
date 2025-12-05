---
title: "ActionButton"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/actionbutton/"
---

# ActionButton

```csharp
GridBuilding.Godot.UI
class ActionButton
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/ActionButton.cs`  
**Namespace:** `GridBuilding.Godot.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ShowIcon

```csharp
[Export] public bool ShowIcon { get; set; } = true;
```

### ShowText

```csharp
[Export] public bool ShowText { get; set; } = true;
```

### IconSize

```csharp
[Export] public Vector2I IconSize { get; set; } = new Vector2I(24, 24);
```

### SelectedColor

```csharp
[Export] public Color SelectedColor { get; set; } = Colors.White;
```

### NormalColor

```csharp
[Export] public Color NormalColor { get; set; } = Colors.LightGray;
```

### HoverColor

```csharp
[Export] public Color HoverColor { get; set; } = Colors.Yellow;
```

### AnimationSpeed

```csharp
[Export] public float AnimationSpeed { get; set; } = 0.2f;
```

### ActionId

```csharp
public string ActionId => _actionId;
```

### IsSelected

```csharp
public bool IsSelected 
        { 
            get => _isSelected; 
            set => SetSelected(value);
        }
```

### IsHovered

```csharp
public bool IsHovered => _isHovered;
```


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            base._Ready();
            
            // Create custom layout
            SetupButtonLayout();
            
            // Set up styling
            SetupStyling();
            
            // Connect signals
            ConnectSignals();
        }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
        {
            base._Process(delta);
            
            // Update visual state based on selection and hover
            UpdateVisualState();
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### SetIcon

```csharp
/// <summary>
        /// Sets the icon for the button
        /// </summary>
        /// <param name="icon">Icon texture to set</param>
        public void SetIcon(Texture2D icon)
        {
            if (_iconRect == null)
            {
                _iconRect = new TextureRect();
                _iconRect.Name = "IconRect";
                _iconRect.ExpandMode = TextureRect.ExpandModeEnum.FitWidthProportional;
                _iconRect.CustomMinimumSize = IconSize.ToGodot();
                _iconRect.StretchMode = TextureRect.StretchModeEnum.KeepAspectCentered;
                
                if (_container != null)
                {
                    _container.AddChild(_iconRect, 0); // Add at beginning
                }
            }
            
            _iconRect.Texture = icon;
            _iconRect.Visible = ShowIcon && icon != null;
        }
```

Sets the icon for the button

**Returns:** `void`

**Parameters:**
- `Texture2D icon`

### SetText

```csharp
/// <summary>
        /// Sets the text for the button
        /// </summary>
        /// <param name="text">Text to set</param>
        public void SetText(string text)
        {
            Text = text;
            
            if (_textLabel != null)
            {
                _textLabel.Text = text;
                _textLabel.Visible = ShowText && !string.IsNullOrEmpty(text);
            }
        }
```

Sets the text for the button

**Returns:** `void`

**Parameters:**
- `string text`

### SetSelected

```csharp
/// <summary>
        /// Sets the selected state of the button
        /// </summary>
        /// <param name="selected">Whether the button should be selected</param>
        public void SetSelected(bool selected)
        {
            if (_isSelected == selected)
                return;
                
            _isSelected = selected;
            
            if (selected)
            {
                EmitSignal(SignalName.Selected);
            }
            else
            {
                EmitSignal(SignalName.Deselected);
            }
        }
```

Sets the selected state of the button

**Returns:** `void`

**Parameters:**
- `bool selected`

### SetIconSize

```csharp
/// <summary>
        /// Sets the icon size
        /// </summary>
        /// <param name="size">New icon size</param>
        public void SetIconSize(Vector2I size)
        {
            IconSize = size;
            
            if (_iconRect != null)
            {
                _iconRect.CustomMinimumSize = size.ToGodot();
            }
        }
```

Sets the icon size

**Returns:** `void`

**Parameters:**
- `Vector2I size`

### SetShowIcon

```csharp
/// <summary>
        /// Sets whether to show the icon
        /// </summary>
        /// <param name="show">Whether to show the icon</param>
        public void SetShowIcon(bool show)
        {
            ShowIcon = show;
            
            if (_iconRect != null)
            {
                _iconRect.Visible = show && _iconRect.Texture != null;
            }
        }
```

Sets whether to show the icon

**Returns:** `void`

**Parameters:**
- `bool show`

### SetShowText

```csharp
/// <summary>
        /// Sets whether to show the text
        /// </summary>
        /// <param name="show">Whether to show the text</param>
        public void SetShowText(bool show)
        {
            ShowText = show;
            
            if (_textLabel != null)
            {
                _textLabel.Visible = show && !string.IsNullOrEmpty(_textLabel.Text);
            }
        }
```

Sets whether to show the text

**Returns:** `void`

**Parameters:**
- `bool show`

### SetSelectedColor

```csharp
/// <summary>
        /// Sets the selected color
        /// </summary>
        /// <param name="color">New selected color</param>
        public void SetSelectedColor(Color color)
        {
            SelectedColor = color;
        }
```

Sets the selected color

**Returns:** `void`

**Parameters:**
- `Color color`

### SetNormalColor

```csharp
/// <summary>
        /// Sets the normal color
        /// </summary>
        /// <param name="color">New normal color</param>
        public void SetNormalColor(Color color)
        {
            NormalColor = color;
        }
```

Sets the normal color

**Returns:** `void`

**Parameters:**
- `Color color`

### SetHoverColor

```csharp
/// <summary>
        /// Sets the hover color
        /// </summary>
        /// <param name="color">New hover color</param>
        public void SetHoverColor(Color color)
        {
            HoverColor = color;
        }
```

Sets the hover color

**Returns:** `void`

**Parameters:**
- `Color color`

