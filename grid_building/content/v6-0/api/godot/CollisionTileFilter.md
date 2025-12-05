---
title: "CollisionTileFilter"
description: "Helpers to normalize tile coverage and prune borderline tiles for mapper heuristics.
Keeps shape-size magic numbers out of the CollisionMapper by centralizing tile-range adjustments and pruning logic here."
weight: 20
url: "/gridbuilding/v6-0/api/godot/collisiontilefilter/"
---

# CollisionTileFilter

```csharp
GridBuilding.Godot.Systems.Placement.Utilities
class CollisionTileFilter
{
    // Members...
}
```

Helpers to normalize tile coverage and prune borderline tiles for mapper heuristics.
Keeps shape-size magic numbers out of the CollisionMapper by centralizing tile-range adjustments and pruning logic here.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Utilities/CollisionTileFilter.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Utilities`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### AdjustRectTileRange

```csharp
/// <summary>
    /// Adjust rectangle tile iteration bounds.
    /// Ensures even tile counts along any axis are expanded to the next odd count for
    /// symmetric coverage around the rectangle's world center tile.
    /// </summary>
    public static Dictionary<string, Vector2I> AdjustRectTileRange(
        Vector2 rectSize,
        Vector2 tileSize,
        Vector2I centerTile,
        Vector2I startTile,
        Vector2I endExclusive
    )
    {
        var tilesW = (int)Math.Ceiling(rectSize.X / tileSize.X);
        var tilesH = (int)Math.Ceiling(rectSize.Y / tileSize.Y);
        
        // Ensure odd counts: if even, increment span by 1 on the positive side
        if (tilesW % 2 == 0)
        {
            tilesW += 1;
        }
        if (tilesH % 2 == 0)
        {
            tilesH += 1;
        }

        var newStart = new Vector2I(
            centerTile.X - (int)Math.Floor(tilesW / 2.0),
            centerTile.Y - (int)Math.Floor(tilesH / 2.0)
        );

        var newEndExclusive = new Vector2I(newStart.X + tilesW, newStart.Y + tilesH);

        return new Dictionary<string, Vector2I>
        {
            { "start", newStart },
            { "end_exclusive", newEndExclusive }
        };
    }
```

Adjust rectangle tile iteration bounds.
Ensures even tile counts along any axis are expanded to the next odd count for
symmetric coverage around the rectangle's world center tile.

**Returns:** `Dictionary<string, Vector2I>`

**Parameters:**
- `Vector2 rectSize`
- `Vector2 tileSize`
- `Vector2I centerTile`
- `Vector2I startTile`
- `Vector2I endExclusive`

### CircleTileAllowed

```csharp
/// <summary>
    /// Circle tile pruning.
    /// Generic pruning based on the distance of the tile center from the circle center.
    /// Excludes extreme corner tiles whose centers lie beyond radius + half_tile allowance.
    /// </summary>
    public static bool CircleTileAllowed(
        Vector2 circleCenter, float radius, Vector2 tileCenter, Vector2 tileSize
    )
    {
        var allowance = radius + tileSize.X / 2.0f;
        return circleCenter.DistanceTo(tileCenter) <= allowance;
    }
```

Circle tile pruning.
Generic pruning based on the distance of the tile center from the circle center.
Excludes extreme corner tiles whose centers lie beyond radius + half_tile allowance.

**Returns:** `bool`

**Parameters:**
- `Vector2 circleCenter`
- `float radius`
- `Vector2 tileCenter`
- `Vector2 tileSize`

