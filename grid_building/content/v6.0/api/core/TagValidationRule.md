---
title: "TagValidationRule"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/tagvalidationrule/"
---

# TagValidationRule

```csharp
GridBuilding.Core.Systems.Validation
class TagValidationRule
{
    // Members...
}
```

Validates placeable tags

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
            if (placeable.Tags == null || !placeable.Tags.Any()) return;

            foreach (var tag in placeable.Tags)
            {
                if (string.IsNullOrWhiteSpace(tag))
                {
                    result.AddWarning("Empty tag found");
                }
                else if (ReservedTags.Contains(tag.ToLowerInvariant()))
                {
                    result.AddWarning($"Tag '{tag}' is reserved and should be avoided");
                }
                else if (tag.Contains(' '))
                {
                    result.AddWarning($"Tag '{tag}' contains spaces, consider using underscores");
                }
            }
        }
```

**Returns:** `void`

**Parameters:**
- `PlaceableDefinition placeable`
- `ValidationResult result`

