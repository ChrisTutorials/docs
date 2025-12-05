---
title: "GridUtilities"
description: "Common utility functions for grid operations"
weight: 10
url: "/gridbuilding/v6-0/api/core/gridutilities/"
---

# GridUtilities

```csharp
GridBuilding.Core.Utilities
class GridUtilities
{
    // Members...
}
```

Common utility functions for grid operations

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Utilities/GridUtilities.cs`  
**Namespace:** `GridBuilding.Core.Utilities`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### WorldToGrid

```csharp
/// <summary>
    /// Converts world coordinates to grid coordinates
    /// </summary>
    public static Vector2I WorldToGrid(Vector2 worldPosition, int gridSize = 1)
    {
        return new Vector2I(
            (int)System.Math.Floor(worldPosition.X / gridSize),
            (int)System.Math.Floor(worldPosition.Y / gridSize)
        );
    }
```

Converts world coordinates to grid coordinates

**Returns:** `Vector2I`

**Parameters:**
- `Vector2 worldPosition`
- `int gridSize`

### GridToWorld

```csharp
/// <summary>
    /// Converts grid coordinates to world coordinates
    /// </summary>
    public static Vector2 GridToWorld(Vector2I gridPosition, int gridSize = 1)
    {
        return new Vector2(
            gridPosition.X * gridSize,
            gridPosition.Y * gridSize
        );
    }
```

Converts grid coordinates to world coordinates

**Returns:** `Vector2`

**Parameters:**
- `Vector2I gridPosition`
- `int gridSize`

### IsValidGridPosition

```csharp
/// <summary>
    /// Checks if a grid position is valid (non-negative)
    /// </summary>
    public static bool IsValidGridPosition(Vector2I position)
    {
        return position.X >= 0 && position.Y >= 0;
    }
```

Checks if a grid position is valid (non-negative)

**Returns:** `bool`

**Parameters:**
- `Vector2I position`

### ManhattanDistance

```csharp
/// <summary>
    /// Gets the Manhattan distance between two grid positions
    /// </summary>
    public static int ManhattanDistance(Vector2I from, Vector2I to)
    {
        return System.Math.Abs(from.X - to.X) + System.Math.Abs(from.Y - to.Y);
    }
```

Gets the Manhattan distance between two grid positions

**Returns:** `int`

**Parameters:**
- `Vector2I from`
- `Vector2I to`

### GetPositionsInRadius

```csharp
/// <summary>
    /// Gets all grid positions within a certain radius
    /// </summary>
    public static Vector2I[] GetPositionsInRadius(Vector2I center, int radius)
    {
        var positions = new List<Vector2I>();
        
        for (int x = center.X - radius; x <= center.X + radius; x++)
        {
            for (int y = center.Y - radius; y <= center.Y + radius; y++)
            {
                var pos = new Vector2I(x, y);
                if (ManhattanDistance(center, pos) <= radius)
                {
                    positions.Add(pos);
                }
            }
        }
        
        return positions.ToArray();
    }
```

Gets all grid positions within a certain radius

**Returns:** `Vector2I[]`

**Parameters:**
- `Vector2I center`
- `int radius`

