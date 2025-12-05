---
title: "GridPositionerUtils"
description: "Static utility class for GridPositioner tile and movement helpers."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/gridpositionerutils/"
---

# GridPositionerUtils

```csharp
GridBuilding.Godot.Systems.GridTargeting.GridPositioner
class GridPositionerUtils
{
    // Members...
}
```

Static utility class for GridPositioner tile and movement helpers.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/GridPositioner/GridPositionerUtils.cs`  
**Namespace:** `GridBuilding.Godot.Systems.GridTargeting.GridPositioner`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetTileFromGlobalPosition

```csharp
#region Tile Conversion

    /// <summary>
    /// Convert global position to tile coordinates on the target map.
    /// </summary>
    /// <param name="globalPosition">Global position to convert</param>
    /// <param name="map">Target tile map</param>
    /// <returns>Tile coordinates</returns>
    public static Vector2I GetTileFromGlobalPosition(Vector2 globalPosition, TileMapLayer map)
    {
        var mapPosition = map.ToLocal(globalPosition);
        return map.LocalToMap(mapPosition);
    }
```

Convert global position to tile coordinates on the target map.

**Returns:** `Vector2I`

**Parameters:**
- `Vector2 globalPosition`
- `TileMapLayer map`

### MoveToTile

```csharp
#endregion

    #region Movement

    /// <summary>
    /// Move a node to a specific tile position.
    /// </summary>
    /// <param name="node">Node to move</param>
    /// <param name="tile">Target tile coordinates</param>
    /// <param name="map">Target tile map</param>
    /// <returns>OK if successful</returns>
    public static Error MoveToTile(Node2D node, Vector2I tile, TileMapLayer map)
    {
        var tilePos = map.ToGlobal(map.MapToLocal(tile));
        node.GlobalPosition = tilePos;
        return Error.Ok;
    }
```

Move a node to a specific tile position.

**Returns:** `Error`

**Parameters:**
- `Node2D node`
- `Vector2I tile`
- `TileMapLayer map`

### MovePositionerByTile

```csharp
/// <summary>
    /// Move the positioner by a specified number of tiles in a given direction.
    /// </summary>
    /// <param name="node">Node to move</param>
    /// <param name="direction">Direction vector (should be unit vector like Vector2.UP, etc.)</param>
    /// <param name="targetMap">Target tile map</param>
    /// <returns>OK if successful</returns>
    public static Error MovePositionerByTile(Node2D node, Vector2 direction, TileMapLayer targetMap)
    {
        var directionInt = new Vector2I((int)direction.X, (int)direction.Y);
        return MoveToTile(node, directionInt, targetMap);
    }
```

Move the positioner by a specified number of tiles in a given direction.

**Returns:** `Error`

**Parameters:**
- `Node2D node`
- `Vector2 direction`
- `TileMapLayer targetMap`

### ApplyRecentering

```csharp
#endregion

    #region Positioning

    /// <summary>
    /// Apply recentering logic to a positioner based on settings.
    /// </summary>
    /// <param name="positioner">The positioner to recenter</param>
    /// <param name="targetingSettings">Targeting settings</param>
    public static void ApplyRecentering(GridPositioner2D positioner, GridTargetingSettings targetingSettings)
    {
        if (targetingSettings == null || positioner?.TargetingState?.TargetMap == null)
            return;

        var targetMap = positioner.TargetingState.TargetMap;
        var decision = GridPositionerLogic.ComputeRecenterDecision(
            targetingSettings,
            false, // hasMouseWorld - would be passed from positioner
            Vector2.Zero // lastShownPosition - would be passed from positioner
        );

        switch (decision)
        {
            case GridPositionerLogic.RecenterDecision.ViewCenter:
                RecenterToViewCenter(positioner, targetMap);
                break;
            case GridPositionerLogic.RecenterDecision.MouseCursor:
                // Would need mouse world position from positioner
                break;
            case GridPositionerLogic.RecenterDecision.LastShown:
                // Would need last shown position from positioner
                break;
            case GridPositionerLogic.RecenterDecision.None:
            default:
                // No recentering
                break;
        }
    }
```

Apply recentering logic to a positioner based on settings.

**Returns:** `void`

**Parameters:**
- `GridPositioner2D positioner`
- `GridTargetingSettings targetingSettings`

### GetTileCenterWorld

```csharp
#endregion

    #region Utility

    /// <summary>
    /// Get the center position of a tile in world coordinates.
    /// </summary>
    /// <param name="tile">Tile coordinates</param>
    /// <param name="map">Target tile map</param>
    /// <returns>World position of tile center</returns>
    public static Vector2 GetTileCenterWorld(Vector2I tile, TileMapLayer map)
    {
        return map.ToGlobal(map.MapToLocal(tile));
    }
