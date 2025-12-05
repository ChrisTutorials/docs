---
title: "CollisionGeometryUtils"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/collisiongeometryutils/"
---

# CollisionGeometryUtils

```csharp
GridBuilding.Godot.Shared.Utils.Geometry
class CollisionGeometryUtils
{
    // Members...
}
```

Collision geometry utilities ported from GDScript.
Provides advanced collision geometry calculations including:
- Tile polygon generation for different tile shapes
- Polygon bounds calculation
- Shape transformation utilities
- Collision detection helpers

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/CollisionGeometryUtils.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Utils.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetTilePolygon

```csharp
/// <summary>
    /// Gets the tile polygon for the specified tile shape and position.
    /// Supports square, isometric, and half-offset square tile shapes.
    /// </summary>
    /// <param name="tilePos">Position of the tile</param>
    /// <param name="tileSize">Size of the tile</param>
    /// <param name="tileShape">Shape of the tile</param>
    /// <returns>Array of vertices defining the tile polygon</returns>
    public static Vector2[] GetTilePolygon(
        Vector2 tilePos, 
        Vector2 tileSize, 
        TileSet.TileShapeEnum tileShape)
    {
        return tileShape switch
        {
            TileSet.TileShapeEnum.Square => GetSquareTilePolygon(tilePos, tileSize),
            TileSet.TileShapeEnum.Isometric => GetIsometricTilePolygon(tilePos, tileSize),
            TileSet.TileShapeEnum.HalfOffsetSquare => GetHalfOffsetSquareTilePolygon(tilePos, tileSize),
            _ => GetSquareTilePolygon(tilePos, tileSize) // Default to square
        };
    }
```

Gets the tile polygon for the specified tile shape and position.
Supports square, isometric, and half-offset square tile shapes.

**Returns:** `Vector2[]`

**Parameters:**
- `Vector2 tilePos`
- `Vector2 tileSize`
- `TileSet.TileShapeEnum tileShape`

### GetPolygonBounds

```csharp
/// <summary>
    /// Gets the bounds (AABB) of a polygon.
    /// </summary>
    /// <param name="polygon">Array of polygon vertices</param>
    /// <returns>Rect2 representing the polygon bounds</returns>
    public static Rect2 GetPolygonBounds(Vector2[] polygon)
    {
        if (polygon == null || polygon.Length == 0)
            return new Rect2();

        var minX = polygon[0].X;
        var minY = polygon[0].Y;
        var maxX = polygon[0].X;
        var maxY = polygon[0].Y;

        for (int i = 1; i < polygon.Length; i++)
        {
            minX = Mathf.Min(minX, polygon[i].X);
            minY = Mathf.Min(minY, polygon[i].Y);
            maxX = Mathf.Max(maxX, polygon[i].X);
            maxY = Mathf.Max(maxY, polygon[i].Y);
        }

        return new Rect2(new Vector2(minX, minY), new Vector2(maxX - minX, maxY - minY));
    }
```

Gets the bounds (AABB) of a polygon.

**Returns:** `Rect2`

**Parameters:**
- `Vector2[] polygon`

### IsPolygonConvex

```csharp
/// <summary>
    /// Checks if a polygon is convex using cross product method.
    /// </summary>
    /// <param name="polygon">Array of polygon vertices in order</param>
    /// <returns>True if polygon is convex, false otherwise</returns>
    public static bool IsPolygonConvex(Vector2[] polygon)
    {
        if (polygon == null || polygon.Length < 3)
            return false;

        var sign = 0;
        for (int i = 0; i < polygon.Length; i++)
        {
            var p1 = polygon[i];
            var p2 = polygon[(i + 1) % polygon.Length];
            var p3 = polygon[(i + 2) % polygon.Length];
            
            var cross = GetCrossProduct(p1, p2, p3);

            if (Math.Abs(cross) > 0.0001f) // Use epsilon for floating point comparison
            {
                if (sign == 0)
                    sign = Math.Sign(cross);
                else if (Math.Sign(cross) != sign)
                    return false;
            }
        }
        return true;
    }
```

Checks if a polygon is convex using cross product method.

**Returns:** `bool`

**Parameters:**
- `Vector2[] polygon`

### ExpandPolygon

