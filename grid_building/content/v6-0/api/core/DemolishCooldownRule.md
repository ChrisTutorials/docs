---
title: "DemolishCooldownRule"
description: "Cooldown rule for demolish operations"
weight: 10
url: "/gridbuilding/v6-0/api/core/demolishcooldownrule/"
---

# DemolishCooldownRule

```csharp
GridBuilding.Core.Services.Manipulation
class DemolishCooldownRule
{
    // Members...
}
```

Cooldown rule for demolish operations

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

                // In a real implementation, this would check the last demolish time
                // For now, assume cooldown is satisfied
                if (settings.DemolishCooldownSeconds > 0)
                {
                    // Check last demolish time from some persistent storage
                    // For now, just pass
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

