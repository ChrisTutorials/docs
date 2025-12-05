---
title: "RotateManager"
description: "Manages building rotation operations
Handles building orientation changes and rotation constraints
Ported from: godot/addons/grid_building/manipulation/rotate_manager.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/rotatemanager/"
---

# RotateManager

```csharp
GridBuilding.Godot.Systems.Manipulation.Managers
class RotateManager
{
    // Members...
}
```

Manages building rotation operations
Handles building orientation changes and rotation constraints
Ported from: godot/addons/grid_building/manipulation/rotate_manager.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/Managers/RotateManager.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Managers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### AnimateRotations

```csharp
#endregion
    
    #region Exported Properties
    
    /// <summary>
    /// Whether to animate rotation operations
    /// </summary>
    [Export] public bool AnimateRotations { get; set; } = true;
```

Whether to animate rotation operations

### AnimationDuration

```csharp
/// <summary>
    /// Rotation animation duration in seconds
    /// </summary>
    [Export] public float AnimationDuration { get; set; } = 0.3f;
```

Rotation animation duration in seconds

### ValidateRotations

```csharp
/// <summary>
    /// Whether to validate rotations before applying
    /// </summary>
    [Export] public bool ValidateRotations { get; set; } = true;
```

Whether to validate rotations before applying

### PlayRotationSounds

```csharp
/// <summary>
    /// Whether to play rotation sound effects
    /// </summary>
    [Export] public bool PlayRotationSounds { get; set; } = true;
```

Whether to play rotation sound effects

### RotationSound

```csharp
/// <summary>
    /// Rotation sound effect
    /// </summary>
    [Export] public AudioStream? RotationSound { get; set; }
```

Rotation sound effect

### RotationStep

```csharp
/// <summary>
    /// Default rotation step in degrees
    /// </summary>
    [Export] public float RotationStep { get; set; } = 45.0f;
```

Default rotation step in degrees

### SnapToSteps

```csharp
/// <summary>
    /// Whether to snap rotation to steps
    /// </summary>
    [Export] public bool SnapToSteps { get; set; } = true;
```

Whether to snap rotation to steps

### MinRotation

```csharp
/// <summary>
    /// Minimum rotation angle in degrees
    /// </summary>
    [Export] public float MinRotation { get; set; } = 0.0f;
```

Minimum rotation angle in degrees

### MaxRotation

```csharp
/// <summary>
    /// Maximum rotation angle in degrees
    /// </summary>
    [Export] public float MaxRotation { get; set; } = 360.0f;
```

Maximum rotation angle in degrees

### TargetBuilding

```csharp
#endregion
    
    #region Public Properties
    
    /// <summary>
    /// Currently targeted building for rotation
    /// </summary>
    public BuildingState? TargetBuilding
    {
        get => _targetBuilding;
        set => _targetBuilding = value;
    }
```

Currently targeted building for rotation

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

### IsRotationActive

```csharp
/// <summary>
    /// Whether a rotation operation is currently active
    /// </summary>
    public bool IsRotationActive => _activeOperations.Count > 0;
```

Whether a rotation operation is currently active

### ActiveOperation

```csharp
/// <summary>
    /// Currently active rotation operation
    /// </summary>
    public RotationOperation? ActiveOperation => _activeOperations.Values.FirstOrDefault();
```

Currently active rotation operation


## Methods

### StartStepRotation

```csharp
#endregion
    
    #region Public Methods
    
    /// <summary>
    /// Starts a rotation operation by the specified step
    /// </summary>
    /// <param name="stepDegrees">Rotation step in degrees (positive for clockwise)</param>
    /// <returns>True if rotation started successfully</returns>
    public bool StartStepRotation(float stepDegrees)
    {
        if (!CanStartRotation())
            return false;
            
        if (_targetBuilding == null)
            return false;
            
        var newRotation = CalculateTargetRotation(_targetBuilding.Rotation, stepDegrees);
        return StartRotationOperation(newRotation);
    }
```

Starts a rotation operation by the specified step

**Returns:** `bool`

**Parameters:**
- `float stepDegrees`

### StartRotationTo

```csharp
/// <summary>
    /// Starts a rotation operation to a specific angle
    /// </summary>
    /// <param name="targetRotation">Target rotation in degrees</param>
    /// <returns>True if rotation started successfully</returns>
    public bool StartRotationTo(float targetRotation)
    {
        if (!CanStartRotation())
            return false;
            
        return StartRotationOperation(targetRotation);
    }
```

