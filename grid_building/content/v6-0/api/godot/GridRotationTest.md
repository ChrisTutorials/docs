---
title: "GridRotationTest"
description: "Unit tests for GBGridRotationUtils
Tests grid-aware rotation utilities for both cardinal (4-direction) and
multi-directional rotation
Covers:
- Cardinal direction rotation (4-dir, 90° increments) - backward compatibility
- 8-direction rotation (45° increments) - isometric with diagonals
- Custom increment angles (30°, 60°, 15°, etc.)
- Edge cases (360° wraparound, negative angles, fractional increments)
- Transform hierarchy handling with various rotation angles
- Grid snapping with different rotation increments
Note: These utilities are used by ManipulationParent for grid-aware object rotation.
GridPositioner2D no longer handles rotation - it focuses strictly on tile targeting."
weight: 20
url: "/gridbuilding/v6-0/api/godot/gridrotationtest/"
---

# GridRotationTest

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class GridRotationTest
{
    // Members...
}
```

Unit tests for GBGridRotationUtils
Tests grid-aware rotation utilities for both cardinal (4-direction) and
multi-directional rotation
Covers:
- Cardinal direction rotation (4-dir, 90° increments) - backward compatibility
- 8-direction rotation (45° increments) - isometric with diagonals
- Custom increment angles (30°, 60°, 15°, etc.)
- Edge cases (360° wraparound, negative angles, fractional increments)
- Transform hierarchy handling with various rotation angles
- Grid snapping with different rotation increments
Note: These utilities are used by ManipulationParent for grid-aware object rotation.
GridPositioner2D no longer handles rotation - it focuses strictly on tile targeting.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/GridRotationTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Integration.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        // Create test tilemap
        _testMap = new TileMapLayer();
        _testMap.TileSet = new TileSet();
        TestScene.AddChild(_testMap);

        // Create test node to rotate
        _testNode = new Node2D();
        _testNode.GlobalPosition = new Vector2(100, 100);
        TestScene.AddChild(_testNode);

        // Create utility instance
        _utils = new GBGridRotationUtils();
    }
```

**Returns:** `void`

### CleanupAll

```csharp
[CleanupAll]
    public void CleanupAll()
    {
        _testMap?.QueueFree();
        _testNode?.QueueFree();
        _utils?.QueueFree();
    }
```

**Returns:** `void`

### DegreesToCardinal_Conversion_WorksCorrectly

```csharp
#region Cardinal Direction Tests

    /// <summary>
    /// Test cardinal direction conversion from degrees
    /// </summary>
    [Test]
    public void DegreesToCardinal_Conversion_WorksCorrectly()
    {
        GBGridRotationUtils.DegreesToCardinal(0).ShouldBe(GBGridRotationUtils.CardinalDirection.NORTH, 
            "North (0°) should map to NORTH cardinal direction");
        GBGridRotationUtils.DegreesToCardinal(90).ShouldBe(GBGridRotationUtils.CardinalDirection.EAST, 
            "East (90°) should map to EAST cardinal direction");
        GBGridRotationUtils.DegreesToCardinal(180).ShouldBe(GBGridRotationUtils.CardinalDirection.SOUTH, 
            "South (180°) should map to SOUTH cardinal direction");
        GBGridRotationUtils.DegreesToCardinal(270).ShouldBe(GBGridRotationUtils.CardinalDirection.WEST, 
            "West (270°) should map to WEST cardinal direction");
    }
```

Test cardinal direction conversion from degrees

**Returns:** `void`

### CardinalToDegrees_Conversion_WorksCorrectly

```csharp
/// <summary>
    /// Test cardinal direction conversion to degrees
    /// </summary>
    [Test]
    public void CardinalToDegrees_Conversion_WorksCorrectly()
    {
        GBGridRotationUtils.CardinalToDegrees(GBGridRotationUtils.CardinalDirection.NORTH).ShouldBe(0, 
            "NORTH should convert to 0°");
        GBGridRotationUtils.CardinalToDegrees(GBGridRotationUtils.CardinalDirection.EAST).ShouldBe(90, 
            "EAST should convert to 90°");
        GBGridRotationUtils.CardinalToDegrees(GBGridRotationUtils.CardinalDirection.SOUTH).ShouldBe(180, 
            "SOUTH should convert to 180°");
        GBGridRotationUtils.CardinalToDegrees(GBGridRotationUtils.CardinalDirection.WEST).ShouldBe(270, 
            "WEST should convert to 270°");
    }
```

Test cardinal direction conversion to degrees

**Returns:** `void`

### DegreesToCardinal_Wrapping_WorksCorrectly

