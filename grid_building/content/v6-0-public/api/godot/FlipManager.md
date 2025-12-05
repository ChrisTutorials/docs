---
title: "FlipManager"
description: "Manages building flipping operations (horizontal and vertical)
Handles building mirroring and orientation changes
Ported from: godot/addons/grid_building/manipulation/flip_manager.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/flipmanager/"
---

# FlipManager

```csharp
GridBuilding.Godot.Systems.Manipulation.Managers
class FlipManager
{
    // Members...
}
```

Manages building flipping operations (horizontal and vertical)
Handles building mirroring and orientation changes
Ported from: godot/addons/grid_building/manipulation/flip_manager.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/Managers/FlipManager.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Managers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### AnimateFlips

```csharp
#endregion
    
    #region Exported Properties
    
    /// <summary>
    /// Whether to animate flip operations
    /// </summary>
    [Export] public bool AnimateFlips { get; set; } = true;
```

Whether to animate flip operations

### AnimationDuration

```csharp
/// <summary>
    /// Flip animation duration in seconds
    /// </summary>
    [Export] public float AnimationDuration { get; set; } = 0.3f;
```

Flip animation duration in seconds

### ValidateFlips

```csharp
/// <summary>
    /// Whether to validate flips before applying
    /// </summary>
    [Export] public bool ValidateFlips { get; set; } = true;
```

Whether to validate flips before applying

### PlayFlipSounds

```csharp
/// <summary>
    /// Whether to play flip sound effects
    /// </summary>
    [Export] public bool PlayFlipSounds { get; set; } = true;
```

Whether to play flip sound effects

### FlipSound

```csharp
/// <summary>
    /// Flip sound effect
    /// </summary>
    [Export] public AudioStream? FlipSound { get; set; }
```

Flip sound effect

### TargetBuilding

```csharp
#endregion
    
    #region Public Properties
    
    /// <summary>
    /// Currently targeted building for flipping
    /// </summary>
    public BuildingState? TargetBuilding
    {
        get => _targetBuilding;
        set => _targetBuilding = value;
    }
```

Currently targeted building for flipping

### ManipulationState

```csharp
/// <summary>
    /// Current manipulation state
    /// </summary>
    public ManipulationState? ManipulationState
    {
        get => _manipulationState;
        set => _manipulationState = value;
    }
```

Current manipulation state

### IsFlipActive

```csharp
/// <summary>
    /// Whether a flip operation is currently active
    /// </summary>
    public bool IsFlipActive => _activeOperations.Count > 0;
```

Whether a flip operation is currently active

### ActiveOperation

```csharp
/// <summary>
    /// Currently active flip operation
    /// </summary>
    public FlipOperation? ActiveOperation => _activeOperations.Values.FirstOrDefault();
```

Currently active flip operation


## Methods

### StartHorizontalFlip

```csharp
#endregion
    
    #region Public Methods
    
    /// <summary>
    /// Starts a horizontal flip operation for the target building
    /// </summary>
    /// <returns>True if flip started successfully</returns>
    public bool StartHorizontalFlip()
    {
        if (!CanStartFlip())
            return false;
            
        if (_targetBuilding == null)
            return false;
            
        var newFlipH = !_targetBuilding.FlipHorizontal;
        return StartFlipOperation(newFlipH, _targetBuilding.FlipVertical);
    }
```

Starts a horizontal flip operation for the target building

**Returns:** `bool`

### StartVerticalFlip

```csharp
/// <summary>
    /// Starts a vertical flip operation for the target building
    /// </summary>
    /// <returns>True if flip started successfully</returns>
    public bool StartVerticalFlip()
    {
        if (!CanStartFlip())
            return false;
            
        if (_targetBuilding == null)
            return false;
            
        var newFlipV = !_targetBuilding.FlipVertical;
        return StartFlipOperation(_targetBuilding.FlipHorizontal, newFlipV);
    }
```

Starts a vertical flip operation for the target building

**Returns:** `bool`

### StartFlipOperation

