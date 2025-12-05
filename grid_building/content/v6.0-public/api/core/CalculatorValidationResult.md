---
title: "CalculatorValidationResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/calculatorvalidationresult/"
---

# CalculatorValidationResult

```csharp
GridBuilding.Core.Services
class CalculatorValidationResult
{
    // Members...
}
```

Calculator validation result

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/ICalculator.cs`  
**Namespace:** `GridBuilding.Core.Services`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
public bool IsValid { get; init; }
```

### Warnings

```csharp
public List<string> Warnings { get; init; } = new();
```

### Errors

```csharp
public List<string> Errors { get; init; } = new();
```


## Methods

### Success

```csharp
public static CalculatorValidationResult Success() => new() { IsValid = true };
```

**Returns:** `CalculatorValidationResult`

### Failure

```csharp
public static CalculatorValidationResult Failure(params string[] errors) => 
            new() { IsValid = false, Errors = new List<string>(errors) };
```

**Returns:** `CalculatorValidationResult`

**Parameters:**
- `string[] errors`

### WithWarnings

```csharp
public static CalculatorValidationResult WithWarnings(params string[] warnings) => 
            new() { IsValid = true, Warnings = new List<string>(warnings) };
```

**Returns:** `CalculatorValidationResult`

**Parameters:**
- `string[] warnings`

