---
title: "IndicatorManager"
description: "Manages placement validation and indicator visualization for grid-based object placement.
Coordinates the creation, validation, and display of placement indicators, integrating
with rule-based validation systems to provide visual feedback on valid or invalid
placement locations. Emits signals to notify changes in indicator states.
Ported from: godot/addons/grid_building/systems/placement/managers/indicator_manager.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/indicatormanager/"
---

# IndicatorManager

```csharp
GridBuilding.Godot.Systems.Placement.Managers
class IndicatorManager
{
    // Members...
}
```

Manages placement validation and indicator visualization for grid-based object placement.
Coordinates the creation, validation, and display of placement indicators, integrating
with rule-based validation systems to provide visual feedback on valid or invalid
placement locations. Emits signals to notify changes in indicator states.
Ported from: godot/addons/grid_building/systems/placement/managers/indicator_manager.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Managers/IndicatorManager.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Managers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Initialized

```csharp
#endregion

    #region Properties

    /// <summary>
    /// Whether the manager has been initialized yet or not.
    /// </summary>
    public bool Initialized { get; private set; }
```

Whether the manager has been initialized yet or not.


## Methods

### CreateWithInjection

```csharp
#endregion

    #region Static Factory Methods

    /// <summary>
    /// Creates an IndicatorManager with dependencies injected from the provided container.
    /// </summary>
    /// <param name="container">The dependency injection container</param>
    /// <param name="parent">Optional parent node to attach the IndicatorManager to</param>
    /// <returns>A configured IndicatorManager instance</returns>
    public static IndicatorManager CreateWithInjection(CompositionContainer container, Node? parent = null)
    {
        var instance = new IndicatorManager();
        
        // Store explicit parent as potential manipulation parent fallback before dependency resolution
        instance.ResolveGbDependencies(container);
        
        if (parent != null)
        {
            // If auto_free or test harness already parented the instance elsewhere, reparent cleanly
            if (instance.GetParent() != parent)
            {
                if (instance.GetParent() != null)
                {
                    instance.GetParent().RemoveChild(instance);
                }
                parent.AddChild(instance);
            }
        }
        
        return instance;
    }
```

Creates an IndicatorManager with dependencies injected from the provided container.

**Returns:** `IndicatorManager`

**Parameters:**
- `CompositionContainer container`
- `Node? parent`

### GetRuntimeIssues

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Validates required dependencies and returns any issues found.
    /// </summary>
    /// <returns>An array of issue strings (empty if valid)</returns>
    public global::Godot.Collections.Array<string> GetRuntimeIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();

        if (_indicatorContext == null)
            issues.Add("IndicatorContext is not set");
        if (_logger == null)
            issues.Add("Logger is not set");
        if (_indicatorTemplate == null)
            issues.Add("Indicator template (rule_check_indicator) not set");
        if (_targetingState == null)
            issues.Add("GridTargetingState is not set");
        else
        {
            var targetingIssues = _targetingState.GetRuntimeIssues();
            issues.AddRange(targetingIssues);
        }

        if (_placementValidator == null)
            issues.Add("PlacementValidator not initialized");
        if (_indicatorService == null)
            issues.Add("IndicatorService not initialized");

        return issues;
    }
```

Validates required dependencies and returns any issues found.

**Returns:** `global::Godot.Collections.Array<string>`

### ResolveGbDependencies

```csharp
/// <summary>
    /// Resolves and injects dependencies from the composition container.
    /// </summary>
    /// <param name="container">The dependency injection container</param>
    public void ResolveGbDependencies(CompositionContainer container)
    {
        var context = container.GetContexts().Indicator;
        var ownerContext = container.GetContexts().Owner;
        var logger = container.GetLogger();
        var indicatorTemplate = container.GetTemplates().RuleCheckIndicator;
        var targetingState = container.GetStates().Targeting;
        var manipulationState = container.GetStates().Manipulation;
        var rules = container.GetPlacementRules();

        Initialize(
            context,
            ownerContext,
            indicatorTemplate,
            targetingState,
            manipulationState,
            logger,
            rules
        );
    }
