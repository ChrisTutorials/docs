---
title: "PlacementValidator"
description: "Runs tests for each rule using RuleCheckIndicators
to determine if placement in the targeted location is
valid if all rules validate successfully.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_validator.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/placementvalidator/"
---

# PlacementValidator

```csharp
GridBuilding.Godot.Systems.Placement.Validators
class PlacementValidator
{
    // Members...
}
```

Runs tests for each rule using RuleCheckIndicators
to determine if placement in the targeted location is
valid if all rules validate successfully.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_validator.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Validators/PlacementValidator.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Validators`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ActiveRules

```csharp
/// <summary>
    /// Full list of rules being used by the placement validator to test object placement.
    /// </summary>
    public Array<PlacementRule> ActiveRules { get; private set; } = new();
```

Full list of rules being used by the placement validator to test object placement.


## Methods

### CreateWithInjection

```csharp
#endregion

    #region Static Factory Methods

    /// <summary>
    /// Creates a PlacementValidator with dependency injection from container.
    /// Container serves as single source of truth for all dependencies.
    /// </summary>
    /// <param name="container">The dependency container</param>
    /// <returns>Fully configured placement validator with validated dependencies</returns>
    public static PlacementValidator CreateWithInjection(GBCompositionContainer container)
    {
        // Get dependencies from container as single source of truth
        var logger = container.GetLogger();
        var containerRules = container.GetPlacementRules();

        var validator = new PlacementValidator(containerRules, logger);

        // Inject dependencies
        validator.ResolveGbDependencies(container);

        // Validate dependencies were properly injected
        var issues = validator.GetRuntimeIssues();
        if (issues.Count > 0)
        {
            logger?.LogWarnings(issues);
        }

        return validator;
    }
```

Creates a PlacementValidator with dependency injection from container.
Container serves as single source of truth for all dependencies.

**Returns:** `PlacementValidator`

**Parameters:**
- `GBCompositionContainer container`

### ResolveGbDependencies

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Passes. No injection needed.
    /// </summary>
    /// <param name="container">The dependency container</param>
    /// <returns>True if dependencies were successfully resolved, false otherwise</returns>
    public bool ResolveGbDependencies(CompositionContainer container)
    {
        // This validator uses constructor injection, so no additional dependencies needed
        return true;
    }
```

Passes. No injection needed.

**Returns:** `bool`

**Parameters:**
- `CompositionContainer container`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Validates that all required dependencies are properly set.
    /// </summary>
    /// <returns>List of validation issues (empty if valid)</returns>
    public override global::Godot.Collections.Array<string> GetRuntimeIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();

        if (_logger == null)
            issues.Add("Logger is not set");

        return issues;
    }
```

Validates that all required dependencies are properly set.

**Returns:** `global::Godot.Collections.Array<string>`

### ValidatePlacement

```csharp
/// <summary>
    /// Validates placement rules against the current target state.
    /// Returns the validation results including details of each placement rule result.
    /// </summary>
    /// <returns>Comprehensive validation results with rule details and success status</returns>
    public ValidationResults ValidatePlacement()
    {
        var results = new ValidationResults();

        // Check prerequisites using pure logic
        var prerequisiteIssues = PlacementRuleValidationLogic.ValidateValidationPrerequisites(ActiveRules);
        if (prerequisiteIssues.Count > 0)
        {
            foreach (var issue in prerequisiteIssues)
            {
                results.AddError(issue);
            }

            results.Message = "Placement validator has not been successfully setup. Must run setup with true result.";
            return results;
        }

        // Clean up any null indicators before validation using pure logic
        var cleanedCount = PlacementRuleValidationLogic.CleanupNullIndicatorsFromRules(ActiveRules);
        if (cleanedCount > 0 && _logger != null)
        {
            _logger.LogWarning(
                $"Cleaned up {cleanedCount} null indicators from {ActiveRules.Count} active rules"
            );
        }

        // Perform core validation using pure logic
        var validationResults = PlacementRuleValidationLogic.ValidatePlacementRules(ActiveRules);

        // Handle orchestration (logging, result processing)
        HandleValidationOrchestration(validationResults);

        return validationResults;
    }
