---
title: "NameDisplayer"
description: ""
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/namedisplayer/"
---

# NameDisplayer

```csharp
GridBuilding.Godot.UI
class NameDisplayer
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/NameDisplayer.cs`  
**Namespace:** `GridBuilding.Godot.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DisplayDuration

```csharp
[Export] public float DisplayDuration { get; set; } = 3.0f;
```

### FadeInDuration

```csharp
[Export] public float FadeInDuration { get; set; } = 0.2f;
```

### FadeOutDuration

```csharp
[Export] public float FadeOutDuration { get; set; } = 0.3f;
```

### Offset

```csharp
[Export] public Vector2 Offset { get; set; } = new Vector2(0, -50);
```

### FollowMouse

```csharp
[Export] public bool FollowMouse { get; set; } = false;
```

### AutoHide

```csharp
[Export] public bool AutoHide { get; set; } = true;
```

### BackgroundColor

```csharp
[ExportGroup("Styling")]
        [Export] public Color BackgroundColor { get; set; } = new Color(0.0f, 0.0f, 0.0f, 0.8f);
```

### TextColor

```csharp
[Export] public Color TextColor { get; set; } = Colors.White;
```

### FontSize

```csharp
[Export] public int FontSize { get; set; } = 14;
```

### Padding

```csharp
[Export] public Vector2I Padding { get; set; } = new Vector2I(8, 4);
```

### CurrentName

```csharp
public string CurrentName => _currentName;
```

### IsVisible

```csharp
public bool IsVisible => _isVisible;
```


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            base._Ready();
            
            // Create UI components
            CreateUI();
            
            // Set up styling
            SetupStyling();
            
            // Set up hide timer
            SetupTimer();
            
            // Initially hidden
            Visible = false;
            Modulate = new Color(1, 1, 1, 0);
        }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
        {
            base._Process(delta);
            
            // Follow mouse if enabled
            if (FollowMouse && _isVisible)
            {
                UpdatePositionToMouse();
            }
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### ShowName

```csharp
/// <summary>
        /// Displays a name at the specified position
        /// </summary>
        /// <param name="name">Name to display</param>
        /// <param name="position">Position to display at (world coordinates)</param>
        public void ShowName(string name, Vector2 position)
        {
            if (string.IsNullOrEmpty(name))
                return;
                
            _currentName = name;
            _nameLabel.Text = name;
            
            // Set position
            UpdatePosition(position);
            
            // Show and fade in
            ShowName();
        }
```

Displays a name at the specified position

**Returns:** `void`

**Parameters:**
- `string name`
- `Vector2 position`

### ShowNameAtMouse

```csharp
/// <summary>
        /// Displays a name following the mouse
        /// </summary>
        /// <param name="name">Name to display</param>
        public void ShowNameAtMouse(string name)
        {
            if (string.IsNullOrEmpty(name))
                return;
                
            _currentName = name;
            _nameLabel.Text = name;
            
            // Update position to mouse
            UpdatePositionToMouse();
            
            // Show and fade in
            ShowName();
        }
```

Displays a name following the mouse

**Returns:** `void`

**Parameters:**
- `string name`

### HideName

```csharp
/// <summary>
        /// Hides the name display
        /// </summary>
        public void HideName()
        {
            if (!_isVisible)
                return;
                
            // Stop hide timer
            _hideTimer.Stop();
            
            // Start fade out animation
            var tween = CreateTween();
            tween.SetEase(Tween.EaseType.In);
            tween.SetTrans(Tween.TransitionType.Quad);
            tween.TweenProperty(this, "modulate", new Color(1, 1, 1, 0), FadeOutDuration);
            
            // Hide after fade out
            tween.TweenCallback(Callable.From(() => {
                Visible = false;
                _isVisible = false;
                EmitSignal(SignalName.NameDisplayHidden);
            }));
        }
