---
title: "PlacementService"
description: "Core placement service implementation containing pure C# placement logic.
This service handles all business logic for placement validation and execution
without any Godot dependencies. It coordinates between validation, collision
detection, and targeting state to provide comprehensive placement functionality.
## Architecture:
- Pure C# business logic (no Godot dependencies)
- Coordinates with validation and collision services
- Maintains placement state and context
- Provides detailed placement reporting
## Dependencies:
- IPlacementValidator: Rule validation logic
- ICollisionCalculator: Collision detection and geometry
- IGridTargetingState: Targeting context and state
- ILogger: Operation logging and diagnostics"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/placementservice/"
---

# PlacementService

```csharp
GridBuilding.Core.Services.Placement
class PlacementService
{
    // Members...
}
```

Core placement service implementation containing pure C# placement logic.
This service handles all business logic for placement validation and execution
without any Godot dependencies. It coordinates between validation, collision
detection, and targeting state to provide comprehensive placement functionality.
## Architecture:
- Pure C# business logic (no Godot dependencies)
- Coordinates with validation and collision services
- Maintains placement state and context
- Provides detailed placement reporting
## Dependencies:
- IPlacementValidator: Rule validation logic
- ICollisionCalculator: Collision detection and geometry
- IGridTargetingState: Targeting context and state
- ILogger: Operation logging and diagnostics

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Placement/PlacementService.cs`  
**Namespace:** `GridBuilding.Core.Services.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsReady

```csharp
#endregion

    #region Properties
    /// <summary>
    /// Gets whether the placement service is ready for operations.
    /// </summary>
    public bool IsReady 
    { 
        get 
        {
            if (_isDisposed) return false;
            
            _isReady = _validator != null && _collisionCalculator != null && _targetingState != null;
            return _isReady;
        }
    }
```

Gets whether the placement service is ready for operations.


## Methods

### ValidatePlacement

```csharp
#endregion

    #region IPlacementService Implementation
    /// <summary>
    /// Validates placement of a placeable at a specific position.
    /// </summary>
    /// <param name="placeable">The placeable to validate</param>
    /// <param name="position">Target position for placement</param>
    /// <param name="placer">Entity performing the placement</param>
    /// <returns>Placement validation report with detailed results</returns>
    public PlacementReport ValidatePlacement(Placeable placeable, Vector2 position, GBOwner placer)
    {
        if (!IsReady)
            return CreateErrorReport("Placement service not ready", placeable, placer);

        if (placeable == null)
            return CreateErrorReport("Placeable is null", placeable, placer);

        if (placer == null)
            return CreateErrorReport("Placer is null", placeable, placer);

        try
        {
            _logger.LogInfo($"Validating placement of {placeable.DisplayName} at {position}");
            
            // Update targeting state
            _targetingState.UpdateTargetPosition(position);
            _targetingState.UpdatePlacer(placer);
            
            // Create validation context
            var context = new PlacementValidationContext
            {
                Placeable = placeable,
                Position = position,
                Placer = placer,
                TargetingState = _targetingState
            };
            
            // Run placement validation
            var validationResult = _validator.ValidatePlacement(context);
            if (validationResult == null)
                return CreateErrorReport("Validation service returned null result", placeable, placer);
            
            // Run collision detection
            var collisionResult = _collisionCalculator.CalculateCollision(placeable, position);
            
            // Create comprehensive placement report
            var report = new PlacementReport(placer, validationResult, collisionResult);
            
            if (!validationResult.IsValid)
            {
                foreach (var issue in validationResult.Issues)
                {
                    report.AddIssue(issue);
                }
            }
            
            if (!collisionResult.IsValid)
            {
                foreach (var collision in collisionResult.Collisions)
                {
                    report.AddIssue($"Collision detected: {collision}");
                }
            }
            
            _logger.LogInfo($"Placement validation completed: {report.GetSummary()}");
            return report;
        }
        catch (Exception ex)
        {
            _logger.LogError($"Exception during placement validation: {ex.Message}");
            return CreateErrorReport($"Validation exception: {ex.Message}", placeable, placer);
        }
    }
```

Validates placement of a placeable at a specific position.

**Returns:** `PlacementReport`

**Parameters:**
- `Placeable placeable`
- `Vector2 position`
- `GBOwner placer`

### ExecutePlacement

