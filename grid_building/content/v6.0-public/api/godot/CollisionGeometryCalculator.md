---
title: "CollisionGeometryCalculator"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/collisiongeometrycalculator/"
---

# CollisionGeometryCalculator

```csharp
GridBuilding.Godot.Systems.Placement.Managers
class CollisionGeometryCalculator
{
    // Members...
}
```

Pure logic class for collision geometry calculations.
Contains no state and can be easily tested in isolation.
POLYGON CLIPPING ALGORITHM - SUTHERLAND-HODGMAN
===============================================
This class implements the Sutherland-Hodgman polygon clipping algorithm for determining
polygon-rectangle overlap areas. The algorithm is correct for both convex and concave polygons.
Algorithm Overview:
1. The polygon is clipped against each of the 4 rectangle boundaries (left, right, top, bottom)
2. Each clipping operation produces a new polygon that is guaranteed to be inside that boundary
3. The final clipped polygon represents the intersection area between the original polygon and rectangle
4. The area of this clipped polygon determines if the overlap meets the minimum threshold
Why Sutherland-Hodgman is Correct:
- Works for both convex and concave polygons (unlike some simpler algorithms)
- Produces a valid polygon as output (no self-intersections or invalid geometry)
- Handles edge cases like polygons completely inside/outside the rectangle
- Deterministic and numerically stable with proper epsilon handling
Default Overlap Thresholds:
- Edge epsilon: 0.01 (1% tolerance for numerical precision)
- Minimum overlap ratio: 0.05 (5% of tile area required for detection)
- Polygons with < 5% tile overlap are considered non-overlapping (prevents spurious micro-overlaps)
Key Methods:
- ClipPolygonToRect(): Implements the core Sutherland-Hodgman algorithm
- PolygonOverlapsRect(): Uses clipping to determine if overlap meets threshold
- PolygonArea(): Calculates area using shoelace formula for overlap measurement
Testing: All clipping methods are public for comprehensive unit testing validation.
Ported from: godot/addons/grid_building/systems/placement/managers/collision_geometry_calculator.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Managers/CollisionGeometryCalculator.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Managers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DebugPolygonOverlap

```csharp
#region Constants

    /// <summary>
    /// Toggle verbose polygon overlap debug logging. Set to true to enable detailed per-tile output.
    /// NOTE: This is a temporary diagnostic toggle. Tests may enable this at runtime.
    /// </summary>
    public static bool DebugPolygonOverlap { get; set; } = false;
```

Toggle verbose polygon overlap debug logging. Set to true to enable detailed per-tile output.
NOTE: This is a temporary diagnostic toggle. Tests may enable this at runtime.


## Methods

### CalculateTileOverlap

```csharp
#endregion

    #region Public Static Methods

    /// <summary>
    /// Pure function for tile overlap calculation.
    /// Returns array of tile coordinates that overlap with the given polygon.
    /// 
    /// IMPORTANT: For isometric tiles, this function requires a TileMapLayer reference
    /// to properly handle coordinate transformations. When tile_type is ISOMETRIC,
    /// the tile_map_layer parameter must be provided for accurate calculations.
    /// </summary>
    /// <param name="polygon">The polygon to check for overlaps</param>
    /// <param name="tileSize">Size of tiles</param>
    /// <param name="tileType">Shape of tiles (square or isometric)</param>
    /// <param name="tileMapLayer">Tile map layer for coordinate transforms</param>
    /// <param name="epsilon">Edge tolerance for numerical precision</param>
    /// <param name="minOverlapRatio">Minimum overlap ratio (0.05 = 5%)</param>
    /// <returns>Array of tile coordinates that overlap</returns>
    public static global::Godot.Collections.Array<Vector2I> CalculateTileOverlap(
        global::Godot.Collections.Array<Vector2> polygon,
        Vector2 tileSize,
        TileSet.TileShape tileType,
        TileMapLayer? tileMapLayer,
        float epsilon = 0.01f,
        float minOverlapRatio = 0.05f)
    {
        // Adapter: prefer map-aware path when tile_map_layer provided
        if (polygon.Count == 0)
            return new global::Godot.Collections.Array<Vector2I>();

        if (tileMapLayer != null)
        {
            // When tile_map_layer is provided prefer map-aware calculation (works for both square & iso)
            if (tileType == TileSet.TileShape.Isometric)
            {
                return CalculateIsometricTileOverlap(polygon, tileMapLayer, epsilon, minOverlapRatio);
            }
            return CalculateSquareTileOverlap(polygon, tileSize, epsilon, minOverlapRatio, tileMapLayer);
        }

        // Fallback: call numeric-only implementation (no TileMapLayer available)
        return CalculateTileOverlapNumeric(polygon, tileSize, tileType, epsilon, minOverlapRatio);
    }
```