```csharp
/// <summary>
    /// Test cardinal direction wrapping
    /// </summary>
    [Test]
    public void DegreesToCardinal_Wrapping_WorksCorrectly()
    {
        GBGridRotationUtils.DegreesToCardinal(360).ShouldBe(GBGridRotationUtils.CardinalDirection.NORTH, 
            "360° should wrap to NORTH");
        GBGridRotationUtils.DegreesToCardinal(-90).ShouldBe(GBGridRotationUtils.CardinalDirection.WEST, 
            "-90° should wrap to WEST");
        GBGridRotationUtils.DegreesToCardinal(450).ShouldBe(GBGridRotationUtils.CardinalDirection.EAST, 
            "450° should wrap to EAST");
    }
```

Test cardinal direction wrapping

**Returns:** `void`

### RotateWithIncrement_90Degrees_WorksCorrectly

```csharp
#endregion

    #region Rotation Increment Tests

    /// <summary>
    /// Test rotation with 90-degree increments
    /// </summary>
    [Test]
    public void RotateWithIncrement_90Degrees_WorksCorrectly()
    {
        var initialRotation = 0f;
        var increment = 90f;
        var direction = 1; // clockwise

        var result = _utils!.RotateWithIncrement(initialRotation, increment, direction);

        result.ShouldBe(90f, "0° + 90° clockwise should be 90°");
    }
```

Test rotation with 90-degree increments

**Returns:** `void`

### RotateWithIncrement_45Degrees_WorksCorrectly

```csharp
/// <summary>
    /// Test rotation with 45-degree increments
    /// </summary>
    [Test]
    public void RotateWithIncrement_45Degrees_WorksCorrectly()
    {
        var initialRotation = 0f;
        var increment = 45f;
        var direction = 1; // clockwise

        var result = _utils!.RotateWithIncrement(initialRotation, increment, direction);

        result.ShouldBe(45f, "0° + 45° clockwise should be 45°");
    }
```

Test rotation with 45-degree increments

**Returns:** `void`

### RotateWithIncrement_CounterClockwise_WorksCorrectly

```csharp
/// <summary>
    /// Test rotation with negative direction (counter-clockwise)
    /// </summary>
    [Test]
    public void RotateWithIncrement_CounterClockwise_WorksCorrectly()
    {
        var initialRotation = 90f;
        var increment = 90f;
        var direction = -1; // counter-clockwise

        var result = _utils!.RotateWithIncrement(initialRotation, increment, direction);

        result.ShouldBe(0f, "90° - 90° should be 0°");
    }
```

Test rotation with negative direction (counter-clockwise)

**Returns:** `void`

### RotateWithIncrement_Wrapping_WorksCorrectly

```csharp
/// <summary>
    /// Test rotation wrapping at 360 degrees
    /// </summary>
    [Test]
    public void RotateWithIncrement_Wrapping_WorksCorrectly()
    {
        var initialRotation = 270f;
        var increment = 90f;
        var direction = 1; // clockwise

        var result = _utils!.RotateWithIncrement(initialRotation, increment, direction);

        result.ShouldBe(0f, "270° + 90° should wrap to 0°");
    }
```

Test rotation wrapping at 360 degrees

**Returns:** `void`

### SnapToGrid_Cardinal_WorksCorrectly

```csharp
#endregion

    #region Grid Snapping Tests

    /// <summary>
    /// Test grid snapping with cardinal directions
    /// </summary>
    [Test]
    public void SnapToGrid_Cardinal_WorksCorrectly()
    {
        _testNode!.Rotation = Mathf.DegToRad(45f); // 45 degrees

        _utils!.SnapToGrid(_testNode, 90f); // Snap to 90-degree increments

        var snappedDegrees = Mathf.RadToDeg(_testNode.Rotation);
        snappedDegrees.ShouldBeApproximately(0f, 0.01f, "45° should snap to 0° for 90° increments");
    }
```

Test grid snapping with cardinal directions

**Returns:** `void`

### SnapToGrid_45Degrees_WorksCorrectly

```csharp
/// <summary>
    /// Test grid snapping with 45-degree increments
    /// </summary>
    [Test]
    public void SnapToGrid_45Degrees_WorksCorrectly()
    {
        _testNode!.Rotation = Mathf.DegToRad(22f); // 22 degrees

        _utils!.SnapToGrid(_testNode, 45f); // Snap to 45-degree increments

        var snappedDegrees = Mathf.RadToDeg(_testNode.Rotation);
        snappedDegrees.ShouldBeApproximately(0f, 0.01f, "22° should snap to 0° for 45° increments");
    }
```

