---
title: "GeometryMath"
description: "POCS geometry math utilities for tile-based calculations.
Ported from: godot/addons/grid_building/core/utils/gb_geometry_math.gd
Provides pure math functions for:
- Tile polygon generation (square, isometric, half-offset)
- Polygon intersection and overlap detection
- Polygon bounds calculation
- Polygon area calculation"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/geometrymath/"
---

# GeometryMath

```csharp
GridBuilding.Core
class GeometryMath
{
    // Members...
}
```

POCS geometry math utilities for tile-based calculations.
Ported from: godot/addons/grid_building/core/utils/gb_geometry_math.gd
Provides pure math functions for:
- Tile polygon generation (square, isometric, half-offset)
- Polygon intersection and overlap detection
- Polygon bounds calculation
- Polygon area calculation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/GeometryMath.cs`  
**Namespace:** `GridBuilding.Core`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetTilePolygon

```csharp
/// <summary>
    /// Gets the polygon vertices for a tile at the given position.
    /// </summary>
    /// <param name="tilePos">The tile position in world coordinates</param>
    /// <param name="tileSize">The tile size</param>
    /// <param name="tileShape">The tile shape (square, isometric, half-offset)</param>
    /// <returns>Array of vertices forming the tile polygon</returns>
    public static Vector2[] GetTilePolygon(Vector2 tilePos, Vector2 tileSize, TileShape tileShape)
    {
        return tileShape switch
        {
            TileShape.Square or TileShape.HalfOffsetSquare => GetSquareTilePolygon(tilePos, tileSize),
            TileShape.Isometric => GetIsometricTilePolygon(tilePos, tileSize),
            _ => GetSquareTilePolygon(tilePos, tileSize)
        };
    }
```

Gets the polygon vertices for a tile at the given position.

**Returns:** `Vector2[]`

**Parameters:**
- `Vector2 tilePos`
- `Vector2 tileSize`
- `TileShape tileShape`

### GetPolygonBounds

```csharp
/// <summary>
    /// Gets the bounding rectangle of a polygon.
    /// </summary>
    public static Rect2 GetPolygonBounds(Vector2[] polygon)
    {
        if (polygon == null || polygon.Length == 0)
            return new Rect2(Vector2.Zero, Vector2.Zero);
        
        var minX = float.MaxValue;
        var minY = float.MaxValue;
        var maxX = float.MinValue;
        var maxY = float.MinValue;
        
        foreach (var point in polygon)
        {
            if (point.X < minX) minX = point.X;
            if (point.Y < minY) minY = point.Y;
            if (point.X > maxX) maxX = point.X;
            if (point.Y > maxY) maxY = point.Y;
        }
        
        return new Rect2(new Vector2(minX, minY), new Vector2(maxX - minX, maxY - minY));
    }
```

Gets the bounding rectangle of a polygon.

**Returns:** `Rect2`

**Parameters:**
- `Vector2[] polygon`

### PolygonArea

```csharp
/// <summary>
    /// Calculates the area of a polygon using the shoelace formula.
    /// Optimized to avoid modulo operations in the hot loop.
    /// </summary>
    public static float PolygonArea(Vector2[] polygon)
    {
        if (polygon == null || polygon.Length < 3)
            return 0f;
        
        float area = 0f;
        var n = polygon.Length;
        
        // Optimized: avoid modulo in loop by handling last element separately
        for (int i = 0; i < n - 1; i++)
        {
            area += polygon[i].X * polygon[i + 1].Y;
            area -= polygon[i + 1].X * polygon[i].Y;
        }
        // Handle wrap-around (last to first)
        area += polygon[n - 1].X * polygon[0].Y;
        area -= polygon[0].X * polygon[n - 1].Y;
        
        return MathF.Abs(area) * 0.5f;
    }
```

Calculates the area of a polygon using the shoelace formula.
Optimized to avoid modulo operations in the hot loop.

**Returns:** `float`

**Parameters:**
- `Vector2[] polygon`

### DoesPolygonOverlapTile

```csharp
/// <summary>
    /// Checks if a polygon overlaps with a tile.
    /// </summary>
    /// <param name="polygon">The polygon to check</param>
    /// <param name="tilePos">The tile position</param>
    /// <param name="tileSize">The tile size</param>
    /// <param name="tileShape">The tile shape</param>
    /// <param name="minOverlapThreshold">Minimum overlap area ratio to consider as overlapping</param>
    /// <returns>True if the polygon overlaps the tile</returns>
    public static bool DoesPolygonOverlapTile(
        Vector2[] polygon, 
        Vector2 tilePos, 
        Vector2 tileSize, 
        TileShape tileShape,
        float minOverlapThreshold = 0.01f)
    {
        var intersectionArea = IntersectionAreaWithTile(polygon, tilePos, tileSize, tileShape);
        var tileArea = tileShape == TileShape.Isometric 
            ? (tileSize.X * tileSize.Y) / 2f  // Diamond area
            : tileSize.X * tileSize.Y;         // Rectangle area
        
        return intersectionArea / tileArea >= minOverlapThreshold;
    }
