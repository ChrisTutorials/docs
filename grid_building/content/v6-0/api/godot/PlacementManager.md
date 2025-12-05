---
title: "PlacementManager"
description: "Manages placement validation and completion for manipulated objects.
Responsibilities:
- Validate placement against rules and constraints
- Apply transforms (position, rotation, scale) to placed objects
- Handle placement success/failure feedback
- Coordinate cleanup after placement
Design: Dependencies injected via constructor for clear contracts and type safety
Ported from: godot/addons/grid_building/systems/manipulation/managers/placement_manager.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/placementmanager/"
---

# PlacementManager

```csharp
GridBuilding.Godot.Systems.Manipulation.Internal
class PlacementManager
{
    // Members...
}
```

Manages placement validation and completion for manipulated objects.
Responsibilities:
- Validate placement against rules and constraints
- Apply transforms (position, rotation, scale) to placed objects
- Handle placement success/failure feedback
- Coordinate cleanup after placement
Design: Dependencies injected via constructor for clear contracts and type safety
Ported from: godot/addons/grid_building/systems/manipulation/managers/placement_manager.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/Internal/PlacementManager.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Internal`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### TryPlacement

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Attempts to place a manipulated object at the current location.
    /// </summary>
    /// <param name="moveData">ManipulationData containing source and move copy information</param>
    /// <returns>ValidationResults with success status and any issues</returns>
    public ValidationResults TryPlacement(ManipulationData moveData)
    {
        if (moveData == null || !IsValidMoveData(moveData))
        {
            var badMoveResults = new ValidationResults(
                false, 
                "[moveData] is not valid. Cannot move object.", 
                new global::Godot.Collections.Dictionary()
            );
            badMoveResults.AddError("[moveData] is not valid. Cannot move object.");

            if (moveData != null)
            {
                moveData.Message = string.Format(_manipulationSettings.InvalidData ?? "Invalid move data: {0}", moveData);
                moveData.Status = ManipulationStatus.Failed;
            }

            // CRITICAL FIX: Clean up invalid move data
            CleanupInvalidMove(moveData);
            
            return badMoveResults;
        }

        // Validate placement rules
        var validationResult = ValidatePlacementRules(moveData);
        
        if (!validationResult.IsValid)
        {
            // Placement failed - update move data and clean up
            moveData.Message = validationResult.Message;
            moveData.Status = ManipulationStatus.Failed;
            moveData.Results = validationResult;
            
            CleanupInvalidMove(moveData);
            return validationResult;
        }

        // Apply placement if validation passed
        var applyResult = ApplyPlacement(moveData);
        
        if (!applyResult.IsValid)
        {
            moveData.Message = applyResult.Message;
            moveData.Status = ManipulationStatus.Failed;
            moveData.Results = applyResult;
            
            CleanupInvalidMove(moveData);
            return applyResult;
        }

        // Placement succeeded
        moveData.Status = ManipulationStatus.Finished;
        moveData.Results = applyResult;
        
        // Clean up successful placement
        CleanupSuccessfulPlacement(moveData);
        
        return applyResult;
    }
```

Attempts to place a manipulated object at the current location.

**Returns:** `ValidationResults`

**Parameters:**
- `ManipulationData moveData`

### ValidatePlacement

```csharp
/// <summary>
    /// Validates if placement is allowed at the current position.
    /// </summary>
    /// <param name="moveData">ManipulationData containing placement info</param>
    /// <returns>ValidationResults with validation status</returns>
    public ValidationResults ValidatePlacement(ManipulationData moveData)
    {
        if (moveData == null || !IsValidMoveData(moveData))
        {
            return new ValidationResults(
                false,
                "Invalid move data for validation",
                new global::Godot.Collections.Dictionary()
            );
        }

        return ValidatePlacementRules(moveData);
    }
```

Validates if placement is allowed at the current position.

**Returns:** `ValidationResults`

**Parameters:**
- `ManipulationData moveData`

