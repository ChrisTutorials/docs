---
title: "PlacementSystem"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/placementsystem/"
---

# PlacementSystem

```csharp
GridBuilding.Godot.Systems.Placement
class PlacementSystem
{
    // Members...
}
```

Main coordinator for the GridBuilding placement system.
This system orchestrates all placement-related functionality including validation,
indicator management, collision detection, and rule processing. It serves as the
central entry point for placement operations and coordinates between the various
placement managers and validators.
## Architecture
- PlacementSystem: Main coordinator (this class)
- IndicatorService: Manages visual feedback indicators
- PlacementValidator: Handles rule validation
- CollisionGeometryCalculator: Processes collision geometry
- IndicatorFactory: Creates indicator instances
## Usage Pattern
```
var system = PlacementSystem.CreateWithInjection(container);
var report = system.ValidatePlacement(placeable, position);
if (report.IsSuccessful()) {
system.ExecutePlacement(placeable, position);
}

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/PlacementSystem.Legacy.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsReady

```csharp
#endregion
    #region Properties
    /// Whether the placement system is ready for use.
    public bool IsReady { get; private set; } = false;
```


## Methods

### CreateWithInjection

```csharp
#endregion
    #region Static Factory
    /// Creates a PlacementSystem with dependency injection from container.
    /// <param name="container">The dependency container</param>
    /// <returns>Fully configured placement system</returns>
    public static PlacementSystem CreateWithInjection(GBCompositionContainer container)
    {
        var logger = container.GetLogger();
        var gridTargetingState = container.GetGridTargetingState();
        var system = new PlacementSystem();
        system._logger = logger;
        system._gridTargetingState = gridTargetingState;
        // Inject dependencies
        system.ResolveGbDependencies(container);
        // Validate dependencies
        var issues = system.GetRuntimeIssues();
        if (issues.Count > 0)
        {
            logger.LogWarnings(issues);
        }
        return system;
    }
```

**Returns:** `PlacementSystem`

**Parameters:**
- `GBCompositionContainer container`

### _Ready

```csharp
#endregion
    #region Godot Lifecycle
    /// Called when the node enters the scene tree.
    public override void _Ready()
    {
        base._Ready();
        InitializeSystem();
    }
```

**Returns:** `void`

### _Process

```csharp
/// Called every frame.
    /// <param name="delta">Time since last frame</param>
    public override void _Process(double delta)
    {
        base._Process(delta);
        
        if (!IsReady)
            return;
        // Process any ongoing placement operations
        ProcessPlacementOperations(delta);
    }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### ValidatePlacement

```csharp
#endregion
    #region Public API
    /// Validates placement of a placeable at a specific position.
    /// <param name="placeable">The placeable to validate</param>
    /// <param name="position">Target position for placement</param>
    /// <param name="placer">Entity performing the placement (or null to use context owner)</param>
    /// <returns>Placement report with validation results</returns>
    public PlacementReport ValidatePlacement(Placeable placeable, Vector2 position, IOwner? placer = null)
    {
        if (!IsReady)
            return CreateErrorReport("Placement system not ready", placeable, placer);
        try
        {
            _logger?.LogInfo($"Validating placement of {placeable.DisplayName} at {position}");
            // Update grid targeting state
            _gridTargetingState?.UpdateTargetPosition(position);
            _gridTargetingState?.UpdatePlacer(placer);
            // Create preview instance for validation
            var previewInstance = CreatePreviewInstance(placeable);
            if (previewInstance == null)
            {
                return CreateErrorReport("Failed to create preview instance", placeable, placer);
            }
            // Setup indicators for validation
            var indicatorsReport = SetupIndicators(previewInstance, placeable);
            if (!indicatorsReport.IsSuccessful)
                return CreateErrorReport("Indicator setup failed", placeable, placer, indicatorsReport);
            // Run placement validation
            var validationResults = _placementValidator?.ValidatePlacement(previewInstance);
            if (validationResults == null)
                return CreateErrorReport("Validation failed", placeable, placer, indicatorsReport);
            // Create placement report
            var report = new PlacementReport(placer, previewInstance, indicatorsReport, ManipulationAction.Build);
            
            if (!validationResults.IsValid)
            {
                foreach (var issue in validationResults.Issues)
                {
                    report.AddIssue(issue);
                }
            }
            _logger?.LogInfo($"Placement validation completed: {report.GetSummary()}");
            return report;
        }
        catch (System.Exception ex)
        {
            _logger?.LogError($"Exception during placement validation: {ex.Message}");
            return CreateErrorReport($"Validation exception: {ex.Message}", placeable, placer);
        }
    }
```

