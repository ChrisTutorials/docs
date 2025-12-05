---
title: "ShapeTileOffsetCalculator"
description: "Shape tile offset calculation utilities for collision processing.
Core implementation without Godot dependencies."
weight: 10
url: "/gridbuilding/v6-0/api/core/shapetileoffsetcalculator/"
---

# ShapeTileOffsetCalculator

```csharp
GridBuilding.Core.Geometry
class ShapeTileOffsetCalculator
{
    // Members...
}
```

Shape tile offset calculation utilities for collision processing.
Core implementation without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/CollisionProcessorHelpers.cs`  
**Namespace:** `GridBuilding.Core.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ComputeShapeTileOffsets

```csharp
/// <summary>
    /// Computes polygon-to-tile offsets using Core math.
    /// </summary>
    public static List<Vector2I> ComputeShapeTileOffsets(
        ShapeDataType shape,
        Transform2D transform,
        Vector2 tileSize,
        float shapeEpsilon,
        Vector2I startTile,
        Vector2I endExclusive,
        Vector2I centerTile,
        Vector2[] polygon)
    {
        var offsets = new List<Vector2I>();
        
        if (polygon.Length == 0)
            return offsets;
        
        // Check each tile in the bounds for overlap
        for (int x = startTile.X; x < endExclusive.X; x++)
        {
            for (int y = startTile.Y; y < endExclusive.Y; y++)
            {
                var tilePos = new Vector2(x * tileSize.X, y * tileSize.Y);
                
                // Use existing GeometryMath for overlap detection
                if (GeometryMath.DoesPolygonOverlapTile(
                    polygon, tilePos, tileSize, Types.TileShape.Square, shapeEpsilon))
                {
                    // Calculate relative offset from center tile
                    var offset = new Vector2I(x - centerTile.X, y - centerTile.Y);
                    offsets.Add(offset);
                }
            }
        }
        
        return offsets;
    }
```

Computes polygon-to-tile offsets using Core math.

**Returns:** `List<Vector2I>`

**Parameters:**
- `ShapeDataType shape`
- `Transform2D transform`
- `Vector2 tileSize`
- `float shapeEpsilon`
- `Vector2I startTile`
- `Vector2I endExclusive`
- `Vector2I centerTile`
- `Vector2[] polygon`

