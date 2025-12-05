---
title: "VariantValidationRule"
description: "Validates placeable variants"
weight: 10
url: "/gridbuilding/v6-0/api/core/variantvalidationrule/"
---

# VariantValidationRule

```csharp
GridBuilding.Core.Systems.Validation
class VariantValidationRule
{
    // Members...
}
```

Validates placeable variants

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
            if (placeable.Variants == null || !placeable.Variants.Any()) return;

            foreach (var variant in placeable.Variants)
            {
                if (string.IsNullOrWhiteSpace(variant.Id))
                {
                    result.AddError("Variant has no ID");
                }

                if (string.IsNullOrWhiteSpace(variant.DisplayName))
                {
                    result.AddWarning("Variant has no display name");
                }

                if (string.IsNullOrWhiteSpace(variant.Scene))
                {
                    result.AddError($"Variant '{variant.Id}' has no scene specified");
                }
            }
        }
```

**Returns:** `void`

**Parameters:**
- `PlaceableDefinition placeable`
- `ValidationResult result`

