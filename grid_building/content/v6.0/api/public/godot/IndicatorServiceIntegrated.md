---
title: "IndicatorServiceIntegrated"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/indicatorserviceintegrated/"
---

# IndicatorServiceIntegrated

```csharp
GridBuilding.Godot.Systems.Placement.Managers
class IndicatorServiceIntegrated
{
    // Members...
}
```

Integrated IndicatorService that uses Core business logic through interfaces.
This updated version delegates all calculation logic to the Core IndicatorCalculationService
while maintaining the same Godot-specific responsibilities for node management,
collision detection, and visual presentation.
## Architecture
- Core Layer: Pure business logic via IIndicatorCalculationService
- Adapter Layer: Converts between Godot and Core data structures
- Godot Layer: Node lifecycle, collision detection, visual management

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Managers/IndicatorServiceIntegrated.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Managers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CreateWithInjection

```csharp
#endregion

    #region Static Factory Methods

    /// <summary>
    /// Creates an IndicatorServiceIntegrated with dependency injection from container.
    /// </summary>
    /// <param name="container">The dependency container providing all required services</param>
    /// <param name="parent">The parent node for indicators (required - cannot be resolved from container)</param>
    /// <returns>Fully configured indicator service with validated dependencies</returns>
    public static IndicatorServiceIntegrated CreateWithInjection(GBCompositionContainer container, Node parent)
    {
        // Get dependencies from container
        var targetingState = container.GetTargetingState();
        var logger = container.GetLogger();
        var template = container.GetTemplates().RuleCheckIndicator;

        var service = new IndicatorServiceIntegrated(parent, targetingState, template, logger);

        // Inject dependencies into the service itself
        service.ResolveGbDependencies(container);

        // Validate dependencies were properly injected
        var issues = service.GetRuntimeIssues();
        if (issues.Count > 0)
        {
            logger?.LogWarnings(issues);
        }

        return service;
    }
```

Creates an IndicatorServiceIntegrated with dependency injection from container.

**Returns:** `IndicatorServiceIntegrated`

**Parameters:**
- `GBCompositionContainer container`
- `Node parent`

### ResolveGbDependencies

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Resolves dependencies from the composition container.
    /// </summary>
    /// <param name="container">The dependency container to resolve dependencies from</param>
    /// <returns>True if dependencies were successfully resolved, false otherwise</returns>
    public bool ResolveGbDependencies(GBCompositionContainer container)
    {
        var collisionMapperInjected = _collisionMapper?.ResolveGbDependencies(container) ?? false;
        return collisionMapperInjected;
    }
```

Resolves dependencies from the composition container.

**Returns:** `bool`

**Parameters:**
- `GBCompositionContainer container`

### ForceUpdate

```csharp
/// <summary>
    /// Forces all managed indicators to update their shapecast collision detection.
    /// </summary>
    public void ForceUpdate()
    {
        foreach (var indicator in _indicators)
        {
            if (GodotObject.IsInstanceValid(indicator))
            {
                indicator.ForceShapecastUpdate();
            }
        }
    }
```

Forces all managed indicators to update their shapecast collision detection.

**Returns:** `void`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Validates that all required dependencies and state are properly set.
    /// </summary>
    /// <returns>List of validation issues (empty if all dependencies are valid)</returns>
    public Array<string> GetRuntimeIssues()
    {
        var issues = new Array<string>();

        if (_indicatorsParent == null)
            issues.Add("Indicators parent node is not set");
        else if (!GodotObject.IsInstanceValid(_indicatorsParent))
            issues.Add("Indicators parent node is not valid");

        if (_indicatorTemplate == null)
            issues.Add("Indicator template is not set");
        else if (!GodotObject.IsInstanceValid(_indicatorTemplate))
            issues.Add("Indicator template is not valid");

        if (_targetingState == null)
            issues.Add("GridTargetingState is not set");

        if (_logger == null)
            issues.Add("Logger is not set");

        if (_collisionMapper != null)
        {
            var mapperIssues = _collisionMapper.GetRuntimeIssues();
            issues.AddRange(mapperIssues);
        }

        return issues;
    }
```

Validates that all required dependencies and state are properly set.

**Returns:** `Array<string>`

### Reset

```csharp
/// <summary>
    /// Performs comprehensive cleanup of all managed indicators and test setups.
    /// </summary>
    /// <param name="parentNode">Optional parent node to check for orphaned indicators</param>
    public void Reset(Node? parentNode = null)
    {
        // Clear indicators array first to prevent stale references
        FreeIndicators(_indicators);

        // Double-check: Ensure indicators array is actually empty
        if (_indicators.Count > 0)
        {
            _logger?.LogWarning("Indicators array not properly cleared after free_indicators. Forcing clear.");
            _indicators.Clear();
            EmitSignal(SignalName.IndicatorsChanged, _indicators);
        }

        // Clean up collision mapper test setups
        if (_collisionMapper != null)
        {
            if (_collisionMapper.HasMethod("clear_test_setups"))
            {
                _collisionMapper.Call("clear_test_setups");
            }
        }

        // Clear test indicator with extra validation
        if (_testingIndicator != null)
        {
            if (GodotObject.IsInstanceValid(_testingIndicator))
            {
                _testingIndicator.Free();
            }
            _testingIndicator = null;
        }

        // Additional cleanup: Check for any orphaned indicators
        if (parentNode != null)
        {
            foreach (Node child in parentNode.GetChildren())
            {
                if (child is RuleCheckIndicator indicator && indicator.Name.BeginsWith("_TestingIndicator"))
                {
                    _logger?.LogWarning($"Found orphaned testing indicator during reset: {indicator.Name}");
                    indicator.Free();
                }
            }
        }
    }
```

