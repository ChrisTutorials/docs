---
title: "ValidationResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/validationresult/"
---

# ValidationResult

```csharp
GridBuilding.Core.Systems.Validation
class ValidationResult
{
    // Members...
}
```

Base validation result

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

### Errors

```csharp
public List<string> Errors { get; init; } = new();
```

### Warnings

```csharp
public List<string> Warnings { get; init; } = new();
```

### Score

```csharp
public float Score { get; init; } = 0.0f;
```

### Metadata

```csharp
public Dictionary<string, object> Metadata { get; init; } = new();
```


## Methods

### Success

```csharp
public static ValidationResult Success() => new() { IsValid = true, Score = 100.0f };
```

**Returns:** `ValidationResult`

### Failure

```csharp
public static ValidationResult Failure(params string[] errors) => 
            new() { IsValid = false, Errors = new List<string>(errors), Score = 0.0f };
```

**Returns:** `ValidationResult`

**Parameters:**
- `string[] errors`

### WithWarnings

```csharp
public static ValidationResult WithWarnings(params string[] warnings) => 
            new() { IsValid = true, Warnings = new List<string>(warnings), Score = 90.0f };
```

**Returns:** `ValidationResult`

**Parameters:**
- `string[] warnings`

### Partial

```csharp
public static ValidationResult Partial(float score, params string[] errors) => 
            new() { IsValid = false, Errors = new List<string>(errors), Score = Max(0, score) };
```

**Returns:** `ValidationResult`

**Parameters:**
- `float score`
- `string[] errors`

