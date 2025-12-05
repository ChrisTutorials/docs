---
title: "RuleValidationResult"
description: "Rule validation result"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/rulevalidationresult/"
---

# RuleValidationResult

```csharp
GridBuilding.Core.Systems.Validation
class RuleValidationResult
{
    // Members...
}
```

Rule validation result

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/IValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
public bool IsValid { get; init; }
```

### RuleName

```csharp
public string RuleName { get; init; } = string.Empty;
```

### Issues

```csharp
public List<string> Issues { get; init; } = new();
```

### Suggestions

```csharp
public List<string> Suggestions { get; init; } = new();
```

### Score

```csharp
public float Score { get; init; } = 0.0f;
```

### Context

```csharp
public Dictionary<string, object> Context { get; init; } = new();
```


## Methods

### Success

```csharp
public static RuleValidationResult Success(string ruleName) => 
            new() { IsValid = true, RuleName = ruleName, Score = 100.0f };
```

**Returns:** `RuleValidationResult`

**Parameters:**
- `string ruleName`

### Failure

```csharp
public static RuleValidationResult Failure(string ruleName, params string[] issues) => 
            new() { IsValid = false, RuleName = ruleName, Issues = new List<string>(issues), Score = 0.0f };
```

**Returns:** `RuleValidationResult`

**Parameters:**
- `string ruleName`
- `string[] issues`

