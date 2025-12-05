---
title: "MoveWorkflowManager"
description: "Manages the move workflow: copy creation, setup, and indicator initialization.
Responsibilities:
- Create manipulation copy with proper metadata
- Position and normalize copy transforms for indicator calculation
- Set up collision exclusions and targeting
- Initialize indicators with move rules
- Apply source rotation/scale after indicator setup
Design: Dependencies injected via constructor for clear contracts and type safety
Ported from: godot/addons/grid_building/systems/manipulation/managers/move_workflow_manager.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/moveworkflowmanager/"
---

# MoveWorkflowManager

```csharp
GridBuilding.Godot.Systems.Manipulation.Internal
class MoveWorkflowManager
{
    // Members...
}
```

Manages the move workflow: copy creation, setup, and indicator initialization.
Responsibilities:
- Create manipulation copy with proper metadata
- Position and normalize copy transforms for indicator calculation
- Set up collision exclusions and targeting
- Initialize indicators with move rules
- Apply source rotation/scale after indicator setup
Design: Dependencies injected via constructor for clear contracts and type safety
Ported from: godot/addons/grid_building/systems/manipulation/managers/move_workflow_manager.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/Internal/MoveWorkflowManager.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Internal`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### StartMove

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Starts a move operation by creating a manipulation copy and setting up indicators.
    /// </summary>
    /// <param name="data">ManipulationData containing source and target information</param>
    /// <returns>True if setup successful, false on failure</returns>
    public bool StartMove(ManipulationData data)
    {
        // Validate input data
        if (data == null || data.Source == null)
            return false;

        // Create the manipulation copy
        var moveCopy = CreateManipulationCopy(data.Source);
        if (moveCopy == null)
        {
            _logger.LogError("Failed to create manipulation copy");
            return false;
        }

        data.MoveCopy = moveCopy;

        // Position the copy at initial location
        PositionManipulationCopy(data);

        // Set up collision exclusions
        SetupCollisionExclusions(data);

        // Initialize indicators for move validation
        var indicatorsSetup = InitializeMoveIndicators(data);
        if (!indicatorsSetup)
        {
            _logger.LogError("Failed to initialize move indicators");
            return false;
        }

        // Apply source transforms after setup
        ApplySourceTransforms(data);

        // Start monitoring source for deletion
        StartSourceMonitoring(data.Source.Root);

        // Disable physics on source
        EmitSignal(SignalName.DisablePhysicsRequested, data.Source.Root);

        _logger.LogInfo($"Move operation started for {data.Source.Root?.Name}");
        return true;
    }
```

Starts a move operation by creating a manipulation copy and setting up indicators.

**Returns:** `bool`

**Parameters:**
- `ManipulationData data`

### EndMove

```csharp
/// <summary>
    /// Ends a move operation and cleans up resources.
    /// </summary>
    /// <param name="data">ManipulationData containing operation state</param>
    /// <param name="commit">Whether to commit the move (true) or cancel (false)</param>
    public void EndMove(ManipulationData data, bool commit)
    {
        if (data == null || data.MoveCopy == null)
            return;

        try
        {
            if (commit)
            {
                CommitMove(data);
            }
            else
            {
                CancelMove(data);
            }

            // Clean up indicators
            CleanupMoveIndicators(data);

            // Stop monitoring source
            StopSourceMonitoring();

            // Re-enable physics on source
            EmitSignal(SignalName.EnablePhysicsRequested);

            _logger.LogInfo($"Move operation {(commit ? "committed" : "cancelled")} for {data.Source?.Root?.Name}");
        }
        catch (Exception ex)
        {
            _logger.LogError($"Error ending move operation: {ex.Message}");
        }
        finally
        {
            // Always clean up the move copy
            CleanupManipulationCopy(data);
        }
    }
```

Ends a move operation and cleans up resources.

**Returns:** `void`

**Parameters:**
- `ManipulationData data`
- `bool commit`

