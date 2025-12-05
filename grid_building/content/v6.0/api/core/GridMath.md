---
title: "GridMath"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/gridmath/"
---

# GridMath

```csharp
GridBuilding.Core.Grid
class GridMath
{
    // Members...
}
```

Static utility class for grid-based mathematical operations.
Provides POCS implementation of grid positioning logic without Godot dependencies.
Supports coordinate conversion, tile-based movement, and grid geometry calculations.
Ported from: godot/addons/grid_building/shared/utils/positioning/gb_positioning_2d_utils.gd

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Math/GridMath.cs`  
**Namespace:** `GridBuilding.Core.Grid`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### WorldToGrid

```csharp
/// <summary>
    /// Convert a world position to tile coordinates.
    /// </summary>
    /// <param name="worldPosition">The world position to convert</param>
    /// <param name="tileSize">Size of each tile in world units</param>
    /// <returns>Grid position representing the tile coordinates</returns>
    public static GridPosition WorldToGrid(Vector2 worldPosition, Vector2 tileSize)
    {
        return GridPosition.FromWorldCoordinates(worldPosition, tileSize);
    }
```

Convert a world position to tile coordinates.

**Returns:** `GridPosition`

**Parameters:**
- `Vector2 worldPosition`
- `Vector2 tileSize`

### GridToWorld

```csharp
/// <summary>
    /// Convert grid coordinates to world position (tile center).
    /// </summary>
    /// <param name="gridPosition">The grid position to convert</param>
    /// <returns>World position at the center of the tile</returns>
    public static Vector2 GridToWorld(GridPosition gridPosition)
    {
        return gridPosition.ToWorldCoordinates(gridPosition.TileSize);
    }
```

Convert grid coordinates to world position (tile center).

**Returns:** `Vector2`

**Parameters:**
- `GridPosition gridPosition`

### GridToWorld

```csharp
/// <summary>
    /// Convert grid coordinates to world position with custom tile size.
    /// </summary>
    /// <param name="gridPosition">The grid position to convert</param>
    /// <param name="tileSize">Custom tile size</param>
    /// <returns>World position at the center of the tile</returns>
    public static Vector2 GridToWorld(GridPosition gridPosition, Vector2 tileSize)
    {
        return gridPosition.ToWorldCoordinates(tileSize);
    }
```

Convert grid coordinates to world position with custom tile size.

**Returns:** `Vector2`

**Parameters:**
- `GridPosition gridPosition`
- `Vector2 tileSize`

### SnapToTileCenter

```csharp
/// <summary>
    /// Snap a world position to the nearest tile center.
    /// </summary>
    /// <param name="worldPosition">World position to snap</param>
    /// <param name="tileSize">Size of each tile</param>
    /// <returns>Snapped world position</returns>
    public static Vector2 SnapToTileCenter(Vector2 worldPosition, Vector2 tileSize)
    {
        var gridPos = WorldToGrid(worldPosition, tileSize);
        return GridToWorld(gridPos, tileSize);
    }
```

Snap a world position to the nearest tile center.

**Returns:** `Vector2`

**Parameters:**
- `Vector2 worldPosition`
- `Vector2 tileSize`

### GetTileBounds

```csharp
/// <summary>
    /// Calculate the tile bounds (rectangular area) for a given grid position.
    /// </summary>
    /// <param name="gridPosition">Grid position</param>
    /// <param name="tileSize">Size of each tile</param>
    /// <returns>Rectangle representing the tile bounds in world coordinates</returns>
    public static Rect2 GetTileBounds(GridPosition gridPosition, Vector2 tileSize)
    {
        var worldPos = gridPosition.ToWorldCoordinates(tileSize);
        var halfSize = tileSize * 0.5f;
        return new Rect2(worldPos - halfSize, tileSize);
    }
```

Calculate the tile bounds (rectangular area) for a given grid position.

**Returns:** `Rect2`

**Parameters:**
- `GridPosition gridPosition`
- `Vector2 tileSize`

### IsPositionInTile

```csharp
/// <summary>
    /// Check if a world position is within the bounds of a specific tile.
    /// </summary>
    /// <param name="worldPosition">World position to check</param>
    /// <param name="gridPosition">Grid position of the tile</param>
    /// <param name="tileSize">Size of each tile</param>
    /// <returns>True if the world position is within the tile bounds</returns>
    public static bool IsPositionInTile(Vector2 worldPosition, GridPosition gridPosition, Vector2 tileSize)
    {
        var tileBounds = GetTileBounds(gridPosition, tileSize);
        return tileBounds.HasPoint(worldPosition);
    }
