---
title: "RuleBasedValidationResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/rulebasedvalidationresult/"
---

# RuleBasedValidationResult

```csharp
GridBuilding.Core.Systems.Validation
class RuleBasedValidationResult
{
    // Members...
}
```

Rule-based validation result

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/IValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### RuleResults

```csharp
public Dictionary<string, RuleValidationResult> RuleResults { get; init; } = new();
```

### TotalRules

```csharp
public int TotalRules { get; init; }
```

### PassedRules

```csharp
public int PassedRules { get; init; }
```

### FailedRules

```csharp
public int FailedRules { get; init; }
```

### SuccessRate

```csharp
public float SuccessRate => TotalRules > 0 ? (float)PassedRules / TotalRules : 0.0f;
```


## Methods

### Success

```csharp
public static new RuleBasedValidationResult Success() => 
            new() { IsValid = true, Score = 100.0f };
```

**Returns:** `RuleBasedValidationResult`

### Failure

```csharp
public static new RuleBasedValidationResult Failure(params string[] errors) => 
            new() { IsValid = false, Errors = new List<string>(errors), Score = 0.0f };
```

**Returns:** `RuleBasedValidationResult`

**Parameters:**
- `string[] errors`