```

Checks if a polygon overlaps with a tile.

**Returns:** `bool`

**Parameters:**
- `Vector2[] polygon`
- `Vector2 tilePos`
- `Vector2 tileSize`
- `TileShape tileShape`
- `float minOverlapThreshold`

### IntersectionAreaWithTile

```csharp
/// <summary>
    /// Calculates the intersection area between a polygon and a tile.
    /// </summary>
    public static float IntersectionAreaWithTile(
        Vector2[] polygon, 
        Vector2 tilePos, 
        Vector2 tileSize, 
        TileShape tileShape)
    {
        var tilePolygon = GetTilePolygon(tilePos, tileSize, tileShape);
        var clipped = ClipPolygonToPolygon(polygon, tilePolygon);
        return PolygonArea(clipped);
    }
```

Calculates the intersection area between a polygon and a tile.

**Returns:** `float`

**Parameters:**
- `Vector2[] polygon`
- `Vector2 tilePos`
- `Vector2 tileSize`
- `TileShape tileShape`

### ClipPolygonToPolygon

```csharp
/// <summary>
    /// Clips a subject polygon to a clip polygon using Sutherland-Hodgman algorithm.
    /// Phase 1 & 2 optimizations: ArrayPool, early bounds check, edge caching, and better capacity prediction.
    /// </summary>
    public static Vector2[] ClipPolygonToPolygon(Vector2[] subject, Vector2[] clip)
    {
        if (subject == null || subject.Length < 3 || clip == null || clip.Length < 3)
            return Array.Empty<Vector2>();
        
        // Phase 1: Early bounds check for quick rejection (10-50x speedup for non-overlapping)
        if (!QuickBoundsCheck(subject, clip))
            return Array.Empty<Vector2>();
        
        // Phase 2: Use ArrayPool to eliminate allocations (3-5x speedup)
        var maxCapacity = System.Math.Max(subject.Length, clip.Length) * 2;
        var buffer1 = ArrayPool<Vector2>.Shared.Rent(maxCapacity);
        var buffer2 = ArrayPool<Vector2>.Shared.Rent(maxCapacity);
        
        try
        {
            // Pre-cache edge vectors for better performance
            var edgeVectors = new EdgeVector[clip.Length];
            for (int i = 0; i < clip.Length; i++)
            {
                var start = clip[i];
                var end = clip[(i + 1) % clip.Length];
                edgeVectors[i] = new EdgeVector(start, end);
            }
            
            // Initialize with subject polygon
            var outputLength = subject.Length;
            Array.Copy(subject, buffer1, outputLength);
            
            var inputBuffer = buffer1;
            var outputBuffer = buffer2;
            var inputLength = outputLength;
            
            // Process each clip edge
            foreach (var edge in edgeVectors)
            {
                if (inputLength == 0)
                    return Array.Empty<Vector2>();
                
                // Swap buffers
                (inputBuffer, outputBuffer) = (outputBuffer, inputBuffer);
                outputLength = 0;
                
                var previous = inputBuffer[inputLength - 1];
                var previousInside = IsPointOnLeftSide(previous, edge.Start, edge.End);
                
                for (int j = 0; j < inputLength; j++)
                {
                    var current = inputBuffer[j];
                    var currentInside = IsPointOnLeftSide(current, edge.Start, edge.End);
                    
                    if (currentInside)
                    {
                        if (!previousInside)
                        {
                            var intersection = LineIntersection(previous, current, edge.Start, edge.End);
                            if (intersection.HasValue && outputLength < maxCapacity)
                            {
                                outputBuffer[outputLength++] = intersection.Value;
                            }
                        }
                        if (outputLength < maxCapacity)
                        {
                            outputBuffer[outputLength++] = current;
                        }
                    }
                    else if (previousInside)
                    {
                        var intersection = LineIntersection(previous, current, edge.Start, edge.End);
                        if (intersection.HasValue && outputLength < maxCapacity)
                        {
                            outputBuffer[outputLength++] = intersection.Value;
                        }
                    }
                    
                    previous = current;
                    previousInside = currentInside;
                }
                
                inputLength = outputLength;
            }
            
            // Copy result to correctly sized array
            var result = new Vector2[outputLength];
            Array.Copy(outputBuffer, result, outputLength);
            return result;
        }
        finally
        {
            ArrayPool<Vector2>.Shared.Return(buffer1);
            ArrayPool<Vector2>.Shared.Return(buffer2);
        }
    }