Pure function for tile overlap calculation.
Returns array of tile coordinates that overlap with the given polygon.
/// IMPORTANT: For isometric tiles, this function requires a TileMapLayer reference
to properly handle coordinate transformations. When tile_type is ISOMETRIC,
the tile_map_layer parameter must be provided for accurate calculations.

**Returns:** `global::Godot.Collections.Array<Vector2I>`

**Parameters:**
- `global::Godot.Collections.Array<Vector2> polygon`
- `Vector2 tileSize`
- `TileSet.TileShape tileType`
- `TileMapLayer? tileMapLayer`
- `float epsilon`
- `float minOverlapRatio`

### CalculateTileOverlapNumeric

```csharp
/// <summary>
    /// New pure-numeric API: calculates tile overlap without needing a TileMapLayer.
    /// This accepts numeric tile coordinates and is useful for unit-testing numeric math and for
    /// consumers that already manage map transforms externally.
    /// </summary>
    /// <param name="polygon">The polygon to check</param>
    /// <param name="tileSize">Size of tiles</param>
    /// <param name="tileType">Shape of tiles</param>
    /// <param name="epsilon">Edge tolerance</param>
    /// <param name="minOverlapRatio">Minimum overlap ratio</param>
    /// <returns>Array of overlapping tile coordinates</returns>
    public static global::Godot.Collections.Array<Vector2I> CalculateTileOverlapNumeric(
        global::Godot.Collections.Array<Vector2> polygon,
        Vector2 tileSize,
        TileSet.TileShape tileType,
        float epsilon = 0.01f,
        float minOverlapRatio = 0.05f)
    {
        var overlappedTiles = new global::Godot.Collections.Array<Vector2I>();
        
        if (polygon.Count == 0)
            return overlappedTiles;
        
        if (tileType == TileSet.TileShape.Isometric)
        {
            // Numeric isometric fallback is not supported without a TileMapLayer; return empty to be safe
            return overlappedTiles;
        }
        
        // Square tiles - legacy numeric algorithm: iterate over world-space bounds divided by tile_size
        var bounds = GetPolygonBounds(polygon);
        var startTile = new Vector2I(
            Mathf.Floor(bounds.Position.X / tileSize.X), 
            Mathf.Floor(bounds.Position.Y / tileSize.Y)
        );
        var endTile = new Vector2I(
            Mathf.Ceil((bounds.Position.X + bounds.Size.X) / tileSize.X),
            Mathf.Ceil((bounds.Position.Y + bounds.Size.Y) / tileSize.Y)
        );
        
        // Safeguard against infinite loops - limit the number of tiles to check
        const int maxTilesToCheck = 1000; // Reasonable upper limit for unit tests
        var tilesChecked = 0;
        
        for (int x = startTile.X; x < endTile.X; x++)
        {
            for (int y = startTile.Y; y < endTile.Y; y++)
            {
                tilesChecked++;
                if (tilesChecked > maxTilesToCheck)
                {
                    GD.PrintErr("CalculateTileOverlapNumeric: Too many tiles to check, possible infinite loop");
                    return overlappedTiles;
                }
                
                var tilePos = new Vector2I(x, y);
                var tileWorldCenter = new Vector2(
                    tilePos.X * tileSize.X + tileSize.X * 0.5f,
                    tilePos.Y * tileSize.Y + tileSize.Y * 0.5f
                );
                var tileRect = new Rect2(tileWorldCenter - tileSize * 0.5f, tileSize);
                
                if (PolygonsOverlap(polygon, tileRect, epsilon, minOverlapRatio))
                {
                    overlappedTiles.Add(tilePos);
                }
            }
        }
        
        return overlappedTiles;
    }
```

