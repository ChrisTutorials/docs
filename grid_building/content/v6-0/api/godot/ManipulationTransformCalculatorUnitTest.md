---
title: "ManipulationTransformCalculatorUnitTest"
description: "Unit tests for ManipulationTransformCalculator.
PORTED FROM: addons/grid_building/test/grid_building/helpers/utils/manipulation_transform_calculator_test.gd
GDSCRIPT TEST COUNT: 25 tests
BEHAVIORAL CONTRACTS (preserved from GDScript):
1. Position comes from parent.GlobalPosition, NOT preview
2. Rotation comes from parent.Rotation
3. Scale preserves negative values (flip semantics)
4. Null inputs return safe defaults (Zero position, 0 rotation, One scale)
5. Never throws - always returns valid TransformData
Tests pure transform calculation functions without system dependencies.
Validates:
- Transform calculation from preview and parent nodes
- Transform validation and preservation
- Transform comparison logic
- Null and edge case handling"
weight: 20
url: "/gridbuilding/v6-0/api/godot/manipulationtransformcalculatorunittest/"
---

# ManipulationTransformCalculatorUnitTest

```csharp
GridBuilding.Godot.Tests.Manipulation
class ManipulationTransformCalculatorUnitTest
{
    // Members...
}
```

Unit tests for ManipulationTransformCalculator.
PORTED FROM: addons/grid_building/test/grid_building/helpers/utils/manipulation_transform_calculator_test.gd
GDSCRIPT TEST COUNT: 25 tests
BEHAVIORAL CONTRACTS (preserved from GDScript):
1. Position comes from parent.GlobalPosition, NOT preview
2. Rotation comes from parent.Rotation
3. Scale preserves negative values (flip semantics)
4. Null inputs return safe defaults (Zero position, 0 rotation, One scale)
5. Never throws - always returns valid TransformData
Tests pure transform calculation functions without system dependencies.
Validates:
- Transform calculation from preview and parent nodes
- Transform validation and preservation
- Transform comparison logic
- Null and edge case handling

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ManipulationTransformCalculatorUnitTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CalculateFinalTransform_WithValidNodes_ReturnsCorrectValues

```csharp
#region Calculate Transform Tests

    [Fact]
    public void CalculateFinalTransform_WithValidNodes_ReturnsCorrectValues()
    {
        // Arrange
        var preview = new MockNode2D();
        var parent = new MockNode2D
        {
            GlobalPosition = new Vector2TypeSafe(100.0f, 200.0f),
            Rotation = MathF.PI / 4, // 45 degrees
            Scale = new Vector2TypeSafe(2.0f, 3.0f)
        };

        // Act
        var result = ManipulationTransformCalculator.CalculateFinalTransform(preview, parent);

        // Assert
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CalculateFinalTransform_PreservesNegativeScale

```csharp
[Fact]
    public void CalculateFinalTransform_PreservesNegativeScale()
    {
        // Arrange - Negative scale represents flip semantics
        var preview = new MockNode2D();
        var parent = new MockNode2D
        {
            Scale = new Vector2TypeSafe(-1.0f, -2.0f) // Flipped horizontally and vertically
        };

        // Act
        var result = ManipulationTransformCalculator.CalculateFinalTransform(preview, parent);

        // Assert
        ;
    }
