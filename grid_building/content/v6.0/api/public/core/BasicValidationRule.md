---
title: "BasicValidationRule"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/basicvalidationrule/"
---

# BasicValidationRule

```csharp
GridBuilding.Core.Systems.Validation
class BasicValidationRule
{
    // Members...
}
```

Validates basic placeable properties

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/PlaceableValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Validate

```csharp
public override void Validate(PlaceableDefinition placeable, ValidationResult result)
        {
            if (string.IsNullOrWhiteSpace(placeable.Id))
            {
                result.AddError("Placeable ID is required");
            }
            else if (!IsValidId(placeable.Id))
            {
                result.AddError($"Invalid placeable ID format: {placeable.Id}");
            }

            if (string.IsNullOrWhiteSpace(placeable.DisplayName))
            {
                result.AddWarning("Placeable has no display name");
            }
        }
```

**Returns:** `void`

**Parameters:**
- `PlaceableDefinition placeable`
- `ValidationResult result`

