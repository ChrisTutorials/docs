---
title: "RotationMathTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/rotationmathtest/"
---

# RotationMathTest

```csharp
GridBuilding.Godot.Tests.Validation
class RotationMathTest
{
    // Members...
}
```

Unit tests for rotation mathematics and angle normalization.
Tests core rotation calculations used in grid building without Godot dependencies.
Based on: GBGridRotationUtils concepts for grid-aware rotation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Validation/RotationMathTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### NormalizeAngle_PositiveAngles_NormalizesCorrectly

```csharp
#region Angle Normalization Tests

    [Theory]
    [InlineData(0, 0)]
    [InlineData(90, 90)]
    [InlineData(180, 180)]
    [InlineData(270, 270)]
    [InlineData(360, 0)]
    [InlineData(450, 90)]
    [InlineData(720, 0)]
    public void NormalizeAngle_PositiveAngles_NormalizesCorrectly(float input, float expected)
    {
        var result = RotationMath.NormalizeAngle(input);
        result.ShouldBe(expected, Tolerance);
    }
```

**Returns:** `void`

**Parameters:**
- `float input`
- `float expected`

### NormalizeAngle_NegativeAngles_NormalizesCorrectly

```csharp
[Theory]
    [InlineData(-90, 270)]
    [InlineData(-180, 180)]
    [InlineData(-270, 90)]
    [InlineData(-360, 0)]
    [InlineData(-450, 270)]
    public void NormalizeAngle_NegativeAngles_NormalizesCorrectly(float input, float expected)
    {
        var result = RotationMath.NormalizeAngle(input);
        result.ShouldBe(expected, Tolerance);
    }
```

**Returns:** `void`

**Parameters:**
- `float input`
- `float expected`

### NormalizeAngle_VeryLargeValue_HandlesCorrectly

```csharp
[Fact]
    public void NormalizeAngle_VeryLargeValue_HandlesCorrectly()
    {
        var result = RotationMath.NormalizeAngle(3600);
        result.ShouldBe(0, Tolerance);
    }
```

**Returns:** `void`

### NormalizeAngle_VeryLargeNegative_HandlesCorrectly

```csharp
[Fact]
    public void NormalizeAngle_VeryLargeNegative_HandlesCorrectly()
    {
        var result = RotationMath.NormalizeAngle(-3600);
        result.ShouldBe(0, Tolerance);
    }
```

**Returns:** `void`

### DegreesToCardinal_North_ReturnsCorrect

```csharp
#endregion

    #region Cardinal Direction Tests

    [Fact]
    public void DegreesToCardinal_North_ReturnsCorrect()
    {
        RotationMath.DegreesToCardinal(0).ShouldBe(CardinalDirection.North);
        RotationMath.DegreesToCardinal(360).ShouldBe(CardinalDirection.North);
    }
```

**Returns:** `void`

### DegreesToCardinal_East_ReturnsCorrect

```csharp
[Fact]
    public void DegreesToCardinal_East_ReturnsCorrect()
    {
        RotationMath.DegreesToCardinal(90).ShouldBe(CardinalDirection.East);
    }
```

**Returns:** `void`

### DegreesToCardinal_South_ReturnsCorrect

```csharp
[Fact]
    public void DegreesToCardinal_South_ReturnsCorrect()
    {
        RotationMath.DegreesToCardinal(180).ShouldBe(CardinalDirection.South);
    }
```

**Returns:** `void`

### DegreesToCardinal_West_ReturnsCorrect

```csharp
[Fact]
    public void DegreesToCardinal_West_ReturnsCorrect()
    {
        RotationMath.DegreesToCardinal(270).ShouldBe(CardinalDirection.West);
    }
```

**Returns:** `void`

### DegreesToCardinal_BetweenDirections_RoundsCorrectly

```csharp
[Theory]
    [InlineData(46, CardinalDirection.East)]    // > 45 rounds up to East
    [InlineData(44, CardinalDirection.North)]   // < 45 rounds down to North
    [InlineData(45, CardinalDirection.North)]   // Exactly 45: MathF.Round uses banker's rounding → 0 → North
    [InlineData(135, CardinalDirection.South)]
    [InlineData(226, CardinalDirection.West)]   // > 225 rounds up
    [InlineData(315, CardinalDirection.North)]
    public void DegreesToCardinal_BetweenDirections_RoundsCorrectly(float degrees, CardinalDirection expected)
    {
        RotationMath.DegreesToCardinal(degrees).ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `float degrees`
- `CardinalDirection expected`

### CardinalToDegrees_AllDirections_ConvertsCorrectly

```csharp
[Fact]
    public void CardinalToDegrees_AllDirections_ConvertsCorrectly()
    {
        RotationMath.CardinalToDegrees(CardinalDirection.North).ShouldBe(0);
        RotationMath.CardinalToDegrees(CardinalDirection.East).ShouldBe(90);
        RotationMath.CardinalToDegrees(CardinalDirection.South).ShouldBe(180);
        RotationMath.CardinalToDegrees(CardinalDirection.West).ShouldBe(270);
    }
