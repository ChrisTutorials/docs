---
title: "ManipulationTransformCalculator"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/manipulationtransformcalculator/"
---

# ManipulationTransformCalculator

```csharp
GridBuilding.Godot.Tests.Manipulation
class ManipulationTransformCalculator
{
    // Members...
}
```

Calculates final transforms for manipulation operations - mirrors GDScript ManipulationTransformCalculatorEnhanced
This is the C# port for debugging and validation before backporting to GDScript.
Implements unified calculator interface for consistency.
CRITICAL: Calculator reads position from manipulation_parent, NOT from preview_root.
ManipulationParent follows the grid positioner, so its position is the final placement position.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ManipulationTransformCalculator.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CalculateFinalTransform

```csharp
#region Transform Calculation

    /// <summary>
    /// Calculates the final transform based on preview and parent nodes.
    /// Returns safe defaults if either node is null.
    /// </summary>
    /// <param name="preview">The preview node (may be null)</param>
    /// <param name="parent">The manipulation parent node (may be null)</param>
    /// <returns>The calculated transform data</returns>
    public static TransformData CalculateFinalTransform(MockNode2D? preview, MockNode2D? parent)
    {
        // Handle null cases - return safe defaults
        if (preview == null || parent == null)
        {
            // Log error in production, but return safe defaults
            return TransformData.Identity();
        }

        // CRITICAL: Position comes from manipulation parent (where the grid positioner placed it)
        // Rotation and scale also come from parent to preserve user transformations
        return new TransformData(
            parent.GlobalPosition,
            parent.Rotation,
            parent.Scale
        );
    }
```

Calculates the final transform based on preview and parent nodes.
Returns safe defaults if either node is null.

**Returns:** `TransformData`

**Parameters:**
- `MockNode2D? preview`
- `MockNode2D? parent`

### ValidateTransformPreservation

```csharp
#endregion

    #region Transform Validation

    /// <summary>
    /// Validates that a transform has valid, usable values.
    /// </summary>
    /// <param name="transform">The transform to validate</param>
    /// <returns>Validation result with any issues found</returns>
    public static ValidationResult ValidateTransformPreservation(TransformData? transform)
    {
        if (transform == null)
        {
            return ValidationResult.Failure("Transform is null");
        }

        var issues = new List<string>();

        // Validate position
        if (!transform.Position.IsValid())
        {
            issues.Add("position contains invalid values (NaN or Infinity)");
        }

        // Validate rotation
        if (float.IsNaN(transform.Rotation) || float.IsInfinity(transform.Rotation))
        {
            issues.Add("rotation contains invalid values (NaN or Infinity)");
        }

        // Validate scale - check for invalid values
        if (!transform.Scale.IsValid())
        {
            issues.Add("scale contains invalid values (NaN or Infinity)");
        }
        // Check for near-zero scale (would make object invisible)
        else if (!transform.Scale.IsValidScale(DefaultScaleMinimum))
        {
            issues.Add("scale is too small (near-zero values would make object invisible)");
        }

        return issues.Count == 0 
            ? ValidationResult.Success() 
            : ValidationResult.Failure(issues);
    }
```

Validates that a transform has valid, usable values.

**Returns:** `ValidationResult`

**Parameters:**
- `TransformData? transform`

### CompareTransforms

```csharp
#endregion

    #region Transform Comparison

    /// <summary>
    /// Compares two transforms and identifies any differences.
    /// </summary>
    /// <param name="transform1">First transform</param>
    /// <param name="transform2">Second transform</param>
    /// <param name="tolerance">Tolerance for floating point comparison</param>
    /// <returns>Comparison result with any differences found</returns>
    public static ComparisonResult CompareTransforms(
        TransformData? transform1, 
        TransformData? transform2, 
        float tolerance = DefaultTolerance)
    {
        if (transform1 == null || transform2 == null)
        {
            return ComparisonResult.Different("One or both transforms are null");
        }

        var differences = new List<string>();

        // Compare position
        if (!transform1.Position.IsEqualTo(transform2.Position, tolerance))
        {
            differences.Add("position");
        }

        // Compare rotation
        if (MathF.Abs(transform1.Rotation - transform2.Rotation) >= tolerance)
        {
            differences.Add("rotation");
        }

        // Compare scale
        if (!transform1.Scale.IsEqualTo(transform2.Scale, tolerance))
        {
            differences.Add("scale");
        }

        return differences.Count == 0 
            ? ComparisonResult.Equal() 
            : ComparisonResult.Different(differences);
    }
```

Compares two transforms and identifies any differences.

**Returns:** `ComparisonResult`

**Parameters:**
- `TransformData? transform1`
- `TransformData? transform2`
- `float tolerance`