Performs comprehensive cleanup of all managed indicators and test setups.

**Returns:** `void`

**Parameters:**
- `Node? parentNode`

### SetupIndicators

```csharp
/// <summary>
    /// Executes indicator setup workflows using Core business logic.
    /// </summary>
    /// <param name="testObject">The test object to set up indicators for</param>
    /// <param name="rules">Array of placement rules to apply</param>
    /// <param name="parentNode">Parent node for indicators</param>
    /// <returns>Setup report with diagnostic information</returns>
    public GridBuilding.Godot.Systems.Placement.Data.IndicatorSetupReport SetupIndicators(Node2D testObject, Array<PlacementRule> rules, Node2D parentNode)
    {
        var report = new GridBuilding.Godot.Systems.Placement.Data.IndicatorSetupReport(rules, _targetingState, _indicatorTemplate);
        
        // Validate setup environment
        if (!ValidateSetupEnvironment(testObject, rules))
        {
            report.AddIssue("setup_indicators: guard prevented indicator setup; report issues=" + string.Join(", ", report.Issues));
            return report;
        }

        // DIAGNOSTIC: Log indicator setup inputs
        _logger?.LogDebug($"setup_indicators: test_object={testObject?.Name ?? "null"}, rules_count={rules.Count}, template={_indicatorTemplate?.ResourcePath ?? "null"}, parent={_indicatorsParent?.Name ?? "null"}");

        // Use Core service for calculation logic
        var gridPosition = _targetingState?.TargetMap?.LocalToMap(testObject?.GlobalPosition ?? Vector2.Zero) ?? Vector2I.Zero;
        var coreResult = _coreService.CalculateIndicators(
            ExtractFootprintFromGodotObject(testObject),
            gridPosition.ToCore(),
            ConvertRulesToCore(rules),
            _occupancyAdapter);

        // DIAGNOSTIC: Log Core service result details
        _logger?.LogDebug($"setup_indicators: core_result has_issues={coreResult.HasIssues()}, indicators_count={coreResult.IndicatorPositions.Count}, position_rules_map_size={coreResult.PositionRulesMap.Count}");
        
        if (coreResult.HasIssues)
        {
            foreach (var issue in coreResult.Issues)
            {
                _logger?.LogWarning($"setup_indicators core issue: {issue}");
                report.AddIssue($"Core Calculation: {issue}");
            }
        }

        // Handle any issues from the Core service
        if (coreResult.HasIssues)
        {
            return report;
        }

        // Convert Core result to Godot indicators
        var godotIndicators = CreateGodotIndicatorsFromCoreResult(coreResult, testObject, parentNode);
        
        // Reconcile with existing indicators
        var reconciled = ReconcileIndicators(godotIndicators);
        report.Indicators = reconciled;

        // Add indicators to service (manage lifecycle)
        SetIndicators(report.Indicators);

        // Log diagnostic information
        report.AddNote($"setup_indicators: computed {coreResult.PositionRulesMap.Count} position entries using Core service");
        report.AddNote("setup_indicators: completed with Core integration");

        // Finalize and log
        report.Finalize();
        LogSummary(report);
        return report;
    }
```

Executes indicator setup workflows using Core business logic.

**Returns:** `GridBuilding.Godot.Systems.Placement.Data.IndicatorSetupReport`

**Parameters:**
- `Node2D testObject`
- `Array<PlacementRule> rules`
- `Node2D parentNode`

### GetIndicators

```csharp
/// <summary>
    /// Gets the current list of managed indicators.
    /// </summary>
    /// <returns>Array of managed RuleCheckIndicator instances</returns>
    public Array<RuleCheckIndicator> GetIndicators()
    {
        return _indicators;
    }
```

Gets the current list of managed indicators.

**Returns:** `Array<RuleCheckIndicator>`

### CalculateIndicatorCount

```csharp
/// <summary>
    /// Calculates the number of indicators that would be created using Core service.
    /// </summary>
    /// <param name="testObject">The test object to calculate indicators for</param>
    /// <param name="tileCheckRules">The tile check rules to apply</param>
    /// <returns>The number of indicators that would be created</returns>
    public int CalculateIndicatorCount(Node2D testObject, Array<TileCheckRule> tileCheckRules)
    {
        var footprint = ExtractFootprintFromGodotObject(testObject);
        var coreRules = ConvertTileCheckRulesToCore(tileCheckRules);
        
        return _coreService.CalculateIndicatorCount(footprint, Vector2I.Zero.ToCore(), coreRules, _occupancyAdapter);
    }
```

Calculates the number of indicators that would be created using Core service.

**Returns:** `int`

**Parameters:**
- `Node2D testObject`
- `Array<TileCheckRule> tileCheckRules`