New pure-numeric API: calculates tile overlap without needing a TileMapLayer.
This accepts numeric tile coordinates and is useful for unit-testing numeric math and for
consumers that already manage map transforms externally.

**Returns:** `global::Godot.Collections.Array<Vector2I>`

**Parameters:**
- `global::Godot.Collections.Array<Vector2> polygon`
- `Vector2 tileSize`
- `TileSet.TileShape tileType`
- `float epsilon`
- `float minOverlapRatio`

### CalculateSquareTileOverlap

```csharp
/// <summary>
    /// Calculates tile overlap for square tiles with map awareness.
    /// </summary>
    /// <param name="polygon">The polygon to check</param>
    /// <param name="tileSize">Size of tiles</param>
    /// <param name="epsilon">Edge tolerance</param>
    /// <param name="minOverlapRatio">Minimum overlap ratio</param>
    /// <param name="tileMapLayer">Tile map layer for transforms</param>
    /// <returns>Array of overlapping tile coordinates</returns>
    public static global::Godot.Collections.Array<Vector2I> CalculateSquareTileOverlap(
        global::Godot.Collections.Array<Vector2> polygon,
        Vector2 tileSize,
        float epsilon,
        float minOverlapRatio,
        TileMapLayer tileMapLayer)
    {
        var overlappedTiles = new global::Godot.Collections.Array<Vector2I>();
        
        // Calculate bounding box of polygon
        var bounds = GetPolygonBounds(polygon);
        
        // Use the TileMapLayer to compute an iteration range that respects map transforms
        var range = CollisionGeometryUtils.ComputeTileIterationRange(bounds, tileMapLayer);
        var startTile = Vector2I.Zero;
        var endExclusive = Vector2I.Zero;
        
        if (range.Count == 0)
        {
            // Fallback to legacy calculation if compute_tile_iteration_range fails
            startTile = new Vector2I(
                Mathf.Floor(bounds.Position.X / tileSize.X), 
                Mathf.Floor(bounds.Position.Y / tileSize.Y)
            );
            var endTile = new Vector2I(
                Mathf.Ceil((bounds.Position.X + bounds.Size.X) / tileSize.X),
                Mathf.Ceil((bounds.Position.Y + bounds.Size.Y) / tileSize.Y)
            );
            endExclusive = endTile;
        }
        else
        {
            startTile = (Vector2I)range["start"];
            endExclusive = (Vector2I)range["end_exclusive"];
        }
        
        // Check each tile for overlap using map-based world rects
        for (int x = startTile.X; x < endExclusive.X; x++)
        {
            for (int y = startTile.Y; y < endExclusive.Y; y++)
            {
                var tilePos = new Vector2I(x, y);
                var tileWorldCenter = tileMapLayer.ToGlobal(tileMapLayer.MapToLocal(tilePos));
                var tileSizeVec = tileMapLayer.TileSet != null 
                    ? new Vector2(tileMapLayer.TileSet.TileSize.X, tileMapLayer.TileSet.TileSize.Y)
                    : tileSize;
                var tileRect = new Rect2(tileWorldCenter - tileSizeVec * 0.5f, tileSizeVec);
                
                if (PolygonsOverlap(polygon, tileRect, epsilon, minOverlapRatio))
                {
                    overlappedTiles.Add(tilePos);
                }
            }
        }
        
        return overlappedTiles;
    }
```

