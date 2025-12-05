---
title: "TileRangeCalculator"
description: "Tile range calculation utilities for collision processing.
Ported from GDScript collision_processor.gd calculate_tile_range method."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/tilerangecalculator/"
---

# TileRangeCalculator

```csharp
GridBuilding.Godot.Systems.Placement.Processors
class TileRangeCalculator
{
    // Members...
}
```

Tile range calculation utilities for collision processing.
Ported from GDScript collision_processor.gd calculate_tile_range method.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Processors/CollisionProcessorHelpers.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Processors`  
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
        Shape2D shape,
        Rect2 bounds,
        TileMapLayer map,
        Vector2 tileSize,
        Transform2D shapeTransform
    )
    {
        var minLocal = map.ToLocal(bounds.Position);
        var maxLocal = map.ToLocal(bounds.Position + bounds.Size);
        var startTile = new Vector2I(
            (int)Math.Floor(minLocal.X / tileSize.X), 
            (int)Math.Floor(minLocal.Y / tileSize.Y)
        );
        var endExclusive = new Vector2I(
            (int)Math.Ceiling(maxLocal.X / tileSize.X), 
            (int)Math.Ceiling(maxLocal.Y / tileSize.Y)
        );

        if (shape is CircleShape2D or CapsuleShape2D)
        {
            var shapeCenterTile = map.LocalToMap(map.ToLocal(shapeTransform.Origin));
            var leftSpan = shapeCenterTile.X - startTile.X;
            var rightSpan = endExclusive.X - shapeCenterTile.X;
            var desiredRightExclusive = shapeCenterTile.X + leftSpan + 1;
            if (endExclusive.X < desiredRightExclusive)
            {
                endExclusive = new Vector2I(desiredRightExclusive, endExclusive.Y);
            }
        }

        if (shape is RectangleShape2D)
        {
            var effSize = bounds.Size;
            var shapeCenterTile = map.LocalToMap(map.ToLocal(shapeTransform.Origin));
            var adjusted = CollisionTileFilter.AdjustRectTileRange(
                effSize, tileSize, shapeCenterTile, startTile, endExclusive
            );
            startTile = adjusted["start"];
            endExclusive = adjusted["end_exclusive"];
        }

        return new Dictionary<string, Vector2I>
        {
            ["start"] = startTile,
            ["end_exclusive"] = endExclusive
        };
    }
```

Calculate the tile range that needs to be checked for a shape.
Returns a dictionary with 'start' and 'end_exclusive' Vector2i values.

**Returns:** `Dictionary<string, Vector2I>`

**Parameters:**
- `Shape2D shape`
- `Rect2 bounds`
- `TileMapLayer map`
- `Vector2 tileSize`
- `Transform2D shapeTransform`

