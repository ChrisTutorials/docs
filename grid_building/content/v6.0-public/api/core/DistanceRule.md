---
title: "DistanceRule"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/distancerule/"
---

# DistanceRule

```csharp
GridBuilding.Core.Services.Manipulation
class DistanceRule
{
    // Members...
}
```

Distance validation rule (for move operations)

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

                if (manipulationState.CurrentMode == ManipulationMode.Move)
                {
                    var originalPosition = manipulationState.GetContextData<Vector2I>("originalPosition");
                    var distance = (position - originalPosition).LengthSquared();

                    if (distance == 0)
                    {
                        result.IsValid = false;
                        result.ValidationErrors.Add("Move distance cannot be zero");
                    }
                    else if (settings.MaxMoveDistance > 0 && distance > settings.MaxMoveDistance * settings.MaxMoveDistance)
                    {
                        result.IsValid = false;
                        result.ValidationErrors.Add($"Move distance exceeds maximum ({settings.MaxMoveDistance})");
                    }
                }

                return result;
            }
```

**Returns:** `PlacementValidationResult`

**Parameters:**
- `ManipulationState manipulationState`
- `Vector2I position`
- `ManipulationSettings settings`