Starts a rotation operation to a specific angle

**Returns:** `bool`

**Parameters:**
- `float targetRotation`

### StartClockwiseRotation

```csharp
/// <summary>
    /// Starts a clockwise rotation by one step
    /// </summary>
    /// <returns>True if rotation started successfully</returns>
    public bool StartClockwiseRotation()
    {
        return StartStepRotation(RotationStep);
    }
```

Starts a clockwise rotation by one step

**Returns:** `bool`

### StartCounterClockwiseRotation

```csharp
/// <summary>
    /// Starts a counter-clockwise rotation by one step
    /// </summary>
    /// <returns>True if rotation started successfully</returns>
    public bool StartCounterClockwiseRotation()
    {
        return StartStepRotation(-RotationStep);
    }
```

Starts a counter-clockwise rotation by one step

**Returns:** `bool`

### CancelActiveRotation

```csharp
/// <summary>
    /// Cancels the current rotation operation
    /// </summary>
    public void CancelActiveRotation()
    {
        if (!IsRotationActive)
            return;
            
        var operation = ActiveOperation;
        if (operation != null)
        {
            _activeOperations.Remove(operation.BuildingId);
            EmitSignal(SignalName.RotationCancelled, operation.BuildingId);
            GD.Print($"Rotation cancelled for building: {operation.BuildingId}");
        }
    }
```

Cancels the current rotation operation

**Returns:** `void`

### UpdateRotations

```csharp
/// <summary>
    /// Updates rotation operations (called each frame)
    /// </summary>
    /// <param name="delta">Time since last frame</param>
    public void UpdateRotations(double delta)
    {
        var completedOperations = new List<string>();
        
        foreach (var kvp in _activeOperations)
        {
            var operation = kvp.Value;
            operation.ElapsedTime += (float)delta;
            
            // Update visual rotation if animating
            if (AnimateRotations)
            {
                UpdateRotationAnimation(operation);
            }
            
            // Check if rotation is complete
            if (operation.ElapsedTime >= operation.Duration)
            {
                CompleteRotationOperation(operation);
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

Updates rotation operations (called each frame)

**Returns:** `void`

**Parameters:**
- `double delta`

### GetRotation

```csharp
/// <summary>
    /// Gets the current rotation for a building
    /// </summary>
    /// <param name="buildingId">Building ID to check</param>
    /// <returns>Current rotation in degrees</returns>
    public float GetRotation(string buildingId)
    {
        if (_targetBuilding?.BuildingId == buildingId)
        {
            return _targetBuilding.Rotation;
        }
        
        // This would typically query the building state system
        return 0f;
    }
```

Gets the current rotation for a building

**Returns:** `float`

**Parameters:**
- `string buildingId`

### ResetRotation

```csharp
/// <summary>
    /// Resets a building's rotation to default
    /// </summary>
    /// <param name="buildingId">Building ID to reset</param>
    /// <returns>True if reset successful</returns>
    public bool ResetRotation(string buildingId)
    {
        return StartRotationTo(0f);
    }
```

Resets a building's rotation to default

**Returns:** `bool`

**Parameters:**
- `string buildingId`

### GetValidRotations

```csharp
/// <summary>
    /// Gets valid rotation angles for a building type
    /// </summary>
    /// <param name="buildingType">Building type to check</param>
    /// <returns>Array of valid rotation angles</returns>
    public float[] GetValidRotations(string buildingType)
    {
        // This would typically use building data to determine valid rotations
        // For now, return common rotation patterns based on building type
        
        return buildingType.ToLower() switch
        {
            "square" or "house" or "workshop" => new[] { 0f, 90f, 180f, 270f },
            "rectangle" or "farm" or "market" => new[] { 0f, 90f, 180f, 270f },
            "circle" or "dome" or "tower" => new[] { 0f }, // Circular buildings don't need rotation
            "l_shape" or "t_shape" => new[] { 0f, 90f, 180f, 270f },
            _ => new[] { 0f, 45f, 90f, 135f, 180f, 225f, 270f, 315f } // Default to 45-degree steps
        };
    }
```

Gets valid rotation angles for a building type

**Returns:** `float[]`

**Parameters:**
- `string buildingType`

### _Ready

```csharp
#endregion
    
    #region Godot Lifecycle
    
    public override void _Ready()
    {
        // Initialize audio player if needed
        if (PlayRotationSounds && RotationSound != null)
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
        UpdateRotations(delta);
    }
```

**Returns:** `void`

**Parameters:**
- `double delta`

