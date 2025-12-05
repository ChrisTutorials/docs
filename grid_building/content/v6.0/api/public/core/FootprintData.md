---
title: "FootprintData"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/footprintdata/"
---

# FootprintData

```csharp
GridBuilding.Core.Data.Placement
class FootprintData
{
    // Members...
}
```

Core footprint data without Godot dependencies.
Describes the space occupied by a building or object.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/Placement/FootprintData.cs`  
**Namespace:** `GridBuilding.Core.Data.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
/// <summary>
    /// Unique identifier for the footprint.
    /// </summary>
    public string Id { get; set; } = string.Empty;
```

Unique identifier for the footprint.

### ShapeType

```csharp
/// <summary>
    /// Type of footprint shape.
    /// </summary>
    public FootprintShapeType ShapeType { get; set; }
```

Type of footprint shape.

### Size

```csharp
/// <summary>
    /// Size of the footprint in grid units.
    /// </summary>
    public Vector2I Size { get; set; }
```

Size of the footprint in grid units.

### Offset

```csharp
/// <summary>
    /// Offset from the origin position.
    /// </summary>
    public Vector2I Offset { get; set; } = Vector2I.Zero;
```

Offset from the origin position.

### PolygonPoints

```csharp
/// <summary>
    /// Custom polygon points for complex shapes.
    /// Used when ShapeType is Custom.
    /// </summary>
    public List<Vector2I> PolygonPoints { get; set; } = new();
```

Custom polygon points for complex shapes.
Used when ShapeType is Custom.

### Radius

```csharp
/// <summary>
    /// Radius for circular shapes.
    /// Used when ShapeType is Circle.
    /// </summary>
    public int Radius { get; set; } = 0;
```

Radius for circular shapes.
Used when ShapeType is Circle.

### CanRotate

```csharp
/// <summary>
    /// Whether the footprint can be rotated.
    /// </summary>
    public bool CanRotate { get; set; } = true;
```

Whether the footprint can be rotated.

### CanFlip

```csharp
/// <summary>
    /// Whether the footprint can be flipped.
    /// </summary>
    public bool CanFlip { get; set; } = false;
```

Whether the footprint can be flipped.


## Methods

### GetOccupiedPositions

```csharp
/// <summary>
    /// Gets the footprint positions at a given grid position.
    /// </summary>
    /// <param name="gridPosition">The base grid position</param>
    /// <param name="rotation">Rotation in degrees (0, 90, 180, 270)</param>
    /// <param name="flipHorizontal">Whether to flip horizontally</param>
    /// <param name="flipVertical">Whether to flip vertically</param>
    /// <returns>List of occupied grid positions</returns>
    public List<Vector2I> GetOccupiedPositions(
        Vector2I gridPosition, 
        int rotation = 0, 
        bool flipHorizontal = false, 
        bool flipVertical = false)
    {
        var positions = new List<Vector2I>();
        
        switch (ShapeType)
        {
            case FootprintShapeType.Rectangle:
                positions = GetRectanglePositions(gridPosition, rotation, flipHorizontal, flipVertical);
                break;
                
            case FootprintShapeType.Circle:
                positions = GetCirclePositions(gridPosition);
                break;
                
            case FootprintShapeType.Custom:
                positions = GetCustomPolygonPositions(gridPosition, rotation, flipHorizontal, flipVertical);
                break;
        }
        
        return positions;
    }
```

Gets the footprint positions at a given grid position.

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I gridPosition`
- `int rotation`
- `bool flipHorizontal`
- `bool flipVertical`

