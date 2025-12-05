---
title: "IndicatorService"
description: "IndicatorService - Service component for managing rule-check indicators within IndicatorManager.
This class is a service component that IndicatorManager uses to handle the creation, placement,
and lifecycle management of RuleCheckIndicator instances. It encapsulates the complex logic
for indicator setup, collision mapping, and diagnostic reporting while providing a clean
interface for IndicatorManager to delegate indicator-related operations.
## Architecture Role
IndicatorService acts as a specialized component within the IndicatorManager architecture:
- IndicatorManager: Main coordinator that owns and orchestrates indicator operations
- IndicatorService: Service component that handles the detailed implementation
- IndicatorFactory: Pure logic class for indicator creation and validation
## Key Responsibilities
- Execute indicator setup workflows with collision mapping and validation
- Manage indicator lifecycle including creation, positioning, and cleanup
- Provide diagnostic capabilities and comprehensive error reporting
- Handle collision detection integration with CollisionMapper
- Generate detailed setup reports for testing and debugging
## Usage Pattern
```
var service = IndicatorService.CreateWithInjection(container, parent_node)
var report = service.SetupIndicators(test_object, rules, parent_node)
var indicators = service.GetIndicators()
service.Reset()
```
Responsibilities:
- Execute indicator setup workflows with collision mapping and validation
- Manage indicator lifecycle including creation, positioning, and cleanup
- Provide diagnostic capabilities and comprehensive error reporting
- Handle collision detection integration with CollisionMapper
- Generate detailed setup reports for testing and debugging
- Maintain indicator state and provide access to managed indicators
- Support comprehensive reset functionality with orphaned indicator detection
Key Features:
- Comprehensive reset() function with critical cleanup logging and orphaned indicator detection
- Guarded indicator setup with detailed error reporting and diagnostic metadata
- Collision mapper integration with test setup management and validation
- Grid alignment utilities for stable geometry calculations
- Diagnostic information reporting for debugging indicator state and issues
- Dependency injection support with comprehensive validation
- Signal emission for indicator state changes to support reactive programming
Ported from: godot/addons/grid_building/systems/placement/managers/indicator_service.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/indicatorservice/"
---

# IndicatorService

```csharp
GridBuilding.Godot.Systems.Placement.Managers
class IndicatorService
{
    // Members...
}
```

IndicatorService - Service component for managing rule-check indicators within IndicatorManager.
This class is a service component that IndicatorManager uses to handle the creation, placement,
and lifecycle management of RuleCheckIndicator instances. It encapsulates the complex logic
for indicator setup, collision mapping, and diagnostic reporting while providing a clean
interface for IndicatorManager to delegate indicator-related operations.
## Architecture Role
IndicatorService acts as a specialized component within the IndicatorManager architecture:
- IndicatorManager: Main coordinator that owns and orchestrates indicator operations
- IndicatorService: Service component that handles the detailed implementation
- IndicatorFactory: Pure logic class for indicator creation and validation
## Key Responsibilities
- Execute indicator setup workflows with collision mapping and validation
- Manage indicator lifecycle including creation, positioning, and cleanup
- Provide diagnostic capabilities and comprehensive error reporting
- Handle collision detection integration with CollisionMapper
- Generate detailed setup reports for testing and debugging
## Usage Pattern
```
var service = IndicatorService.CreateWithInjection(container, parent_node)
var report = service.SetupIndicators(test_object, rules, parent_node)
var indicators = service.GetIndicators()
service.Reset()
```
Responsibilities:
- Execute indicator setup workflows with collision mapping and validation
- Manage indicator lifecycle including creation, positioning, and cleanup
- Provide diagnostic capabilities and comprehensive error reporting
- Handle collision detection integration with CollisionMapper
- Generate detailed setup reports for testing and debugging
- Maintain indicator state and provide access to managed indicators
- Support comprehensive reset functionality with orphaned indicator detection
Key Features:
- Comprehensive reset() function with critical cleanup logging and orphaned indicator detection
- Guarded indicator setup with detailed error reporting and diagnostic metadata
- Collision mapper integration with test setup management and validation
- Grid alignment utilities for stable geometry calculations
- Diagnostic information reporting for debugging indicator state and issues
- Dependency injection support with comprehensive validation
- Signal emission for indicator state changes to support reactive programming
Ported from: godot/addons/grid_building/systems/placement/managers/indicator_service.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Managers/IndicatorService.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Managers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _Notification

