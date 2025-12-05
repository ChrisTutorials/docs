---
title: "DemolishValidationResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/demolishvalidationresult/"
---

# DemolishValidationResult

```csharp
GridBuilding.Core.Services.Manipulation
class DemolishValidationResult
{
    // Members...
}
```

Demolish validation result

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Manipulation/DemolishManager.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
public bool IsValid { get; set; }
```

### ValidationErrors

```csharp
public List<string> ValidationErrors { get; set; } = new();
```


## Methods

### Failed

```csharp
public static DemolishValidationResult Failed(string error)
            {
                return new DemolishValidationResult
                {
                    IsValid = false,
                    ValidationErrors = { error }
                };
            }
```

**Returns:** `DemolishValidationResult`

**Parameters:**
- `string error`

