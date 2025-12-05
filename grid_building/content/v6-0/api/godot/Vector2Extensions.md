---
title: "Vector2Extensions"
description: "Extension methods for Vector2 to support orthogonal calculations."
weight: 20
url: "/gridbuilding/v6-0/api/godot/vector2extensions/"
---

# Vector2Extensions

```csharp
GridBuilding.Godot.Shared.Utils.Geometry
class Vector2Extensions
{
    // Members...
}
```

Extension methods for Vector2 to support orthogonal calculations.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/CollisionGeometryUtils.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Utils.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Orthogonal

```csharp
/// <summary>
    /// Gets the orthogonal (perpendicular) vector.
    /// </summary>
    /// <param name="vector">Original vector</param>
    /// <returns>Orthogonal vector (rotated 90 degrees counter-clockwise)</returns>
    public static Vector2 Orthogonal(this Vector2 vector)
    {
        return new Vector2(-vector.Y, vector.X);
    }
```

Gets the orthogonal (perpendicular) vector.

**Returns:** `Vector2`

**Parameters:**
- `Vector2 vector`

