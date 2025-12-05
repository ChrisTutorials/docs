---
title: "ManipulationSystem"
description: "Core manipulation system for grid building objects.
Provides the pure C# logic foundation for move, rotate, flip, and demolish operations.
Ported from: godot/addons/grid_building/systems/manipulation/manipulation_system.gd"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/manipulationsystem/"
---

# ManipulationSystem

```csharp
GridBuilding.Core.Systems.Manipulation
class ManipulationSystem
{
    // Members...
}
```

Core manipulation system for grid building objects.
Provides the pure C# logic foundation for move, rotate, flip, and demolish operations.
Ported from: godot/addons/grid_building/systems/manipulation/manipulation_system.gd

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Placement/Manipulation/ManipulationSystem.cs`  
**Namespace:** `GridBuilding.Core.Systems.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CurrentState

```csharp
#endregion

    #region Public Properties

    /// <summary>
    /// Current manipulation state.
    /// </summary>
    public ManipulationState? CurrentState => GetActiveManipulation();
```

Current manipulation state.

### IsActive

```csharp
/// <summary>
    /// Whether the system is currently active.
    /// </summary>
    public bool IsActive => _isActive;
```

Whether the system is currently active.

### ManipulationService

```csharp
/// <summary>
    /// Access to the manipulation service.
    /// </summary>
    public ManipulationService ManipulationService => _manipulationService;
```

Access to the manipulation service.

### TransformHandler

```csharp
/// <summary>
    /// Access to the transform handler.
    /// </summary>
    public ManipulationTransformHandler TransformHandler => _transformHandler;
```

Access to the transform handler.

### PhysicsManager

```csharp
/// <summary>
    /// Access to the physics layer manager.
    /// </summary>
    public PhysicsLayerManager PhysicsManager => _physicsManager;
```

Access to the physics layer manager.

### MoveManager

```csharp
/// <summary>
    /// Access to the move workflow manager.
    /// </summary>
    public MoveWorkflowManager MoveManager => _moveManager;
```

Access to the move workflow manager.

### PlacementManager

```csharp
/// <summary>
    /// Access to the placement manager.
    /// </summary>
    public PlacementManager PlacementManager => _placementManager;
```

Access to the placement manager.

### DemolishManager

```csharp
/// <summary>
    /// Access to the demolish manager.
    /// </summary>
    public DemolishManager DemolishManager => _demolishManager;
```

Access to the demolish manager.

### Settings

```csharp
/// <summary>
    /// Current manipulation settings.
    /// </summary>
    public ManipulationSettings Settings => _settings;
```

Current manipulation settings.


## Methods

### StartMove

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Starts a move operation for the specified target.
    /// </summary>
    /// <param name="target">Target to move</param>
    /// <param name="context">Manipulation context</param>
    /// <returns>Result of starting the move operation</returns>
    public ManipulationResult StartMove(ManipulationTarget target, ManipulationContext context)
    {
        if (_isActive)
        {
            return ManipulationResult.Failed("Another manipulation operation is already active");
        }

        if (target == null)
        {
            return ManipulationResult.Failed("Target cannot be null");
        }

        if (context == null)
        {
            return ManipulationResult.Failed("Context cannot be null");
        }

        try
        {
            // Start manipulation using the service
            var manipulationState = _manipulationService.StartManipulation(ManipulationMode.Move, target.GridPosition);
            
            // Start move workflow
            var moveSuccess = _moveManager.StartMove(manipulationState, target.ObjectId, target.GridPosition);
            if (!moveSuccess)
            {
                _manipulationService.CancelManipulation(manipulationState.ManipulationId);
                return ManipulationResult.Failed("Failed to start move workflow");
            }

            // Set context data
            manipulationState.SetContextData("targetObjectId", target.ObjectId);
            manipulationState.SetContextData("targetNodePath", target.NodePath);
            manipulationState.SetContextData("manipulationContext", context);

            return new ManipulationResult
            {
                IsSuccess = true,
                ManipulationType = ManipulationMode.Move,
                OriginalPosition = target.GridPosition,
                NewPosition = target.GridPosition,
                Data = new Dictionary<string, object>
                {
                    ["manipulationId"] = manipulationState.ManipulationId,
                    ["workflowId"] = manipulationState.GetContextData<string>("moveWorkflowId")
                }
            };
        }
        catch (Exception ex)
        {
            return ManipulationResult.Failed($"Move operation failed: {ex.Message}");
        }
    }
