---
title: "RuleResult"
description: "Results from placement rule validation.
RuleResult encapsulates the outcome of evaluating a placement rule, storing validation issues,
success state, and contextual information for debugging and logging. The class supports both
incremental construction (for building issues during validation) and complete construction
(for finished results). Success is determined by the absence of validation issues.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/rule_result.gd"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/ruleresult/"
---

# RuleResult

```csharp
GridBuilding.Core.Validation
class RuleResult
{
    // Members...
}
```

Results from placement rule validation.
RuleResult encapsulates the outcome of evaluating a placement rule, storing validation issues,
success state, and contextual information for debugging and logging. The class supports both
incremental construction (for building issues during validation) and complete construction
(for finished results). Success is determined by the absence of validation issues.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/rule_result.gd

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/RuleResult.cs`  
**Namespace:** `GridBuilding.Core.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Rule

```csharp
/// <summary>
    /// The rule that was tested.
    /// </summary>
    public IPlacementRule Rule { get; }
```

The rule that was tested.

### IssueCount

```csharp
/// <summary>
    /// Returns the count of issues.
    /// </summary>
    public int IssueCount => _issues.Count;
```

Returns the count of issues.


## Methods

### Build

```csharp
/// <summary>
    /// Factory for creating a finished rule result.
    /// Creates an immutable result with all validation data complete.
    /// </summary>
    /// <param name="rule">The rule that was tested</param>
    /// <param name="issues">Issues found during validation</param>
    public static RuleResult Build(IPlacementRule rule, IEnumerable<string> issues)
    {
        if (rule == null) throw new ArgumentNullException(nameof(rule), "Rule cannot be null");
        
        var result = new RuleResult(rule);
        if (issues != null)
        {
            result._issues.AddRange(issues);
        }
        return result;
    }
```

Factory for creating a finished rule result.
Creates an immutable result with all validation data complete.

**Returns:** `RuleResult`

**Parameters:**
- `IPlacementRule rule`
- `IEnumerable<string> issues`

### AddIssue

```csharp
/// <summary>
    /// Adds a single validation issue to the result.
    /// </summary>
    /// <param name="issue">A descriptive validation issue. Should not be empty.</param>
    public void AddIssue(string issue)
    {
        _issues.Add(issue);
    }
```

Adds a single validation issue to the result.

**Returns:** `void`

**Parameters:**
- `string issue`

### AddIssues

```csharp
/// <summary>
    /// Adds multiple validation issues to the result.
    /// </summary>
    /// <param name="issues">Array of descriptive validation issues.</param>
    public void AddIssues(IEnumerable<string> issues)
    {
        if (issues != null)
        {
            _issues.AddRange(issues);
        }
    }
```

Adds multiple validation issues to the result.

**Returns:** `void`

**Parameters:**
- `IEnumerable<string> issues`

### IsSuccessful

```csharp
/// <summary>
    /// Returns whether the rule validation was successful.
    /// A rule is considered successful if no validation issues were found.
    /// </summary>
    public bool IsSuccessful() => _issues.Count == 0;
```

Returns whether the rule validation was successful.
A rule is considered successful if no validation issues were found.

**Returns:** `bool`

### IsEmpty

```csharp
/// <summary>
    /// Backward compatibility shim expected by legacy validation code which called is_empty on RuleResult.
    /// </summary>
    public bool IsEmpty() => _issues.Count == 0;
```

Backward compatibility shim expected by legacy validation code which called is_empty on RuleResult.

**Returns:** `bool`

### GetIssues

```csharp
/// <summary>
    /// Returns a copy of all issues.
    /// </summary>
    public List<string> GetIssues() => new(_issues);
```

Returns a copy of all issues.

**Returns:** `List<string>`

