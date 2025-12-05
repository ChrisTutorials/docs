---
title: "ValidationReport"
description: "Aggregates multiple rule results into a comprehensive report."
weight: 20
url: "/gridbuilding/v6-0/api/godot/validationreport/"
---

# ValidationReport

```csharp
GridBuilding.Godot.Tests.Validation
class ValidationReport
{
    // Members...
}
```

Aggregates multiple rule results into a comprehensive report.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Validation/PlacementReportTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsSuccessful

```csharp
public bool IsSuccessful => !HasFailingRules;
```

### HasFailingRules

```csharp
public bool HasFailingRules => _ruleResults.Values.Any(r => !r.IsSuccessful);
```

### TotalRuleCount

```csharp
public int TotalRuleCount => _ruleResults.Count;
```

### PassingRuleCount

```csharp
public int PassingRuleCount => _ruleResults.Values.Count(r => r.IsSuccessful);
```

### FailingRuleCount

```csharp
public int FailingRuleCount => _ruleResults.Values.Count(r => !r.IsSuccessful);
```


## Methods

### AddRuleResult

```csharp
public void AddRuleResult(RuleResult result)
    {
        _ruleResults[result.Rule.Name] = result;
    }
```

**Returns:** `void`

**Parameters:**
- `RuleResult result`

### GetAllIssues

```csharp
public List<string> GetAllIssues()
    {
        return _ruleResults.Values
            .SelectMany(r => r.GetIssues())
            .ToList();
    }
```

**Returns:** `List<string>`

### GetFailingRuleNames

```csharp
public List<string> GetFailingRuleNames()
    {
        return _ruleResults.Values
            .Where(r => !r.IsSuccessful)
            .Select(r => r.Rule.Name)
            .ToList();
    }
```

**Returns:** `List<string>`

### GetSummary

```csharp
public string GetSummary()
    {
        return $"{TotalRuleCount} rules evaluated: {PassingRuleCount} passed, {FailingRuleCount} failed";
    }
```

**Returns:** `string`

