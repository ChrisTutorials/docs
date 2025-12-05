---
title: "Rect2Extensions"
description: "Extension methods for Rect2 to support merging operations."
weight: 20
url: "/gridbuilding/v6-0/api/godot/rect2extensions/"
---

# Rect2Extensions

```csharp
GridBuilding.Godot.Shared.Utils.Collision
class Rect2Extensions
{
    // Members...
}
```

Extension methods for Rect2 to support merging operations.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/CollisionObjectResolver.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Utils.Collision`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Merge

```csharp
/// <summary>
    /// Merges two rectangles into a bounding rectangle that contains both.
    /// </summary>
    /// <param name="rect1">First rectangle</param>
    /// <param name="rect2">Second rectangle</param>
    /// <returns>Merged rectangle</returns>
    public static Rect2 Merge(this Rect2 rect1, Rect2 rect2)
    {
        if (rect1.Size == Vector2.Zero)
            return rect2;
        if (rect2.Size == Vector2.Zero)
            return rect1;

        var minX = Mathf.Min(rect1.Position.X, rect2.Position.X);
        var minY = Mathf.Min(rect1.Position.Y, rect2.Position.Y);
        var maxX = Mathf.Max(rect1.Position.X + rect1.Size.X, rect2.Position.X + rect2.Size.X);
        var maxY = Mathf.Max(rect1.Position.Y + rect1.Size.Y, rect2.Position.Y + rect2.Size.Y);

        return new Rect2(new Vector2(minX, minY), new Vector2(maxX - minX, maxY - minY));
    }
```

Merges two rectangles into a bounding rectangle that contains both.

**Returns:** `Rect2`

**Parameters:**
- `Rect2 rect1`
- `Rect2 rect2`