```

**Returns:** `void`

### RotateByStep_CardinalSteps_RotatesCorrectly

```csharp
#endregion

    #region Rotation Stepping Tests

    [Theory]
    [InlineData(0, 90, true, 90)]     // CW from 0
    [InlineData(90, 90, true, 180)]   // CW from 90
    [InlineData(270, 90, true, 0)]    // CW wraps around
    [InlineData(0, 90, false, 270)]   // CCW from 0
    [InlineData(90, 90, false, 0)]    // CCW from 90
    public void RotateByStep_CardinalSteps_RotatesCorrectly(float start, float step, bool clockwise, float expected)
    {
        var result = RotationMath.RotateByStep(start, step, clockwise);
        result.ShouldBe(expected, Tolerance);
    }
```

**Returns:** `void`

**Parameters:**
- `float start`
- `float step`
- `bool clockwise`
- `float expected`

### RotateByStep_OctantSteps_RotatesCorrectly

```csharp
[Theory]
    [InlineData(0, 45, true, 45)]
    [InlineData(45, 45, true, 90)]
    [InlineData(315, 45, true, 0)]
    [InlineData(0, 45, false, 315)]
    public void RotateByStep_OctantSteps_RotatesCorrectly(float start, float step, bool clockwise, float expected)
    {
        var result = RotationMath.RotateByStep(start, step, clockwise);
        result.ShouldBe(expected, Tolerance);
    }
```

**Returns:** `void`

**Parameters:**
- `float start`
- `float step`
- `bool clockwise`
- `float expected`

### RotateByStep_30DegreeSteps_RotatesCorrectly

```csharp
[Theory]
    [InlineData(0, 30)]
    [InlineData(30, 60)]
    [InlineData(60, 90)]
    [InlineData(330, 0)]
    public void RotateByStep_30DegreeSteps_RotatesCorrectly(float start, float expected)
    {
        var result = RotationMath.RotateByStep(start, 30, clockwise: true);
        result.ShouldBe(expected, Tolerance);
    }
```

**Returns:** `void`

**Parameters:**
- `float start`
- `float expected`

### SnapToGrid_90DegreeGrid_SnapsCorrectly

```csharp
#endregion

    #region Snap To Grid Tests

    [Theory]
    [InlineData(0, 90, 0)]
    [InlineData(44, 90, 0)]
    [InlineData(46, 90, 90)]   // > 45 rounds up
    [InlineData(89, 90, 90)]
    [InlineData(91, 90, 90)]
    [InlineData(135, 90, 180)]
    [InlineData(45, 90, 0)]    // Exactly 45: banker's rounding → 0
    public void SnapToGrid_90DegreeGrid_SnapsCorrectly(float input, float gridSize, float expected)
    {
        var result = RotationMath.SnapToGrid(input, gridSize);
        result.ShouldBe(expected, Tolerance);
    }
```

**Returns:** `void`

**Parameters:**
- `float input`
- `float gridSize`
- `float expected`

### SnapToGrid_45DegreeGrid_SnapsCorrectly

```csharp
[Theory]
    [InlineData(0, 45, 0)]
    [InlineData(22, 45, 0)]
    [InlineData(23, 45, 45)]
    [InlineData(67, 45, 45)]
    [InlineData(68, 45, 90)]
    public void SnapToGrid_45DegreeGrid_SnapsCorrectly(float input, float gridSize, float expected)
    {
        var result = RotationMath.SnapToGrid(input, gridSize);
        result.ShouldBe(expected, Tolerance);
    }
```

**Returns:** `void`

**Parameters:**
- `float input`
- `float gridSize`
- `float expected`

### SnapToGrid_NegativeAngle_NormalizesAndSnaps

```csharp
[Fact]
    public void SnapToGrid_NegativeAngle_NormalizesAndSnaps()
    {
        // -45 normalizes to 315, snaps to either 270 or 0 depending on rounding
        // With banker's rounding: 315/90 = 3.5 → rounds to 4 → 360 → normalizes to 0
        var result = RotationMath.SnapToGrid(-45, 90);
        result.ShouldBe(0, Tolerance);
    }
