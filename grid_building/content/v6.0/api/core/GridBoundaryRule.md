---
title: "GridBoundaryRule"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/gridboundaryrule/"
---

# GridBoundaryRule

```csharp
GridBuilding.Core.Services.Manipulation
class GridBoundaryRule
{
    // Members...
}
```

Grid boundary validation rule

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

                if (position.X < 0 || position.Y < 0)
                {
                    result.IsValid = false;
                    result.ValidationErrors.Add("Position cannot be negative");
                }

                if (position.X > settings.MaxGridSize.X || position.Y > settings.MaxGridSize.Y)
                {
                    result.IsValid = false;
                    result.ValidationErrors.Add($"Position exceeds maximum grid size ({settings.MaxGridSize})");
                }

                return result;
            }
```

**Returns:** `PlacementValidationResult`

**Parameters:**
- `ManipulationState manipulationState`
- `Vector2I position`
- `ManipulationSettings settings`