```

Starts a move operation for the specified target.

**Returns:** `ManipulationResult`

**Parameters:**
- `ManipulationTarget target`
- `ManipulationContext context`

### StartRotate

```csharp
/// <summary>
    /// Starts a rotate operation for the specified target.
    /// </summary>
    /// <param name="target">Target to rotate</param>
    /// <param name="rotationAngle">Rotation angle in degrees</param>
    /// <param name="context">Manipulation context</param>
    /// <returns>Result of starting the rotate operation</returns>
    public ManipulationResult StartRotate(ManipulationTarget target, float rotationAngle, ManipulationContext context)
    {
        if (_isActive)
        {
            return ManipulationResult.Failed("Another manipulation operation is already active");
        }

        if (target == null)
        {
            return ManipulationResult.Failed("Target cannot be null");
        }

        if (context == null)
        {
            return ManipulationResult.Failed("Context cannot be null");
        }

        try
        {
            // Start manipulation using the service
            var manipulationState = _manipulationService.StartManipulation(ManipulationMode.Rotate, target.GridPosition);
            
            // Set context data
            manipulationState.SetContextData("targetObjectId", target.ObjectId);
            manipulationState.SetContextData("targetNodePath", target.NodePath);
            manipulationState.SetContextData("rotationAngle", rotationAngle);
            manipulationState.SetContextData("manipulationContext", context);

            return new ManipulationResult
            {
                IsSuccess = true,
                ManipulationType = ManipulationMode.Rotate,
                OriginalPosition = target.GridPosition,
                NewPosition = target.GridPosition,
                Data = new Dictionary<string, object>
                {
                    ["manipulationId"] = manipulationState.ManipulationId,
                    ["rotationAngle"] = rotationAngle
                }
            };
        }
        catch (Exception ex)
        {
            return ManipulationResult.Failed($"Rotate operation failed: {ex.Message}");
        }
    }
```

Starts a rotate operation for the specified target.

**Returns:** `ManipulationResult`

**Parameters:**
- `ManipulationTarget target`
- `float rotationAngle`
- `ManipulationContext context`

### StartFlip

```csharp
/// <summary>
    /// Starts a flip operation for the specified target.
    /// </summary>
    /// <param name="target">Target to flip</param>
    /// <param name="flipDirection">Direction to flip</param>
    /// <param name="context">Manipulation context</param>
    /// <returns>Result of starting the flip operation</returns>
    public ManipulationResult StartFlip(ManipulationTarget target, FlipDirection flipDirection, ManipulationContext context)
    {
        if (_isActive)
        {
            return ManipulationResult.Failed("Another manipulation operation is already active");
        }

        if (target == null)
        {
            return ManipulationResult.Failed("Target cannot be null");
        }

        if (context == null)
        {
            return ManipulationResult.Failed("Context cannot be null");
        }

        try
        {
            // Start manipulation using the service
            var manipulationState = _manipulationService.StartManipulation(ManipulationMode.Flip, target.GridPosition);
            
            // Set context data
            manipulationState.SetContextData("targetObjectId", target.ObjectId);
            manipulationState.SetContextData("targetNodePath", target.NodePath);
            manipulationState.SetContextData("flipDirection", flipDirection);
            manipulationState.SetContextData("manipulationContext", context);

            return new ManipulationResult
            {
                IsSuccess = true,
                ManipulationType = ManipulationMode.Flip,
                OriginalPosition = target.GridPosition,
                NewPosition = target.GridPosition,
                Data = new Dictionary<string, object>
                {
                    ["manipulationId"] = manipulationState.ManipulationId,
                    ["flipDirection"] = flipDirection
                }
            };
        }
        catch (Exception ex)
        {
            return ManipulationResult.Failed($"Flip operation failed: {ex.Message}");
        }
    }
```

Starts a flip operation for the specified target.

**Returns:** `ManipulationResult`

**Parameters:**
- `ManipulationTarget target`
- `FlipDirection flipDirection`
- `ManipulationContext context`

### StartDemolish

```csharp
/// <summary>
    /// Starts a demolish operation for the specified target.
    /// </summary>
    /// <param name="target">Target to demolish</param>
    /// <param name="context">Manipulation context</param>
    /// <returns>Result of starting the demolish operation</returns>
    public ManipulationResult StartDemolish(ManipulationTarget target, ManipulationContext context)
    {
        if (_isActive)
        {
            return ManipulationResult.Failed("Another manipulation operation is already active");
        }

        if (target == null)
        {
            return ManipulationResult.Failed("Target cannot be null");
        }

        if (context == null)
        {
            return ManipulationResult.Failed("Context cannot be null");
        }

        try
        {
            // Start manipulation using the service
            var manipulationState = _manipulationService.StartManipulation(ManipulationMode.Remove, target.GridPosition);
            
            // Start demolish workflow
            var demolishSuccess = _demolishManager.StartDemolish(manipulationState, target.ObjectId, target.GridPosition);
            if (!demolishSuccess)
            {
                _manipulationService.CancelManipulation(manipulationState.ManipulationId);
                return ManipulationResult.Failed("Failed to start demolish workflow");
            }

            // Set context data
            manipulationState.SetContextData("targetObjectId", target.ObjectId);
            manipulationState.SetContextData("targetNodePath", target.NodePath);
            manipulationState.SetContextData("manipulationContext", context);

            return new ManipulationResult
            {
                IsSuccess = true,
                ManipulationType = ManipulationMode.Remove,
                OriginalPosition = target.GridPosition,
                NewPosition = target.GridPosition,
                Data = new Dictionary<string, object>
                {
                    ["manipulationId"] = manipulationState.ManipulationId,
                    ["demolishWorkflowId"] = manipulationState.GetContextData<string>("demolishWorkflowId")
                }
            };
        }
        catch (Exception ex)
        {
            return ManipulationResult.Failed($"Demolish operation failed: {ex.Message}");
        }
    }
