---
title: "GBGeometryMath"
description: "Geometry math utilities - mirrors GDScript GBGeometryMathEnhanced
Provides type-safe geometry operations for grid building."
weight: 20
url: "/gridbuilding/v6-0/api/godot/gbgeometrymath/"
---

# GBGeometryMath

```csharp
GridBuilding.Godot.Tests.Geometry
class GBGeometryMath
{
    // Members...
}
```

Geometry math utilities - mirrors GDScript GBGeometryMathEnhanced
Provides type-safe geometry operations for grid building.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Geometry/GBGeometryMath.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetTilePolygon

```csharp
#region Tile Polygon Generation

    /// <summary>
    /// Generates a polygon for a tile at the specified position with the given size and shape.
    /// </summary>
    /// <param name="tilePos">The position of the tile</param>
    /// <param name="tileSize">The size of the tile</param>
    /// <param name="tileShape">The shape of the tile</param>
    /// <returns>Array of vertices forming the tile polygon</returns>
    /// <exception cref="ArgumentException">If tileSize has non-positive dimensions</exception>
    public static List<Vector2> GetTilePolygon(
        Vector2 tilePos, 
        Vector2 tileSize, 
        TileSet.TileShape tileShape)
    {
        if (tileSize.X <= 0 || tileSize.Y <= 0)
        {
            throw new ArgumentException("Tile size must have positive dimensions", nameof(tileSize));
        }

        var result = tileShape switch
        {
            TileSet.TileShape.Square => GetSquarePolygon(tilePos, tileSize),
            TileSet.TileShape.Isometric => GetIsometricPolygon(tilePos, tileSize),
            TileSet.TileShape.HalfOffsetSquare => GetHalfOffsetSquarePolygon(tilePos, tileSize),
            _ => throw new ArgumentException($"Unsupported tile shape: {tileShape}", nameof(tileShape))
        };

        return new List<Vector2>(result);
    }
```

Generates a polygon for a tile at the specified position with the given size and shape.

**Returns:** `List<Vector2>`

**Parameters:**
- `Vector2 tilePos`
- `Vector2 tileSize`
- `TileSet.TileShape tileShape`

### WorldToTile

```csharp
#endregion

    #region Coordinate Conversion

    /// <summary>
    /// Converts world coordinates to tile coordinates.
    /// </summary>
    public static Vector2I WorldToTile(Vector2 worldPos, Vector2 tileSize, TileSet.TileShape tileShape)
    {
        return tileShape switch
        {
            TileSet.TileShape.Square => new Vector2I(
                (int)Mathf.Floor(worldPos.X / tileSize.X),
                (int)Mathf.Floor(worldPos.Y / tileSize.Y)
            ),
            TileSet.TileShape.Isometric => new Vector2I(
                (int)Mathf.Floor((worldPos.X / tileSize.X + worldPos.Y / tileSize.Y)),
                (int)Mathf.Floor((worldPos.X / tileSize.X - worldPos.Y / tileSize.Y))
            ),
            TileSet.TileShape.HalfOffsetSquare => new Vector2I(
                (int)Mathf.Floor(worldPos.X / tileSize.X),
                (int)Mathf.Floor(worldPos.Y / tileSize.Y)
            ),
            _ => throw new ArgumentException($"Unsupported tile shape: {tileShape}")
        };
    }
```

Converts world coordinates to tile coordinates.

**Returns:** `Vector2I`

**Parameters:**
- `Vector2 worldPos`
- `Vector2 tileSize`
- `TileSet.TileShape tileShape`

### TileToWorld

```csharp
/// <summary>
    /// Converts tile coordinates to world coordinates.
    /// </summary>
    public static Vector2 TileToWorld(Vector2I tileCoords, Vector2 tileSize, TileSet.TileShape tileShape)
    {
        return tileShape switch
        {
            TileSet.TileShape.Square => new Vector2(
                tileCoords.X * tileSize.X,
                tileCoords.Y * tileSize.Y
            ),
            TileSet.TileShape.Isometric => new Vector2(
                (tileCoords.X - tileCoords.Y) * tileSize.X / 2,
                (tileCoords.X + tileCoords.Y) * tileSize.Y / 2
            ),
            TileSet.TileShape.HalfOffsetSquare => new Vector2(
                tileCoords.X * tileSize.X + (tileCoords.Y % 2 == 1 ? tileSize.X / 2 : 0),  // offset odd rows
                tileCoords.Y * tileSize.Y
            ),
            _ => throw new ArgumentException($"Unsupported tile shape: {tileShape}")
        };
    }
```

Converts tile coordinates to world coordinates.

**Returns:** `Vector2`

**Parameters:**
- `Vector2I tileCoords`
- `Vector2 tileSize`
- `TileSet.TileShape tileShape`

### GetTileCenter

