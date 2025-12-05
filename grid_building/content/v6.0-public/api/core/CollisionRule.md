---
title: "CollisionRule"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/collisionrule/"
---

# CollisionRule

```csharp
GridBuilding.Core.Services.Manipulation
class CollisionRule
{
    // Members...
}
```

Collision validation rule

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Manipulation/PlacementManager.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Validate

```csharp
public override PlacementValidationResult Validate(ManipulationState manipulationState, Vector2I position, ManipulationSettings settings)
            {
                var result = new PlacementValidationResult { IsValid = true };

                // In a real implementation, this would check actual collisions
                // For now, just basic validation

                return result;
            }
```

**Returns:** `PlacementValidationResult`

**Parameters:**
- `ManipulationState manipulationState`
- `Vector2I position`
- `ManipulationSettings settings`