```

Resolves and injects dependencies from the composition container.

**Returns:** `void`

**Parameters:**
- `CompositionContainer container`

### Initialize

```csharp
/// <summary>
    /// Initializes the IndicatorManager with required dependencies.
    /// </summary>
    /// <param name="indicatorContext">The placement context</param>
    /// <param name="ownerContext">The owner context</param>
    /// <param name="indicatorTemplate">The PackedScene for indicator instances</param>
    /// <param name="targetingState">The grid targeting state</param>
    /// <param name="manipulationState">The manipulation state for listening to cancellation signals</param>
    /// <param name="logger">The logging system</param>
    /// <param name="rules">The placement rules</param>
    public void Initialize(
        IndicatorContext indicatorContext,
        OwnerContext ownerContext,
        PackedScene indicatorTemplate,
        GridTargetingState targetingState,
        ManipulationState manipulationState,
        Logger logger,
        global::Godot.Collections.Array<PlacementRule> rules
    )
    {
        _indicatorContext = indicatorContext;
        _ownerContext = ownerContext;
        _logger = logger;
        _indicatorTemplate = indicatorTemplate;
        _targetingState = targetingState;
        _manipulationState = manipulationState;

        if (indicatorTemplate == null)
        {
            var errorMsg = "CRITICAL: Indicator template is not set. Cannot generate placement indicators. ";
            errorMsg += "Check GBConfig.templates configuration.";
            
            if (_logger != null)
                _logger.LogError(errorMsg);
            else
                GD.PrintErr(errorMsg);
            
            return;
        }

        System.Diagnostics.Debug.Assert(_indicatorContext != null, "IndicatorContext is null in IndicatorManager");
        _indicatorContext?.SetManager(this);

        _placementValidator = new PlacementValidator(rules, logger);
        _testSetupFactory = new PlacementScenarioFactory(targetingState, logger);
        _indicatorService = new IndicatorService(this, targetingState, indicatorTemplate, logger);

        // Listen for manipulation cancellation to auto-cleanup indicators
        // Guard against duplicate connections (e.g., in tests that create multiple managers)
        if (_manipulationState != null)
        {
            if (!_manipulationState.IsCanceledConnected(OnManipulationCanceled))
            {
                _manipulationState.Canceled += OnManipulationCanceled;
            }
        }

        Initialized = true;
    }
```

Initializes the IndicatorManager with required dependencies.

**Returns:** `void`

**Parameters:**
- `IndicatorContext indicatorContext`
- `OwnerContext ownerContext`
- `PackedScene indicatorTemplate`
- `GridTargetingState targetingState`
- `ManipulationState manipulationState`
- `Logger logger`
- `global::Godot.Collections.Array<PlacementRule> rules`

### SetupIndicators

```csharp
/// <summary>
    /// Sets up placement indicators for a test object using specified tile check rules.
    /// </summary>
    /// <param name="testObject">The object to test for placement</param>
    /// <param name="tileCheckRules">The tile check rules to apply</param>
    /// <returns>An IndicatorSetupReport with indicators and diagnostic information</returns>
    public IndicatorSetupReport SetupIndicators(Node2D testObject, global::Godot.Collections.Array<TileCheckRule> tileCheckRules)
    {
        if (tileCheckRules.Count == 0)
        {
            _indicatorService?.Reset(this);

            var failureReport = new IndicatorSetupReport(tileCheckRules, _targetingState, _indicatorTemplate);
            failureReport.AddIssue("no tile check rules provided; aborting");
            return failureReport;
        }

        // Only reset the service (free indicators) when the preview/test object changes.
        // This allows reusing RuleCheckIndicator instances frame-to-frame for the same preview
        // which reduces allocations. When the passed test object is different from the
        // last one we saw, perform a full reset to avoid visual/pooling issues.
        if (_indicatorService != null)
        {
            if (testObject != _lastSetupTestObject)
            {
                _indicatorService.Reset(this);
            }
            // otherwise keep existing indicators for reuse
            QueueRedraw();
        }

        if (_indicatorService == null)
        {
            GD.PrintErr("IndicatorService not assigned. Cannot setup indicators.");
            return null!;
        }

        var report = _indicatorService.SetupIndicators(testObject, new global::Godot.Collections.Array<PlacementRule>(), this);
        // Track last test object used for reuse decisions
        _lastSetupTestObject = testObject;
        return report;
    }
