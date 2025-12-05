---
title: "GBGeometryMathEnhancedCS"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/gbgeometrymathenhancedcs/"
---

# GBGeometryMathEnhancedCS

```csharp
GridBuilding.Godot.Tests.Geometry
class GBGeometryMathEnhancedCS
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Geometry/GeometryMathEnhancedTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetTilePolygon

```csharp
public static float[] GetTilePolygon(Vector2TypeSafeEnhancedCS tilePos, Vector2TypeSafeEnhancedCS tileSize, TileShape shape)
        {
            // Simplified square polygon for testing
            return new float[]
            {
                tilePos.X, tilePos.Y,
                tilePos.X + tileSize.X, tilePos.Y,
                tilePos.X + tileSize.X, tilePos.Y + tileSize.Y,
                tilePos.X, tilePos.Y + tileSize.Y
            };
        }
```

**Returns:** `float[]`

**Parameters:**
- `Vector2TypeSafeEnhancedCS tilePos`
- `Vector2TypeSafeEnhancedCS tileSize`
- `TileShape shape`

### GetPolygonBounds

```csharp
public static Rect2TypeSafeEnhancedCS GetPolygonBounds(float[] polygon)
        {
            // Simplified bounds calculation for testing
            var minX = polygon[0];
            var maxX = polygon[0];
            var minY = polygon[1];
            var maxY = polygon[1];
            
            for (int i = 2; i < polygon.Length; i += 2)
            {
                minX = Math.Min(minX, polygon[i]);
                maxX = Math.Max(maxX, polygon[i]);
                minY = Math.Min(minY, polygon[i + 1]);
                maxY = Math.Max(maxY, polygon[i + 1]);
            }
            
            var position = new Vector2TypeSafeEnhancedCS(minX, minY);
            var size = new Vector2TypeSafeEnhancedCS(maxX - minX, maxY - minY);
            return new Rect2TypeSafeEnhancedCS(position, size);
        }
```

**Returns:** `Rect2TypeSafeEnhancedCS`

**Parameters:**
- `float[] polygon`

### IsPointInPolygon

```csharp
public static bool IsPointInPolygon(Vector2TypeSafeEnhancedCS point, float[] polygon)
        {
            // Simplified point-in-polygon test for square
            var bounds = GetPolygonBounds(polygon);
            return point.X >= bounds.Position.X && point.X <= bounds.Position.X + bounds.Size.X &&
                   point.Y >= bounds.Position.Y && point.Y <= bounds.Position.Y + bounds.Size.Y;
        }
```

**Returns:** `bool`

**Parameters:**
- `Vector2TypeSafeEnhancedCS point`
- `float[] polygon`

### GetDistanceToPolygon

```csharp
public static float GetDistanceToPolygon(Vector2TypeSafeEnhancedCS point, float[] polygon)
        {
            // Simplified distance calculation
            var bounds = GetPolygonBounds(polygon);
            var centerX = bounds.Position.X + bounds.Size.X / 2;
            var centerY = bounds.Position.Y + bounds.Size.Y / 2;
            
            var dx = point.X - centerX;
            var dy = point.Y - centerY;
            return (float)Math.Sqrt(dx * dx + dy * dy);
        }
```

**Returns:** `float`

**Parameters:**
- `Vector2TypeSafeEnhancedCS point`
- `float[] polygon`