```csharp
/// <summary>
    /// Starts a flip operation to specific flip states
    /// </summary>
    /// <param name="flipHorizontal">Target horizontal flip state</param>
    /// <param name="flipVertical">Target vertical flip state</param>
    /// <returns>True if flip started successfully</returns>
    public bool StartFlipOperation(bool flipHorizontal, bool flipVertical)
    {
        if (!CanStartFlip())
            return false;
            
        if (_targetBuilding == null)
            return false;
            
        // Check if flip would actually change anything
        if (_targetBuilding.FlipHorizontal == flipHorizontal && _targetBuilding.FlipVertical == flipVertical)
        {
            GD.Print("Flip operation skipped: Building already has target flip state");
            return false;
        }
        
        var operation = new FlipOperation
        {
            BuildingId = _targetBuilding.BuildingId,
            FromFlipH = _targetBuilding.FlipHorizontal,
            FromFlipV = _targetBuilding.FlipVertical,
            ToFlipH = flipHorizontal,
            ToFlipV = flipVertical,
            StartTime = Time.GetTimeDictFromSystem(),
            Duration = AnimateFlips ? AnimationDuration : 0.1f,
            ElapsedTime = 0f
        };
        
        if (ValidateFlips && !ValidateFlipOperation(operation))
            return false;
            
        return ExecuteFlipOperation(operation);
    }
```

Starts a flip operation to specific flip states

**Returns:** `bool`

**Parameters:**
- `bool flipHorizontal`
- `bool flipVertical`

### CancelActiveFlip

```csharp
/// <summary>
    /// Cancels the current flip operation
    /// </summary>
    public void CancelActiveFlip()
    {
        if (!IsFlipActive)
            return;
            
        var operation = ActiveOperation;
        if (operation != null)
        {
            _activeOperations.Remove(operation.BuildingId);
            EmitSignal(SignalName.FlipCancelled, operation.BuildingId);
            GD.Print($"Flip cancelled for building: {operation.BuildingId}");
        }
    }
```

Cancels the current flip operation

**Returns:** `void`

### UpdateFlips

```csharp
/// <summary>
    /// Updates flip operations (called each frame)
    /// </summary>
    /// <param name="delta">Time since last frame</param>
    public void UpdateFlips(double delta)
    {
        var completedOperations = new List<string>();
        
        foreach (var kvp in _activeOperations)
        {
            var operation = kvp.Value;
            operation.ElapsedTime += (float)delta;
            
            // Update visual flip if animating
            if (AnimateFlips)
            {
                UpdateFlipAnimation(operation);
            }
            
            // Check if flip is complete
            if (operation.ElapsedTime >= operation.Duration)
            {
                CompleteFlipOperation(operation);
                completedOperations.Add(kvp.Key);
            }
        }
        
        // Remove completed operations
        foreach (var buildingId in completedOperations)
        {
            _activeOperations.Remove(buildingId);
        }
    }
```

Updates flip operations (called each frame)

**Returns:** `void`

**Parameters:**
- `double delta`

### GetFlipState

```csharp
/// <summary>
    /// Gets the current flip state for a building
    /// </summary>
    /// <param name="buildingId">Building ID to check</param>
    /// <returns>Tuple of (horizontalFlip, verticalFlip)</returns>
    public (bool horizontal, bool vertical) GetFlipState(string buildingId)
    {
        if (_targetBuilding?.BuildingId == buildingId)
        {
            return (_targetBuilding.FlipHorizontal, _targetBuilding.FlipVertical);
        }
        
        // This would typically query the building state system
        return (false, false);
    }
```

Gets the current flip state for a building

**Returns:** `(bool horizontal, bool vertical)`

**Parameters:**
- `string buildingId`

### ResetFlipState

```csharp
/// <summary>
    /// Resets a building's flip state to default
    /// </summary>
    /// <param name="buildingId">Building ID to reset</param>
    /// <returns>True if reset successful</returns>
    public bool ResetFlipState(string buildingId)
    {
        return StartFlipOperation(false, false);
    }
```

Resets a building's flip state to default

**Returns:** `bool`

**Parameters:**
- `string buildingId`

### _Ready

```csharp
#endregion
    
    #region Godot Lifecycle
    
    public override void _Ready()
    {
        // Initialize audio player if needed
        if (PlayFlipSounds && FlipSound != null)
        {
            _audioPlayer = new AudioStreamPlayer();
            AddChild(_audioPlayer);
        }
    }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
    {
        UpdateFlips(delta);
    }
```

**Returns:** `void`

**Parameters:**
- `double delta`