```csharp
/// <summary>
    /// Expands a polygon by the specified amount (Minkowski sum with a circle).
    /// Useful for creating collision boundaries with tolerance.
    /// </summary>
    /// <param name="polygon">Original polygon vertices</param>
    /// <param name="expansion">Amount to expand outward</param>
    /// <returns>Expanded polygon vertices</returns>
    public static Vector2[] ExpandPolygon(Vector2[] polygon, float expansion)
    {
        if (polygon == null || polygon.Length < 3)
            return polygon;

        var expanded = new List<Vector2>();
        
        for (int i = 0; i < polygon.Length; i++)
        {
            var current = polygon[i];
            var prev = polygon[(i - 1 + polygon.Length) % polygon.Length];
            var next = polygon[(i + 1) % polygon.Length];
            
            // Calculate normal vectors
            var normal1 = (current - prev).Normalized().Orthogonal();
            var normal2 = (next - current).Normalized().Orthogonal();
            
            // Average the normals for corner expansion
            var avgNormal = (normal1 + normal2).Normalized();
            
            // Push vertex outward
            expanded.Add(current + avgNormal * expansion);
        }
        
        return expanded.ToArray();
    }
```

Expands a polygon by the specified amount (Minkowski sum with a circle).
Useful for creating collision boundaries with tolerance.

**Returns:** `Vector2[]`

**Parameters:**
- `Vector2[] polygon`
- `float expansion`

### SimplifyPolygon

```csharp
/// <summary>
    /// Simplifies a polygon by removing collinear points within tolerance.
    /// </summary>
    /// <param name="polygon">Original polygon vertices</param>
    /// <param name="tolerance">Tolerance for collinearity detection</param>
    /// <returns>Simplified polygon vertices</returns>
    public static Vector2[] SimplifyPolygon(Vector2[] polygon, float tolerance = 0.001f)
    {
        if (polygon == null || polygon.Length <= 3)
            return polygon;

        var simplified = new List<Vector2>();
        
        for (int i = 0; i < polygon.Length; i++)
        {
            var prev = polygon[(i - 1 + polygon.Length) % polygon.Length];
            var current = polygon[i];
            var next = polygon[(i + 1) % polygon.Length];
            
            // Check if current point is collinear with prev and next
            var cross = Math.Abs(GetCrossProduct(prev, current, next));
            
            if (cross > tolerance)
            {
                simplified.Add(current);
            }
        }
        
        return simplified.Count >= 3 ? simplified.ToArray() : polygon;
    }
```

Simplifies a polygon by removing collinear points within tolerance.

**Returns:** `Vector2[]`

**Parameters:**
- `Vector2[] polygon`
- `float tolerance`

### GetPolygonArea

```csharp
/// <summary>
    /// Gets the area of a polygon using the shoelace formula.
    /// </summary>
    /// <param name="polygon">Polygon vertices</param>
    /// <returns>Area of the polygon</returns>
    public static float GetPolygonArea(Vector2[] polygon)
    {
        if (polygon == null || polygon.Length < 3)
            return 0f;

        float area = 0f;
        for (int i = 0; i < polygon.Length; i++)
        {
            var j = (i + 1) % polygon.Length;
            area += polygon[i].X * polygon[j].Y;
            area -= polygon[j].X * polygon[i].Y;
        }
        
        return Math.Abs(area) / 2f;
    }
```

Gets the area of a polygon using the shoelace formula.

**Returns:** `float`

**Parameters:**
- `Vector2[] polygon`

### GetPolygonCentroid

```csharp
/// <summary>
    /// Gets the centroid (center of mass) of a polygon.
    /// </summary>
    /// <param name="polygon">Polygon vertices</param>
    /// <returns>Centroid of the polygon</returns>
    public static Vector2 GetPolygonCentroid(Vector2[] polygon)
    {
        if (polygon == null || polygon.Length < 3)
            return Vector2.Zero;

        float area = 0f;
        float centerX = 0f;
        float centerY = 0f;
        
        for (int i = 0; i < polygon.Length; i++)
        {
            var j = (i + 1) % polygon.Length;
            var cross = polygon[i].X * polygon[j].Y - polygon[j].X * polygon[i].Y;
            
            area += cross;
            centerX += (polygon[i].X + polygon[j].X) * cross;
            centerY += (polygon[i].Y + polygon[j].Y) * cross;
        }
        
        area *= 0.5f;
        if (Math.Abs(area) < 0.0001f)
            return GetPolygonBounds(polygon).GetCenter();
        
        var factor = 1f / (6f * area);
        return new Vector2(centerX * factor, centerY * factor);
    }
```

Gets the centroid (center of mass) of a polygon.

**Returns:** `Vector2`

**Parameters:**
- `Vector2[] polygon`

