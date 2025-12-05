---
title: "GBValidation"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/gbvalidation/"
---

# GBValidation

```csharp
GridBuilding.Godot.Systems.Manipulation.Utils
class GBValidation
{
    // Members...
}
```

Utility class for validation operations.
Ported from: godot/addons/grid_building/shared/utils/validation.gd
NOTE: Uses Godot's built-in property access (Get/Set) instead of .NET reflection
for iOS/Android AOT compatibility.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Utils/Validation.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CheckNotNull

```csharp
/// <summary>
    /// Checks that specified properties on a GodotObject are not null.
    /// Uses Godot's built-in Get() method for AOT-safe property access.
    /// </summary>
    /// <param name="obj">The GodotObject to check</param>
    /// <param name="propertyNames">Array of property names to check</param>
    /// <returns>Array of validation issues (empty if all valid)</returns>
    public static GDCollections.Array<string> CheckNotNull(GodotObject? obj, string[] propertyNames)
    {
        var issues = new GDCollections.Array<string>();

        if (obj == null)
        {
            issues.Add("Object is null");
            return issues;
        }

        foreach (var propertyName in propertyNames)
        {
            if (string.IsNullOrEmpty(propertyName))
                continue;

            try
            {
                // Use Godot's built-in Get() method - AOT-safe, no .NET reflection
                var value = obj.Get(propertyName);
                
                // Check if the property exists and is not null
                if (value.VariantType == Variant.Type.Nil)
                {
                    issues.Add($"{propertyName} is null or not found");
                }
            }
            catch (System.Exception ex)
            {
                issues.Add($"Error checking {propertyName}: {ex.Message}");
            }
        }

        return issues;
    }
```

Checks that specified properties on a GodotObject are not null.
Uses Godot's built-in Get() method for AOT-safe property access.

**Returns:** `GDCollections.Array<string>`

**Parameters:**
- `GodotObject? obj`
- `string[] propertyNames`

### ValidateNotNullOrEmpty

```csharp
/// <summary>
    /// Validates that a string is not null or empty.
    /// </summary>
    /// <param name="value">The string to validate</param>
    /// <param name="fieldName">The name of the field for error messages</param>
    /// <returns>Validation result with any issues</returns>
    public static ValidationResult ValidateNotNullOrEmpty(string? value, string fieldName)
    {
        if (string.IsNullOrEmpty(value))
        {
            return new ValidationResult(false, $"{fieldName} cannot be null or empty");
        }

        return ValidationResult.Success();
    }
```

Validates that a string is not null or empty.

**Returns:** `ValidationResult`

**Parameters:**
- `string? value`
- `string fieldName`

### ValidateRange

```csharp
/// <summary>
    /// Validates that a value is within a specified range.
    /// </summary>
    /// <param name="value">The value to validate</param>
    /// <param name="min">Minimum allowed value</param>
    /// <param name="max">Maximum allowed value</param>
    /// <param name="fieldName">The name of the field for error messages</param>
    /// <returns>Validation result with any issues</returns>
    public static ValidationResult ValidateRange(float value, float min, float max, string fieldName)
    {
        if (value < min || value > max)
        {
            return new ValidationResult(false, $"{fieldName} must be between {min} and {max}");
        }

        return ValidationResult.Success();
    }
```

Validates that a value is within a specified range.

**Returns:** `ValidationResult`

**Parameters:**
- `float value`
- `float min`
- `float max`
- `string fieldName`

### ValidateMinimum

```csharp
/// <summary>
    /// Validates that a value is greater than or equal to a minimum.
    /// </summary>
    /// <param name="value">The value to validate</param>
    /// <param name="min">Minimum allowed value</param>
    /// <param name="fieldName">The name of the field for error messages</param>
    /// <returns>Validation result with any issues</returns>
    public static ValidationResult ValidateMinimum(float value, float min, string fieldName)
    {
        if (value < min)
        {
            return new ValidationResult(false, $"{fieldName} must be at least {min}");
        }

        return ValidationResult.Success();
    }
```

Validates that a value is greater than or equal to a minimum.

**Returns:** `ValidationResult`

**Parameters:**
- `float value`
- `float min`
- `string fieldName`

### ValidateNotEmpty

```csharp
/// <summary>
    /// Validates that a collection is not null and has items.
    /// </summary>
    /// <param name="collection">The collection to validate</param>
    /// <param name="fieldName">The name of the field for error messages</param>
    /// <returns>Validation result with any issues</returns>
    public static ValidationResult ValidateNotEmpty(GDCollections.Array? collection, string fieldName)
    {
        if (collection == null)
        {
            return new ValidationResult(false, $"{fieldName} cannot be null");
        }

        if (collection.Count == 0)
        {
            return new ValidationResult(false, $"{fieldName} cannot be empty");
        }

        return ValidationResult.Success();
    }
```

Validates that a collection is not null and has items.

**Returns:** `ValidationResult`

**Parameters:**
- `GDCollections.Array? collection`
- `string fieldName`

### ValidateNode

```csharp
/// <summary>
    /// Validates that a node is valid and in the scene tree.
    /// </summary>
    /// <param name="node">The node to validate</param>
    /// <param name="fieldName">The name of the field for error messages</param>
    /// <returns>Validation result with any issues</returns>
    public static ValidationResult ValidateNode(Node? node, string fieldName)
    {
        if (node == null)
        {
            return new ValidationResult(false, $"{fieldName} cannot be null");
        }

        if (!GodotObject.IsInstanceValid(node))
        {
            return new ValidationResult(false, $"{fieldName} is not a valid instance");
        }

        if (!node.IsInsideTree())
        {
            return new ValidationResult(false, $"{fieldName} must be in the scene tree");
        }

        return ValidationResult.Success();
    }
```

Validates that a node is valid and in the scene tree.

**Returns:** `ValidationResult`

**Parameters:**
- `Node? node`
- `string fieldName`

### Combine

```csharp
/// <summary>
    /// Combines multiple validation results.
    /// </summary>
    /// <param name="results">Array of validation results to combine</param>
    /// <returns>Combined validation result</returns>
    public static ValidationResult Combine(params ValidationResult[] results)
    {
        var allIssues = new System.Collections.Generic.List<string>();

        foreach (var result in results)
        {
            if (!result.IsValid && !string.IsNullOrEmpty(result.ErrorMessage))
            {
                allIssues.Add(result.ErrorMessage);
            }
        }

        if (allIssues.Count > 0)
        {
            return new ValidationResult(false, string.Join("; ", allIssues));
        }

        return ValidationResult.Success();
    }
```

Combines multiple validation results.

**Returns:** `ValidationResult`

**Parameters:**
- `ValidationResult[] results`

