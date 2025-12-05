---
title: "CollisionExtensions"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionextensions/"
---

# CollisionExtensions

```csharp
GridBuilding.Godot.Extensions
class CollisionExtensions
{
    // Members...
}
```

Extension methods for Godot types to support collision utilities.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/CollisionExtensions.cs`  
**Namespace:** `GridBuilding.Godot.Extensions`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ToTuple

```csharp
/// <summary>
        /// Converts a Rect2 to a tuple of (min, max) vectors.
        /// </summary>
        /// <param name="rect">The rectangle to convert</param>
        /// <returns>Tuple containing min and max vectors</returns>
        public static (Vector2 min, Vector2 max) ToTuple(this Rect2 rect)
        {
            return (rect.Position, rect.Position + rect.Size);
        }
```

Converts a Rect2 to a tuple of (min, max) vectors.

**Returns:** `(Vector2 min, Vector2 max)`

**Parameters:**
- `Rect2 rect`

### FromMinMax

```csharp
/// <summary>
        /// Creates a rectangle from min and max vectors.
        /// </summary>
        /// <param name="min">Minimum corner</param>
        /// <param name="max">Maximum corner</param>
        /// <returns>Rectangle created from the bounds</returns>
        public static Rect2 FromMinMax(Vector2 min, Vector2 max)
        {
            return new Rect2(min, max - min);
        }
```

Creates a rectangle from min and max vectors.

**Returns:** `Rect2`

**Parameters:**
- `Vector2 min`
- `Vector2 max`

