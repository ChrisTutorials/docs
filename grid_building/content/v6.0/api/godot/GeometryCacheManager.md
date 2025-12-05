---
title: "GeometryCacheManager"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/geometrycachemanager/"
---

# GeometryCacheManager

```csharp
GridBuilding.Godot.Systems.Placement.Processors
class GeometryCacheManager
{
    // Members...
}
```

Manages caching for geometry calculations to improve performance.
Ported from: godot/addons/grid_building/systems/placement/processors/geometry_cache_manager.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Processors/GeometryCacheManager.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Processors`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### InvalidateCache

```csharp
/// <summary>
    /// Invalidates all cached geometry data when setup changes.
    /// </summary>
    public void InvalidateCache()
    {
        _geometryCache.Clear();
        _polygonBoundsCache.Clear();
        _tilePolygonCache.Clear();
        _cacheFrame = Engine.GetProcessFrames();
    }
```

Invalidates all cached geometry data when setup changes.

**Returns:** `void`

### GetCachedPolygonBounds

```csharp
/// <summary>
    /// Gets cached polygon bounds or calculates and caches if not found.
    /// Uses optimized hash-based key generation for performance.
    /// </summary>
    public Rect2 GetCachedPolygonBounds(Vector2[] polygon)
    {
        // Use hash-based key for better performance
        var cacheKey = GetPolygonHashKey(polygon);
        
        if (_polygonBoundsCache.ContainsKey(cacheKey))
        {
            return _polygonBoundsCache[cacheKey];
        }

        // Convert to Core types, calculate, convert back
        var corePolygon = polygon.ToCore();
        var coreBounds = GeometryMath.GetPolygonBounds(corePolygon);
        var bounds = coreBounds.ToGodot();
        
        _polygonBoundsCache[cacheKey] = bounds;
        return bounds;
    }
```

Gets cached polygon bounds or calculates and caches if not found.
Uses optimized hash-based key generation for performance.

**Returns:** `Rect2`

**Parameters:**
- `Vector2[] polygon`

### GetCachedTilePolygon

```csharp
/// <summary>
    /// Gets cached tile polygon or calculates and caches if not found.
    /// </summary>
    public Vector2[] GetCachedTilePolygon(Vector2 tilePos, Vector2 tileSize, TileSet.TileShapeEnum tileShape)
    {
        var cacheKey = $"{tilePos}_{tileSize}_{tileShape}";
        
        if (_tilePolygonCache.ContainsKey(cacheKey))
        {
            return _tilePolygonCache[cacheKey];
        }

        var coreTilePos = tilePos.ToCore();
        var coreTileSize = tileSize.ToCore();
        var coreTileShape = tileShape.ToCore();
        
        var corePolygon = GeometryMath.GetTilePolygon(coreTilePos, coreTileSize, coreTileShape);
        var tilePolygon = corePolygon.ToGodot();
        
        _tilePolygonCache[cacheKey] = tilePolygon;
        return tilePolygon;
    }
```

Gets cached tile polygon or calculates and caches if not found.

**Returns:** `Vector2[]`

**Parameters:**
- `Vector2 tilePos`
- `Vector2 tileSize`
- `TileSet.TileShapeEnum tileShape`

### GetCachedGeometryResult

```csharp
/// <summary>
    /// Gets cached geometry calculation result or calculates and caches if not found.
    /// </summary>
    public object GetCachedGeometryResult(string cacheKey, System.Func<object> calculationFunc)
    {
        if (_geometryCache.ContainsKey(cacheKey))
        {
            return _geometryCache[cacheKey];
        }

        var result = calculationFunc();
        _geometryCache[cacheKey] = result;
        return result;
    }
```

Gets cached geometry calculation result or calculates and caches if not found.

**Returns:** `object`

**Parameters:**
- `string cacheKey`
- `System.Func<object> calculationFunc`