**Returns:** `PlacementReport`

**Parameters:**
- `Placeable placeable`
- `Vector2 position`
- `IOwner? placer`

### ExecutePlacement

```csharp
/// Executes placement of a placeable at a specific position.
    /// <param name="placeable">The placeable to place</param>
    /// <returns>Placement report with execution results</returns>
    public PlacementReport ExecutePlacement(Placeable placeable, Vector2 position, IOwner? placer = null)
    {
        try
        {
            _logger?.LogInfo($"Executing placement of {placeable.DisplayName} at {position}");
            // First validate the placement
            var validationReport = ValidatePlacement(placeable, position, placer);
            if (!validationReport.IsSuccessful())
                return validationReport;
            // Execute the actual placement
            var placedInstance = placeable.PackedScene?.Instantiate();
            if (placedInstance == null)
                return CreateErrorReport("Failed to instantiate placeable scene", placeable, placer);
            // Set position and add to scene
            placedInstance.Position = position;
            placer.AddChild(placedInstance);
            // Update the report with successful placement
            validationReport.Placed = placedInstance;
            validationReport.AddNote($"Successfully placed {placeable.DisplayName} at {position}");
            _logger?.LogInfo($"Placement executed successfully: {validationReport.GetSummary()}");
            return validationReport;
        }
        catch (System.Exception ex)
        {
            _logger?.LogError($"Exception during placement execution: {ex.Message}");
            return CreateErrorReport($"Placement exception: {ex.Message}", placeable, placer);
        }
    }
```

**Returns:** `PlacementReport`

**Parameters:**
- `Placeable placeable`
- `Vector2 position`
- `IOwner? placer`

### Reset

```csharp
/// Resets the placement system state.
    public void Reset()
    {
        _indicatorService?.Reset();
        _placementValidator?.Reset();
        IsReady = false;
    }
```

**Returns:** `void`

### ResolveGbDependencies

```csharp
#endregion
    #region Dependency Injection
    /// Resolves GB dependencies from the container.
    public override void ResolveGbDependencies(GBCompositionContainer container)
    {
        base.ResolveGbDependencies(container);
        _indicatorService = container.GetService<IndicatorService>();
        _placementValidator = container.GetService<PlacementValidator>();
        _collisionCalculator = container.GetService<CollisionGeometryCalculator>();
        _indicatorFactory = container.GetService<IndicatorFactory>();
    }
```

**Returns:** `void`

**Parameters:**
- `GBCompositionContainer container`

### GetRuntimeIssues

```csharp
/// Gets runtime issues for the placement system.
    /// <returns>Array of runtime issues</returns>
    public override global::Godot.Collections.Array<string> GetRuntimeIssues()
    {
        var issues = base.GetRuntimeIssues();
        if (_indicatorService == null)
            issues.Add("IndicatorService is not available");
        if (_placementValidator == null)
            issues.Add("PlacementValidator is not available");
        if (_collisionCalculator == null)
            issues.Add("CollisionGeometryCalculator is not available");
        if (_indicatorFactory == null)
            issues.Add("IndicatorFactory is not available");
        if (_logger == null)
            issues.Add("Logger is not available");
        return issues;
    }
```

**Returns:** `global::Godot.Collections.Array<string>`

