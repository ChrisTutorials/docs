---
title: "CollisionUtilities"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionutilities/"
---

# CollisionUtilities

```csharp
GridBuilding.Godot.Systems.Placement.Processors
class CollisionUtilities
{
    // Members...
}
```

Static utility methods for collision mapping.
C# implementation of GDScript CollisionUtilities

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Processors/CollisionUtilities.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Processors`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetRectTilePositions

```csharp
/// <summary>
    /// Returns absolute tile coordinates overlapped by a rectangle centered at a world position.
    /// Enhanced version using shared utilities.
    /// </summary>
    public static List<Vector2I> GetRectTilePositions(
        TileMapLayer? map, Vector2 globalCenterPosition, Vector2 transformedRectSize
    )
    {
        return Shared.Utils.Collision.CollisionUtilities.GetRectTilePositions(
            map, globalCenterPosition, transformedRectSize);
    }
```

Returns absolute tile coordinates overlapped by a rectangle centered at a world position.
Enhanced version using shared utilities.

**Returns:** `List<Vector2I>`

**Parameters:**
- `TileMapLayer? map`
- `Vector2 globalCenterPosition`
- `Vector2 transformedRectSize`

### DoesIndicatorOverlapShape

```csharp
/// <summary>
    /// Tests collision between indicator and a target shape.
    /// Enhanced version using shared utilities.
    /// </summary>
    public static bool DoesIndicatorOverlapShape(
        RuleCheckIndicator? tileIndicator, Shape2D? shape, Node2D? shapeOwner
    )
    {
        return Shared.Utils.Collision.CollisionUtilities.DoesIndicatorOverlapShape(
            tileIndicator, shape, shapeOwner);
    }
```

Tests collision between indicator and a target shape.
Enhanced version using shared utilities.

**Returns:** `bool`

**Parameters:**
- `RuleCheckIndicator? tileIndicator`
- `Shape2D? shape`
- `Node2D? shapeOwner`

### ObjectMatchesLayerMask

```csharp
/// <summary>
    /// Check if a collision object matches the given layer mask
    /// </summary>
    public static bool ObjectMatchesLayerMask(CollisionObject2D? collisionObject, int mask)
    {
        if (collisionObject == null)
            return false;

        // Check if any bits match between the object's layer and the mask
        return (collisionObject.CollisionLayer & (uint)mask) != 0;
    }
```

Check if a collision object matches the given layer mask

**Returns:** `bool`

**Parameters:**
- `CollisionObject2D? collisionObject`
- `int mask`

### BuildShapeTransform

```csharp
/// <summary>
    /// Builds a world transform for a specific collision shape_owner attached to a col_obj.
    /// Enhanced version using shared utilities.
    /// </summary>
    public static Transform2D BuildShapeTransform(Node2D colObj, Node2D shapeOwner)
    {
        return Shared.Utils.Collision.CollisionUtilities.BuildShapeTransform(
            colObj.GlobalPosition, colObj.Rotation, colObj.Scale, shapeOwner.Position);
    }
```

Builds a world transform for a specific collision shape_owner attached to a col_obj.
Enhanced version using shared utilities.

**Returns:** `Transform2D`

**Parameters:**
- `Node2D colObj`
- `Node2D shapeOwner`

### CenterTileForShapeObject

```csharp
/// <summary>
    /// Computes the center tile for a collision shape-carrying object on a TileMap layer.
    /// </summary>
    public static Vector2I CenterTileForShapeObject(TileMapLayer map, Node2D colObj)
    {
        if (map == null || colObj == null)
            return Vector2I.Zero;
        return map.LocalToMap(map.ToLocal(colObj.GlobalPosition));
    }
```

Computes the center tile for a collision shape-carrying object on a TileMap layer.

**Returns:** `Vector2I`

**Parameters:**
- `TileMapLayer map`
- `Node2D colObj`

### CenterTileForPolygonPositioner

```csharp
/// <summary>
    /// Computes the center tile for a polygon positioner node on a given TileMap layer.
    /// </summary>
    public static Vector2I CenterTileForPolygonPositioner(TileMapLayer map, Node2D positioner)
    {
        if (map == null || positioner == null)
            return Vector2I.Zero;
        return map.LocalToMap(map.ToLocal(positioner.GlobalPosition));
    }
