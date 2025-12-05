---
title: "GridRotationUtilsTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/gridrotationutilstest/"
---

# GridRotationUtilsTest

```csharp
GridBuilding.Godot.Tests.Utils
class GridRotationUtilsTest
{
    // Members...
}
```

C# tests for grid-aware rotation utilities
Mirrors GDScript tests in gb_grid_rotation_utils.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GridRotationUtilsTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### DirectionAngles_ShouldContainCorrectValues

```csharp
[Fact]
    public void DirectionAngles_ShouldContainCorrectValues()
    {
        // Test that direction angles are correctly defined
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### DegreesToCardinal_ShouldReturnCorrectDirection

```csharp
[Theory]
    [InlineData(0.0f, GridRotationUtils.CardinalDirection.NORTH)]
    [InlineData(45.0f, GridRotationUtils.CardinalDirection.NORTH)]
    [InlineData(89.9f, GridRotationUtils.CardinalDirection.NORTH)]
    [InlineData(90.0f, GridRotationUtils.CardinalDirection.EAST)]
    [InlineData(135.0f, GridRotationUtils.CardinalDirection.EAST)]
    [InlineData(179.9f, GridRotationUtils.CardinalDirection.EAST)]
    [InlineData(180.0f, GridRotationUtils.CardinalDirection.SOUTH)]
    [InlineData(225.0f, GridRotationUtils.CardinalDirection.SOUTH)]
    [InlineData(269.9f, GridRotationUtils.CardinalDirection.SOUTH)]
    [InlineData(270.0f, GridRotationUtils.CardinalDirection.WEST)]
    [InlineData(315.0f, GridRotationUtils.CardinalDirection.WEST)]
    [InlineData(359.9f, GridRotationUtils.CardinalDirection.WEST)]
    public void DegreesToCardinal_ShouldReturnCorrectDirection(float degrees, GridRotationUtils.CardinalDirection expected)
    {
        var result = GridRotationUtils.DegreesToCardinal(degrees);
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `float degrees`
- `GridRotationUtils.CardinalDirection expected`

### SetNodeDirection_WithNullNode_ShouldReturnZero

```csharp
[Fact]
    public void SetNodeDirection_WithNullNode_ShouldReturnZero()
    {
        var result = GridRotationUtils.SetNodeDirection(null, GridRotationUtils.CardinalDirection.NORTH, null);
        ;
    }
```

**Returns:** `void`

### SetNodeDirection_WithValidNode_ShouldSetCorrectRotation

```csharp
[Fact]
    public void SetNodeDirection_WithValidNode_ShouldSetCorrectRotation()
    {
        // Create a test node
        var node = new Node2D();
        
        // Test setting to each cardinal direction
        var northResult = GridRotationUtils.SetNodeDirection(node, GridRotationUtils.CardinalDirection.NORTH, null);
        ;
        ;
        
        var eastResult = GridRotationUtils.SetNodeDirection(node, GridRotationUtils.CardinalDirection.EAST, null);
        ;
        ;
        
        var southResult = GridRotationUtils.SetNodeDirection(node, GridRotationUtils.CardinalDirection.SOUTH, null);
        ;
        ;
        
        var westResult = GridRotationUtils.SetNodeDirection(node, GridRotationUtils.CardinalDirection.WEST, null);
        ;
        ;
    }
```

**Returns:** `void`

### RotateNodeClockwise_WithValidNode_ShouldRotate90Degrees

```csharp
[Fact]
    public void RotateNodeClockwise_WithValidNode_ShouldRotate90Degrees()
    {
        var node = new Node2D();
        
        // Start facing north
        GridRotationUtils.SetNodeDirection(node, GridRotationUtils.CardinalDirection.NORTH, null);
        ;
        
        // Rotate clockwise to east
        var result1 = GridRotationUtils.RotateNodeClockwise(node, null);
        ;
        ;
        
        // Rotate clockwise to south
        var result2 = GridRotationUtils.RotateNodeClockwise(node, null);
        ;
        ;
        
        // Rotate clockwise to west
        var result3 = GridRotationUtils.RotateNodeClockwise(node, null);
        ;
        ;
        
        // Rotate clockwise back to north
        var result4 = GridRotationUtils.RotateNodeClockwise(node, null);
        ;
        ;
    }
```

**Returns:** `void`

### RotateNodeCounterClockwise_WithValidNode_ShouldRotateNegative90Degrees

```csharp
[Fact]
    public void RotateNodeCounterClockwise_WithValidNode_ShouldRotateNegative90Degrees()
    {
        var node = new Node2D();
        
        // Start facing north
        GridRotationUtils.SetNodeDirection(node, GridRotationUtils.CardinalDirection.NORTH, null);
        ;
        
        // Rotate counter-clockwise to west
        var result1 = GridRotationUtils.RotateNodeCounterClockwise(node, null);
        ;
        ;
        
        // Rotate counter-clockwise to south
        var result2 = GridRotationUtils.RotateNodeCounterClockwise(node, null);
        ;
        ;
        
        // Rotate counter-clockwise to east
        var result3 = GridRotationUtils.RotateNodeCounterClockwise(node, null);
        ;
        ;
        
        // Rotate counter-clockwise back to north
        var result4 = GridRotationUtils.RotateNodeCounterClockwise(node, null);
        ;
        ;
    }
```

**Returns:** `void`

### GetNodeDirection_ShouldReturnCorrectCardinalDirection

```csharp
[Fact]
    public void GetNodeDirection_ShouldReturnCorrectCardinalDirection()
    {
        var node = new Node2D();
        
        // Test each direction
        GridRotationUtils.SetNodeDirection(node, GridRotationUtils.CardinalDirection.NORTH, null);
        ;
        
        GridRotationUtils.SetNodeDirection(node, GridRotationUtils.CardinalDirection.EAST, null);
        ;
        
        GridRotationUtils.SetNodeDirection(node, GridRotationUtils.CardinalDirection.SOUTH, null);
        ;
        
        GridRotationUtils.SetNodeDirection(node, GridRotationUtils.CardinalDirection.WEST, null);
        ;
    }
```

**Returns:** `void`

### WithParentTransform_ShouldAccountForParentRotation

```csharp
[Fact]
    public void WithParentTransform_ShouldAccountForParentRotation()
    {
        // Create a parent node with rotation
        var parent = new Node2D();
        parent.Rotation = Mathf.DegToRad(45.0f); // 45 degrees
        
        // Create child node
        var child = new Node2D();
        parent.AddChild(child);
        
        // Set child direction - should account for parent rotation
        var result = GridRotationUtils.SetNodeDirection(child, GridRotationUtils.CardinalDirection.EAST, null);
        
        // Child should have local rotation that results in global east rotation (90 degrees)
        var expectedGlobalRotation = 90.0f;
        var actualGlobalRotation = Mathf.RadToDeg(child.GlobalRotation);
        
        ; // Allow 2 degree tolerance
    }
```

**Returns:** `void`

### CardinalDirectionCount_ShouldBeFour

```csharp
[Fact]
    public void CardinalDirectionCount_ShouldBeFour()
    {
        var directions = Enum.GetValues(typeof(GridRotationUtils.CardinalDirection));
        ;
    }
```

**Returns:** `void`

### AllCardinalDirections_ShouldHaveUniqueAngles

```csharp
[Fact]
    public void AllCardinalDirections_ShouldHaveUniqueAngles()
    {
        var angles = new float[4];
        angles[(int)GridRotationUtils.CardinalDirection.NORTH] = GridRotationUtils.DIRECTION_ANGLES[GridRotationUtils.CardinalDirection.NORTH];
        angles[(int)GridRotationUtils.CardinalDirection.EAST] = GridRotationUtils.DIRECTION_ANGLES[GridRotationUtils.CardinalDirection.EAST];
        angles[(int)GridRotationUtils.CardinalDirection.SOUTH] = GridRotationUtils.DIRECTION_ANGLES[GridRotationUtils.CardinalDirection.SOUTH];
        angles[(int)GridRotationUtils.CardinalDirection.WEST] = GridRotationUtils.DIRECTION_ANGLES[GridRotationUtils.CardinalDirection.WEST];
        
        // Check all angles are unique
        ;
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

