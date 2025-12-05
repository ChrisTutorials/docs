---
title: "TargetInformer"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/targetinformer/"
---

# TargetInformer

```csharp
GridBuilding.Godot.UI
class TargetInformer
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/TargetInformer.cs`  
**Namespace:** `GridBuilding.Godot.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DisplayDuration

```csharp
[Export] public float DisplayDuration { get; set; } = 5.0f;
```

### FadeInDuration

```csharp
[Export] public float FadeInDuration { get; set; } = 0.3f;
```

### FadeOutDuration

```csharp
[Export] public float FadeOutDuration { get; set; } = 0.3f;
```

### Offset

```csharp
[Export] public Vector2 Offset { get; set; } = new Vector2(20, -100);
```

### AutoHide

```csharp
[Export] public bool AutoHide { get; set; } = true;
```

### ShowHealth

```csharp
[Export] public bool ShowHealth { get; set; } = true;
```

### ShowProperties

```csharp
[Export] public bool ShowProperties { get; set; } = true;
```

### ShowDescription

```csharp
[Export] public bool ShowDescription { get; set; } = true;
```

### BackgroundColor

```csharp
[ExportGroup("Styling")]
        [Export] public Color BackgroundColor { get; set; } = new Color(0.0f, 0.0f, 0.0f, 0.9f);
```

### TitleColor

```csharp
[Export] public Color TitleColor { get; set; } = Colors.White;
```

### TextColor

```csharp
[Export] public Color TextColor { get; set; } = Colors.LightGray;
```

### HealthBarColor

```csharp
[Export] public Color HealthBarColor { get; set; } = Colors.Green;
```

### HealthBarBackgroundColor

```csharp
[Export] public Color HealthBarBackgroundColor { get; set; } = Colors.Red;
```

### TitleFontSize

```csharp
[Export] public int TitleFontSize { get; set; } = 16;
```

### TextFontSize

```csharp
[Export] public int TextFontSize { get; set; } = 12;
```

### Padding

```csharp
[Export] public Vector2I Padding { get; set; } = new Vector2I(12, 8);
```

### CurrentTarget

```csharp
public TargetInfo CurrentTarget => _currentTarget;
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
            
            // Update position if target object exists
            if (_currentTarget.TargetObject != null && _isVisible)
            {
                UpdatePositionToTarget();
            }
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### ShowTargetInfo

```csharp
/// <summary>
        /// Shows target information
        /// </summary>
        /// <param name="targetInfo">Target information to display</param>
        public void ShowTargetInfo(TargetInfo targetInfo)
        {
            _currentTarget = targetInfo;
            
            // Update UI with target information
            UpdateDisplay();
            
            // Update position
            UpdatePosition(targetInfo.Position);
            
            // Show and fade in
            ShowInfo();
        }
```

Shows target information

**Returns:** `void`

**Parameters:**
- `TargetInfo targetInfo`

### ShowTargetInfo

```csharp
/// <summary>
        /// Shows target information for a Godot object
        /// </summary>
        /// <param name="targetObject">Target object</param>
        /// <param name="customName">Custom name override</param>
        public void ShowTargetInfo(GodotObject targetObject, string customName = null)
        {
            var targetInfo = CreateTargetInfoFromObject(targetObject, customName);
            ShowTargetInfo(targetInfo);
        }
```

Shows target information for a Godot object

**Returns:** `void`

**Parameters:**
- `GodotObject targetObject`
- `string customName`

### HideTargetInfo

```csharp
/// <summary>
        /// Hides the target information
        /// </summary>
        public void HideTargetInfo()
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
                _currentTarget = default;
                EmitSignal(SignalName.TargetInfoHidden);
            }));
        }
```

Hides the target information

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
            
            if (_isVisible && _currentTarget.TargetObject != null)
            {
                UpdatePositionToTarget();
            }
        }
```

Sets the offset

**Returns:** `void`

**Parameters:**
- `Vector2 offset`

### SetShowHealth

```csharp
/// <summary>
        /// Sets whether to show health information
        /// </summary>
        /// <param name="show">Whether to show health</param>
        public void SetShowHealth(bool show)
        {
            ShowHealth = show;
            
            if (_healthLabel != null)
            {
                _healthLabel.Visible = show;
            }
        }
```

Sets whether to show health information

**Returns:** `void`

**Parameters:**
- `bool show`

### SetShowProperties

```csharp
/// <summary>
        /// Sets whether to show properties
        /// </summary>
        /// <param name="show">Whether to show properties</param>
        public void SetShowProperties(bool show)
        {
            ShowProperties = show;
            
            if (_propertiesLabel != null)
            {
                _propertiesLabel.Visible = show;
            }
        }
```

Sets whether to show properties

**Returns:** `void`

**Parameters:**
- `bool show`

### SetShowDescription

```csharp
/// <summary>
        /// Sets whether to show description
        /// </summary>
        /// <param name="show">Whether to show description</param>
        public void SetShowDescription(bool show)
        {
            ShowDescription = show;
            
            if (_descriptionLabel != null)
            {
                _descriptionLabel.Visible = show;
            }
        }
```

Sets whether to show description

**Returns:** `void`

**Parameters:**
- `bool show`

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