```

Validates placement rules against the current target state.
Returns the validation results including details of each placement rule result.

**Returns:** `ValidationResults`

### SetupRules

```csharp
/// <summary>
    /// Tries setup on all of the rules PlacementRule.
    /// Uses pure logic class for composition over inheritance.
    /// Returns a dictionary PlacementRules and the issues found for each rule that had issues.
    /// </summary>
    /// <param name="rules">The placement rules to setup</param>
    /// <param name="gts">The current grid targeting state</param>
    /// <returns>Dictionary of rules and their setup issues</returns>
    public GDCollections.Dictionary<PlacementRule, GDCollections.Array> SetupRules(
        Array<PlacementRule> rules,
        GridTargetingState gts)
    {
        return PlacementRuleValidationLogic.SetupRules(rules, gts);
    }
```

Tries setup on all of the rules PlacementRule.
Uses pure logic class for composition over inheritance.
Returns a dictionary PlacementRules and the issues found for each rule that had issues.

**Returns:** `GDCollections.Dictionary<PlacementRule, GDCollections.Array>`

**Parameters:**
- `Array<PlacementRule> rules`
- `GridTargetingState gts`

### Setup

```csharp
/// <summary>
    /// Sets the active rules set and rule_check_indicators for
    /// validating the current target's placement position.
    /// Uses pure logic class for composition over inheritance.
    /// Returns a dictionary of issues.
    /// </summary>
    /// <param name="rules">The placement rules to setup</param>
    /// <param name="gts">The current grid targeting state</param>
    /// <returns>Dictionary of issues</returns>
    public GDCollections.Dictionary<PlacementRule, GDCollections.Array> Setup(
        Array<PlacementRule> rules,
        GridTargetingState gts)
    {
        var ruleIssues = SetupRules(rules, gts);

        if (ruleIssues.Count == 0)
        {
            var tileCheckRules = RuleFilters.OnlyTileCheck(rules);
            PreCheckTileRules(tileCheckRules); // Find potential warnings
            
            // CRITICAL: Duplicate rules array as final failsafe before storing in active_rules
            // Even though callers should duplicate, we duplicate here to prevent ANY possibility
            // of mutating shared resource arrays when TearDown() calls active_rules.clear()
            ActiveRules = rules.Duplicate();
        }
        else
        {
            EmitSignal(SignalName.SetupFailed, ruleIssues);
        }

        return ruleIssues;
    }
```

Sets the active rules set and rule_check_indicators for
validating the current target's placement position.
Uses pure logic class for composition over inheritance.
Returns a dictionary of issues.

**Returns:** `GDCollections.Dictionary<PlacementRule, GDCollections.Array>`

**Parameters:**
- `Array<PlacementRule> rules`
- `GridTargetingState gts`

### GetCombinedRules

```csharp
/// <summary>
    /// Gets the rules of the placement validator combined with the rules of the placeable resource.
    /// Uses pure logic class for composition over inheritance.
    /// </summary>
    /// <param name="outsideRules">Rules from outside source</param>
    /// <param name="ignoreBase">Whether to ignore base rules</param>
    /// <returns>Combined rules array</returns>
    public Array<PlacementRule> GetCombinedRules(
        Array<PlacementRule> outsideRules,
        bool ignoreBase = false)
    {
        // Use pure logic class for rule combination
        return PlacementRuleValidationLogic.CombineRules(_baseRules, outsideRules, ignoreBase);
    }
```

Gets the rules of the placement validator combined with the rules of the placeable resource.
Uses pure logic class for composition over inheritance.

**Returns:** `Array<PlacementRule>`

**Parameters:**
- `Array<PlacementRule> outsideRules`
- `bool ignoreBase`

### TearDown

```csharp
/// <summary>
    /// Tears down the validator, clearing active rules.
    /// </summary>
    public void TearDown()
    {
        ActiveRules.Clear();
    }
```

Tears down the validator, clearing active rules.

**Returns:** `void`