```

Get the center position of a tile in world coordinates.

**Returns:** `Vector2`

**Parameters:**
- `Vector2I tile`
- `TileMapLayer map`

### IsValidTile

```csharp
/// <summary>
    /// Check if a tile coordinate is valid for the given map.
    /// </summary>
    /// <param name="tile">Tile coordinates to check</param>
    /// <param name="map">Target tile map</param>
    /// <returns>True if tile is valid (within map bounds)</returns>
    public static bool IsValidTile(Vector2I tile, TileMapLayer map)
    {
        if (map == null)
            return false;

        // Check if the tile has any valid cell data
        var sourceId = map.GetCellSourceId(tile);
        return sourceId != -1;
    }
```

Check if a tile coordinate is valid for the given map.

**Returns:** `bool`

**Parameters:**
- `Vector2I tile`
- `TileMapLayer map`

### GetCardinalNeighbors

```csharp
/// <summary>
    /// Get neighboring tiles in the four cardinal directions.
    /// </summary>
    /// <param name="centerTile">Center tile coordinate</param>
    /// <returns>Array of neighboring tile coordinates</returns>
    public static Vector2I[] GetCardinalNeighbors(Vector2I centerTile)
    {
        return new Vector2I[]
        {
            centerTile + Vector2I.Up,    // North
            centerTile + Vector2I.Right, // East
            centerTile + Vector2I.Down,  // South
            centerTile + Vector2I.Left  // West
        };
    }
```

Get neighboring tiles in the four cardinal directions.

**Returns:** `Vector2I[]`

**Parameters:**
- `Vector2I centerTile`

### GetAllNeighbors

```csharp
/// <summary>
    /// Get neighboring tiles in all eight directions (including diagonals).
    /// </summary>
    /// <param name="centerTile">Center tile coordinate</param>
    /// <returns>Array of neighboring tile coordinates</returns>
    public static Vector2I[] GetAllNeighbors(Vector2I centerTile)
    {
        return new Vector2I[]
        {
            centerTile + Vector2I.Up,        // North
            centerTile + Vector2I.Up + Vector2I.Right, // Northeast
            centerTile + Vector2I.Right,     // East
            centerTile + Vector2I.Down + Vector2I.Right, // Southeast
            centerTile + Vector2I.Down,      // South
            centerTile + Vector2I.Down + Vector2I.Left, // Southwest
            centerTile + Vector2I.Left,      // West
            centerTile + Vector2I.Up + Vector2I.Left  // Northwest
        };
    }
```

Get neighboring tiles in all eight directions (including diagonals).

**Returns:** `Vector2I[]`

**Parameters:**
- `Vector2I centerTile`

### GetTileDistance

```csharp
/// <summary>
    /// Calculate distance between two tile coordinates.
    /// </summary>
    /// <param name="tileA">First tile coordinate</param>
    /// <param name="tileB">Second tile coordinate</param>
    /// <returns>Manhattan distance between tiles</returns>
    public static int GetTileDistance(Vector2I tileA, Vector2I tileB)
    {
        return Mathf.Abs(tileA.X - tileB.X) + Mathf.Abs(tileA.Y - tileB.Y);
    }
```

Calculate distance between two tile coordinates.

**Returns:** `int`

**Parameters:**
- `Vector2I tileA`
- `Vector2I tileB`

### GetTileDistanceEuclidean

```csharp
/// <summary>
    /// Calculate Euclidean distance between two tile coordinates.
    /// </summary>
    /// <param name="tileA">First tile coordinate</param>
    /// <param name="tileB">Second tile coordinate</param>
    /// <returns>Euclidean distance between tile centers</returns>
    public static float GetTileDistanceEuclidean(Vector2I tileA, Vector2I tileB, TileMapLayer map)
    {
        if (map == null)
            return 0f;

        var worldA = GetTileCenterWorld(tileA, map);
        var worldB = GetTileCenterWorld(tileB, map);
        return worldA.DistanceTo(worldB);
    }
```

Calculate Euclidean distance between two tile coordinates.

**Returns:** `float`

**Parameters:**
- `Vector2I tileA`
- `Vector2I tileB`
- `TileMapLayer map`

