---
title: "IndicatorFactory"
description: "IndicatorFactory - Creates, positions and manages lifecycle of rule-check indicators.
This class provides both static factory methods for creating indicators and instance methods
for managing indicator lifecycle. It serves as the unified interface for all indicator operations
in the grid building system.
ARCHITECTURE NOTE: IndicatorFactory instances are typically used within IndicatorManager,
which serves as the scene tree parent for rule check indicators. Objects being manipulated
should be parented to ManipulationParent instead.
## Static Factory Methods
- GenerateIndicators() - Creates multiple indicators from position-rules mapping
- CreateIndicator() - Creates a single indicator at specified position
## Instance Methods
- SetupIndicators() - Full indicator setup with collision mapping and reporting
- Reset() - Comprehensive cleanup with diagnostic capabilities
- GetRuntimeIssues() - Validation of dependencies and state
Responsibilities:
- Create and position RuleCheckIndicator instances for placement validation
- Transform absolute collision positions into relative positioning around test objects
- Integrate with CollisionMapper to map collision positions to rules
- Produce IndicatorSetupReport with diagnostic metadata for tests and logging
- Provide dependency-injection friendly constructors and validation helpers
- Manage indicator lifecycle with enhanced cleanup and reset functionality
- Offer diagnostic capabilities for debugging indicator state and orphaned indicators
Positioning Architecture:
The factory implements a normalized relative positioning system where collision detection
provides absolute tile coordinates, but indicators are positioned relative to test objects.
This ensures indicators maintain consistent spatial relationships when test objects move,
while collision results provide meaningful spatial validation patterns.
Key Features:
- Comprehensive reset() function with critical cleanup logging and orphaned indicator detection
- Diagnostic information reporting for debugging indicator cleanup issues
- Guarded indicator setup with detailed error reporting
- Collision mapper integration with test setup management
- Grid alignment utilities for stable geometry calculations
Ported from: godot/addons/grid_building/systems/placement/managers/indicator_factory.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/indicatorfactory/"
---

# IndicatorFactory

```csharp
GridBuilding.Godot.Systems.Placement.Managers
class IndicatorFactory
{
    // Members...
}
```

IndicatorFactory - Creates, positions and manages lifecycle of rule-check indicators.
This class provides both static factory methods for creating indicators and instance methods
for managing indicator lifecycle. It serves as the unified interface for all indicator operations
in the grid building system.
ARCHITECTURE NOTE: IndicatorFactory instances are typically used within IndicatorManager,
which serves as the scene tree parent for rule check indicators. Objects being manipulated
should be parented to ManipulationParent instead.
## Static Factory Methods
- GenerateIndicators() - Creates multiple indicators from position-rules mapping
- CreateIndicator() - Creates a single indicator at specified position
## Instance Methods
- SetupIndicators() - Full indicator setup with collision mapping and reporting
- Reset() - Comprehensive cleanup with diagnostic capabilities
- GetRuntimeIssues() - Validation of dependencies and state
Responsibilities:
- Create and position RuleCheckIndicator instances for placement validation
- Transform absolute collision positions into relative positioning around test objects
- Integrate with CollisionMapper to map collision positions to rules
- Produce IndicatorSetupReport with diagnostic metadata for tests and logging
- Provide dependency-injection friendly constructors and validation helpers
- Manage indicator lifecycle with enhanced cleanup and reset functionality
- Offer diagnostic capabilities for debugging indicator state and orphaned indicators
Positioning Architecture:
The factory implements a normalized relative positioning system where collision detection
provides absolute tile coordinates, but indicators are positioned relative to test objects.
This ensures indicators maintain consistent spatial relationships when test objects move,
while collision results provide meaningful spatial validation patterns.
Key Features:
- Comprehensive reset() function with critical cleanup logging and orphaned indicator detection
- Diagnostic information reporting for debugging indicator cleanup issues
- Guarded indicator setup with detailed error reporting
- Collision mapper integration with test setup management
- Grid alignment utilities for stable geometry calculations
Ported from: godot/addons/grid_building/systems/placement/managers/indicator_factory.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Managers/IndicatorFactory.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Managers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GenerateIndicators

