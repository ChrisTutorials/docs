---
title: "TileRangeCalculator"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/tilerangecalculator/"
---

# TileRangeCalculator

```csharp
GridBuilding.Core.Geometry
class TileRangeCalculator
{
    // Members...
}
```

Tile range calculation utilities for collision processing.
Core implementation without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/CollisionProcessorHelpers.cs`  
**Namespace:** `GridBuilding.Core.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CalculateTileRange

```csharp
/// <summary>
    /// Calculate the tile range that needs to be checked for a shape.
    /// Returns a dictionary with 'start' and 'end_exclusive' Vector2i values.
    /// </summary>
    public static Dictionary<string, Vector2I> CalculateTileRange(
        ShapeDataType shape,
        Rect2 bounds,
        Vector2 tileSize,
        Transform2D transform)
    {
        var minLocal = bounds.Position;
        var maxLocal = bounds.Position + bounds.Size;
        var startTile = new Vector2I(
            (int)System.Math.Floor(minLocal.X / tileSize.X), 
            (int)System.Math.Floor(minLocal.Y / tileSize.Y)
        );
        var endExclusive = new Vector2I(
            (int)System.Math.Ceiling(maxLocal.X / tileSize.X), 
            (int)System.Math.Ceiling(maxLocal.Y / tileSize.Y)
        );

        // Adjust for symmetric shapes (Circle, Capsule)
        if (shape.ShapeType == Types.ShapeType.Circle || shape.ShapeType == Types.ShapeType.Capsule)
        {
            var shapeCenterTile = new Vector2I(
                (int)System.Math.Floor(transform.Origin.X / tileSize.X),
                (int)System.Math.Floor(transform.Origin.Y / tileSize.Y)
            );
            var leftSpan = shapeCenterTile.X - startTile.X;
            var rightSpan = endExclusive.X - shapeCenterTile.X;
            var desiredRightExclusive = shapeCenterTile.X + leftSpan + 1;
            if (endExclusive.X < desiredRightExclusive)
            {
                endExclusive = new Vector2I(desiredRightExclusive, endExclusive.Y);
            }
        }

        return new Dictionary<string, Vector2I>
        {
            { "start", startTile },
            { "end_exclusive", endExclusive }
        };
    }
```

Calculate the tile range that needs to be checked for a shape.
Returns a dictionary with 'start' and 'end_exclusive' Vector2i values.

**Returns:** `Dictionary<string, Vector2I>`

**Parameters:**
- `ShapeDataType shape`
- `Rect2 bounds`
- `Vector2 tileSize`
- `Transform2D transform`