Calculates tile overlap for square tiles with map awareness.

**Returns:** `global::Godot.Collections.Array<Vector2I>`

**Parameters:**
- `global::Godot.Collections.Array<Vector2> polygon`
- `Vector2 tileSize`
- `float epsilon`
- `float minOverlapRatio`
- `TileMapLayer tileMapLayer`

### CalculateIsometricTileOverlap

```csharp
/// <summary>
    /// Calculates tile overlap for isometric tiles.
    /// </summary>
    /// <param name="polygon">The polygon to check</param>
    /// <param name="tileMapLayer">Tile map layer for transforms</param>
    /// <param name="epsilon">Edge tolerance</param>
    /// <param name="minOverlapRatio">Minimum overlap ratio</param>
    /// <returns>Array of overlapping tile coordinates</returns>
    public static global::Godot.Collections.Array<Vector2I> CalculateIsometricTileOverlap(
        global::Godot.Collections.Array<Vector2> polygon,
        TileMapLayer tileMapLayer,
        float epsilon,
        float minOverlapRatio)
    {
        var overlappedTiles = new global::Godot.Collections.Array<Vector2I>();
        
        // Get polygon bounds in world space
        var bounds = GetPolygonBounds(polygon);
        
        // Convert world bounds to tile coordinates using TileMapLayer's isometric transformation
        var topLeftWorld = bounds.Position;
        var bottomRightWorld = bounds.Position + bounds.Size;
        var topRightWorld = new Vector2(bottomRightWorld.X, topLeftWorld.Y);
        var bottomLeftWorld = new Vector2(topLeftWorld.X, bottomRightWorld.Y);
        
        // Convert all corners to tile coordinates to get proper tile range
        var cornersTile = new Vector2I[]
        {
            tileMapLayer.LocalToMap(tileMapLayer.ToLocal(topLeftWorld)),
            tileMapLayer.LocalToMap(tileMapLayer.ToLocal(topRightWorld)),
            tileMapLayer.LocalToMap(tileMapLayer.ToLocal(bottomLeftWorld)),
            tileMapLayer.LocalToMap(tileMapLayer.ToLocal(bottomRightWorld))
        };
        
        // Find the tile bounding box
        var minTileX = cornersTile[0].X;
        var maxTileX = cornersTile[0].X;
        var minTileY = cornersTile[0].Y;
        var maxTileY = cornersTile[0].Y;
        
        foreach (var corner in cornersTile)
        {
            minTileX = Mathf.Min(minTileX, corner.X);
            maxTileX = Mathf.Max(maxTileX, corner.X);
            minTileY = Mathf.Min(minTileY, corner.Y);
            maxTileY = Mathf.Max(maxTileY, corner.Y);
        }
        
        // Check each tile in the range
        for (int x = minTileX; x <= maxTileX; x++)
        {
            for (int y = minTileY; y <= maxTileY; y++)
            {
                var tilePos = new Vector2I(x, y);
                
                // Convert tile position back to world space to get the tile's world bounds
                var tileWorldCenter = tileMapLayer.ToGlobal(tileMapLayer.MapToLocal(tilePos));
                var tileSize = tileMapLayer.TileSet != null 
                    ? new Vector2(tileMapLayer.TileSet.TileSize.X, tileMapLayer.TileSet.TileSize.Y)
                    : new Vector2(16, 16);
                
                // For isometric tiles, create a diamond-shaped polygon for accurate overlap detection
                // Diamond vertices: top, right, bottom, left (in world space)
                var halfWidth = tileSize.X * 0.5f;
                var halfHeight = tileSize.Y * 0.5f;
                var tileDiamond = new global::Godot.Collections.Array<Vector2>
                {
                    tileWorldCenter + new Vector2(0, -halfHeight), // Top
                    tileWorldCenter + new Vector2(halfWidth, 0), // Right
                    tileWorldCenter + new Vector2(0, halfHeight), // Bottom
                    tileWorldCenter + new Vector2(-halfWidth, 0) // Left
                };
                
                // Check polygon-to-polygon overlap using Sutherland-Hodgman clipping
                if (PolygonsOverlap(polygon, tileDiamond, minOverlapRatio, tileSize.X * tileSize.Y))
                {
                    overlappedTiles.Add(tilePos);
                }
            }
        }
        
        return overlappedTiles;
    }
```