```csharp
#endregion

    #region Godot Lifecycle

    public override void _Notification(int what)
    {
        if (what == NotificationPredelete)
        {
            // Clean up managed indicators that might be orphaned
            foreach (var indicator in _indicators)
            {
                if (GodotObject.IsInstanceValid(indicator) && indicator.GetParent() == null)
                {
                    indicator.QueueFree();
                }
            }
            _indicators.Clear();

            // Clean up testing indicator if orphaned
            if (GodotObject.IsInstanceValid(_testingIndicator) && _testingIndicator.GetParent() == null)
            {
                _testingIndicator.QueueFree();
                _testingIndicator = null;
            }
        }
    }
```

**Returns:** `void`

**Parameters:**
- `int what`

### CreateWithInjection

```csharp
#endregion

    #region Static Factory Methods

    /// <summary>
    /// Creates an IndicatorService with dependency injection from container.
    /// Container serves as single source of truth for all dependencies.
    /// This method handles the complete setup including dependency resolution,
    /// validation, and logging of any issues found during initialization.
    /// </summary>
    /// <param name="container">The dependency container providing all required services</param>
    /// <param name="parent">The parent node for indicators (required - cannot be resolved from container)</param>
    /// <returns>Fully configured indicator service with validated dependencies</returns>
    /// <note>Callers should check GetRuntimeIssues() after creation to handle any validation warnings.</note>
    public static IndicatorService CreateWithInjection(GBCompositionContainer container, Node parent)
    {
        // Get dependencies from container as single source of truth
        var targetingState = container.GetTargetingState();
        var logger = container.GetLogger();
        var template = container.GetTemplates().RuleCheckIndicator;

        var service = new IndicatorService(parent, targetingState, template, logger);

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

Creates an IndicatorService with dependency injection from container.
Container serves as single source of truth for all dependencies.
This method handles the complete setup including dependency resolution,
validation, and logging of any issues found during initialization.

**Returns:** `IndicatorService`

**Parameters:**
- `GBCompositionContainer container`
- `Node parent`

### ResolveGbDependencies

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Resolves dependencies from the composition container.
    /// This method is called during initialization and can be called again if the container
    /// becomes available later. Primarily used to inject dependencies into the collision mapper.
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
This method is called during initialization and can be called again if the container
becomes available later. Primarily used to inject dependencies into the collision mapper.

**Returns:** `bool`

**Parameters:**
- `GBCompositionContainer container`

### ForceUpdate

```csharp
/// <summary>
    /// Forces all managed indicators to update their shapecast collision detection.
    /// This is useful when the scene state has changed and indicators need to recalculate
    /// their collision status without regenerating the indicators themselves.
    /// Only processes indicators that are still valid instances.
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
This is useful when the scene state has changed and indicators need to recalculate
their collision status without regenerating the indicators themselves.
Only processes indicators that are still valid instances.

**Returns:** `void`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Validates that all required dependencies and state are properly set.
    /// Performs comprehensive validation of the indicator service's internal state
    /// including parent node validity, template availability, targeting state readiness,
    /// logger availability, and collision mapper dependency issues.
    /// </summary>
    /// <returns>List of validation issues (empty if all dependencies are valid)</returns>
    /// <note>This method is non-mutating and safe to call frequently for diagnostic purposes.</note>
    public global::Godot.Collections.Array<string> GetRuntimeIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();

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
Performs comprehensive validation of the indicator service's internal state
including parent node validity, template availability, targeting state readiness,
logger availability, and collision mapper dependency issues.

**Returns:** `global::Godot.Collections.Array<string>`

### Reset

