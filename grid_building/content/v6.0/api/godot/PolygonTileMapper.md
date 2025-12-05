---
title: "PolygonTileMapper"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/polygontilemapper/"
---

# PolygonTileMapper

```csharp
GridBuilding.Godot.Systems.Placement.Processors
class PolygonTileMapper
{
    // Members...
}
```

Handles polygon-to-tile-offset conversion with testable, separated concerns.
C# implementation of GDScript PolygonTileMapper

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Processors/PolygonTileMapper.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Processors`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ComputeTileOffsets

```csharp
/// <summary>
    /// Primary entry point for polygon-to-tile conversion (runtime optimized)
    /// </summary>
    public static List<Vector2I> ComputeTileOffsets(
        CollisionPolygon2D? polygonNode, TileMapLayer? map)
    {
        // Early validation
        if (polygonNode == null || map == null || map.TileSet == null)
            return new List<Vector2I>();

        // Convert the polygon's global position into the TileMap's local space before mapping to tile coords.
        // This maintains correctness when the TileMap has a transform (common in isometric setups).
        var centerTile = map.LocalToMap(map.ToLocal(polygonNode.GlobalPosition));
        return ComputeTileOffsetsInternal(polygonNode, map, centerTile);
    }
```

Primary entry point for polygon-to-tile conversion (runtime optimized)

**Returns:** `List<Vector2I>`

**Parameters:**
- `CollisionPolygon2D? polygonNode`
- `TileMapLayer? map`

### ComputeTileOffsetsWithPositioner

```csharp
/// <summary>
    /// Primary entry point with positioner reference for consistent positioning
    /// Uses positioner's position as coordinate reference instead of polygon's position
    /// </summary>
    public static List<Vector2I> ComputeTileOffsetsWithPositioner(
        CollisionPolygon2D? polygonNode, TileMapLayer? map, Node2D? positioner)
    {
        // Early validation
        if (polygonNode == null || map == null || map.TileSet == null || positioner == null)
            return new List<Vector2I>();

        // CRITICAL: Use positioner position as coordinate reference for consistency
        var centerTile = map.LocalToMap(map.ToLocal(positioner.GlobalPosition));
        return ComputeTileOffsetsInternal(polygonNode, map, centerTile);
    }
```

Primary entry point with positioner reference for consistent positioning
Uses positioner's position as coordinate reference instead of polygon's position

**Returns:** `List<Vector2I>`

**Parameters:**
- `CollisionPolygon2D? polygonNode`
- `TileMapLayer? map`
- `Node2D? positioner`

### GetPolygonTileOverlapArea

```csharp
/// <summary>
    /// Calculate overlap area between polygon and rectangle
    /// </summary>
    public static float GetPolygonTileOverlapArea(List<Vector2> polygon, Rect2 rect)
    {
        if (polygon.Count == 0)
            return 0.0f;

        // Quick bounds check
        var polyBounds = ComputePolygonBounds(polygon);
        if (!polyBounds.Intersects(rect, true))
            return 0.0f;

        // Special case: if polygon is a perfect rectangle matching the tile rect
        if (polygon.Count == 4)
        {
            // Simple implementation - assume full overlap if bounds intersect
            return rect.Size.X * rect.Size.Y;
        }

        // Simplified implementation - return approximate overlap
        // Real implementation would use polygon clipping algorithms
        var overlapArea = CalculateSimpleOverlap(polygon, rect);
        return overlapArea;
    }
```

Calculate overlap area between polygon and rectangle

**Returns:** `float`

**Parameters:**
- `List<Vector2> polygon`
- `Rect2 rect`