```

Computes the center tile for a polygon positioner node on a given TileMap layer.

**Returns:** `Vector2I`

**Parameters:**
- `TileMapLayer map`
- `Node2D positioner`

### ComputeTileIterationRange

```csharp
/// <summary>
    /// Converts world-space bounds to a tile iteration range.
    /// Returns tuple (start, endExclusive).
    /// </summary>
    public static (Vector2I Start, Vector2I EndExclusive) ComputeTileIterationRange(Rect2 bounds, TileMapLayer map)
    {
        if (map == null)
            return (Vector2I.Zero, Vector2I.Zero);

        var epsilon = 0.0001f;
        var adjustedMinCorner = bounds.Position + new Vector2(epsilon, epsilon);
        var startTile = map.LocalToMap(map.ToLocal(adjustedMinCorner));
        
        var adjustedMaxCorner = bounds.Position + bounds.Size - new Vector2(epsilon, epsilon);
        var endTileInclusive = map.LocalToMap(map.ToLocal(adjustedMaxCorner));
        var endExclusive = new Vector2I(endTileInclusive.X + 1, endTileInclusive.Y + 1);
        
        return (startTile, endExclusive);
    }
```

Converts world-space bounds to a tile iteration range.
Returns tuple (start, endExclusive).

**Returns:** `(Vector2I Start, Vector2I EndExclusive)`

**Parameters:**
- `Rect2 bounds`
- `TileMapLayer map`

### ToWorldPolygon

```csharp
/// <summary>
    /// Converts a CollisionPolygon2D to world-space points.
    /// Enhanced version using shared utilities.
    /// </summary>
    public static Vector2[] ToWorldPolygon(CollisionPolygon2D polygonNode)
    {
        return CollisionObjectResolver.GetCollisionPolygon(polygonNode);
    }
```

Converts a CollisionPolygon2D to world-space points.
Enhanced version using shared utilities.

**Returns:** `Vector2[]`

**Parameters:**
- `CollisionPolygon2D polygonNode`

### ConvertShapeToPolygon

```csharp
/// <summary>
    /// Converts a Shape2D to a polygon representation with the given transform.
    /// </summary>
    public static Vector2[] ConvertShapeToPolygon(Shape2D shape, Transform2D transform)
    {
        if (shape is RectangleShape2D rectShape)
        {
            var halfSize = rectShape.Size * 0.5f;
            var corners = new[]
            {
                new Vector2(-halfSize.X, -halfSize.Y),
                new Vector2(halfSize.X, -halfSize.Y),
                new Vector2(halfSize.X, halfSize.Y),
                new Vector2(-halfSize.X, halfSize.Y)
            };
            
            var worldCorners = new Vector2[4];
            for (int i = 0; i < 4; i++)
            {
                worldCorners[i] = transform * corners[i];
            }
            return worldCorners;
        }
        else if (shape is ConvexPolygonShape2D convexShape)
        {
            var points = convexShape.Points;
            var worldPoints = new Vector2[points.Length];
            for (int i = 0; i < points.Length; i++)
            {
                worldPoints[i] = transform * points[i];
            }
            return worldPoints;
        }
        else if (shape is ConcavePolygonShape2D concaveShape)
        {
             var points = concaveShape.Segments; // Segments are pairs of points
             // This might be wrong if we want a filled polygon. Concave shapes are usually lines.
             // For now, let's just return transformed points.
             var worldPoints = new Vector2[points.Length];
             for (int i = 0; i < points.Length; i++)
             {
                 worldPoints[i] = transform * points[i];
             }
             return worldPoints;
        }
        
        // For Circle and Capsule, we might approximate with a polygon if needed, 
        // but for now we return empty as the original code seems to handle specific shapes 
        // via "shape is CircleShape2D" checks separately in some places, 
        // but _process_shape_offsets expects a polygon.
        // If we return empty, _calculate_tile_range falls back to AABB which is good.
        
        return System.Array.Empty<Vector2>();
    }
```

Converts a Shape2D to a polygon representation with the given transform.

**Returns:** `Vector2[]`

**Parameters:**
- `Shape2D shape`
- `Transform2D transform`

### ComputePolygonTileOffsets

```csharp
/// <summary>
    /// Compute polygon tile offsets relative to a center tile.
    /// Enhanced version using shared utilities.
    /// </summary>
    public static List<Vector2I> ComputePolygonTileOffsets(
        Vector2[] worldPoints,
        Vector2 tileSize,
        Vector2I centerTile,
        TileSet.TileShapeEnum tileShape,
        TileMapLayer? tileMapLayer
    )
    {
        return Shared.Utils.Collision.CollisionUtilities.ComputePolygonTileOffsets(
            worldPoints, tileSize, centerTile, tileShape, tileMapLayer);
    }