```

**Returns:** `void`

### CalculateFinalTransform_WithNullPreview_ReturnsDefaults

```csharp
[Fact]
    public void CalculateFinalTransform_WithNullPreview_ReturnsDefaults()
    {
        // Arrange
        var parent = new MockNode2D
        {
            GlobalPosition = new Vector2TypeSafe(100.0f, 200.0f)
        };

        // Act
        var result = ManipulationTransformCalculator.CalculateFinalTransform(null, parent);

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CalculateFinalTransform_WithNullParent_ReturnsDefaults

```csharp
[Fact]
    public void CalculateFinalTransform_WithNullParent_ReturnsDefaults()
    {
        // Arrange
        var preview = new MockNode2D();

        // Act
        var result = ManipulationTransformCalculator.CalculateFinalTransform(preview, null);

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CalculateFinalTransform_WithBothNull_ReturnsDefaults

```csharp
[Fact]
    public void CalculateFinalTransform_WithBothNull_ReturnsDefaults()
    {
        // Act
        var result = ManipulationTransformCalculator.CalculateFinalTransform(null, null);

        // Assert
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CalculateFinalTransform_UsesParentGlobalPosition

```csharp
[Fact]
    public void CalculateFinalTransform_UsesParentGlobalPosition()
    {
        // Arrange - Simulating parent with global position offset
        var preview = new MockNode2D();
        var parent = new MockNode2D
        {
            GlobalPosition = new Vector2TypeSafe(100.0f, 100.0f)
        };

        // Act
        var result = ManipulationTransformCalculator.CalculateFinalTransform(preview, parent);

        // Assert
        ;
    }
```

**Returns:** `void`

### ValidateTransformPreservation_WithValidData_Passes

```csharp
#endregion

    #region Validation Tests

    [Fact]
    public void ValidateTransformPreservation_WithValidData_Passes()
    {
        // Arrange
        var transform = new TransformData(
            new Vector2TypeSafe(100.0f, 200.0f),
            MathF.PI / 4, // 45 degrees
            new Vector2TypeSafe(1.0f, 1.0f)
        );

        // Act
        var result = ManipulationTransformCalculator.ValidateTransformPreservation(transform);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### ValidateTransformPreservation_AcceptsNegativeScale

```csharp
[Fact]
    public void ValidateTransformPreservation_AcceptsNegativeScale()
    {
        // Arrange - Negative scale is valid for flip semantics
        var transform = new TransformData(
            Vector2TypeSafe.Zero(),
            0.0f,
            new Vector2TypeSafe(-1.0f, -2.0f)
        );

        // Act
        var result = ManipulationTransformCalculator.ValidateTransformPreservation(transform);

        // Assert
        ;
    }
```

**Returns:** `void`

### ValidateTransformPreservation_DetectsNullTransform

```csharp
[Fact]
    public void ValidateTransformPreservation_DetectsNullTransform()
    {
        // Act
        var result = ManipulationTransformCalculator.ValidateTransformPreservation(null);

        // Assert
        ;
        Assert.NotEmpty(result.Issues);
    }
```

**Returns:** `void`

### ValidateTransformPreservation_DetectsNearZeroScale

```csharp
[Fact]
    public void ValidateTransformPreservation_DetectsNearZeroScale()
    {
        // Arrange
        var transform = new TransformData(
            Vector2TypeSafe.Zero(),
            0.0f,
            new Vector2TypeSafe(0.005f, 0.005f)
        );

        // Act
        var result = ManipulationTransformCalculator.ValidateTransformPreservation(transform);

        // Assert
        ;
        Assert.NotEmpty(result.Issues);
    }
```

**Returns:** `void`

### CompareTransforms_DetectsMatchingTransforms

```csharp
#endregion

    #region Compare Transforms Tests

    [Fact]
    public void CompareTransforms_DetectsMatchingTransforms()
    {
        // Arrange
        var expected = new TransformData(
            new Vector2TypeSafe(100.0f, 200.0f),
            MathF.PI / 4,
            new Vector2TypeSafe(2.0f, 3.0f)
        );
        var actual = new TransformData(
            new Vector2TypeSafe(100.0f, 200.0f),
            MathF.PI / 4,
            new Vector2TypeSafe(2.0f, 3.0f)
        );

        // Act
        var result = ManipulationTransformCalculator.CompareTransforms(expected, actual);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### CompareTransforms_DetectsPositionDifference

```csharp
[Fact]
    public void CompareTransforms_DetectsPositionDifference()
    {
        // Arrange
        var expected = new TransformData(
            new Vector2TypeSafe(100.0f, 200.0f),
            0.0f,
            Vector2TypeSafe.One()
        );
        var actual = new TransformData(
            new Vector2TypeSafe(110.0f, 200.0f),
            0.0f,
            Vector2TypeSafe.One()
        );

        // Act
        var result = ManipulationTransformCalculator.CompareTransforms(expected, actual, 0.1f);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### CompareTransforms_DetectsRotationDifference

```csharp
[Fact]
    public void CompareTransforms_DetectsRotationDifference()
    {
        // Arrange
        var expected = new TransformData(
            Vector2TypeSafe.Zero(),
            MathF.PI / 4, // 45 degrees
            Vector2TypeSafe.One()
        );
        var actual = new TransformData(
            Vector2TypeSafe.Zero(),
            MathF.PI / 3.6f, // ~50 degrees
            Vector2TypeSafe.One()
        );

        // Act
        var result = ManipulationTransformCalculator.CompareTransforms(expected, actual, 0.01f);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### CompareTransforms_DetectsScaleDifference

```csharp
[Fact]
    public void CompareTransforms_DetectsScaleDifference()
    {
        // Arrange
        var expected = new TransformData(
            Vector2TypeSafe.Zero(),
            0.0f,
            new Vector2TypeSafe(1.0f, 1.0f)
        );
        var actual = new TransformData(
            Vector2TypeSafe.Zero(),
            0.0f,
            new Vector2TypeSafe(1.0f, 1.5f)
        );

        // Act
        var result = ManipulationTransformCalculator.CompareTransforms(expected, actual, 0.01f);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### CompareTransforms_UsesToleranceCorrectly

```csharp
[Fact]
    public void CompareTransforms_UsesToleranceCorrectly()
    {
        // Arrange
        var expected = new TransformData(
            new Vector2TypeSafe(100.0f, 200.0f),
            0.0f,
            Vector2TypeSafe.One()
        );
        var actual = new TransformData(
            new Vector2TypeSafe(100.05f, 200.05f),
            0.0f,
            Vector2TypeSafe.One()
        );

        // Act - Within tolerance
        var result1 = ManipulationTransformCalculator.CompareTransforms(expected, actual, 0.1f);
        ;

        // Act - Outside tolerance
        var result2 = ManipulationTransformCalculator.CompareTransforms(expected, actual, 0.01f);
        ;
    }
```

**Returns:** `void`

### CompareTransforms_ReportsAllDifferences

```csharp
[Fact]
    public void CompareTransforms_ReportsAllDifferences()
    {
        // Arrange
        var expected = new TransformData(
            new Vector2TypeSafe(100.0f, 200.0f),
            MathF.PI / 4,
            new Vector2TypeSafe(2.0f, 3.0f)
        );
        var actual = new TransformData(
            new Vector2TypeSafe(150.0f, 250.0f),
            MathF.PI / 2,
            new Vector2TypeSafe(1.0f, 1.0f)
        );

        // Act
        var result = ManipulationTransformCalculator.CompareTransforms(expected, actual, 0.1f);

        // Assert
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CompareTransforms_HandlesNullTransforms

```csharp
[Fact]
    public void CompareTransforms_HandlesNullTransforms()
    {
        // Arrange
        var transform = new TransformData(
            Vector2TypeSafe.Zero(),
            0.0f,
            Vector2TypeSafe.One()
        );

        // Act
        var result1 = ManipulationTransformCalculator.CompareTransforms(null, transform);
        var result2 = ManipulationTransformCalculator.CompareTransforms(transform, null);
        var result3 = ManipulationTransformCalculator.CompareTransforms(null, null);

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CalculateFinalTransform_WithZeroScale_ReturnsZeroScale

```csharp
#endregion

    #region Edge Case Tests

    [Fact]
    public void CalculateFinalTransform_WithZeroScale_ReturnsZeroScale()
    {
        // Arrange
        var preview = new MockNode2D();
        var parent = new MockNode2D
        {
            Scale = new Vector2TypeSafe(0.0f, 0.0f)
        };

        // Act
        var result = ManipulationTransformCalculator.CalculateFinalTransform(preview, parent);

        // Assert
        ;
    }
```

**Returns:** `void`

### CalculateFinalTransform_WithLargeValues_HandlesCorrectly

```csharp
[Fact]
    public void CalculateFinalTransform_WithLargeValues_HandlesCorrectly()
    {
        // Arrange
        var preview = new MockNode2D();
        var parent = new MockNode2D
        {
            GlobalPosition = new Vector2TypeSafe(10000.0f, 20000.0f),
            Rotation = MathF.PI * 2, // Full rotation
            Scale = new Vector2TypeSafe(100.0f, 100.0f)
        };

        // Act
        var result = ManipulationTransformCalculator.CalculateFinalTransform(preview, parent);

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CalculateFinalTransform_WithVariousRotations_PreservesRotation

```csharp
[Theory]
    [InlineData(0.0f)]
    [InlineData(45.0f)]
    [InlineData(90.0f)]
    [InlineData(180.0f)]
    [InlineData(270.0f)]
    [InlineData(360.0f)]
    public void CalculateFinalTransform_WithVariousRotations_PreservesRotation(float degrees)
    {
        // Arrange
        var preview = new MockNode2D();
        var radians = degrees * MathF.PI / 180.0f;
        var parent = new MockNode2D
        {
            Rotation = radians
        };

        // Act
        var result = ManipulationTransformCalculator.CalculateFinalTransform(preview, parent);

        // Assert
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `float degrees`

