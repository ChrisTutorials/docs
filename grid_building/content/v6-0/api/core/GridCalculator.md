---
title: "GridCalculator"
description: "Core grid calculation service.
Contains pure business logic without Godot dependencies."
weight: 10
url: "/gridbuilding/v6-0/api/core/gridcalculator/"
---

# GridCalculator

```csharp
GridBuilding.Core.Services.Placement
class GridCalculator
{
    // Members...
}
```

Core grid calculation service.
Contains pure business logic without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Placement/GridCalculator.cs`  
**Namespace:** `GridBuilding.Core.Services.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CalculateGridPosition

```csharp
/// <summary>
        /// Converts a world position to grid position.
        /// </summary>
        public Vector2I CalculateGridPosition(object worldPosition)
        {
            // Basic implementation - would need world position type in real scenario
            // For now, return origin
            return new Vector2I(0, 0);
        }
```

Converts a world position to grid position.

**Returns:** `Vector2I`

**Parameters:**
- `object worldPosition`

### GetOccupiedCells

```csharp
/// <summary>
        /// Gets all cells that would be occupied by the footprint at the given position.
        /// </summary>
        public List<Vector2I> GetOccupiedCells(FootprintData footprint, Vector2I position)
        {
            var cells = new List<Vector2I>();
            if (footprint == null)
                return cells;

            var size = footprint.Size;
            
            for (int x = 0; x < size.X; x++)
            {
                for (int y = 0; y < size.Y; y++)
                {
                    cells.Add(new Vector2I(position.X + x, position.Y + y));
                }
            }
            
            return cells;
        }
```

Gets all cells that would be occupied by the footprint at the given position.

**Returns:** `List<Vector2I>`

**Parameters:**
- `FootprintData footprint`
- `Vector2I position`

### IsValidGridPosition

```csharp
/// <summary>
        /// Checks if a grid position is valid.
        /// </summary>
        public bool IsValidGridPosition(Vector2I position)
        {
            return position.X >= 0 && position.Y >= 0;
        }
```

Checks if a grid position is valid.

**Returns:** `bool`

**Parameters:**
- `Vector2I position`

### GetBounds

```csharp
/// <summary>
        /// Gets the bounds of the footprint at the given position.
        /// </summary>
        public RectangleI GetBounds(FootprintData footprint, Vector2I position)
        {
            if (footprint == null)
                return new RectangleI(position.X, position.Y, 0, 0);

            return new RectangleI(position.X, position.Y, footprint.Size.X, footprint.Size.Y);
        }
```

Gets the bounds of the footprint at the given position.

**Returns:** `RectangleI`

**Parameters:**
- `FootprintData footprint`
- `Vector2I position`

