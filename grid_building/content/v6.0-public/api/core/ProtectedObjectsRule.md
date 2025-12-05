---
title: "ProtectedObjectsRule"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/protectedobjectsrule/"
---

# ProtectedObjectsRule

```csharp
GridBuilding.Core.Services.Manipulation
class ProtectedObjectsRule
{
    // Members...
}
```

Rule to protect certain objects from demolition

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Manipulation/DemolishManager.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Validate

```csharp
public override DemolishValidationResult Validate(ManipulationState manipulationState, string targetObjectId, Vector2I targetPosition, ManipulationSettings settings)
            {
                var result = new DemolishValidationResult { IsValid = true };

                // In a real implementation, this would check against a list of protected objects
                // For now, assume no objects are protected unless specified in settings
                if (settings.ProtectedObjectTypes != null && settings.ProtectedObjectTypes.Contains("essential"))
                {
                    result.IsValid = false;
                    result.ValidationErrors.Add("Essential objects cannot be demolished");
                }

                return result;
            }
```

**Returns:** `DemolishValidationResult`

**Parameters:**
- `ManipulationState manipulationState`
- `string targetObjectId`
- `Vector2I targetPosition`
- `ManipulationSettings settings`