```

Hides the name display

**Returns:** `void`

### SetDisplayDuration

```csharp
/// <summary>
        /// Sets the display duration
        /// </summary>
        /// <param name="duration">New duration in seconds</param>
        public void SetDisplayDuration(float duration)
        {
            DisplayDuration = Mathf.Max(0.1f, duration);
            _hideTimer.WaitTime = DisplayDuration;
        }
```

Sets the display duration

**Returns:** `void`

**Parameters:**
- `float duration`

### SetOffset

```csharp
/// <summary>
        /// Sets the offset
        /// </summary>
        /// <param name="offset">New offset</param>
        public void SetOffset(Vector2 offset)
        {
            Offset = offset;
            
            if (_isVisible)
            {
                // Update position if currently visible
                if (FollowMouse)
                    UpdatePositionToMouse();
            }
        }
```

Sets the offset

**Returns:** `void`

**Parameters:**
- `Vector2 offset`

### SetBackgroundColor

```csharp
/// <summary>
        /// Sets the background color
        /// </summary>
        /// <param name="color">New background color</param>
        public void SetBackgroundColor(Color color)
        {
            BackgroundColor = color;
            SetupStyling(); // Reapply styling
        }
```

Sets the background color

**Returns:** `void`

**Parameters:**
- `Color color`

### SetTextColor

```csharp
/// <summary>
        /// Sets the text color
        /// </summary>
        /// <param name="color">New text color</param>
        public void SetTextColor(Color color)
        {
            TextColor = color;
            _nameLabel.AddThemeColorOverride("font_color", color);
        }
```

Sets the text color

**Returns:** `void`

**Parameters:**
- `Color color`

### SetFontSize

```csharp
/// <summary>
        /// Sets the font size
        /// </summary>
        /// <param name="size">New font size</param>
        public void SetFontSize(int size)
        {
            FontSize = Mathf.Max(8, size);
            _nameLabel.AddThemeFontSizeOverride("font_size", FontSize);
        }
```

Sets the font size

**Returns:** `void`

**Parameters:**
- `int size`

### SetPadding

```csharp
/// <summary>
        /// Sets the padding
        /// </summary>
        /// <param name="padding">New padding</param>
        public void SetPadding(Vector2I padding)
        {
            Padding = padding;
            SetupStyling(); // Reapply styling
        }
```

Sets the padding

**Returns:** `void`

**Parameters:**
- `Vector2I padding`

### SetFollowMouse

```csharp
/// <summary>
        /// Sets whether to follow the mouse
        /// </summary>
        /// <param name="follow">Whether to follow the mouse</param>
        public void SetFollowMouse(bool follow)
        {
            FollowMouse = follow;
            
            if (!follow && _isVisible)
            {
                // Update position to current position if no longer following mouse
                // Position will remain where it was last set
            }
        }
```

Sets whether to follow the mouse

**Returns:** `void`

**Parameters:**
- `bool follow`

### SetAutoHide

```csharp
/// <summary>
        /// Sets whether to auto-hide
        /// </summary>
        /// <param name="autoHide">Whether to auto-hide</param>
        public void SetAutoHide(bool autoHide)
        {
            AutoHide = autoHide;
            
            if (AutoHide && _isVisible)
            {
                // Start timer if currently visible
                _hideTimer.Start(DisplayDuration);
            }
            else if (!AutoHide)
            {
                // Stop timer if currently visible
                _hideTimer.Stop();
            }
        }
```

Sets whether to auto-hide

**Returns:** `void`

**Parameters:**
- `bool autoHide`

### GetDisplayText

```csharp
/// <summary>
        /// Gets the current display text
        /// </summary>
        /// <returns>Current display text</returns>
        public string GetDisplayText()
        {
            return _nameLabel.Text;
        }
```

Gets the current display text

**Returns:** `string`

### IsShowing

```csharp
/// <summary>
        /// Checks if the display is currently showing
        /// </summary>
        /// <returns>True if showing</returns>
        public bool IsShowing()
        {
            return _isVisible && Visible;
        }
```

Checks if the display is currently showing

**Returns:** `bool`