Test grid snapping with 45-degree increments

**Returns:** `void`

### SnapToGrid_CustomIncrement_WorksCorrectly

```csharp
/// <summary>
    /// Test grid snapping with custom increments
    /// </summary>
    [Test]
    public void SnapToGrid_CustomIncrement_WorksCorrectly()
    {
        _testNode!.Rotation = Mathf.DegToRad(20f); // 20 degrees

        _utils!.SnapToGrid(_testNode, 30f); // Snap to 30-degree increments

        var snappedDegrees = Mathf.RadToDeg(_testNode.Rotation);
        snappedDegrees.ShouldBeApproximately(0f, 0.01f, "20° should snap to 0° for 30° increments");
    }
```

Test grid snapping with custom increments

**Returns:** `void`

### RotateWithParentTransform_WorksCorrectly

```csharp
#endregion

    #region Transform Hierarchy Tests

    /// <summary>
    /// Test rotation with parent transform
    /// </summary>
    [Test]
    public void RotateWithParentTransform_WorksCorrectly()
    {
        var parent = new Node2D();
        parent.Rotation = Mathf.DegToRad(45f); // Parent rotated 45 degrees
        TestScene.AddChild(parent);

        var child = new Node2D();
        child.Rotation = Mathf.DegToRad(90f); // Child rotated 90 degrees
        parent.AddChild(child);

        _utils!.RotateWithIncrement(child, 90f, 1); // Rotate child 90 degrees

        var childGlobalRotation = Mathf.RadToDeg(child.GlobalRotation);
        childGlobalRotation.ShouldBeApproximately(225f, 0.01f, "Child global rotation should account for parent");

        // Cleanup
        parent.QueueFree();
    }
```

Test rotation with parent transform

**Returns:** `void`

### SnapToGridWithParentTransform_WorksCorrectly

```csharp
/// <summary>
    /// Test grid snapping with parent transform
    /// </summary>
    [Test]
    public void SnapToGridWithParentTransform_WorksCorrectly()
    {
        var parent = new Node2D();
        parent.Rotation = Mathf.DegToRad(30f); // Parent rotated 30 degrees
        TestScene.AddChild(parent);

        var child = new Node2D();
        child.Rotation = Mathf.DegToRad(50f); // Child rotated 50 degrees
        parent.AddChild(child);

        _utils!.SnapToGrid(child, 45f); // Snap to 45-degree increments

        var childGlobalRotation = Mathf.RadToDeg(child.GlobalRotation);
        // Should snap to nearest 45-degree increment considering parent rotation
        childGlobalRotation.ShouldBeOneOf(new[] { 75f, 120f, 165f }, 0.01f);

        // Cleanup
        parent.QueueFree();
    }
```

Test grid snapping with parent transform

**Returns:** `void`

### RotateWithIncrement_SmallIncrement_WorksCorrectly

```csharp
#endregion

    #region Edge Cases

    /// <summary>
    /// Test handling of very small rotation increments
    /// </summary>
    [Test]
    public void RotateWithIncrement_SmallIncrement_WorksCorrectly()
    {
        var initialRotation = 0f;
        var increment = 1f; // 1 degree increment
        var direction = 1;

        var result = _utils!.RotateWithIncrement(initialRotation, increment, direction);

        result.ShouldBe(1f, "Should handle 1-degree increments");
    }
```

Test handling of very small rotation increments

**Returns:** `void`

### RotateWithIncrement_FractionalIncrement_WorksCorrectly

```csharp
/// <summary>
    /// Test handling of fractional rotation increments
    /// </summary>
    [Test]
    public void RotateWithIncrement_FractionalIncrement_WorksCorrectly()
    {
        var initialRotation = 0f;
        var increment = 22.5f; // 22.5 degree increment
        var direction = 1;

        var result = _utils!.RotateWithIncrement(initialRotation, increment, direction);

        result.ShouldBe(22.5f, "Should handle fractional increments");
    }
```

Test handling of fractional rotation increments

**Returns:** `void`

### RotateWithIncrement_MultipleWraps_WorksCorrectly

```csharp
/// <summary>
    /// Test rotation beyond 360 degrees multiple times
    /// </summary>
    [Test]
    public void RotateWithIncrement_MultipleWraps_WorksCorrectly()
    {
        var initialRotation = 350f;
        var increment = 45f;
        var direction = 1;

        var result = _utils!.RotateWithIncrement(initialRotation, increment, direction);

        result.ShouldBe(35f, "350° + 45° should wrap to 35°");
    }
```

Test rotation beyond 360 degrees multiple times

**Returns:** `void`