```csharp
/// <summary>
    /// Executes placement of a placeable at a specific position.
    /// Note: This only handles the business logic. Actual scene instantiation
    /// should be handled by ISceneService in the Godot layer.
    /// </summary>
    /// <param name="placeable">The placeable to place</param>
    /// <param name="position">Target position for placement</param>
    /// <param name="placer">Entity performing the placement</param>
    /// <returns>Placement execution result with outcome details</returns>
    public PlacementResult ExecutePlacement(Placeable placeable, Vector2 position, GBOwner placer)
    {
        if (!IsReady)
            return PlacementResult.Failed(placeable, position, placer, "Placement service not ready");

        if (placeable == null)
            return PlacementResult.Failed(placeable, position, placer, "Placeable is null");

        if (placer == null)
            return PlacementResult.Failed(placeable, position, placer, "Placer is null");

        try
        {
            _logger.LogInfo($"Executing placement of {placeable.DisplayName} at {position}");
            
            // First validate the placement
            var validationReport = ValidatePlacement(placeable, position, placer);
            if (!validationReport.IsSuccessful())
            {
                var errors = validationReport.GetIssues().Select(i => i.Description);
                return PlacementResult.Failed(placeable, position, placer, errors);
            }
            
            // Business logic validation passed
            // The actual scene instantiation will be handled by ISceneService in Godot layer
            var result = PlacementResult.Success(placeable, position, placer);
            
            _logger.LogInfo($"Placement execution completed successfully: {result}");
            return result;
        }
        catch (Exception ex)
        {
            _logger.LogError($"Exception during placement execution: {ex.Message}");
            return PlacementResult.Failed(placeable, position, placer, $"Placement exception: {ex.Message}");
        }
    }
```

Executes placement of a placeable at a specific position.
Note: This only handles the business logic. Actual scene instantiation
should be handled by ISceneService in the Godot layer.

**Returns:** `PlacementResult`

**Parameters:**
- `Placeable placeable`
- `Vector2 position`
- `GBOwner placer`

### GetValidationIssues

```csharp
/// <summary>
    /// Gets validation issues if any dependencies are missing or misconfigured.
    /// </summary>
    /// <returns>Collection of validation issue descriptions</returns>
    public IEnumerable<string> GetValidationIssues()
    {
        var issues = new List<string>();
        
        if (_validator == null)
            issues.Add("IPlacementValidator is not available");
        if (_collisionCalculator == null)
            issues.Add("ICollisionCalculator is not available");
        if (_targetingState == null)
            issues.Add("IGridTargetingState is not available");
        if (_logger == null)
            issues.Add("ILogger is not available");
        if (_isDisposed)
            issues.Add("PlacementService has been disposed");
            
        return issues;
    }
```

Gets validation issues if any dependencies are missing or misconfigured.

**Returns:** `IEnumerable<string>`

### Reset

```csharp
/// <summary>
    /// Resets the placement service state.
    /// </summary>
    public void Reset()
    {
        if (_isDisposed)
        {
            _logger.LogWarning("Attempted to reset disposed PlacementService");
            return;
        }

        _logger.LogInfo("Resetting PlacementService state");
        
        // Reset targeting state if available
        _targetingState?.Reset();
        
        // Reset validation state if available
        if (_validator is IResettable resettableValidator)
            resettableValidator.Reset();
            
        // Reset collision calculator if available
        if (_collisionCalculator is IResettable resettableCalculator)
            resettableCalculator.Reset();
            
        _isReady = false;
        _logger.LogInfo("PlacementService reset completed");
    }
```

Resets the placement service state.

**Returns:** `void`

### RemoveObject

```csharp
#endregion

    /// <summary>
    /// Removes a placed object from the specified position.
    /// </summary>
    /// <param name="position">Position of the object to remove</param>
    /// <param name="remover">Entity performing the removal</param>
    /// <returns>True if removal was successful</returns>
    public bool RemoveObject(Vector2 position, GBOwner remover)
    {
        // TODO: Implement object removal logic
        _logger.LogInfo($"RemoveObject called at position {position} by {remover?.Id}");
        return true;
    }
```

Removes a placed object from the specified position.

**Returns:** `bool`

**Parameters:**
- `Vector2 position`
- `GBOwner remover`

### MoveObject