```

Check if a world position is within the bounds of a specific tile.

**Returns:** `bool`

**Parameters:**
- `Vector2 worldPosition`
- `GridPosition gridPosition`
- `Vector2 tileSize`

### GetTileAtPosition

```csharp
/// <summary>
    /// Get the tile at a world position.
    /// </summary>
    /// <param name="worldPosition">World position</param>
    /// <param name="tileSize">Size of each tile</param>
    /// <returns>Grid position of the tile containing the world position</returns>
    public static GridPosition GetTileAtPosition(Vector2 worldPosition, Vector2 tileSize)
    {
        return WorldToGrid(worldPosition, tileSize);
    }
```

Get the tile at a world position.

**Returns:** `GridPosition`

**Parameters:**
- `Vector2 worldPosition`
- `Vector2 tileSize`

### GridDistanceToWorld

```csharp
/// <summary>
    /// Calculate the distance between two grid positions in world units.
    /// </summary>
    /// <param name="from">Starting grid position</param>
    /// <param name="to">Target grid position</param>
    /// <returns>Distance in world units</returns>
    public static float GridDistanceToWorld(GridPosition from, GridPosition to)
    {
        var fromWorld = GridToWorld(from);
        var toWorld = GridToWorld(to);
        return fromWorld.DistanceTo(toWorld);
    }
```

Calculate the distance between two grid positions in world units.

**Returns:** `float`

**Parameters:**
- `GridPosition from`
- `GridPosition to`

### LimitToMaxDistance

```csharp
/// <summary>
    /// Limit a target tile to be within maximum distance from source tile.
    /// </summary>
    /// <param name="source">Source grid position</param>
    /// <param name="target">Target grid position to limit</param>
    /// <param name="maxDistance">Maximum allowed distance in tiles</param>
    /// <param name="useManhattanDistance">If true, use Manhattan distance; if false, use Chebyshev distance</param>
    /// <returns>Limited grid position</returns>
    public static GridPosition LimitToMaxDistance(
        GridPosition source, 
        GridPosition target, 
        int maxDistance, 
        bool useManhattanDistance = true)
    {
        var distance = useManhattanDistance 
            ? source.ManhattanDistanceTo(target) 
            : source.ChebyshevDistanceTo(target);
        
        if (distance <= maxDistance)
            return target;
        
        // Find the farthest position within max distance
        var direction = target - source;
        var limitedPos = source;
        
        // Normalize direction and scale to max distance
        if (useManhattanDistance)
        {
            // For Manhattan distance, we move step by step
            var steps = maxDistance;
            var current = source;
            
            for (int i = 0; i < steps; i++)
            {
                var next = current;
                if (direction.X > 0) next = new GridPosition(current.X + 1, current.Y, current.TileSize);
                else if (direction.X < 0) next = new GridPosition(current.X - 1, current.Y, current.TileSize);
                else if (direction.Y > 0) next = new GridPosition(current.X, current.Y + 1, current.TileSize);
                else if (direction.Y < 0) next = new GridPosition(current.X, current.Y - 1, current.TileSize);
                
                if (next.ManhattanDistanceTo(source) > maxDistance) break;
                current = next;
                
                // If we've reached or passed the target direction, try diagonal
                if (i < steps - 1 && direction.X != 0 && direction.Y != 0)
                {
                    var diagonal = new GridPosition(
                        current.X + System.Math.Sign(direction.X), 
                        current.Y + System.Math.Sign(direction.Y), 
                        current.TileSize);
                    
                    if (diagonal.ManhattanDistanceTo(source) <= maxDistance)
                        current = diagonal;
                }
            }
            
            limitedPos = current;
        }
        else
        {
            // For Chebyshev distance, we can move directly
            var normalizedDir = new Vector2I(
                System.Math.Sign(direction.X), 
                System.Math.Sign(direction.Y));
            
            limitedPos = new GridPosition(
                source.X + normalizedDir.X * maxDistance,
                source.Y + normalizedDir.Y * maxDistance,
                source.TileSize);
        }
        
        return limitedPos;
    }
