---
title: "RuleResult"
description: "Result of a placement rule validation.
Encapsulates the outcome of a rule validation including whether the rule passed,
any issues encountered, and reference to the rule that was evaluated.
Ported from GDScript equivalent in the placement validation system."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/ruleresult/"
---

# RuleResult

```csharp
GridBuilding.Godot.Systems.Placement.Validators
class RuleResult
{
    // Members...
}
```

Result of a placement rule validation.
Encapsulates the outcome of a rule validation including whether the rule passed,
any issues encountered, and reference to the rule that was evaluated.
Ported from GDScript equivalent in the placement validation system.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Validators/RuleResult.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Validators`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Rule

```csharp
#region Properties

    /// <summary>
    /// The rule that was evaluated.
    /// </summary>
    public PlacementRule Rule { get; private set; }
```

The rule that was evaluated.

### IsValid

```csharp
/// <summary>
    /// Whether the rule validation passed.
    /// </summary>
    public bool IsValid { get; private set; }
```

Whether the rule validation passed.

### Issues

```csharp
/// <summary>
    /// Issues encountered during validation.
    /// </summary>
    public Array<string> Issues { get; private set; } = new();
```

Issues encountered during validation.

### Notes

```csharp
/// <summary>
    /// Additional notes from the validation.
    /// </summary>
    public Array<string> Notes { get; private set; } = new();
```

Additional notes from the validation.


## Methods

### Build

```csharp
#endregion

    #region Static Factory

    /// <summary>
    /// Builds a rule result with the given issues (automatically sets IsValid to false if issues exist).
    /// </summary>
    /// <param name="rule">The rule that was evaluated</param>
    /// <param name="issues">Issues encountered during validation</param>
    /// <returns>Rule result instance</returns>
    public static RuleResult Build(PlacementRule rule, Array<string> issues)
    {
        return new RuleResult(rule, issues.Count == 0, issues);
    }
```

Builds a rule result with the given issues (automatically sets IsValid to false if issues exist).

**Returns:** `RuleResult`

**Parameters:**
- `PlacementRule rule`
- `Array<string> issues`

### Success

```csharp
/// <summary>
    /// Creates a successful rule result.
    /// </summary>
    /// <param name="rule">The rule that was evaluated</param>
    /// <returns>Successful rule result</returns>
    public static RuleResult Success(PlacementRule rule)
    {
        return new RuleResult(rule, true);
    }
```

Creates a successful rule result.

**Returns:** `RuleResult`

**Parameters:**
- `PlacementRule rule`

### Failure

```csharp
/// <summary>
    /// Creates a failed rule result with a single issue.
    /// </summary>
    /// <param name="rule">The rule that was evaluated</param>
    /// <param name="issue">The issue that caused failure</param>
    /// <returns>Failed rule result</returns>
    public static RuleResult Failure(PlacementRule rule, string issue)
    {
        return new RuleResult(rule, false, new global::Godot.Collections.Array<string> { issue });
    }
```

Creates a failed rule result with a single issue.

**Returns:** `RuleResult`

**Parameters:**
- `PlacementRule rule`
- `string issue`

### AddIssue

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Adds an issue to the rule result.
    /// </summary>
    /// <param name="issue">Description of the issue</param>
    public void AddIssue(string issue)
    {
        Issues.Add(issue);
        IsValid = false; // Any issue makes the result invalid
    }
```

Adds an issue to the rule result.

**Returns:** `void`

**Parameters:**
- `string issue`

### AddNote

```csharp
/// <summary>
    /// Adds a note to the rule result.
    /// </summary>
    /// <param name="note">Additional information</param>
    public void AddNote(string note)
    {
        Notes.Add(note);
    }
```

Adds a note to the rule result.

**Returns:** `void`

**Parameters:**
- `string note`

### GetSummary

```csharp
/// <summary>
    /// Gets a summary of the rule result.
    /// </summary>
    /// <returns>Formatted summary string</returns>
    public string GetSummary()
    {
        var summary = $"Rule {Rule.ResourcePath}: {(IsValid ? "PASS" : "FAIL")}";
        
        if (Issues.Count > 0)
        {
            summary += $"\nIssues: {string.Join(", ", Issues)}";
        }
        
        if (Notes.Count > 0)
        {
            summary += $"\nNotes: {string.Join(", ", Notes)}";
        }

        return summary;
    }
```

Gets a summary of the rule result.

**Returns:** `string`

