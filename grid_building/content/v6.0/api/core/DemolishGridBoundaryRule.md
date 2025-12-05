---
title: "DemolishGridBoundaryRule"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/demolishgridboundaryrule/"
---

# DemolishGridBoundaryRule

```csharp
GridBuilding.Core.Services.Manipulation
class DemolishGridBoundaryRule
{
    // Members...
}
```

Grid boundary validation rule for demolish

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

                if (targetPosition.X < 0 || targetPosition.Y < 0 || 
                    targetPosition.X > settings.MaxGridSize.X || targetPosition.Y > settings.MaxGridSize.Y)
                {
                    result.IsValid = false;
                    result.ValidationErrors.Add("Target position is outside grid boundaries");
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

