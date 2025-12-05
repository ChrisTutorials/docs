---
title: "GeometryUtils"
description: "Utility class for geometry operations
This will be backported to GDScript utilities"
weight: 20
url: "/gridbuilding/v6-0/api/godot/geometryutils/"
---

# GeometryUtils

```csharp
GridBuilding.Godot.Tests.GoDotTest
class GeometryUtils
{
    // Members...
}
```

Utility class for geometry operations
This will be backported to GDScript utilities

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ManipulationIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### IsPointInPolygon

```csharp
public static bool IsPointInPolygon(Vector2 point, Vector2[] polygon)
    {
        if (polygon.Length < 3) return false;
        
        bool inside = false;
        int j = polygon.Length - 1;
        
        for (int i = 0; i < polygon.Length; i++)
        {
            var pi = polygon[i];
            var pj = polygon[j];
            
            if (((pi.Y > point.Y) != (pj.Y > point.Y)) &&
                (point.X < (pj.X - pi.X) * (point.Y - pi.Y) / (pj.Y - pi.Y) + pi.X))
            {
                inside = !inside;
            }
            j = i;
        }
        
        return inside;
    }
```

**Returns:** `bool`

**Parameters:**
- `Vector2 point`
- `Vector2[] polygon`