```

Clips a subject polygon to a clip polygon using Sutherland-Hodgman algorithm.
Phase 1 & 2 optimizations: ArrayPool, early bounds check, edge caching, and better capacity prediction.

**Returns:** `Vector2[]`

**Parameters:**
- `Vector2[] subject`
- `Vector2[] clip`

### ClipPolygonToRect

```csharp
/// <summary>
    /// Clips a polygon to a rectangle.
    /// </summary>
    public static Vector2[] ClipPolygonToRect(Vector2[] polygon, Rect2 rect)
    {
        var rectPolygon = new[]
        {
            new Vector2(rect.Position.X, rect.Position.Y),
            new Vector2(rect.Position.X + rect.Size.X, rect.Position.Y),
            new Vector2(rect.Position.X + rect.Size.X, rect.Position.Y + rect.Size.Y),
            new Vector2(rect.Position.X, rect.Position.Y + rect.Size.Y)
        };
        return ClipPolygonToPolygon(polygon, rectPolygon);
    }
```

Clips a polygon to a rectangle.

**Returns:** `Vector2[]`

**Parameters:**
- `Vector2[] polygon`
- `Rect2 rect`

### RectsOverlap

```csharp
/// <summary>
    /// Checks if two rectangles overlap.
    /// </summary>
    public static bool RectsOverlap(Rect2 a, Rect2 b)
    {
        return a.Position.X < b.Position.X + b.Size.X &&
               a.Position.X + a.Size.X > b.Position.X &&
               a.Position.Y < b.Position.Y + b.Size.Y &&
               a.Position.Y + a.Size.Y > b.Position.Y;
    }
```

Checks if two rectangles overlap.

**Returns:** `bool`

**Parameters:**
- `Rect2 a`
- `Rect2 b`

### PolygonOverlapsRect

```csharp
/// <summary>
    /// Checks if a polygon overlaps with a rectangle.
    /// Uses a simplified check based on bounding box first, then detailed intersection.
    /// </summary>
    public static bool PolygonOverlapsRect(
        Vector2[] polygon, 
        Rect2 rect, 
        float positionTolerance = 0.01f,
        float areaThreshold = 0.05f)
    {
        if (polygon == null || polygon.Length < 3)
            return false;
        
        // Quick bounding box check
        var polyBounds = GetPolygonBounds(polygon);
        if (!RectsOverlap(polyBounds, rect))
            return false;
        
        // Detailed intersection check
        var clipped = ClipPolygonToRect(polygon, rect);
        if (clipped.Length < 3)
            return false;
        
        var clippedArea = PolygonArea(clipped);
        var rectArea = rect.Size.X * rect.Size.Y;
        
        return clippedArea / rectArea >= areaThreshold;
    }
```

Checks if a polygon overlaps with a rectangle.
Uses a simplified check based on bounding box first, then detailed intersection.

**Returns:** `bool`

**Parameters:**
- `Vector2[] polygon`
- `Rect2 rect`
- `float positionTolerance`
- `float areaThreshold`

### ConvertSizeToPolygon

```csharp
/// <summary>
    /// Converts a RectangleShape2D to a polygon representation with the given transform.
    /// </summary>
    /// <param name="shape">The RectangleShape2D to convert</param>
    /// <param name="transform">The transform to apply</param>
    /// <returns>Polygon vertices in world coordinates</returns>
    // public static Vector2[] ConvertShapeToPolygon(RectangleShape2D shape, Transform2D transform)
    // {
    //     var size = shape.Size;
    //     return ConvertSizeToPolygon(size, transform);
    // }
    
    /// <summary>
    /// Converts a size vector to a polygon with the given transform.
    /// </summary>
    public static Vector2[] ConvertSizeToPolygon(Vector2 size, Transform2D transform)
    {
        var halfSize = size * 0.5f;
        
        // Define rectangle corners in local space
        var corners = new[]
        {
            new Vector2(-halfSize.X, -halfSize.Y), // Top-left
            new Vector2(halfSize.X, -halfSize.Y),  // Top-right
            new Vector2(halfSize.X, halfSize.Y),   // Bottom-right
            new Vector2(-halfSize.X, halfSize.Y)   // Bottom-left
        };
        
        // Transform corners to world space
        var worldCorners = new Vector2[corners.Length];
        for (var i = 0; i < corners.Length; i++)
        {
            worldCorners[i] = transform.Xform(corners[i]);
        }
        
        return worldCorners;
    }
```

Converts a RectangleShape2D to a polygon representation with the given transform.

**Returns:** `Vector2[]`

**Parameters:**
- `Vector2 size`
- `Transform2D transform`

### ConvertRectangleToPolygon

```csharp
/// <summary>
    /// Converts a rectangle shape to a polygon representation.
    /// </summary>
    public static Vector2[] ConvertRectangleToPolygon(Vector2 size, Transform2D transform)
    {
        return ConvertSizeToPolygon(size, transform);
    }