```csharp
/// <summary>
    /// Performs comprehensive cleanup of all managed indicators and test setups.
    /// This enhanced reset function provides critical cleanup logging and orphaned indicator
    /// detection to prevent test pollution and ensure proper teardown.
    /// 
    /// Cleanup sequence:
    /// 1. Frees all managed indicators with proper validation
    /// 2. Clears collision mapper test setups
    /// 3. Cleans up testing indicator with extra validation
    /// 4. Detects and removes orphaned testing indicators from the scene tree
    /// 5. Emits indicators_changed signal to notify listeners
    /// </summary>
    /// <param name="parentNode">Optional parent node to check for orphaned indicators</param>
    public void Reset(Node? parentNode = null)
    {
        // CRITICAL: Ensure indicators array is cleared first to prevent stale references
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
            // Note: CollisionMapper would need a TestSetups property for this to work
            // For now, we'll call Clear if available
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
                // CRITICAL: Use free() instead of queue_free() for immediate cleanup
                _testingIndicator.Free();
            }
            _testingIndicator = null;
        }

        // Additional cleanup: Check for any orphaned indicators that might still exist
        if (parentNode != null)
        {
            foreach (Node child in parentNode.GetChildren())
            {
                if (child is RuleCheckIndicator indicator && indicator.Name.BeginsWith("_TestingIndicator"))
                {
                    _logger?.LogWarning($"Found orphaned testing indicator during reset: {indicator.Name}");
                    // CRITICAL: Use free() instead of queue_free() for immediate cleanup
                    indicator.Free();
                }
            }
        }
    }
```

Performs comprehensive cleanup of all managed indicators and test setups.
This enhanced reset function provides critical cleanup logging and orphaned indicator
detection to prevent test pollution and ensure proper teardown.
/// Cleanup sequence:
1. Frees all managed indicators with proper validation
2. Clears collision mapper test setups
3. Cleans up testing indicator with extra validation
4. Detects and removes orphaned testing indicators from the scene tree
5. Emits indicators_changed signal to notify listeners

**Returns:** `void`

**Parameters:**
- `Node? parentNode`

### SetupIndicators

```csharp
/// <summary>
    /// Executes indicator setup workflows with collision mapping and validation.
    /// This is the main method for setting up indicators based on a test object and tile check rules.
    /// The method performs comprehensive validation, collision mapping, and indicator generation
    /// with detailed error reporting and diagnostic metadata.
    /// 
    /// Process overview:
    /// 1. Validates environment and inputs through guard checks
    /// 2. Normalizes positioning for stable geometry calculations
    /// 3. Gathers collision shapes from the test object
    /// 4. Sets up collision mapper with test configurations
    /// 5. Maps collision positions to applicable rules
    /// 6. Generates indicators using the factory pattern
    /// 7. Builds and returns comprehensive setup report
    /// </summary>
    /// <param name="testObject">The test object to set up indicators for</param>
    /// <param name="rules">Array of placement rules to apply</param>
    /// <param name="parentNode">Parent node for indicators</param>
    /// <returns>Setup report with diagnostic information</returns>
    public IndicatorSetupReport SetupIndicators(Node2D testObject, global::Godot.Collections.Array<PlacementRule> rules, Node2D parentNode)
    {
        var report = new IndicatorSetupReport(rules, _targetingState, _indicatorTemplate);
        
        // Validate setup environment
        if (!ValidateSetupEnvironment(testObject, rules))
        {
            report.AddIssue("setup_indicators: guard prevented indicator setup; report issues=" + string.Join(", ", report.Issues));
            return report;
        }

        // DIAGNOSTIC: Log indicator setup inputs
        _logger?.LogDebug($"setup_indicators: test_object={testObject?.Name ?? "null"}, rules_count={rules.Count}, template={_indicatorTemplate?.ResourcePath ?? "null"}, parent={_indicatorsParent?.Name ?? "null"}");

        // Use static utility to execute the core setup logic
        var setupResult = IndicatorSetupUtils.ExecuteIndicatorSetup(
            testObject,
            rules,
            _collisionMapper,
            _indicatorTemplate,
            _indicatorsParent,
            _targetingState
        );

        // DIAGNOSTIC: Log setup result details
        _logger?.LogDebug($"setup_indicators: setup_result has_issues={setupResult.HasIssues()}, indicators_count={setupResult.Indicators.Count}, position_rules_map_size={setupResult.PositionRulesMap.Count}");
        
        if (setupResult.HasIssues)
        {
            foreach (var issue in setupResult.Issues)
            {
                _logger?.LogWarning($"setup_indicators issue: {issue}");
            }
        }

        // Handle any issues from the setup
        if (setupResult.HasIssues)
        {
            foreach (var issue in setupResult.Issues)
            {
                report.AddIssue($"setup_indicators: {issue}");
            }
            return report;
        }

        // Update report with results
        report.OwnerShapes = setupResult.OwnerShapes;
        var testSetups = setupResult.TestSetups;
        report.SetTestSetups(testSetups);

        // Populate report with generated indicators and position/rules mapping
        // Try to reconcile newly generated indicators with existing managed indicators
        // to avoid unnecessary instantiation. This will reuse indicators that match
        // by tile position and update their rules, freeing the freshly created
        // duplicates when appropriate.
        var reconciled = ReconcileIndicators(setupResult.Indicators);
        report.Indicators = reconciled;
        report.PositionRulesMap = setupResult.PositionRulesMap;
        report.TilePositions = setupResult.PositionRulesMap.Keys.ToArray();

        // Add indicators to service (manage lifecycle) - we've already reconciled
        SetIndicators(report.Indicators);

        // Log diagnostic information
        report.AddNote($"setup_indicators: computed position_rules_map with {setupResult.PositionRulesMap.Count} entries");
        report.AddNote("setup_indicators: completed");

        // Finalize and log
        report.Finalize();
        LogSummary(report);
        return report;
    }
```