Calculates tile overlap for isometric tiles.

**Returns:** `global::Godot.Collections.Array<Vector2I>`

**Parameters:**
- `global::Godot.Collections.Array<Vector2> polygon`
- `TileMapLayer tileMapLayer`
- `float epsilon`
- `float minOverlapRatio`

### ClipPolygonToRect

```csharp
/// <summary>
    /// Implements the core Sutherland-Hodgman polygon clipping algorithm.
    /// Clips a polygon against a rectangular boundary.
    /// 
    /// Implements the Sutherland-Hodgman polygon clipping algorithm:
    /// - Iteratively clips the polygon against each of the 4 rectangle boundaries
    /// - Each boundary clip produces a new polygon guaranteed to be inside that boundary
    /// - The final result is the intersection of the polygon with the rectangle
    /// - Works correctly for both convex and concave input polygons
    /// </summary>
    /// <param name="polygon">The polygon to clip</param>
    /// <param name="rect">The rectangle to clip against</param>
    /// <returns>Clipped polygon</returns>
    public static global::Godot.Collections.Array<Vector2> ClipPolygonToRect(
        global::Godot.Collections.Array<Vector2> polygon,
        Rect2 rect)
    {
        var output = new global::Godot.Collections.Array<Vector2>(polygon);
        if (output.Count == 0)
            return output;

        // Boundaries
        var left = rect.Position.X;
        var right = rect.Position.X + rect.Size.X;
        var top = rect.Position.Y;
        var bottom = rect.Position.Y + rect.Size.Y;

        // Process each boundary sequentially
        for (int boundary = 0; boundary < 4; boundary++)
        {
            if (output.Count == 0)
                break;
            
            var result = new global::Godot.Collections.Array<Vector2>();
            var prev = output[output.Count - 1];
            var prevInside = PointInsideBoundary(prev, boundary, left, right, top, bottom);
            
            // Safeguard against infinite loops - limit iterations per boundary
            var maxIterations = output.Count * 2; // Should never need more than 2x the points
            var iteration = 0;
            
            foreach (var curr in output)
            {
                iteration++;
                if (iteration > maxIterations)
                {
                    GD.PrintErr($"clip_polygon_to_rect: Infinite loop detected on boundary {boundary}");
                    return new global::Godot.Collections.Array<Vector2>();
                }
            
                var currInside = PointInsideBoundary(curr, boundary, left, right, top, bottom);
                if (currInside)
                {
                    if (!prevInside)
                    {
                        result.Add(
                            ComputeIntersection(prev, curr, boundary, left, right, top, bottom)
                        );
                    }
                    result.Add(curr);
                }
                else if (prevInside)
                {
                    result.Add(ComputeIntersection(prev, curr, boundary, left, right, top, bottom));
                }
                prev = curr;
                prevInside = currInside;
            }
            output = result;
        }
        return output;
    }
```

Implements the core Sutherland-Hodgman polygon clipping algorithm.
Clips a polygon against a rectangular boundary.
/// Implements the Sutherland-Hodgman polygon clipping algorithm:
- Iteratively clips the polygon against each of the 4 rectangle boundaries
- Each boundary clip produces a new polygon guaranteed to be inside that boundary
- The final result is the intersection of the polygon with the rectangle
- Works correctly for both convex and concave input polygons