```

Starts a demolish operation for the specified target.

**Returns:** `ManipulationResult`

**Parameters:**
- `ManipulationTarget target`
- `ManipulationContext context`

### CompleteOperation

```csharp
/// <summary>
    /// Completes the current manipulation operation.
    /// </summary>
    /// <returns>Result of completing the operation</returns>
    public ManipulationResult CompleteOperation()
    {
        var activeManipulation = GetActiveManipulation();
        if (activeManipulation == null)
        {
            return ManipulationResult.Failed("No active manipulation operation to complete");
        }

        try
        {
            switch (activeManipulation.CurrentMode)
            {
                case ManipulationMode.Move:
                    var moveResult = _moveManager.CompleteMove(activeManipulation);
                    if (moveResult.IsSuccess)
                    {
                        var placementResult = _placementManager.CompletePlacement(activeManipulation);
                        return new ManipulationResult
                        {
                            IsSuccess = placementResult.IsSuccess,
                            ErrorMessage = placementResult.ErrorMessage,
                            ManipulationType = ManipulationMode.Move,
                            OriginalPosition = moveResult.OriginalPosition,
                            NewPosition = moveResult.FinalPosition
                        };
                    }
                    return ManipulationResult.Failed(moveResult.ErrorMessage);

                case ManipulationMode.Rotate:
                    // Complete rotation by applying the transform
                    var rotationAngle = activeManipulation.GetContextData<float>("rotationAngle");
                    // In a real implementation, this would apply the rotation to the actual object
                    return _manipulationService.CompleteManipulation(activeManipulation.ManipulationId).IsSuccess
                        ? new ManipulationResult { IsSuccess = true, ManipulationType = ManipulationMode.Rotate }
                        : ManipulationResult.Failed("Failed to complete rotation");

                case ManipulationMode.Flip:
                    // Complete flip by applying the transform
                    var flipDirection = activeManipulation.GetContextData<FlipDirection>("flipDirection");
                    // In a real implementation, this would apply the flip to the actual object
                    return _manipulationService.CompleteManipulation(activeManipulation.ManipulationId).IsSuccess
                        ? new ManipulationResult { IsSuccess = true, ManipulationType = ManipulationMode.Flip }
                        : ManipulationResult.Failed("Failed to complete flip");

                case ManipulationMode.Remove:
                    var demolishResult = _demolishManager.CompleteDemolish(activeManipulation);
                    return new ManipulationResult
                    {
                        IsSuccess = demolishResult.IsSuccess,
                        ErrorMessage = demolishResult.ErrorMessage,
                        ManipulationType = ManipulationMode.Remove,
                        OriginalPosition = demolishResult.TargetPosition,
                        NewPosition = demolishResult.TargetPosition
                    };

                default:
                    return ManipulationResult.Failed($"Unsupported manipulation mode: {activeManipulation.CurrentMode}");
            }
        }
        catch (Exception ex)
        {
            return ManipulationResult.Failed($"Failed to complete operation: {ex.Message}");
        }
    }
```

Completes the current manipulation operation.

**Returns:** `ManipulationResult`

### CancelOperation

```csharp
/// <summary>
    /// Cancels the current manipulation operation.
    /// </summary>
    /// <returns>Result of canceling the operation</returns>
    public ManipulationResult CancelOperation()
    {
        var activeManipulation = GetActiveManipulation();
        if (activeManipulation == null)
        {
            return ManipulationResult.Failed("No active manipulation operation to cancel");
        }

        try
        {
            // Cancel based on operation type
            switch (activeManipulation.CurrentMode)
            {
                case ManipulationMode.Move:
                    _moveManager.CancelMove(activeManipulation);
                    break;
                case ManipulationMode.Remove:
                    _demolishManager.CancelDemolish(activeManipulation);
                    break;
                default:
                    // For other operations, just cancel the manipulation
                    break;
            }

            // Cancel the manipulation service
            var success = _manipulationService.CancelManipulation(activeManipulation.ManipulationId);
            
            return success 
                ? new ManipulationResult { IsSuccess = true, ManipulationType = activeManipulation.CurrentMode }
                : ManipulationResult.Failed("Failed to cancel manipulation");
        }
        catch (Exception ex)
        {
            return ManipulationResult.Failed($"Failed to cancel operation: {ex.Message}");
        }
    }
```

Cancels the current manipulation operation.

**Returns:** `ManipulationResult`