```

Limit a target tile to be within maximum distance from source tile.

**Returns:** `GridPosition`

**Parameters:**
- `GridPosition source`
- `GridPosition target`
- `int maxDistance`
- `bool useManhattanDistance`

### SnapToRegion

```csharp
/// <summary>
    /// Snap a grid position to be within a rectangular region.
    /// </summary>
    /// <param name="position">Position to snap</param>
    /// <param name="regionMin">Minimum bounds of region</param>
    /// <param name="regionMax">Maximum bounds of region</param>
    /// <returns>Snapped grid position</returns>
    public static GridPosition SnapToRegion(GridPosition position, GridPosition regionMin, GridPosition regionMax)
    {
        return position.Clamp(regionMin, regionMax);
    }
```

Snap a grid position to be within a rectangular region.

**Returns:** `GridPosition`

**Parameters:**
- `GridPosition position`
- `GridPosition regionMin`
- `GridPosition regionMax`

### IsValidPosition

```csharp
/// <summary>
    /// Check if a grid position is within a used rectangle.
    /// </summary>
    /// <param name="position">Position to check</param>
    /// <param name="usedRect">Rectangle representing used tiles (x, y, width, height)</param>
    /// <returns>True if position is within the used rectangle</returns>
    public static bool IsValidPosition(GridPosition position, (int x, int y, int width, int height) usedRect)
    {
        return position.X >= usedRect.x && 
               position.X < usedRect.x + usedRect.width &&
               position.Y >= usedRect.y && 
               position.Y < usedRect.y + usedRect.height;
    }
```

Check if a grid position is within a used rectangle.

**Returns:** `bool`

**Parameters:**
- `GridPosition position`
- `(int x, int y, int width, int height) usedRect`

### IsValidPosition

```csharp
/// <summary>
    /// Check if a grid position is valid within bounds.
    /// </summary>
    /// <param name="position">Position to check</param>
    /// <param name="minBounds">Minimum bounds</param>
    /// <param name="maxBounds">Maximum bounds</param>
    /// <returns>True if position is within bounds</returns>
    public static bool IsValidPosition(GridPosition position, Vector2I minBounds, Vector2I maxBounds)
    {
        return position.X >= minBounds.X && 
               position.X < maxBounds.X &&
               position.Y >= minBounds.Y && 
               position.Y < maxBounds.Y;
    }
```

Check if a grid position is valid within bounds.

**Returns:** `bool`

**Parameters:**
- `GridPosition position`
- `Vector2I minBounds`
- `Vector2I maxBounds`

### GetRegionCenter

```csharp
/// <summary>
    /// Get the center position of a rectangular region.
    /// </summary>
    /// <param name="regionMin">Minimum bounds of region</param>
    /// <param name="regionMax">Maximum bounds of region</param>
    /// <returns>Center grid position</returns>
    public static GridPosition GetRegionCenter(GridPosition regionMin, GridPosition regionMax)
    {
        return new GridPosition(
            (regionMin.X + regionMax.X) / 2,
            (regionMin.Y + regionMax.Y) / 2,
            regionMin.TileSize);
    }
```

Get the center position of a rectangular region.

**Returns:** `GridPosition`

**Parameters:**
- `GridPosition regionMin`
- `GridPosition regionMax`

### GetRegionArea

```csharp
/// <summary>
    /// Calculate the area of a rectangular region in tiles.
    /// </summary>
    /// <param name="regionMin">Minimum bounds of region</param>
    /// <param name="regionMax">Maximum bounds of region</param>
    /// <returns>Area in number of tiles</returns>
    public static int GetRegionArea(GridPosition regionMin, GridPosition regionMax)
    {
        var width = System.Math.Abs(regionMax.X - regionMin.X) + 1;
        var height = System.Math.Abs(regionMax.Y - regionMin.Y) + 1;
        return width * height;
    }
```

Calculate the area of a rectangular region in tiles.

**Returns:** `int`

**Parameters:**
- `GridPosition regionMin`
- `GridPosition regionMax`

### GetRegionPositions

```csharp
/// <summary>
    /// Get all positions in a rectangular region.
    /// </summary>
    /// <param name="regionMin">Minimum bounds of region</param>
    /// <param name="regionMax">Maximum bounds of region</param>
    /// <returns>Enumerable of all grid positions in the region</returns>
    public static IEnumerable<GridPosition> GetRegionPositions(GridPosition regionMin, GridPosition regionMax)
    {
        for (var x = regionMin.X; x <= regionMax.X; x++)
        {
            for (var y = regionMin.Y; y <= regionMax.Y; y++)
            {
                yield return new GridPosition(x, y, regionMin.TileSize);
            }
        }
    }