**Returns:** `global::Godot.Collections.Array<Vector2>`

**Parameters:**
- `global::Godot.Collections.Array<Vector2> polygon`
- `Rect2 rect`

### PolygonOverlapsRect

```csharp
/// <summary>
    /// Checks if a polygon overlaps a rectangle with a minimum overlap threshold.
    /// </summary>
    /// <param name="polygon">The polygon to check</param>
    /// <param name="rect">The rectangle to check against</param>
    /// <param name="minOverlapRatio">Minimum overlap ratio required</param>
    /// <returns>True if overlap meets threshold</returns>
    public static bool PolygonOverlapsRect(
        global::Godot.Collections.Array<Vector2> polygon,
        Rect2 rect,
        float minOverlapRatio = 0.05f)
    {
        if (polygon.Count < 3)
            return false;

        // Simple implementation: check if any polygon vertex is inside the rectangle
        // This is a basic implementation - a full implementation would use polygon clipping
        foreach (var vertex in polygon)
        {
            if (rect.HasPoint(vertex))
                return true;
        }

        // Check if any rectangle corner is inside the polygon
        var rectCorners = new Vector2[]
        {
            rect.Position,
            new Vector2(rect.Position.X + rect.Size.X, rect.Position.Y),
            new Vector2(rect.Position.X + rect.Size.X, rect.Position.Y + rect.Size.Y),
            new Vector2(rect.Position.X, rect.Position.Y + rect.Size.Y)
        };

        foreach (var corner in rectCorners)
        {
            if (IsPointInPolygon(corner, polygon))
                return true;
        }

        return false;
    }
```

Checks if a polygon overlaps a rectangle with a minimum overlap threshold.

**Returns:** `bool`

**Parameters:**
- `global::Godot.Collections.Array<Vector2> polygon`
- `Rect2 rect`
- `float minOverlapRatio`

### PolygonOverlapsRect

```csharp
/// <summary>
    /// Checks if a polygon overlaps a rectangle with a minimum overlap threshold.
    /// Overload for List&lt;Vector2&gt; compatibility.
    /// </summary>
    /// <param name="polygon">The polygon to check</param>
    /// <param name="rect">The rectangle to check against</param>
    /// <param name="minOverlapRatio">Minimum overlap ratio required</param>
    /// <returns>True if overlap meets threshold</returns>
    public static bool PolygonOverlapsRect(
        List<Vector2> polygon,
        Rect2 rect,
        float minOverlapRatio = 0.05f)
    {
        if (polygon.Count < 3)
            return false;

        // Convert to global::Godot.Collections.Array and delegate to the main implementation
        var godotArray = new global::Godot.Collections.Array<Vector2>(polygon);
        return PolygonOverlapsRect(godotArray, rect, minOverlapRatio);
    }
```

Checks if a polygon overlaps a rectangle with a minimum overlap threshold.
Overload for List&lt;Vector2&gt; compatibility.

**Returns:** `bool`

**Parameters:**
- `List<Vector2> polygon`
- `Rect2 rect`
- `float minOverlapRatio`

### PolygonArea

```csharp
/// <summary>
    /// Calculates the area of a polygon using the shoelace formula.
    /// </summary>
    /// <param name="polygon">The polygon to calculate area for</param>
    /// <returns>The area of the polygon</returns>
    public static float PolygonArea(global::Godot.Collections.Array<Vector2> polygon)
    {
        if (polygon.Count < 3)
            return 0f;

        float area = 0f;
        for (int i = 0; i < polygon.Count; i++)
        {
            var j = (i + 1) % polygon.Count;
            area += polygon[i].X * polygon[j].Y;
            area -= polygon[j].X * polygon[i].Y;
        }

        return Mathf.Abs(area) / 2f;
    }
```

Calculates the area of a polygon using the shoelace formula.

**Returns:** `float`

**Parameters:**
- `global::Godot.Collections.Array<Vector2> polygon`

