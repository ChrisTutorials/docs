---
title: "ManipulationTransformHandler"
description: "Handles transform operations for the manipulation system
Provides unified interface for building transforms (move, rotate, flip, demolish)
Ported from: godot/addons/grid_building/manipulation/manipulation_transform_handler.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/manipulationtransformhandler/"
---

# ManipulationTransformHandler

```csharp
GridBuilding.Godot.Systems.Manipulation.Handlers
class ManipulationTransformHandler
{
    // Members...
}
```

Handles transform operations for the manipulation system
Provides unified interface for building transforms (move, rotate, flip, demolish)
Ported from: godot/addons/grid_building/manipulation/manipulation_transform_handler.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/Handlers/ManipulationTransformHandler.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Handlers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### GridMap

```csharp
#endregion
    
    #region Exported Properties
    
    /// <summary>
    /// The grid map for coordinate conversion
    /// </summary>
    [Export] public TileMapLayer? GridMap { get; set; }
```

The grid map for coordinate conversion

### ValidateTransforms

```csharp
/// <summary>
    /// Whether to validate transforms before applying
    /// </summary>
    [Export] public bool ValidateTransforms { get; set; } = true;
```

Whether to validate transforms before applying

### AnimateTransforms

```csharp
/// <summary>
    /// Whether to animate transform operations
    /// </summary>
    [Export] public bool AnimateTransforms { get; set; } = true;
```

Whether to animate transform operations

### AnimationDuration

```csharp
/// <summary>
    /// Transform animation duration in seconds
    /// </summary>
    [Export] public float AnimationDuration { get; set; } = 0.3f;
```

Transform animation duration in seconds

### ManipulationState

```csharp
#endregion
    
    #region Public Properties
    
    /// <summary>
    /// Current manipulation state
    /// </summary>
    public ManipulationState? ManipulationState
    {
        get => _manipulationState;
        set
        {
            _manipulationState = value;
            UpdateTargetBuilding();
        }
    }
```

Current manipulation state

### TargetBuilding

```csharp
/// <summary>
    /// Currently targeted building for transforms
    /// </summary>
    public BuildingState? TargetBuilding
    {
        get => _targetBuilding;
        set
        {
            if (_targetBuilding != value)
            {
                CancelActiveTransform();
                _targetBuilding = value;
            }
        }
    }
```

Currently targeted building for transforms

### IsTransformActive

```csharp
/// <summary>
    /// Whether a transform operation is currently active
    /// </summary>
    public bool IsTransformActive => _activeOperations.Count > 0;
```

Whether a transform operation is currently active

### ActiveTransform

```csharp
/// <summary>
    /// Current active transform operation
    /// </summary>
    public TransformOperation? ActiveTransform => _activeOperations.Values.FirstOrDefault();
```

Current active transform operation


## Methods

### StartMoveOperation

```csharp
#endregion
    
    #region Public Methods
    
    /// <summary>
    /// Starts a move operation for the target building
    /// </summary>
    /// <param name="targetPosition">Target grid position</param>
    /// <returns>True if operation started successfully</returns>
    public bool StartMoveOperation(Vector2I targetPosition)
    {
        if (!CanStartTransform("move"))
            return false;
            
        var operation = new TransformOperation
        {
            Type = "move",
            BuildingId = _targetBuilding?.BuildingId ?? string.Empty,
            FromPosition = _targetBuilding?.GridPosition ?? Vector2I.Zero,
            ToPosition = targetPosition,
            StartTime = Time.GetTimeDictFromSystem()
        };
        
        if (ValidateTransform && !ValidateMoveOperation(operation))
            return false;
            
        return StartTransformOperation(operation);
    }
```

Starts a move operation for the target building

**Returns:** `bool`

**Parameters:**
- `Vector2I targetPosition`

### StartRotateOperation

