---
title: "PlacementValidationResults"
description: "Results from building rule validation tests.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/validation_results.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/placementvalidationresults/"
---

# PlacementValidationResults

```csharp
GridBuilding.Godot.Tests.Core.Validation
class PlacementValidationResults
{
    // Members...
}
```

Results from building rule validation tests.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/validation_results.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Validation/ValidationResults.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Message

```csharp
/// <summary>
    /// Success or failure message.
    /// </summary>
    public string Message { get; set; } = "";
```

Success or failure message.

### IsSuccessful

```csharp
/// <summary>
    /// Checks that there were no validation issues
    /// </summary>
    public bool IsSuccessful => !HasErrors() && !HasFailingRules();
```

Checks that there were no validation issues


## Methods

### AddRuleResult

```csharp
/// <summary>
    /// Adds a rule result for a specific placement rule.
    /// </summary>
    public void AddRuleResult(IPlacementRule rule, RuleResult result)
    {
        if (result == null) throw new ArgumentNullException(nameof(result), "Rule result cannot be null");
        _ruleResults[rule] = result;
    }
```

Adds a rule result for a specific placement rule.

**Returns:** `void`

**Parameters:**
- `IPlacementRule rule`
- `RuleResult result`

### AddIssue

```csharp
/// <summary>
    /// Adds an issue without a specific rule context
    /// </summary>
    public void AddIssue(string issue)
    {
        _errors.Add(issue);
    }
```

Adds an issue without a specific rule context

**Returns:** `void`

**Parameters:**
- `string issue`

### GetIssues

```csharp
/// <summary>
    /// Gets all issues from all rule results
    /// </summary>
    public List<string> GetIssues()
    {
        var allIssues = new List<string>();
        foreach (var result in _ruleResults.Values)
        {
            allIssues.AddRange(result.GetIssues());
        }
        return allIssues;
    }
```

Gets all issues from all rule results

**Returns:** `List<string>`

### AddError

```csharp
/// <summary>
    /// Adds a configuration/setup error
    /// </summary>
    public void AddError(string error)
    {
        _errors.Add(error);
    }
```

Adds a configuration/setup error

**Returns:** `void`

**Parameters:**
- `string error`

### HasFailingRules

```csharp
/// <summary>
    /// Whether the validation had any failing placement rules
    /// </summary>
    public bool HasFailingRules()
    {
        return GetFailingRules().Any();
    }
```

Whether the validation had any failing placement rules

**Returns:** `bool`

### HasErrors

```csharp
/// <summary>
    /// Whether the validation had any development configuration or setup errors
    /// </summary>
    public bool HasErrors()
    {
        return _errors.Count > 0;
    }
```

Whether the validation had any development configuration or setup errors

**Returns:** `bool`

### GetSuccessfulRules

```csharp
/// <summary>
    /// Gets the successful rules
    /// </summary>
    public List<IPlacementRule> GetSuccessfulRules()
    {
        return _ruleResults
            .Where(kv => kv.Value.IsSuccessful)
            .Select(kv => kv.Key)
            .ToList();
    }
```

Gets the successful rules

**Returns:** `List<IPlacementRule>`

### GetFailingRules

```csharp
/// <summary>
    /// Gets the failing rules
    /// </summary>
    public List<IPlacementRule> GetFailingRules()
    {
        return _ruleResults
            .Where(kv => !kv.Value.IsSuccessful)
            .Select(kv => kv.Key)
            .ToList();
    }
```

Gets the failing rules

**Returns:** `List<IPlacementRule>`

### GetErrors

```csharp
/// <summary>
    /// Gets the configuration/setup errors
    /// </summary>
    public List<string> GetErrors()
    {
        return new List<string>(_errors);
    }
```

Gets the configuration/setup errors

**Returns:** `List<string>`

### GetFailingRuleResults

```csharp
/// <summary>
    /// Gets the failing rules and their issues
    /// </summary>
    public Dictionary<IPlacementRule, List<string>> GetFailingRuleResults()
    {
        return _ruleResults
            .Where(kv => !kv.Value.IsSuccessful)
            .ToDictionary(kv => kv.Key, kv => kv.Value.GetIssues());
    }
```

Gets the failing rules and their issues

**Returns:** `Dictionary<IPlacementRule, List<string>>`

### GetSummaryString

```csharp
/// <summary>
    /// Generates a concise summary string of the validation results.
    /// </summary>
    public string GetSummaryString()
    {
        var successCount = GetSuccessfulRules().Count;
        var failCount = GetFailingRules().Count;
        var errorCount = _errors.Count;

        if (IsSuccessful)
        {
            return $"Validation PASSED: {successCount} rules passed";
        }

        return $"Validation FAILED: {successCount} passed, {failCount} failed, {errorCount} errors";
    }
```

Generates a concise summary string of the validation results.

**Returns:** `string`

