---
title: "ShapeTileOffsetCalculator"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/shapetileoffsetcalculator/"
---

# ShapeTileOffsetCalculator

```csharp
GridBuilding.Godot.Systems.Placement.Processors
class ShapeTileOffsetCalculator
{
    // Members...
}
```

Shape tile offset computation utilities for collision processing.
Ported from GDScript collision_processor.gd compute_shape_tile_offsets method.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Processors/CollisionProcessorHelpers.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Processors`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ComputeShapeTileOffsets

```csharp
/// <summary>
    /// Compute which tiles a shape overlaps with, returning offset positions.
    /// Delegates to CollisionGeometryUtils to compute polygon→tile offsets.
    /// This ensures identical behavior to polygon processing and fixes missing edge tiles.
    /// </summary>
    public static List<Vector2I> ComputeShapeTileOffsets(
        Shape2D shape,
        Transform2D shapeTransform,
        TileMapLayer map,
        Vector2 tileSize,
        float shapeEpsilon,
        Vector2I startTile,
        Vector2I endExclusive,
        Vector2I centerTile,
        Vector2[] shapePolygon
    )
    {
        var tileShape = map.TileSet.TileShape;
        // shapePolygon is expected in world coordinates (built via build_shape_transform above)
        var shapeOffsets = CollisionUtilities.ComputePolygonTileOffsets(
            shapePolygon, tileSize, centerTile, tileShape, map
        );

        // Debug: only log detailed tile offset calculations at VERBOSE level to reduce test noise
        GD.Print($"compute_shape_tile_offsets -> start_tile={startTile} end_exclusive={endExclusive} center_tile={centerTile} produced_offsets={shapeOffsets.Count}");

        return shapeOffsets;
    }
```

Compute which tiles a shape overlaps with, returning offset positions.
Delegates to CollisionGeometryUtils to compute polygon→tile offsets.
This ensures identical behavior to polygon processing and fixes missing edge tiles.

**Returns:** `List<Vector2I>`

**Parameters:**
- `Shape2D shape`
- `Transform2D shapeTransform`
- `TileMapLayer map`
- `Vector2 tileSize`
- `float shapeEpsilon`
- `Vector2I startTile`
- `Vector2I endExclusive`
- `Vector2I centerTile`
- `Vector2[] shapePolygon`

