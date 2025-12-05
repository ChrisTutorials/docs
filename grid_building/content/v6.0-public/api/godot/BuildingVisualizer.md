---
title: "BuildingVisualizer"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/buildingvisualizer/"
---

# BuildingVisualizer

```csharp
GridBuilding.Godot.Visualizers
class BuildingVisualizer
{
    // Members...
}
```

Visual component for building state that handles rendering and UI updates.
Separates visualization logic from core building state data.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Visualizers/BuildingVisualizer.cs`  
**Namespace:** `GridBuilding.Godot.Visualizers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### BuildingState

```csharp
#endregion
    
    #region Public Properties
    
    /// <summary>
    /// The building state being visualized.
    /// </summary>
    public BuildingState BuildingState
    {
        get => _buildingState;
        set => SetBuildingState(value);
    }
```

The building state being visualized.

### AutoUpdateVisuals

```csharp
/// <summary>
    /// Whether to automatically update visuals when state changes.
    /// </summary>
    public bool AutoUpdateVisuals
    {
        get => _autoUpdateVisuals;
        set => _autoUpdateVisuals = value;
    }
```

Whether to automatically update visuals when state changes.

### VisualUpdateInterval

```csharp
/// <summary>
    /// Interval for visual updates.
    /// </summary>
    public float VisualUpdateInterval
    {
        get => _visualUpdateInterval;
        set => _visualUpdateInterval = Mathf.Max(0.01f, value);
    }
```

Interval for visual updates.


## Methods

### _Ready

```csharp
#endregion
    
    #region Godot Lifecycle
    
    public override void _Ready()
    {
        base._Ready();
        
        // Find child nodes
        FindChildNodes();
        
        // Initial visual update
        UpdateAllVisuals();
    }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
    {
        if (!_autoUpdateVisuals || _buildingState == null)
            return;
        
        // Throttled visual updates
        if (Time.GetUnixTimeFromSystem() - _lastVisualUpdate > _visualUpdateInterval)
        {
            UpdateAllVisuals();
            _lastVisualUpdate = Time.GetUnixTimeFromSystem();
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
        DisconnectFromBuildingState();
        base._ExitTree();
    }
```

**Returns:** `void`

### SetBuildingState

```csharp
#endregion
    
    #region Public Methods
    
    /// <summary>
    /// Sets the building state to visualize.
    /// </summary>
    /// <param name="buildingState">New building state</param>
    public void SetBuildingState(BuildingState buildingState)
    {
        DisconnectFromBuildingState();
        _buildingState = buildingState;
        
        if (_buildingState != null && _autoUpdateVisuals)
        {
            ConnectToBuildingState();
            UpdateAllVisuals();
        }
    }
```

Sets the building state to visualize.

**Returns:** `void`

**Parameters:**
- `BuildingState buildingState`

### ForceVisualUpdate

```csharp
/// <summary>
    /// Forces an immediate visual update.
    /// </summary>
    public void ForceVisualUpdate()
    {
        UpdateAllVisuals();
    }
```

Forces an immediate visual update.

**Returns:** `void`

### UpdateSprite

```csharp
/// <summary>
    /// Updates the sprite based on building type and status.
    /// </summary>
    public void UpdateSprite()
    {
        if (_sprite == null || _buildingState == null)
            return;
        
        // Set sprite texture based on building type
        var texturePath = GetBuildingTexturePath(_buildingState.BuildingType);
        if (!string.IsNullOrEmpty(texturePath))
        {
            _sprite.Texture = GD.Load<Texture2D>(texturePath);
        }
        
        // Set sprite color based on status
        if (_statusColors.TryGetValue(_buildingState.Status, out var statusColor))
        {
            _sprite.Modulate = statusColor;
        }
        
        // Handle visibility based on status
        _sprite.Visible = _buildingState.Status != BuildingStatus.Destroyed;
    }
```

Updates the sprite based on building type and status.

**Returns:** `void`

### UpdateHealthBar

```csharp
/// <summary>
    /// Updates the health bar.
    /// </summary>
    public void UpdateHealthBar()
    {
        if (_healthBar == null || _buildingState == null)
            return;
        
        var healthPercent = (float)_buildingState.Health / _buildingState.MaxHealth;
        _healthBar.Value = healthPercent;
        
        // Update health bar color based on health percentage
        Color healthColor;
        if (healthPercent > 0.6f)
            healthColor = Colors.Green;
        else if (healthPercent > 0.3f)
            healthColor = Colors.Yellow;
        else
            healthColor = Colors.Red;
        
        _healthBar.Modulate = healthColor;
    }
```

Updates the health bar.

**Returns:** `void`

### UpdateStatusLabel