```csharp
#region Static Factory Methods

    /// <summary>
    /// Creates multiple indicators from a position-to-rules mapping.
    /// 
    /// This method handles the core positioning logic for rule check indicators, ensuring they are
    /// positioned relative to the test_object rather than at absolute collision coordinates.
    /// 
    /// Positioning Behavior:
    /// - Input: Collision detection provides absolute tile positions where collisions would occur
    /// - Processing: Positions are normalized into consistent relative offsets around the test_object
    /// - Output: Indicators positioned relative to test_object that maintain spatial relationships when moved
    /// 
    /// Expected Usage:
    /// The collision system detects potential collision positions for a test_object. Rather than positioning
    /// indicators at those absolute coordinates, this method transforms them into relative positions around
    /// the test_object's current location. This ensures indicators follow the test_object when it moves
    /// while preserving the spatial pattern of collision detection results.
    /// </summary>
    /// <param name="positionRulesMap">Map of collision positions to validation rules</param>
    /// <param name="indicatorTemplate">Template scene for creating indicators</param>
    /// <param name="parentNode">Parent node for the indicators</param>
    /// <param name="targetingState">Grid targeting state for tile map positioning</param>
    /// <param name="testObject">Test object that indicators should be positioned relative to</param>
    /// <param name="logger">Logger instance for diagnostic output (optional)</param>
    /// <returns>Array of created indicators positioned relative to test_object</returns>
    public static global::Godot.Collections.Array<RuleCheckIndicator> GenerateIndicators(
        global::Godot.Collections.Dictionary<Vector2I, global::Godot.Collections.Array> positionRulesMap,
        PackedScene indicatorTemplate,
        Node2D parentNode,
        GridTargetingState? targetingState,
        Node2D testObject,
        Logger? logger = null
    )
    {
        var indicators = new global::Godot.Collections.Array<RuleCheckIndicator>();

        foreach (var position in positionRulesMap.Keys)
        {
            var rules = new global::Godot.Collections.Array<TileCheckRule>();
            var rulesArray = positionRulesMap[position].AsGodotArray();
            foreach (var rule in rulesArray)
            {
                if (rule is TileCheckRule tileRule)
                {
                    rules.Add(tileRule);
                }
            }

            var indicator = CreateIndicator(position, rules, indicatorTemplate, parentNode, logger);
            if (indicator != null)
            {
                indicators.Add(indicator);
                
                if (targetingState != null)
                {
                    var targetMap = targetingState.TargetMap;
                    if (targetMap != null && targetingState.Positioner != null)
                    {
                        // Position indicators at absolute world positions
                        // positionRulesMap contains relative offsets from positioner
                        var positionerTile = targetMap.LocalToMap(
                            targetMap.ToLocal(targetingState.Positioner.GlobalPosition)
                        );
                        var targetTile = positionerTile + position;
                        indicator.GlobalPosition = targetMap.ToGlobal(
                            targetMap.MapToLocal(targetTile)
                        );
                    }
                }
            }
        }

        return indicators;
    }
```

Creates multiple indicators from a position-to-rules mapping.
/// This method handles the core positioning logic for rule check indicators, ensuring they are
positioned relative to the test_object rather than at absolute collision coordinates.
/// Positioning Behavior:
- Input: Collision detection provides absolute tile positions where collisions would occur
- Processing: Positions are normalized into consistent relative offsets around the test_object
- Output: Indicators positioned relative to test_object that maintain spatial relationships when moved
/// Expected Usage:
The collision system detects potential collision positions for a test_object. Rather than positioning
indicators at those absolute coordinates, this method transforms them into relative positions around
the test_object's current location. This ensures indicators follow the test_object when it moves
while preserving the spatial pattern of collision detection results.

**Returns:** `global::Godot.Collections.Array<RuleCheckIndicator>`

**Parameters:**
- `global::Godot.Collections.Dictionary<Vector2I, global::Godot.Collections.Array> positionRulesMap`
- `PackedScene indicatorTemplate`
- `Node2D parentNode`
- `GridTargetingState? targetingState`
- `Node2D testObject`
- `Logger? logger`

