---
title: "ValidatorValidationResult"
description: "Validator validation result (for validator self-validation)"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/validatorvalidationresult/"
---

# ValidatorValidationResult

```csharp
GridBuilding.Core.Systems.Validation
class ValidatorValidationResult
{
    // Members...
}
```

Validator validation result (for validator self-validation)

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/IValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ConfigurationErrors

```csharp
public List<string> ConfigurationErrors { get; init; } = new();
```

### RuleErrors

```csharp
public List<string> RuleErrors { get; init; } = new();
```


## Methods

### Success

```csharp
public static new ValidatorValidationResult Success() => new() { IsValid = true, Score = 100.0f };
```

**Returns:** `ValidatorValidationResult`

### Failure

```csharp
public static new ValidatorValidationResult Failure(params string[] errors) => 
            new() { IsValid = false, Errors = new List<string>(errors), Score = 0.0f };
```

**Returns:** `ValidatorValidationResult`

**Parameters:**
- `string[] errors`