```csharp
/// <summary>
    /// Moves an object from one position to another.
    /// </summary>
    /// <param name="fromPosition">Current position of the object</param>
    /// <param name="toPosition">Target position for movement</param>
    /// <param name="mover">Entity performing the movement</param>
    /// <returns>True if movement was successful</returns>
    public bool MoveObject(Vector2 fromPosition, Vector2 toPosition, GBOwner mover)
    {
        // TODO: Implement object movement logic
        _logger.LogInfo($"MoveObject from {fromPosition} to {toPosition} by {mover?.Id}");
        return true;
    }
```

Moves an object from one position to another.

**Returns:** `bool`

**Parameters:**
- `Vector2 fromPosition`
- `Vector2 toPosition`
- `GBOwner mover`

### IsPositionOccupied

```csharp
/// <summary>
    /// Checks if a position is currently occupied.
    /// </summary>
    /// <param name="position">Position to check</param>
    /// <returns>True if position is occupied</returns>
    public bool IsPositionOccupied(Vector2 position)
    {
        // TODO: Implement position occupancy check
        _logger.LogInfo($"IsPositionOccupied called for position {position}");
        return false;
    }
```

Checks if a position is currently occupied.

**Returns:** `bool`

**Parameters:**
- `Vector2 position`

### GetObjectsInArea

```csharp
/// <summary>
    /// Gets all placed objects within a specified area.
    /// </summary>
    /// <param name="area">Area to search within</param>
    /// <returns>Collection of placed objects in the area</returns>
    public IEnumerable<Placeable> GetObjectsInArea(Rect2I area)
    {
        // TODO: Implement area query logic
        _logger.LogInfo($"GetObjectsInArea called for area {area}");
        return Enumerable.Empty<Placeable>();
    }
```

Gets all placed objects within a specified area.

**Returns:** `IEnumerable<Placeable>`

**Parameters:**
- `Rect2I area`

### GetObjectsByOwner

```csharp
/// <summary>
    /// Gets all objects owned by a specific entity.
    /// </summary>
    /// <param name="ownerId">Owner identifier</param>
    /// <returns>Collection of objects owned by the specified entity</returns>
    public IEnumerable<Placeable> GetObjectsByOwner(string ownerId)
    {
        // TODO: Implement owner query logic
        _logger.LogInfo($"GetObjectsByOwner called for owner {ownerId}");
        return Enumerable.Empty<Placeable>();
    }
```

Gets all objects owned by a specific entity.

**Returns:** `IEnumerable<Placeable>`

**Parameters:**
- `string ownerId`

### ValidateObjectPlacement

```csharp
/// <summary>
    /// Validates object placement with detailed error reporting.
    /// </summary>
    /// <param name="position">Target position</param>
    /// <param name="placeableType">Type of placeable object</param>
    /// <returns>List of validation issues</returns>
    public List<string> ValidateObjectPlacement(Vector2 position, string placeableType)
    {
        // TODO: Implement detailed validation logic
        _logger.LogInfo($"ValidateObjectPlacement called for {placeableType} at {position}");
        return new List<string>();
    }
```

Validates object placement with detailed error reporting.

**Returns:** `List<string>`

**Parameters:**
- `Vector2 position`
- `string placeableType`

### ClearAllObjects

```csharp
/// <summary>
    /// Clears all placed objects (for testing/reset scenarios).
    /// </summary>
    public void ClearAllObjects()
    {
        // TODO: Implement clear all objects logic
        _logger.LogInfo("ClearAllObjects called");
    }
```

Clears all placed objects (for testing/reset scenarios).

**Returns:** `void`

### Dispose

```csharp
#region IDisposable Implementation
    /// <summary>
    /// Disposes of the placement service and its resources.
    /// </summary>
    public void Dispose()
    {
        if (_isDisposed)
            return;

        _logger.LogInfo("Disposing PlacementService");
        
        // Dispose of disposable dependencies
        if (_validator is IDisposable disposableValidator)
            disposableValidator.Dispose();
            
        if (_collisionCalculator is IDisposable disposableCalculator)
            disposableCalculator.Dispose();
            
        if (_targetingState is IDisposable disposableState)
            disposableState.Dispose();
            
        if (_logger is IDisposable disposableLogger)
            disposableLogger.Dispose();

        _isDisposed = true;
        _isReady = false;
    #endregion
    }
```

Disposes of the placement service and its resources.

**Returns:** `void`