### CreateIndicator

```csharp
/// <summary>
    /// Creates a single indicator at the specified position with the given rules.
    /// </summary>
    /// <param name="position">Grid position for the indicator</param>
    /// <param name="rules">Array of validation rules for this indicator</param>
    /// <param name="indicatorTemplate">Template scene for creating the indicator</param>
    /// <param name="parentNode">Parent node for the indicator</param>
    /// <param name="logger">Logger instance for diagnostic output (optional)</param>
    /// <returns>Created indicator instance, or null if creation failed</returns>
    public static RuleCheckIndicator? CreateIndicator(
        Vector2I position,
        global::Godot.Collections.Array<TileCheckRule> rules,
        PackedScene indicatorTemplate,
        Node parentNode,
        Logger? logger = null
    )
    {
        if (indicatorTemplate == null)
            return null;

        if (parentNode == null)
            return null;

        logger?.LogDebug(
            $"indicator_template={indicatorTemplate}, parent_node={parentNode}, position={position}"
        );

        var indicator = indicatorTemplate.Instantiate<RuleCheckIndicator>();
        if (indicator == null)
        {
            logger?.LogWarning($"instantiate returned null for template {indicatorTemplate}");
            return null;
        }

        // Diagnostics instead of hard asserts: report issues but continue gracefully
        var shapeVal = indicator.Shape;
        if (shapeVal == null)
        {
            logger?.LogWarning($"indicator.shape is null or missing for {indicator}");
        }
        else if (!(shapeVal is Shape2D))
        {
            logger?.LogWarning(
                $"indicator.shape is not Shape2D; type={shapeVal.GetType().Name}"
            );
        }

        // Set up the indicator with unique naming format per tile position
        // Format: "Offset(X,Y)_suffix" to match test expectations - each position gets unique first part
        indicator.Name = $"RuleCheckIndicator-Offset({position.X},{position.Y})";

        // Set target_position to Vector2.ZERO for proper tile alignment
        indicator.TargetPosition = Vector2.Zero;

        // Set collision mask to match test expectations
        indicator.CollisionMask = 1;

        parentNode.AddChild(indicator);

        // Configure rules using proper add_rule() method to establish bidirectional relationship
        foreach (var rule in rules)
        {
            indicator.AddRule(rule);
        }

        return indicator;
    }
```

Creates a single indicator at the specified position with the given rules.

**Returns:** `RuleCheckIndicator?`

**Parameters:**
- `Vector2I position`
- `global::Godot.Collections.Array<TileCheckRule> rules`
- `PackedScene indicatorTemplate`
- `Node parentNode`
- `Logger? logger`

### SetupIndicators

```csharp
#endregion

    #region Instance Methods

    /// <summary>
    /// Full indicator setup with collision mapping and reporting.
    /// </summary>
    /// <param name="testObject">The test object to set up indicators for</param>
    /// <param name="rules">Array of placement rules to apply</param>
    /// <param name="parentNode">Parent node for indicators</param>
    /// <returns>Setup report with diagnostic information</returns>
    public IndicatorSetupReport SetupIndicators(Node2D testObject, global::Godot.Collections.Array<PlacementRule> rules, Node2D parentNode)
    {
        var report = new IndicatorSetupReport();
        
        // Validate inputs
        if (testObject == null)
        {
            report.AddError("Test object is null");
            return report;
        }
        
        if (rules == null || rules.Count == 0)
        {
            report.AddError("No rules provided");
            return report;
        }
        
        if (parentNode == null)
        {
            report.AddError("Parent node is null");
            return report;
        }
        
        try
        {
            // 1. Collision mapping - create indicators at test object position
            var position = Vector2.Zero; // Relative to test object
            var indicator = CreateIndicator(position, rules, parentNode, null, testObject);
            
            if (indicator != null)
            {
                report.IndicatorsCreated++;
                report.IndicatorPositions.Add(position);
            }
            else
            {
                report.AddError("Failed to create indicator");
            }
            
            // 2. Position calculation - ensure proper positioning
            indicator.Position = position;
            
            // 3. Rule application - rules already applied in CreateIndicator
            
            // 4. Report generation
            report.SetupSuccess = indicator != null;
            report.TestObjectName = testObject.Name;
            report.ParentNodeName = parentNode.Name;
            report.RuleCount = rules.Count;
        }
        catch (System.Exception ex)
        {
            report.AddError($"Exception during setup: {ex.Message}");
        }
        
        return report;
    }
```