```csharp
/// <summary>
    /// Updates the status label.
    /// </summary>
    public void UpdateStatusLabel()
    {
        if (_statusLabel == null || _buildingState == null)
            return;
        
        _statusLabel.Text = $"{_buildingState.BuildingType}\n{_buildingState.Status}";
        _statusLabel.Visible = true;
    }
```

Updates the status label.

**Returns:** `void`

### UpdateCollisionShape

```csharp
/// <summary>
    /// Updates collision shape based on building size.
    /// </summary>
    public void UpdateCollisionShape()
    {
        if (_collisionShape == null || _buildingState == null)
            return;
        
        // Update shape size based on building type
        var shapeSize = GetBuildingShapeSize(_buildingState.BuildingType);
        if (_collisionShape.Shape is RectangleShape2D rectShape)
        {
            rectShape.Size = shapeSize;
        }
    }
```

Updates collision shape based on building size.

**Returns:** `void`

### PlayDamageEffects

```csharp
/// <summary>
    /// Plays damage effects.
    /// </summary>
    /// <param name="damageAmount">Amount of damage taken</param>
    public void PlayDamageEffects(int damageAmount)
    {
        // Play damage particles
        if (_damageParticles != null)
        {
            _damageParticles.Emitting = true;
        }
        
        // Play damage sound
        if (_audioPlayer != null && damageAmount > 0)
        {
            var soundPath = GetDamageSoundPath(damageAmount);
            if (!string.IsNullOrEmpty(soundPath))
            {
                var sound = GD.Load<AudioStream>(soundPath);
                if (sound != null)
                {
                    _audioPlayer.Stream = sound;
                    _audioPlayer.Play();
                }
            }
        }
        
        // Flash sprite
        if (_sprite != null)
        {
            var tween = CreateTween();
            tween.TweenProperty(_sprite, "modulate", Colors.Red, 0.1f);
            tween.TweenProperty(_sprite, "modulate", Colors.White, 0.1f);
        }
    }
```

Plays damage effects.

**Returns:** `void`

**Parameters:**
- `int damageAmount`

### PlayDestructionEffects

```csharp
/// <summary>
    /// Plays destruction effects.
    /// </summary>
    public void PlayDestructionEffects()
    {
        // Play destruction particles
        if (_damageParticles != null)
        {
            _damageParticles.Emitting = true;
        }
        
        // Play destruction sound
        if (_audioPlayer != null)
        {
            var sound = GD.Load<AudioStream>("res://sounds/building_destroyed.wav");
            if (sound != null)
            {
                _audioPlayer.Stream = sound;
                _audioPlayer.Play();
            }
        }
        
        // Shake effect
        if (_sprite != null)
        {
            var tween = CreateTween();
            tween.TweenProperty(this, "position", Vector2.One * 5, 0.1f);
            tween.TweenProperty(this, "position", Vector2.One * -5, 0.1f);
            tween.TweenProperty(this, "position", Vector2.One * 3, 0.1f);
            tween.TweenProperty(this, "position", Vector2.One * -3, 0.1f);
            tween.TweenProperty(this, "position", Vector2.Zero, 0.1f);
        }
    }
```

Plays destruction effects.

**Returns:** `void`

### Create

```csharp
#endregion
    
    #region Static Factory Methods
    
    /// <summary>
    /// Creates a visualizer for a building state.
    /// </summary>
    /// <param name="buildingState">Building state to visualize</param>
    /// <returns>New visualizer instance</returns>
    public static BuildingVisualizer Create(BuildingState buildingState)
    {
        return new BuildingVisualizer(buildingState);
    }
```

Creates a visualizer for a building state.

**Returns:** `BuildingVisualizer`

**Parameters:**
- `BuildingState buildingState`

### CreateWithScene

```csharp
/// <summary>
    /// Creates a visualizer with default scene structure.
    /// </summary>
    /// <param name="buildingState">Building state to visualize</param>
    /// <returns>New visualizer instance with child nodes</returns>
    public static BuildingVisualizer CreateWithScene(BuildingState buildingState)
    {
        var visualizer = new BuildingVisualizer(buildingState);
        
        // Create standard child nodes
        var sprite = new Sprite2D { Name = "Sprite" };
        visualizer.AddChild(sprite);
        
        var healthBar = new ProgressBar { Name = "HealthBar" };
        healthBar.Position = new Vector2(0, -20);
        healthBar.Size = new Vector2(40, 4);
        visualizer.AddChild(healthBar);
        
        var statusLabel = new Label { Name = "StatusLabel" };
        statusLabel.Position = new Vector2(0, -30);
        statusLabel.Text = "";
        visualizer.AddChild(statusLabel);
        
        return visualizer;
    }
```

Creates a visualizer with default scene structure.

**Returns:** `BuildingVisualizer`

**Parameters:**
- `BuildingState buildingState`

