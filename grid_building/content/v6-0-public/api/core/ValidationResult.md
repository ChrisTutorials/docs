---
title: "ValidationResult"
description: "Validation result information."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/validationresult/"
---

# ValidationResult

```csharp
GridBuilding.Core.Interfaces
class ValidationResult
{
    // Members...
}
```

Validation result information.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Interfaces/IPlacementValidator.cs`  
**Namespace:** `GridBuilding.Core.Interfaces`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
public bool IsValid { get; set; }
```

### Message

```csharp
public string Message { get; set; } = string.Empty;
```

### Severity

```csharp
public ValidationSeverity Severity { get; set; }
```

### Errors

```csharp
public System.Collections.Generic.List<string> Errors { get; set; } = new();
```

### Warnings

```csharp
public System.Collections.Generic.List<string> Warnings { get; set; } = new();
```


## Methods

### AddError

```csharp
public void AddError(string error) => Errors.Add(error);
```

**Returns:** `void`

**Parameters:**
- `string error`

### AddWarning

```csharp
public void AddWarning(string warning) => Warnings.Add(warning);
```

**Returns:** `void`

**Parameters:**
- `string warning`