```csharp
/// <summary>
    /// Starts a rotate operation for the target building
    /// </summary>
    /// <param name="rotationDegrees">Rotation in degrees</param>
    /// <returns>True if operation started successfully</returns>
    public bool StartRotateOperation(float rotationDegrees)
    {
        if (!CanStartTransform("rotate"))
            return false;
            
        var operation = new TransformOperation
        {
            Type = "rotate",
            BuildingId = _targetBuilding?.BuildingId ?? string.Empty,
            FromRotation = _targetBuilding?.Rotation ?? 0f,
            ToRotation = rotationDegrees,
            StartTime = Time.GetTimeDictFromSystem()
        };
        
        if (ValidateTransform && !ValidateRotateOperation(operation))
            return false;
            
        return StartTransformOperation(operation);
    }
```

Starts a rotate operation for the target building

**Returns:** `bool`

**Parameters:**
- `float rotationDegrees`

### StartFlipOperation

```csharp
/// <summary>
    /// Starts a flip operation for the target building
    /// </summary>
    /// <param name="flipHorizontal">Whether to flip horizontally</param>
    /// <param name="flipVertical">Whether to flip vertically</param>
    /// <returns>True if operation started successfully</returns>
    public bool StartFlipOperation(bool flipHorizontal, bool flipVertical)
    {
        if (!CanStartTransform("flip"))
            return false;
            
        var operation = new TransformOperation
        {
            Type = "flip",
            BuildingId = _targetBuilding?.BuildingId ?? string.Empty,
            FromFlipH = _targetBuilding?.FlipHorizontal ?? false,
            FromFlipV = _targetBuilding?.FlipVertical ?? false,
            ToFlipH = flipHorizontal,
            ToFlipV = flipVertical,
            StartTime = Time.GetTimeDictFromSystem()
        };
        
        if (ValidateTransform && !ValidateFlipOperation(operation))
            return false;
            
        return StartTransformOperation(operation);
    }
```

Starts a flip operation for the target building

**Returns:** `bool`

**Parameters:**
- `bool flipHorizontal`
- `bool flipVertical`

### StartDemolishOperation

```csharp
/// <summary>
    /// Starts a demolish operation for the target building
    /// </summary>
    /// <returns>True if operation started successfully</returns>
    public bool StartDemolishOperation()
    {
        if (!CanStartTransform("demolish"))
            return false;
            
        var operation = new TransformOperation
        {
            Type = "demolish",
            BuildingId = _targetBuilding?.BuildingId ?? string.Empty,
            StartTime = Time.GetTimeDictFromSystem()
        };
        
        if (ValidateTransform && !ValidateDemolishOperation(operation))
            return false;
            
        return StartTransformOperation(operation);
    }
```

Starts a demolish operation for the target building

**Returns:** `bool`

### CancelActiveTransform

```csharp
/// <summary>
    /// Cancels the current active transform operation
    /// </summary>
    public void CancelActiveTransform()
    {
        if (!IsTransformActive)
            return;
            
        var operation = ActiveTransform;
        if (operation != null)
        {
            _activeOperations.Remove(operation.BuildingId);
            EmitSignal(SignalName.TransformCancelled, operation.BuildingId, operation.Type);
        }
    }
```

Cancels the current active transform operation

**Returns:** `void`

### UpdateTransforms

```csharp
/// <summary>
    /// Updates the transform handler (called each frame)
    /// </summary>
    /// <param name="delta">Time since last frame</param>
    public void UpdateTransforms(double delta)
    {
        if (!IsTransformActive)
            return;
            
        var completedOperations = new List<string>();
        
        foreach (var kvp in _activeOperations)
        {
            var operation = kvp.Value;
            
            if (AnimateTransforms)
            {
                UpdateAnimatedTransform(operation, (float)delta);
                if (IsTransformComplete(operation))
                {
                    CompleteTransformOperation(operation);
                    completedOperations.Add(kvp.Key);
                }
            }
            else
            {
                CompleteTransformOperation(operation);
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

Updates the transform handler (called each frame)

**Returns:** `void`

**Parameters:**
- `double delta`

### _Ready

```csharp
#endregion
    
    #endregion
    
    #region Godot Lifecycle
    
    public override void _Ready()
    {
        // Initialize systems
        UpdateTargetBuilding();
    }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
    {
        UpdateTransforms(delta);
    }
```

**Returns:** `void`

**Parameters:**
- `double delta`