```

Converts a rectangle shape to a polygon representation.

**Returns:** `Vector2[]`

**Parameters:**
- `Vector2 size`
- `Transform2D transform`

### ConvertCircleToPolygon

```csharp
/// <summary>
    /// Converts a circle shape to a polygon approximation.
    /// </summary>
    public static Vector2[] ConvertCircleToPolygon(float radius, Transform2D transform, int segments = 16)
    {
        if (radius <= 0.0f)
            return Array.Empty<Vector2>();
        
        var vertices = new Vector2[segments];
        var angleStep = 2.0f * MathF.PI / segments;
        
        for (var i = 0; i < segments; i++)
        {
            var angle = i * angleStep;
            var localPoint = new Vector2(
                radius * MathF.Cos(angle),
                radius * MathF.Sin(angle)
            );
            vertices[i] = transform.Xform(localPoint);
        }
        
        return vertices;
    }
```

Converts a circle shape to a polygon approximation.

**Returns:** `Vector2[]`

**Parameters:**
- `float radius`
- `Transform2D transform`
- `int segments`

### ConvertCapsuleToPolygon

```csharp
/// <summary>
    /// Converts a capsule shape to a polygon approximation.
    /// </summary>
    public static Vector2[] ConvertCapsuleToPolygon(float radius, float height, Transform2D transform, int segments = 8)
    {
        if (radius <= 0.0f || height <= 0.0f)
            return Array.Empty<Vector2>();
        
        var halfHeight = height * 0.5f;
        var cylinderHeight = halfHeight - radius;
        
        if (cylinderHeight < 0)
            cylinderHeight = 0;
        
        var vertices = new List<Vector2>();
        var angleStep = MathF.PI / segments;
        
        // Top semicircle
        for (var i = 0; i <= segments; i++)
        {
            var angle = i * angleStep;
            var localPoint = new Vector2(
                radius * MathF.Cos(angle),
                -cylinderHeight + radius * MathF.Sin(angle)
            );
            vertices.Add(transform.Xform(localPoint));
        }
        
        // Bottom semicircle
        for (var i = 0; i <= segments; i++)
        {
            var angle = MathF.PI + i * angleStep;
            var localPoint = new Vector2(
                radius * MathF.Cos(angle),
                cylinderHeight + radius * MathF.Sin(angle)
            );
            vertices.Add(transform.Xform(localPoint));
        }
        
        return vertices.ToArray();
    }
```

Converts a capsule shape to a polygon approximation.

**Returns:** `Vector2[]`

**Parameters:**
- `float radius`
- `float height`
- `Transform2D transform`
- `int segments`

### DoesRectangleOverlapTileOptimized

```csharp
/// <summary>
    /// Checks if a rectangle overlaps with a tile using optimized bounds checking.
    /// </summary>
    public static bool DoesRectangleOverlapTileOptimized(
        Vector2 size, 
        Transform2D transform, 
        Vector2 tilePos, 
        Vector2 tileSize, 
        TileShape tileShape,
        float minOverlapThreshold = 0.01f)
    {
        // Convert rectangle to polygon and use existing overlap detection
        var rectanglePolygon = ConvertRectangleToPolygon(size, transform);
        return DoesPolygonOverlapTile(rectanglePolygon, tilePos, tileSize, tileShape, minOverlapThreshold);
    }
```

Checks if a rectangle overlaps with a tile using optimized bounds checking.

**Returns:** `bool`

**Parameters:**
- `Vector2 size`
- `Transform2D transform`
- `Vector2 tilePos`
- `Vector2 tileSize`
- `TileShape tileShape`
- `float minOverlapThreshold`

### DoesCircleOverlapTileOptimized

```csharp
/// <summary>
    /// Checks if a circle overlaps with a tile using optimized bounds checking.
    /// </summary>
    public static bool DoesCircleOverlapTileOptimized(
        float radius, 
        Transform2D transform, 
        Vector2 tilePos, 
        Vector2 tileSize, 
        TileShape tileShape,
        float minOverlapThreshold = 0.01f)
    {
        // Convert circle to polygon and use existing overlap detection
        var circlePolygon = ConvertCircleToPolygon(radius, transform);
        return DoesPolygonOverlapTile(circlePolygon, tilePos, tileSize, tileShape, minOverlapThreshold);
    }
```

Checks if a circle overlaps with a tile using optimized bounds checking.

**Returns:** `bool`

**Parameters:**
- `float radius`
- `Transform2D transform`
- `Vector2 tilePos`
- `Vector2 tileSize`
- `TileShape tileShape`
- `float minOverlapThreshold`

