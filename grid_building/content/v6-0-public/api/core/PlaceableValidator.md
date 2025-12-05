---
title: "PlaceableValidator"
description: "Comprehensive validation system for placeable configurations"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/placeablevalidator/"
---

# PlaceableValidator

```csharp
GridBuilding.Core.Systems.Validation
class PlaceableValidator
{
    // Members...
}
```

Comprehensive validation system for placeable configurations

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/PlaceableValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ValidateCollection

```csharp
/// <summary>
        /// Validates a complete placeable collection
        /// </summary>
        public ValidationResult ValidateCollection(PlaceableCollection collection)
        {
            var result = new ValidationResult();

            if (collection == null)
            {
                result.AddError("Collection is null");
                return result;
            }

            // Validate metadata
            ValidateMetadata(collection.Metadata, result);

            // Validate categories
            ValidateCategories(collection.Categories, result);

            // Validate all placeables
            var allPlaceables = collection.GetAllPlaceables().ToList();
            ValidatePlaceables(allPlaceables, result);

            // Validate cross-references
            ValidateCrossReferences(collection, result);

            // Validate file references
            ValidateFileReferences(allPlaceables, result);

            // Validate uniqueness
            ValidateUniqueness(collection, result);

            return result;
        }
```

Validates a complete placeable collection

**Returns:** `ValidationResult`

**Parameters:**
- `PlaceableCollection collection`

### ValidatePlaceable

```csharp
/// <summary>
        /// Validates a single placeable definition
        /// </summary>
        public ValidationResult ValidatePlaceable(PlaceableDefinition placeable)
        {
            var result = new ValidationResult();

            if (placeable == null)
            {
                result.AddError("Placeable is null");
                return result;
            }

            foreach (var rule in _rules)
            {
                rule.Validate(placeable, result);
            }

            return result;
        }
```

Validates a single placeable definition

**Returns:** `ValidationResult`

**Parameters:**
- `PlaceableDefinition placeable`

