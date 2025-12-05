---
title: "PlacementValidator"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/placementvalidator/"
---

# PlacementValidator

```csharp
GridBuilding.Core.Services.Placement
class PlacementValidator
{
    // Members...
}
```

Core placement validation service.
Contains pure business logic without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Placement/PlacementValidator.cs`  
**Namespace:** `GridBuilding.Core.Services.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ValidatePlacement

```csharp
/// <summary>
        /// Validates if a placeable can be placed in the given context.
        /// </summary>
        public bool ValidatePlacement(object placeable, object context)
        {
            // Basic implementation - check if placeable is not null
            return placeable != null;
        }
```

Validates if a placeable can be placed in the given context.

**Returns:** `bool`

**Parameters:**
- `object placeable`
- `object context`

### GetValidationErrors

```csharp
/// <summary>
        /// Gets validation errors for a placeable in the given context.
        /// </summary>
        public List<string> GetValidationErrors(object placeable, object context)
        {
            var errors = new List<string>();
            
            if (placeable == null)
                errors.Add("Placeable cannot be null");
            
            return errors;
        }
```

Gets validation errors for a placeable in the given context.

**Returns:** `List<string>`

**Parameters:**
- `object placeable`
- `object context`

### CanPlaceAt

```csharp
/// <summary>
        /// Validates if a footprint can be placed at the given grid position.
        /// </summary>
        public bool CanPlaceAt(FootprintData footprint, Vector2I position)
        {
            if (footprint == null)
                return false;

            // Basic validation - check if position is valid
            return position.X >= 0 && position.Y >= 0;
        }
```

Validates if a footprint can be placed at the given grid position.

**Returns:** `bool`

**Parameters:**
- `FootprintData footprint`
- `Vector2I position`