```

**Returns:** `void`

### ShortestAngleDifference_VariousAngles_ReturnsShortestPath

```csharp
#endregion

    #region Angle Difference Tests

    [Theory]
    [InlineData(0, 90, 90)]
    [InlineData(90, 0, -90)]
    [InlineData(0, 180, 180)]   // 180 is ambiguous - could be +180 or -180, impl returns +180
    [InlineData(180, 0, 180)]   // Same - implementation returns +180 for exact opposite
    [InlineData(0, 270, -90)]   // Shortest path is CCW
    [InlineData(270, 0, 90)]    // Shortest path is CW
    [InlineData(350, 10, 20)]   // Across 0 boundary
    [InlineData(10, 350, -20)]  // Across 0 boundary reverse
    public void ShortestAngleDifference_VariousAngles_ReturnsShortestPath(float from, float to, float expected)
    {
        var result = RotationMath.ShortestAngleDifference(from, to);
        result.ShouldBe(expected, Tolerance);
    }
```

**Returns:** `void`

**Parameters:**
- `float from`
- `float to`
- `float expected`

### ShortestAngleDifference_SameAngle_ReturnsZero

```csharp
[Fact]
    public void ShortestAngleDifference_SameAngle_ReturnsZero()
    {
        RotationMath.ShortestAngleDifference(90, 90).ShouldBe(0, Tolerance);
    }
```

**Returns:** `void`

### ShortestAngleDifference_OppositeAngles_Returns180

```csharp
[Fact]
    public void ShortestAngleDifference_OppositeAngles_Returns180()
    {
        var result = Math.Abs(RotationMath.ShortestAngleDifference(0, 180));
        result.ShouldBe(180, Tolerance);
    }
```

**Returns:** `void`

### DegreesToRadians_StandardAngles_ConvertsCorrectly

```csharp
#endregion

    #region Radians Conversion Tests

    [Theory]
    [InlineData(0, 0)]
    [InlineData(90, Math.PI / 2)]
    [InlineData(180, Math.PI)]
    [InlineData(270, 3 * Math.PI / 2)]
    [InlineData(360, 2 * Math.PI)]
    public void DegreesToRadians_StandardAngles_ConvertsCorrectly(float degrees, double expectedRadians)
    {
        var result = RotationMath.DegreesToRadians(degrees);
        result.ShouldBe((float)expectedRadians, Tolerance);
    }
```

**Returns:** `void`

**Parameters:**
- `float degrees`
- `double expectedRadians`

### RadiansToDegrees_StandardAngles_ConvertsCorrectly

```csharp
[Theory]
    [InlineData(0, 0)]
    [InlineData(Math.PI / 2, 90)]
    [InlineData(Math.PI, 180)]
    [InlineData(3 * Math.PI / 2, 270)]
    [InlineData(2 * Math.PI, 360)]
    public void RadiansToDegrees_StandardAngles_ConvertsCorrectly(double radians, float expectedDegrees)
    {
        var result = RotationMath.RadiansToDegrees((float)radians);
        result.ShouldBe(expectedDegrees, Tolerance);
    }
```

**Returns:** `void`

**Parameters:**
- `double radians`
- `float expectedDegrees`

### CountRotationSteps_QuarterTurns_ReturnsCorrectCount

```csharp
#endregion

    #region Rotation Count Tests

    [Fact]
    public void CountRotationSteps_QuarterTurns_ReturnsCorrectCount()
    {
        RotationMath.CountRotationSteps(0, 90, 90).ShouldBe(1);
        RotationMath.CountRotationSteps(0, 180, 90).ShouldBe(2);
        RotationMath.CountRotationSteps(0, 270, 90).ShouldBe(3);
        RotationMath.CountRotationSteps(0, 360, 90).ShouldBe(0); // Full rotation = 0
    }
```

**Returns:** `void`

### CountRotationSteps_OctantTurns_ReturnsCorrectCount

```csharp
[Fact]
    public void CountRotationSteps_OctantTurns_ReturnsCorrectCount()
    {
        RotationMath.CountRotationSteps(0, 45, 45).ShouldBe(1);
        RotationMath.CountRotationSteps(0, 90, 45).ShouldBe(2);
        RotationMath.CountRotationSteps(0, 180, 45).ShouldBe(4);
    }
```

**Returns:** `void`

