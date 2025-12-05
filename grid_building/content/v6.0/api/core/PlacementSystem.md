---
title: "PlacementSystem"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/placementsystem/"
---

# PlacementSystem

```csharp
GridBuilding.Core.Systems.Placement
class PlacementSystem
{
    // Members...
}
```

Core placement system that coordinates all placement-related functionality.
Pure C# implementation without Godot dependencies for unit testing.
This system orchestrates placement operations including validation,
indicator management, collision detection, and rule processing.
Responsibilities:
- Coordinate placement validation and execution
- Manage indicator setup and positioning
- Handle collision detection integration
- Process placement rules and validation
- Generate placement reports
Ported from: godot/addons/grid_building/systems/placement/placement_system.gd

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Placement/Placement.cs/PlacementSystem.cs`  
**Namespace:** `GridBuilding.Core.Systems.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### GridTargetingState

```csharp
#endregion

    #region Properties

    /// <summary>
    /// The grid targeting state for position information.
    /// </summary>
    public IGridTargetingState? GridTargetingState { get; private set; }
```

The grid targeting state for position information.

### BuildingState

```csharp
/// <summary>
    /// The building state for building operations.
    /// </summary>
    public IBuildingState? BuildingState { get; private set; }
```

The building state for building operations.

### PlacementContext

```csharp
/// <summary>
    /// The placement context for validation.
    /// </summary>
    public IPlacementContext? PlacementContext { get; private set; }
```

The placement context for validation.

### IsReady

```csharp
/// <summary>
    /// Whether the system is ready for placement operations.
    /// </summary>
    public bool IsReady => 
        GridTargetingState?.IsReady == true && 
        BuildingState?.IsReady == true && 
        PlacementContext != null;
```

Whether the system is ready for placement operations.


## Methods

### SetGridTargetingState

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Sets the grid targeting state.
    /// </summary>
    /// <param name="targetingState">The targeting state</param>
    public void SetGridTargetingState(IGridTargetingState targetingState)
    {
        GridTargetingState = targetingState;
    }
```

Sets the grid targeting state.

**Returns:** `void`

**Parameters:**
- `IGridTargetingState targetingState`

### SetBuildingState

```csharp
/// <summary>
    /// Sets the building state.
    /// </summary>
    /// <param name="buildingState">The building state</param>
    public void SetBuildingState(IBuildingState buildingState)
    {
        BuildingState = buildingState;
    }
```

Sets the building state.

**Returns:** `void`

**Parameters:**
- `IBuildingState buildingState`

### SetPlacementContext

```csharp
/// <summary>
    /// Sets the placement context.
    /// </summary>
    /// <param name="context">The placement context</param>
    public void SetPlacementContext(IPlacementContext context)
    {
        PlacementContext = context;
    }
```

Sets the placement context.

**Returns:** `void`

**Parameters:**
- `IPlacementContext context`

### ValidatePlacement

```csharp
/// <summary>
    /// Validates a placement operation.
    /// </summary>
    /// <param name="placeable">The object to place</param>
    /// <param name="position">The target position</param>
    /// <returns>Placement report with validation results</returns>
    public PlacementReport ValidatePlacement(object? placeable, Vector2I position)
    {
        var report = new PlacementReport
        {
            ActionType = ManipulationAction.Build,
            PreviewInstance = placeable
        };

        if (!IsReady)
        {
            report.Issues.Add("Placement system is not ready");
            PlacementValidated?.Invoke(report);
            return report;
        }

        if (placeable == null)
        {
            report.Issues.Add("Placeable is null");
            PlacementValidated?.Invoke(report);
            return report;
        }

        // Validate position
        var positionIssues = ValidatePosition(position);
        report.Issues.AddRange(positionIssues);

        // Validate rules
        var ruleIssues = ValidatePlacementRules(placeable, position);
        report.Issues.AddRange(ruleIssues);

        // Set up indicators if validation passed
        if (report.Issues.Count == 0)
        {
            var indicatorReport = SetupIndicators(placeable, position);
            report.IndicatorsReport = indicatorReport;
            report.Issues.AddRange(indicatorReport.Issues);
        }

        PlacementValidated?.Invoke(report);
        return report;
    }
```

Validates a placement operation.

**Returns:** `PlacementReport`

**Parameters:**
- `object? placeable`
- `Vector2I position`

### ExecutePlacement

```csharp
/// <summary>
    /// Executes a placement operation.
    /// </summary>
    /// <param name="placeable">The object to place</param>
    /// <param name="position">The target position</param>
    /// <returns>Placement report with execution results</returns>
    public PlacementReport ExecutePlacement(object? placeable, Vector2I position)
    {
        var report = ValidatePlacement(placeable, position);
        
        // Don't execute if validation failed
        if (report.Issues.Count > 0)
        {
            PlacementExecuted?.Invoke(report);
            return report;
        }

        // Execute the placement
        try
        {
            // In a real implementation, this would coordinate with the building system
            // For POCS, we simulate successful placement
            report.Placed = placeable;
            report.Notes.Add("Placement executed successfully");
        }
        catch (Exception ex)
        {
            report.Issues.Add($"Placement execution failed: {ex.Message}");
        }

        PlacementExecuted?.Invoke(report);
        return report;
    }
```

Executes a placement operation.

**Returns:** `PlacementReport`

**Parameters:**
- `object? placeable`
- `Vector2I position`

### SetupIndicators

```csharp
/// <summary>
    /// Sets up indicators for a placement.
    /// </summary>
    /// <param name="placeable">The object being placed</param>
    /// <param name="position">The target position</param>
    /// <returns>Indicator setup report</returns>
    public IndicatorSetupReport SetupIndicators(object? placeable, Vector2I position)
    {
        var report = new IndicatorSetupReport
        {
            TargetingState = GridTargetingState
        };

        if (!IsReady)
        {
            report.Issues.Add("Cannot set up indicators - system not ready");
            return report;
        }

        if (placeable == null)
        {
            report.Issues.Add("Cannot set up indicators - placeable is null");
            return report;
        }

        // In a real implementation, this would:
        // 1. Calculate collision positions
        // 2. Create indicator instances
        // 3. Position indicators at calculated offsets
        // For POCS, we simulate successful setup
        report.Notes.Add("Indicators set up successfully");

        IndicatorsSetUp?.Invoke(report);
        return report;
    }
```

Sets up indicators for a placement.

**Returns:** `IndicatorSetupReport`

**Parameters:**
- `object? placeable`
- `Vector2I position`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Gets runtime validation issues.
    /// </summary>
    /// <returns>List of validation issues</returns>
    public List<string> GetRuntimeIssues()
    {
        var issues = new List<string>();

        if (GridTargetingState == null)
            issues.Add("GridTargetingState is not set");
        else if (!GridTargetingState.IsReady)
            issues.Add("GridTargetingState is not ready");

        if (BuildingState == null)
            issues.Add("BuildingState is not set");
        else if (!BuildingState.IsReady)
            issues.Add("BuildingState is not ready");

        if (PlacementContext == null)
            issues.Add("PlacementContext is not set");

        return issues;
    }
```

Gets runtime validation issues.

**Returns:** `List<string>`

