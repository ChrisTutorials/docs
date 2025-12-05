---
title: "PlacementRuleValidationRule"
description: "Validates placement rules"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/placementrulevalidationrule/"
---

# PlacementRuleValidationRule

```csharp
GridBuilding.Core.Systems.Validation
class PlacementRuleValidationRule
{
    // Members...
}
```

Validates placement rules

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
            if (placeable.PlacementRules == null || !placeable.PlacementRules.Any()) return;

            foreach (var rule in placeable.PlacementRules)
            {
                if (string.IsNullOrWhiteSpace(rule.Type))
                {
                    result.AddError("Placement rule has no type");
                }

                if (rule.Parameters == null || !rule.Parameters.Any())
                {
                    result.AddWarning($"Placement rule '{rule.Type}' has no parameters");
                }
            }
        }
```

**Returns:** `void`

**Parameters:**
- `PlaceableDefinition placeable`
- `ValidationResult result`