Executes indicator setup workflows with collision mapping and validation.
This is the main method for setting up indicators based on a test object and tile check rules.
The method performs comprehensive validation, collision mapping, and indicator generation
with detailed error reporting and diagnostic metadata.
/// Process overview:
1. Validates environment and inputs through guard checks
2. Normalizes positioning for stable geometry calculations
3. Gathers collision shapes from the test object
4. Sets up collision mapper with test configurations
5. Maps collision positions to applicable rules
6. Generates indicators using the factory pattern
7. Builds and returns comprehensive setup report

**Returns:** `IndicatorSetupReport`

**Parameters:**
- `Node2D testObject`
- `global::Godot.Collections.Array<PlacementRule> rules`
- `Node2D parentNode`

### GetIndicators

```csharp
/// <summary>
    /// Gets the current list of managed indicators.
    /// </summary>
    /// <returns>Array of managed RuleCheckIndicator instances</returns>
    public global::Godot.Collections.Array<RuleCheckIndicator> GetIndicators()
    {
        return _indicators;
    }
```

Gets the current list of managed indicators.

**Returns:** `global::Godot.Collections.Array<RuleCheckIndicator>`

### CalculateIndicatorCount

```csharp
/// <summary>
    /// Calculates the number of indicators that would be created without actually creating them.
    /// This is useful for performance-critical scenarios or UI preview functionality.
    /// </summary>
    /// <param name="testObject">The test object to calculate indicators for</param>
    /// <param name="tileCheckRules">The tile check rules to apply</param>
    /// <returns>The number of indicators that would be created</returns>
    public int CalculateIndicatorCount(Node2D testObject, global::Godot.Collections.Array<TileCheckRule> tileCheckRules)
    {
        return IndicatorSetupUtils.CalculateIndicatorCount(
            testObject,
            tileCheckRules,
            _collisionMapper,
            _indicatorTemplate,
            _indicatorsParent
        );
    }
```

Calculates the number of indicators that would be created without actually creating them.
This is useful for performance-critical scenarios or UI preview functionality.

**Returns:** `int`

**Parameters:**
- `Node2D testObject`
- `global::Godot.Collections.Array<TileCheckRule> tileCheckRules`

