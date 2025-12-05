---
title: "RequirementsValidationRule"
description: "Validates placeable requirements"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/requirementsvalidationrule/"
---

# RequirementsValidationRule

```csharp
GridBuilding.Core.Systems.Validation
class RequirementsValidationRule
{
    // Members...
}
```

Validates placeable requirements

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
            if (placeable.Requirements == null) return;

            var req = placeable.Requirements;

            if (req.Cost < 0)
            {
                result.AddError("Cost cannot be negative");
            }

            if (req.RequiredLevel < 0)
            {
                result.AddError("Required level cannot be negative");
            }

            if (req.RequiredTags != null)
            {
                foreach (var tag in req.RequiredTags)
                {
                    if (string.IsNullOrWhiteSpace(tag))
                    {
                        result.AddWarning("Empty tag in required tags");
                    }
                }
            }
        }
```

**Returns:** `void`

**Parameters:**
- `PlaceableDefinition placeable`
- `ValidationResult result`

