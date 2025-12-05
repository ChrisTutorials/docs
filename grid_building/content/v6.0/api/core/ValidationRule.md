---
title: "ValidationRule"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/validationrule/"
---

# ValidationRule

```csharp
GridBuilding.Core.Systems.Validation
class ValidationRule
{
    // Members...
}
```

Base class for validation rules

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/PlaceableValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Validate

```csharp
public abstract void Validate(PlaceableDefinition placeable, ValidationResult result);
```

**Returns:** `void`

**Parameters:**
- `PlaceableDefinition placeable`
- `ValidationResult result`