```

Get all positions in a rectangular region.

**Returns:** `IEnumerable<GridPosition>`

**Parameters:**
- `GridPosition regionMin`
- `GridPosition regionMax`

### RegionsOverlap

```csharp
/// <summary>
    /// Check if two rectangular regions overlap.
    /// </summary>
    /// <param name="min1">Minimum bounds of first region</param>
    /// <param name="max1">Maximum bounds of first region</param>
    /// <param name="min2">Minimum bounds of second region</param>
    /// <param name="max2">Maximum bounds of second region</param>
    /// <returns>True if regions overlap</returns>
    public static bool RegionsOverlap(GridPosition min1, GridPosition max1, GridPosition min2, GridPosition max2)
    {
        return !(max1.X < min2.X || min1.X > max2.X || max1.Y < min2.Y || min1.Y > max2.Y);
    }
```

Check if two rectangular regions overlap.

**Returns:** `bool`

**Parameters:**
- `GridPosition min1`
- `GridPosition max1`
- `GridPosition min2`
- `GridPosition max2`

### GetOverlapRegion

```csharp
/// <summary>
    /// Get the overlapping region between two rectangular regions.
    /// </summary>
    /// <param name="min1">Minimum bounds of first region</param>
    /// <param name="max1">Maximum bounds of first region</param>
    /// <param name="min2">Minimum bounds of second region</param>
    /// <param name="max2">Maximum bounds of second region</param>
    /// <returns>Overlapping region as (min, max) tuple, or null if no overlap</returns>
    public static (GridPosition min, GridPosition max)? GetOverlapRegion(
        GridPosition min1, GridPosition max1, GridPosition min2, GridPosition max2)
    {
        if (!RegionsOverlap(min1, max1, min2, max2))
            return null;
        
        var overlapMin = new GridPosition(
            System.Math.Max(min1.X, min2.X),
            System.Math.Max(min1.Y, min2.Y),
            min1.TileSize);
        
        var overlapMax = new GridPosition(
            System.Math.Min(max1.X, max2.X),
            System.Math.Min(max1.Y, max2.Y),
            min1.TileSize);
        
        return (overlapMin, overlapMax);
    }
```

Get the overlapping region between two rectangular regions.

**Returns:** `(GridPosition min, GridPosition max)?`

**Parameters:**
- `GridPosition min1`
- `GridPosition max1`
- `GridPosition min2`
- `GridPosition max2`

### GridRectToWorld

```csharp
/// <summary>
    /// Convert a grid-based rectangle to world coordinates.
    /// </summary>
    /// <param name="gridMin">Minimum grid position</param>
    /// <param name="gridMax">Maximum grid position</param>
    /// <param name="tileSize">Size of each tile</param>
    /// <returns>Rectangle in world coordinates</returns>
    public static Rect2 GridRectToWorld(GridPosition gridMin, GridPosition gridMax, Vector2 tileSize)
    {
        var worldMin = GridToWorld(gridMin, tileSize) - tileSize * 0.5f;
        var worldMax = GridToWorld(gridMax, tileSize) + tileSize * 0.5f;
        var size = worldMax - worldMin;
        return new Rect2(worldMin, size);
    }
```

Convert a grid-based rectangle to world coordinates.

**Returns:** `Rect2`

**Parameters:**
- `GridPosition gridMin`
- `GridPosition gridMax`
- `Vector2 tileSize`

### WorldRectToGrid

```csharp
/// <summary>
    /// Convert a world rectangle to grid coordinates.
    /// </summary>
    /// <param name="worldRect">Rectangle in world coordinates</param>
    /// <param name="tileSize">Size of each tile</param>
    /// <returns>Rectangle in grid coordinates as (min, max) tuple</returns>
    public static (GridPosition min, GridPosition max) WorldRectToGrid(Rect2 worldRect, Vector2 tileSize)
    {
        var gridMin = WorldToGrid(worldRect.Position, tileSize);
        var gridMax = WorldToGrid(worldRect.End, tileSize);
        return (gridMin, gridMax);
    }
```

Convert a world rectangle to grid coordinates.

**Returns:** `(GridPosition min, GridPosition max)`

**Parameters:**
- `Rect2 worldRect`
- `Vector2 tileSize`

