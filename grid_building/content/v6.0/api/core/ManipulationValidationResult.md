---
title: "ManipulationValidationResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/manipulationvalidationresult/"
---

# ManipulationValidationResult

```csharp
GridBuilding.Core.Systems.Manipulation
class ManipulationValidationResult
{
    // Members...
}
```

Result of manipulation validation.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Placement/Manipulation/ManipulationTypes.cs`  
**Namespace:** `GridBuilding.Core.Systems.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
public bool IsValid { get; private set; }
```

### ErrorMessage

```csharp
public string ErrorMessage { get; private set; }
```


## Methods

### Valid

```csharp
public static ManipulationValidationResult Valid()
    {
        return new ManipulationValidationResult(true);
    }
```

**Returns:** `ManipulationValidationResult`

### Invalid

```csharp
public static ManipulationValidationResult Invalid(string errorMessage)
    {
        return new ManipulationValidationResult(false, errorMessage);
    }
```

**Returns:** `ManipulationValidationResult`

**Parameters:**
- `string errorMessage`

