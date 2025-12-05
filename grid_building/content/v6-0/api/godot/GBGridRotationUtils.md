---
title: "GBGridRotationUtils"
description: "Mock implementation of GBGridRotationUtils for testing"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gbgridrotationutils/"
---

# GBGridRotationUtils

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class GBGridRotationUtils
{
    // Members...
}
```

Mock implementation of GBGridRotationUtils for testing

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/GridRotationTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Integration.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### DegreesToCardinal

```csharp
/// <summary>
    /// Converts degrees to cardinal direction
    /// </summary>
    public static CardinalDirection DegreesToCardinal(float degrees)
    {
        // Normalize to 0-360 range
        degrees = degrees % 360f;
        if (degrees < 0) degrees += 360f;

        return degrees switch
        {
            >= 315f or < 45f => CardinalDirection.NORTH,
            >= 45f and < 135f => CardinalDirection.EAST,
            >= 135f and < 225f => CardinalDirection.SOUTH,
            >= 225f and < 315f => CardinalDirection.WEST,
            _ => CardinalDirection.NORTH
        };
    }
```

Converts degrees to cardinal direction

**Returns:** `CardinalDirection`

**Parameters:**
- `float degrees`

### CardinalToDegrees

```csharp
/// <summary>
    /// Converts cardinal direction to degrees
    /// </summary>
    public static float CardinalToDegrees(CardinalDirection cardinal)
    {
        return cardinal switch
        {
            CardinalDirection.NORTH => 0f,
            CardinalDirection.EAST => 90f,
            CardinalDirection.SOUTH => 180f,
            CardinalDirection.WEST => 270f,
            _ => 0f
        };
    }
```

Converts cardinal direction to degrees

**Returns:** `float`

**Parameters:**
- `CardinalDirection cardinal`

### RotateWithIncrement

```csharp
/// <summary>
    /// Rotates by increment with direction
    /// </summary>
    public float RotateWithIncrement(float currentRotation, float increment, int direction)
    {
        var newRotation = currentRotation + (increment * direction);
        
        // Normalize to 0-360 range
        newRotation = newRotation % 360f;
        if (newRotation < 0) newRotation += 360f;
        
        return newRotation;
    }
```

Rotates by increment with direction

**Returns:** `float`

**Parameters:**
- `float currentRotation`
- `float increment`
- `int direction`

### SnapToGrid

```csharp
/// <summary>
    /// Snaps rotation to grid increments
    /// </summary>
    public void SnapToGrid(Node2D node, float increment)
    {
        if (node == null) return;

        var currentDegrees = Mathf.RadToDeg(node.Rotation);
        var snappedDegrees = Mathf.Round(currentDegrees / increment) * increment;
        
        // Normalize to 0-360 range
        snappedDegrees = snappedDegrees % 360f;
        if (snappedDegrees < 0) snappedDegrees += 360f;
        
        node.Rotation = Mathf.DegToRad(snappedDegrees);
    }
```

Snaps rotation to grid increments

**Returns:** `void`

**Parameters:**
- `Node2D node`
- `float increment`