```

Compute polygon tile offsets relative to a center tile.
Enhanced version using shared utilities.

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2[] worldPoints`
- `Vector2 tileSize`
- `Vector2I centerTile`
- `TileSet.TileShapeEnum tileShape`
- `TileMapLayer? tileMapLayer`

### CalculateTileRange

```csharp
/// <summary>
    /// Calculates tile range for a shape with optional filtering.
    /// New method using shared utilities.
    /// </summary>
    public static TileRange CalculateTileRange(
        Vector2 size,
        Transform2D transform,
        Vector2 tileSize,
        TileSet.TileShapeEnum tileShape,
        TileFilterType filterType = TileFilterType.None)
    {
        return Shared.Utils.Collision.CollisionUtilities.CalculateTileRange(
            size, transform, tileSize, tileShape, filterType);
    }
```

Calculates tile range for a shape with optional filtering.
New method using shared utilities.

**Returns:** `TileRange`

**Parameters:**
- `Vector2 size`
- `Transform2D transform`
- `Vector2 tileSize`
- `TileSet.TileShapeEnum tileShape`
- `TileFilterType filterType`

### ValidateCollisionObject

```csharp
/// <summary>
    /// Validates a collision object for placement operations.
    /// New method using shared utilities.
    /// </summary>
    public static List<string> ValidateCollisionObject(Node node)
    {
        return CollisionObjectResolver.ValidateCollisionObject(node);
    }
```

Validates a collision object for placement operations.
New method using shared utilities.

**Returns:** `List<string>`

**Parameters:**
- `Node node`

### GetEffectiveCollisionShape

```csharp
/// <summary>
    /// Gets the effective collision shape for a node.
    /// New method using shared utilities.
    /// </summary>
    public static EffectiveCollisionShape GetEffectiveCollisionShape(Node node)
    {
        return CollisionObjectResolver.GetEffectiveCollisionShape(node);
    }
```

Gets the effective collision shape for a node.
New method using shared utilities.

**Returns:** `EffectiveCollisionShape`

**Parameters:**
- `Node node`

### IsPolygonConvex

```csharp
/// <summary>
    /// Checks if a polygon is convex.
    /// New method using shared utilities.
    /// </summary>
    public static bool IsPolygonConvex(Vector2[] polygon)
    {
        return CollisionGeometryUtils.IsPolygonConvex(polygon);
    }
```

Checks if a polygon is convex.
New method using shared utilities.

**Returns:** `bool`

**Parameters:**
- `Vector2[] polygon`

### GetPolygonArea

```csharp
/// <summary>
    /// Gets the area of a polygon.
    /// New method using shared utilities.
    /// </summary>
    public static float GetPolygonArea(Vector2[] polygon)
    {
        return CollisionGeometryUtils.GetPolygonArea(polygon);
    }
```

Gets the area of a polygon.
New method using shared utilities.

**Returns:** `float`

**Parameters:**
- `Vector2[] polygon`

### GetPolygonCentroid

```csharp
/// <summary>
    /// Gets the centroid of a polygon.
    /// New method using shared utilities.
    /// </summary>
    public static Vector2 GetPolygonCentroid(Vector2[] polygon)
    {
        return CollisionGeometryUtils.GetPolygonCentroid(polygon);
    }
```

Gets the centroid of a polygon.
New method using shared utilities.

**Returns:** `Vector2`

**Parameters:**
- `Vector2[] polygon`

### ExpandPolygon

```csharp
/// <summary>
    /// Expands a polygon by the specified amount.
    /// New method using shared utilities.
    /// </summary>
    public static Vector2[] ExpandPolygon(Vector2[] polygon, float expansion)
    {
        return CollisionGeometryUtils.ExpandPolygon(polygon, expansion);
    }
```

Expands a polygon by the specified amount.
New method using shared utilities.

**Returns:** `Vector2[]`

**Parameters:**
- `Vector2[] polygon`
- `float expansion`

### SimplifyPolygon

```csharp
/// <summary>
    /// Simplifies a polygon by removing collinear points.
    /// New method using shared utilities.
    /// </summary>
    public static Vector2[] SimplifyPolygon(Vector2[] polygon, float tolerance = 0.001f)
    {
        return CollisionGeometryUtils.SimplifyPolygon(polygon, tolerance);
    }
```

Simplifies a polygon by removing collinear points.
New method using shared utilities.

**Returns:** `Vector2[]`

**Parameters:**
- `Vector2[] polygon`
- `float tolerance`

