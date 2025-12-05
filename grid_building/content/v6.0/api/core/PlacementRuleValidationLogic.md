---
title: "PlacementRuleValidationLogic"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/placementrulevalidationlogic/"
---

# PlacementRuleValidationLogic

```csharp
GridBuilding.Core.Validation
class PlacementRuleValidationLogic
{
    // Members...
}
```

Pure logic class for placement rule validation.
Contains no state and can be easily tested in isolation.
Focuses on core validation logic without orchestration concerns.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/placement_rule_validation_logic.gd

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/PlacementRuleValidationLogic.cs`  
**Namespace:** `GridBuilding.Core.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ValidatePlacementRules

```csharp
/// <summary>
    /// Pure function to validate a set of rules and return results.
    /// No side effects - just validates rules and collects issues.
    /// Returns validation results with rule-issue mappings.
    /// </summary>
    /// <param name="rules">Array of placement rules to validate</param>
    /// <returns>Validation results with comprehensive rule information</returns>
    public static GridBuilding.Core.Results.ValidationResult ValidatePlacementRules(IPlacementRule[] rules)
    {
        var results = new GridBuilding.Core.Results.ValidationResult();

        if (rules == null || rules.Length == 0)
        {
            results.Message = "No rules provided for validation";
            results.AddError("Rules array is empty");
            return results;
        }

        foreach (var rule in rules)
        {
            if (rule == null)
            {
                results.AddError("Null rule in rules array");
                continue;
            }

            // For now, we'll create a basic RuleResult since we don't have the full validation logic
            // In a complete implementation, this would call rule.ValidatePlacement()
            var ruleResult = new RuleResult(rule);
            
            // Add the result (without issues for now - this would be populated by actual rule validation)
            results.AddRuleResult(rule, ruleResult);
        }

        results.Message = $"Validated {rules.Length} rules";
        return results;
    }
```

Pure function to validate a set of rules and return results.
No side effects - just validates rules and collects issues.
Returns validation results with rule-issue mappings.

**Returns:** `GridBuilding.Core.Results.ValidationResult`

**Parameters:**
- `IPlacementRule[] rules`

### ValidateValidationPrerequisites

```csharp
/// <summary>
    /// Pure function to validate prerequisites for rule validation.
    /// Returns array of prerequisite issues.
    /// </summary>
    /// <param name="rules">Array of placement rules to check</param>
    /// <returns>List of prerequisite validation issues</returns>
    public static List<string> ValidateValidationPrerequisites(IPlacementRule[] rules)
    {
        var issues = new List<string>();

        if (rules == null || rules.Length == 0)
        {
            issues.Add("No active rules. Setup must be called first.");
            return issues;
        }

        // Check for null or invalid rules
        var invalidCount = 0;
        foreach (var rule in rules)
        {
            if (rule == null)
            {
                invalidCount++;
            }
        }

        if (invalidCount > 0)
        {
            issues.Add($"Found {invalidCount} invalid or null rules");
        }

        return issues;
    }
```

Pure function to validate prerequisites for rule validation.
Returns array of prerequisite issues.

**Returns:** `List<string>`

**Parameters:**
- `IPlacementRule[] rules`

### SetupRules

```csharp
/// <summary>
    /// Pure function to extract rule setup logic.
    /// Returns dictionary of issues for each rule that failed setup.
    /// </summary>
    /// <param name="rules">Array of placement rules to set up</param>
    /// <param name="context">Placement context for rule setup</param>
    /// <returns>Dictionary mapping rule IDs to their setup issues</returns>
    public static Dictionary<string, List<string>> SetupRules(
        IPlacementRule[] rules, 
        IPlacementContext context)
    {
        var ruleIssues = new Dictionary<string, List<string>>();

        if (rules == null)
            return ruleIssues;

        foreach (var rule in rules)
        {
            if (rule == null)
            {
                ruleIssues["null"] = new List<string> { "Null rule encountered" };
                continue;
            }

            var issues = new List<string>();
            
            // In a complete implementation, this would call rule.Setup(context)
            // For now, we'll just validate basic prerequisites
            if (string.IsNullOrEmpty(rule.Id))
            {
                issues.Add("Rule has no ID");
            }
            
            if (string.IsNullOrEmpty(rule.Name))
            {
                issues.Add("Rule has no name");
            }

            if (issues.Count > 0)
            {
                ruleIssues[rule.Id] = issues;
            }
        }

        return ruleIssues;
    }
```

Pure function to extract rule setup logic.
Returns dictionary of issues for each rule that failed setup.

**Returns:** `Dictionary<string, List<string>>`

**Parameters:**
- `IPlacementRule[] rules`
- `IPlacementContext context`

### CleanupInvalidRules

```csharp
/// <summary>
    /// Pure function to clean up invalid rules from an array.
    /// Returns cleaned array and count of removed rules.
    /// </summary>
    /// <param name="rules">Array of placement rules to clean</param>
    /// <returns>Tuple with cleaned rules array and count of removed rules</returns>
    public static (IPlacementRule[] cleanedRules, int removedCount) CleanupInvalidRules(IPlacementRule[] rules)
    {
        if (rules == null)
            return (Array.Empty<IPlacementRule>(), 0);

        var validRules = new List<IPlacementRule>();
        var removedCount = 0;

        foreach (var rule in rules)
        {
            if (rule != null && !string.IsNullOrEmpty(rule.Id))
            {
                validRules.Add(rule);
            }
            else
            {
                removedCount++;
            }
        }

        return (validRules.ToArray(), removedCount);
    }
```

Pure function to clean up invalid rules from an array.
Returns cleaned array and count of removed rules.

**Returns:** `(IPlacementRule[] cleanedRules, int removedCount)`

**Parameters:**
- `IPlacementRule[] rules`

### GetValidationStatistics

```csharp
/// <summary>
    /// Pure function to get validation statistics for a set of rules.
    /// Returns dictionary with validation metrics.
    /// </summary>
    /// <param name="results">Validation results to analyze</param>
    /// <returns>Dictionary containing validation statistics</returns>
    public static Dictionary<string, int> GetValidationStatistics(GridBuilding.Core.Results.ValidationResult results)
    {
        var stats = new Dictionary<string, int>
        {
            ["total_rules"] = results.RuleResultCount,
            ["successful_rules"] = results.GetSuccessfulRules().Count,
            ["failed_rules"] = results.GetFailingRules().Count,
            ["configuration_errors"] = results.GetErrors().Count,
            ["total_issues"] = results.GetIssues().Count
        };

        return stats;
    }
```

Pure function to get validation statistics for a set of rules.
Returns dictionary with validation metrics.

**Returns:** `Dictionary<string, int>`

**Parameters:**
- `GridBuilding.Core.Results.ValidationResult results`

