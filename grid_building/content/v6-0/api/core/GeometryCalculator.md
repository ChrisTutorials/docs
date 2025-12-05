---
title: "GeometryCalculator"
description: "Default implementation of geometry calculator"
weight: 10
url: "/gridbuilding/v6-0/api/core/geometrycalculator/"
---

# GeometryCalculator

```csharp
GridBuilding.Core.Interfaces
class GeometryCalculator
{
    // Members...
}
```

Default implementation of geometry calculator

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/IGeometryCalculator.cs`  
**Namespace:** `GridBuilding.Core.Interfaces`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CalculatePolygonTileOverlap

```csharp
/// <summary>
    /// Calculates polygon-tile overlap with precise geometry
    /// </summary>
    public List<Vector2I> CalculatePolygonTileOverlap(
        Vector2[] worldPoints, 
        Vector2 tileSize, 
        float edgeEpsilon = DefaultEdgeEpsilon, 
        float minAreaFraction = DefaultMinAreaFraction)
    {
        var overlappedTiles = new List<Vector2I>();
        
        if (worldPoints == null || worldPoints.Length < 3)
            return overlappedTiles;

        // Calculate bounds of the polygon
        var bounds = CalculatePolygonBounds(worldPoints);
        
        // Calculate tile range to check
        var minTile = new Vector2I(
            Floor(bounds.Position.X / tileSize.X),
            Floor(bounds.Position.Y / tileSize.Y)
        );
        var maxTile = new Vector2I(
            Floor((bounds.Position.X + bounds.Size.X) / tileSize.X),
            Floor((bounds.Position.Y + bounds.Size.Y) / tileSize.Y)
        );

        // Check each tile in the range for overlap
        for (int x = minTile.X; x <= maxTile.X; x++)
        {
            for (int y = minTile.Y; y <= maxTile.Y; y++)
            {
                var tilePos = new Vector2I(x, y);
                if (DoesPolygonOverlapTile(worldPoints, tilePos, tileSize, edgeEpsilon, minAreaFraction))
                {
                    overlappedTiles.Add(tilePos);
                }
            }
        }

        return overlappedTiles;
    }
```

Calculates polygon-tile overlap with precise geometry

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2[] worldPoints`
- `Vector2 tileSize`
- `float edgeEpsilon`
- `float minAreaFraction`

### DoesPolygonOverlapTile

```csharp
/// <summary>
    /// Checks if a polygon overlaps a specific tile
    /// </summary>
    public bool DoesPolygonOverlapTile(
        Vector2[] worldPoints,
        Vector2I tilePosition,
        Vector2 tileSize,
        float edgeEpsilon = DefaultEdgeEpsilon,
        float minAreaFraction = DefaultMinAreaFraction)
    {
        if (worldPoints == null || worldPoints.Length < 3)
            return false;

        // Calculate tile bounds in world space
        var tileTopLeft = new Vector2(tilePosition.X * tileSize.X, tilePosition.Y * tileSize.Y);
        var tileBounds = new Rect2(tileTopLeft, tileSize);

        // Quick bounds check first
        var polygonBounds = CalculatePolygonBounds(worldPoints);
        if (!polygonBounds.Overlaps(tileBounds))
            return false;

        // More precise overlap check
        var overlapArea = CalculateOverlapArea(worldPoints, tileBounds);
        var minRequiredArea = tileSize.X * tileSize.Y * minAreaFraction;
        
        return overlapArea >= minRequiredArea;
    }
```

Checks if a polygon overlaps a specific tile

**Returns:** `bool`

**Parameters:**
- `Vector2[] worldPoints`
- `Vector2I tilePosition`
- `Vector2 tileSize`
- `float edgeEpsilon`
- `float minAreaFraction`

### CalculatePolygonArea

```csharp
/// <summary>
    /// Calculates the area of a polygon using the shoelace formula
    /// </summary>
    public float CalculatePolygonArea(Vector2[] points)
    {
        if (points == null || points.Length < 3)
            return 0f;

        var area = 0f;
        var n = points.Length;
        
        for (int i = 0; i < n; i++)
        {
            var j = (i + 1) % n;
            area += points[i].X * points[j].Y;
            area -= points[j].X * points[i].Y;
        }
        
        return Abs(area) / 2f;
    }
```

Calculates the area of a polygon using the shoelace formula

**Returns:** `float`

**Parameters:**
- `Vector2[] points`

### IsPolygonConvex

```csharp
/// <summary>
    /// Checks if a polygon is convex using cross product sign consistency
    /// </summary>
    public bool IsPolygonConvex(Vector2[] points)
    {
        if (points == null || points.Length < 4) // Triangles are always convex
            return true;

        var sign = 0;
        var n = points.Length;
        
        for (int i = 0; i < n; i++)
        {
            var a = points[i];
            var b = points[(i + 1) % n];
            var c = points[(i + 2) % n];
            
            var cross = (b - a).Cross(c - b);
            if (Abs(cross) < 0.0001f)
                continue;
                
            var currSign = Sign(cross);
            if (sign == 0)
                sign = currSign;
            else if (currSign != sign)
                return false;
        }
        
        return true;
    }
```

Checks if a polygon is convex using cross product sign consistency

**Returns:** `bool`

**Parameters:**
- `Vector2[] points`

### CalculatePolygonBounds

```csharp
/// <summary>
    /// Calculates bounding rectangle of a polygon
    /// </summary>
    public Rect2 CalculatePolygonBounds(Vector2[] points)
    {
        if (points == null || points.Length == 0)
            return new Rect2();

        var minX = points[0].X;
        var minY = points[0].Y;
        var maxX = points[0].X;
        var maxY = points[0].Y;

        foreach (var point in points)
        {
            minX = Min(minX, point.X);
            minY = Min(minY, point.Y);
            maxX = Max(maxX, point.X);
            maxY = Max(maxY, point.Y);
        }

        return new Rect2(minX, minY, maxX - minX, maxY - minY);
    }
```

Calculates bounding rectangle of a polygon

**Returns:** `Rect2`

**Parameters:**
- `Vector2[] points`