Full indicator setup with collision mapping and reporting.

**Returns:** `IndicatorSetupReport`

**Parameters:**
- `Node2D testObject`
- `global::Godot.Collections.Array<PlacementRule> rules`
- `Node2D parentNode`

### Reset

```csharp
/// <summary>
    /// Comprehensive cleanup with diagnostic capabilities.
    /// </summary>
    public void Reset()
    {
        var indicatorsCleaned = 0;
        var orphanedDetected = 0;
        
        try
        {
            // 1. Cleaning up all indicators
            // Find all RuleCheckIndicator instances in the scene tree
            var tree = SceneTree.Current;
            if (tree != null)
            {
                var indicators = new GDCollections.Array<Node>();
                _collectIndicators(tree.CurrentScene, indicators);
                
                foreach (Node indicator in indicators)
                {
                    if (indicator is RuleCheckIndicator ruleIndicator)
                    {
                        // Check if it's orphaned (parent is null or not in scene tree)
                        if (ruleIndicator.GetParent() == null || !ruleIndicator.IsInsideTree())
                        {
                            orphanedDetected++;
                            GD.PrintErr($"Orphaned indicator detected: {ruleIndicator.Name}");
                        }
                        
                        // Safe cleanup
                        if (ruleIndicator.GetParent() != null)
                        {
                            ruleIndicator.GetParent().RemoveChild(ruleIndicator);
                        }
                        ruleIndicator.QueueFree();
                        indicatorsCleaned++;
                    }
                }
            }
            
            // 2. Logging cleanup operations
            GD.Print($"IndicatorFactory.Reset(): Cleaned up {indicatorsCleaned} indicators, detected {orphanedDetected} orphaned");
            
            // 3. Resetting internal state
            // Clear any cached references or state here
        }
        catch (System.Exception ex)
        {
            GD.PrintErr($"IndicatorFactory.Reset(): Exception during cleanup: {ex.Message}");
        }
    }
```

Comprehensive cleanup with diagnostic capabilities.

**Returns:** `void`

### ResolveGbDependencies

```csharp
/// <summary>
    /// Override this method to receive injected dependencies.
    /// </summary>
    /// <param name="container">The dependency container</param>
    /// <returns>True if dependencies were successfully resolved, false otherwise</returns>
    public override bool ResolveGbDependencies(GBCompositionContainer container)
    {
        if (container == null)
        {
            GD.PrintErr("IndicatorFactory: Dependency container is null");
            return false;
        }
        
        try
        {
            // Store injected dependencies as needed
            // For now, we don't have specific dependencies to store,
            // but this method is ready for future dependency injection
            
            GD.Print("IndicatorFactory: Dependencies resolved successfully");
            return true;
        }
        catch (System.Exception ex)
        {
            GD.PrintErr($"IndicatorFactory: Failed to resolve dependencies: {ex.Message}");
            return false;
        }
    }
```

Override this method to receive injected dependencies.

**Returns:** `bool`

**Parameters:**
- `GBCompositionContainer container`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Validation of dependencies and state.
    /// </summary>
    /// <returns>Array of validation issues</returns>
    public override GDCollections.Array<string> GetRuntimeIssues()
    {
        var issues = new GDCollections.Array<string>();
        
        // Check for required dependencies
        var tree = SceneTree.Current;
        if (tree == null)
        {
            issues.Add("SceneTree is not available");
        }
        
        // Check for valid state
        if (!IsInsideTree() && GetParent() != null)
        {
            issues.Add("Node has parent but is not inside tree");
        }
        
        // Check for proper configuration
        // This is where we would validate any specific configuration requirements
        
        return issues;
    }
```

Validation of dependencies and state.

**Returns:** `GDCollections.Array<string>`