```

Sets up placement indicators for a test object using specified tile check rules.

**Returns:** `IndicatorSetupReport`

**Parameters:**
- `Node2D testObject`
- `global::Godot.Collections.Array<TileCheckRule> tileCheckRules`

### GetIndicatorCount

```csharp
/// <summary>
    /// Calculates the number of indicators that would be created for the given test object and rules.
    /// This is useful for performance-critical scenarios or UI preview functionality.
    /// </summary>
    /// <param name="testObject">The object to test for placement</param>
    /// <param name="tileCheckRules">The tile check rules to apply</param>
    /// <returns>The number of indicators that would be created, or -1 if calculation fails</returns>
    public int GetIndicatorCount(Node2D testObject, global::Godot.Collections.Array<TileCheckRule> tileCheckRules)
    {
        if (tileCheckRules.Count == 0)
            return 0;

        if (_indicatorService == null)
        {
            GD.PrintErr("IndicatorService not assigned. Cannot calculate indicator count.");
            return -1;
        }

        return _indicatorService.CalculateIndicatorCount(testObject, tileCheckRules);
    }
```

Calculates the number of indicators that would be created for the given test object and rules.
This is useful for performance-critical scenarios or UI preview functionality.

**Returns:** `int`

**Parameters:**
- `Node2D testObject`
- `global::Godot.Collections.Array<TileCheckRule> tileCheckRules`

### GetIndicators

```csharp
/// <summary>
    /// Gets the current indicators managed by this manager.
    /// </summary>
    /// <returns>Array of current indicators</returns>
    public global::Godot.Collections.Array<RuleCheckIndicator> GetIndicators()
    {
        return _indicatorService?.GetIndicators() ?? new global::Godot.Collections.Array<RuleCheckIndicator>();
    }
```

Gets the current indicators managed by this manager.

**Returns:** `global::Godot.Collections.Array<RuleCheckIndicator>`

### ForceUpdate

```csharp
/// <summary>
    /// Forces all indicators to update their collision detection.
    /// </summary>
    public void ForceUpdate()
    {
        _indicatorService?.ForceUpdate();
    }
```

Forces all indicators to update their collision detection.

**Returns:** `void`

### ClearIndicators

```csharp
/// <summary>
    /// Clears all indicators.
    /// </summary>
    public void ClearIndicators()
    {
        _indicatorService?.Reset(this);
    }
```

Clears all indicators.

**Returns:** `void`

### TearDown

```csharp
/// <summary>
    /// Tears down the indicator manager and cleans up all resources.
    /// Removes all indicators from the scene and disconnects from signals.
    /// </summary>
    public void TearDown()
    {
        // Clear all indicators first
        ClearIndicators();
        
        // Disconnect from manipulation signals
        if (_manipulationState != null)
        {
            _manipulationState.Canceled -= OnManipulationCanceled;
        }
        
        // Clear service reference
        _indicatorService = null;
    }
```

Tears down the indicator manager and cleans up all resources.
Removes all indicators from the scene and disconnects from signals.

**Returns:** `void`

### _ExitTree

```csharp
/// <summary>
    /// Called when the node is removed from the scene tree.
    /// Ensures all indicators and resources are properly cleaned up.
    /// </summary>
    public override void _ExitTree()
    {
        TearDown();
        base._ExitTree();
    }
```

Called when the node is removed from the scene tree.
Ensures all indicators and resources are properly cleaned up.

**Returns:** `void`