```csharp
#endregion

    #region Tile Center Calculation

    /// <summary>
    /// Gets the center position of a tile.
    /// </summary>
    public static Vector2 GetTileCenter(Vector2I tileCoords, Vector2 tileSize, TileSet.TileShape tileShape)
    {
        var worldPos = TileToWorld(tileCoords, tileSize, tileShape);
        
        return tileShape switch
        {
            TileSet.TileShape.Square => worldPos + tileSize / 2,
            TileSet.TileShape.Isometric => new Vector2(worldPos.X, worldPos.Y + tileSize.Y / 2),
            TileSet.TileShape.HalfOffsetSquare => worldPos + tileSize / 2,
            _ => throw new ArgumentException($"Unsupported tile shape: {tileShape}")
        };
    }
```

Gets the center position of a tile.

**Returns:** `Vector2`

**Parameters:**
- `Vector2I tileCoords`
- `Vector2 tileSize`
- `TileSet.TileShape tileShape`

### GetTileBounds

```csharp
#endregion

    #region Tile Bounds

    /// <summary>
    /// Gets the bounding rectangle of a tile.
    /// </summary>
    public static Rect2 GetTileBounds(Vector2I tileCoords, Vector2 tileSize, TileSet.TileShape tileShape)
    {
        var center = GetTileCenter(tileCoords, tileSize, tileShape);
        
        return tileShape switch
        {
            TileSet.TileShape.Square => new Rect2(
                TileToWorld(tileCoords, tileSize, tileShape),
                tileSize
            ),
            TileSet.TileShape.Isometric => new Rect2(
                new Vector2(center.X - tileSize.X / 2, center.Y - tileSize.Y / 2),
                new Vector2(tileSize.X, tileSize.Y)
            ),
            TileSet.TileShape.HalfOffsetSquare => new Rect2(
                TileToWorld(tileCoords, tileSize, tileShape),
                tileSize
            ),
            _ => throw new ArgumentException($"Unsupported tile shape: {tileShape}")
        };
    }
```

Gets the bounding rectangle of a tile.

**Returns:** `Rect2`

**Parameters:**
- `Vector2I tileCoords`
- `Vector2 tileSize`
- `TileSet.TileShape tileShape`

### GetPolygonBounds

```csharp
#endregion

    #region Polygon Bounds

    /// <summary>
    /// Calculates the bounding rectangle of a polygon.
    /// </summary>
    /// <param name="polygon">The polygon vertices</param>
    /// <returns>The bounding rectangle</returns>
    /// <exception cref="ArgumentException">If polygon is null or empty</exception>
    public static Rect2 GetPolygonBounds(List<Vector2> polygon)
    {
        if (polygon == null || polygon.Count == 0)
        {
            return new Rect2();
        }

        var minX = polygon[0].X;
        var minY = polygon[0].Y;
        var maxX = polygon[0].X;
        var maxY = polygon[0].Y;

        foreach (var vertex in polygon)
        {
            minX = Mathf.Min(minX, vertex.X);
            minY = Mathf.Min(minY, vertex.Y);
            maxX = Mathf.Max(maxX, vertex.X);
            maxY = Mathf.Max(maxY, vertex.Y);
        }

        return new Rect2(new Vector2(minX, minY), new Vector2(maxX - minX, maxY - minY));
    }
```

Calculates the bounding rectangle of a polygon.

**Returns:** `Rect2`

**Parameters:**
- `List<Vector2> polygon`

### GetTileDistance

```csharp
#endregion

    #region Tile Distance

    /// <summary>
    /// Calculates Manhattan distance between two tiles.
    /// </summary>
    public static int GetTileDistance(Vector2I fromTile, Vector2I toTile, TileSet.TileShape tileShape)
    {
        return Math.Abs(fromTile.X - toTile.X) + Math.Abs(fromTile.Y - toTile.Y);
    }
```

Calculates Manhattan distance between two tiles.

**Returns:** `int`

**Parameters:**
- `Vector2I fromTile`
- `Vector2I toTile`
- `TileSet.TileShape tileShape`

### AreTilesAdjacent

```csharp
#endregion

    #region Tile Adjacency

    /// <summary>
    /// Tests if two tiles are adjacent.
    /// </summary>
    public static bool AreTilesAdjacent(Vector2I fromTile, Vector2I toTile, TileSet.TileShape tileShape)
    {
        var distance = GetTileDistance(fromTile, toTile, tileShape);
        
        return tileShape switch
        {
            TileSet.TileShape.Square => distance == 1,
            TileSet.TileShape.Isometric => distance <= 2, // Diagonal counts as adjacent in isometric
            TileSet.TileShape.HalfOffsetSquare => distance == 1,
            _ => false
        };
    }
```

Tests if two tiles are adjacent.

**Returns:** `bool`

**Parameters:**
- `Vector2I fromTile`
- `Vector2I toTile`
- `TileSet.TileShape tileShape`

