---
title: "IndicatorValidationResults"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/indicatorvalidationresults/"
---

# IndicatorValidationResults

```csharp
GridBuilding.Core.Contexts
class IndicatorValidationResults
{
    // Members...
}
```

Validation results from placement validation (specific to indicators)

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Building/IndicatorContext.cs`  
**Namespace:** `GridBuilding.Core.Contexts`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
public bool IsValid { get; }
```

### Issues

```csharp
public List<string> Issues { get; }
```


## Methods

### Success

```csharp
public static IndicatorValidationResults Success() => new(true);
```

**Returns:** `IndicatorValidationResults`

### Failure

```csharp
public static IndicatorValidationResults Failure(string issue) => new(false, new List<string> { issue });
```

**Returns:** `IndicatorValidationResults`

**Parameters:**
- `string issue`

### Failure

```csharp
public static IndicatorValidationResults Failure(List<string> issues) => new(false, issues);
```

**Returns:** `IndicatorValidationResults`

**Parameters:**
- `List<string> issues`

