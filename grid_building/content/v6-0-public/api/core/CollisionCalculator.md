---
title: "CollisionCalculator"
description: "Core collision calculation service.
Contains pure business logic without Godot dependencies."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/collisioncalculator/"
---

# CollisionCalculator

```csharp
GridBuilding.Core.Services.Placement
class CollisionCalculator
{
    // Members...
}
```

Core collision calculation service.
Contains pure business logic without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Placement/CollisionCalculator.cs`  
**Namespace:** `GridBuilding.Core.Services.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CheckCollision

```csharp
/// <summary>
        /// Checks if a footprint collides with occupied cells at the given position.
        /// </summary>
        public bool CheckCollision(FootprintData footprint, Vector2I position, IGridOccupancy occupancy)
        {
            if (footprint == null || occupancy == null)
                return false;

            var occupiedCells = GetOccupiedCells(footprint, position);
            return occupiedCells.Any(occupancy.IsOccupied);
        }
```

Checks if a footprint collides with occupied cells at the given position.

**Returns:** `bool`

**Parameters:**
- `FootprintData footprint`
- `Vector2I position`
- `IGridOccupancy occupancy`

### GetCollisionCells

```csharp
/// <summary>
        /// Gets all cells that would be occupied by the footprint at the given position.
        /// </summary>
        public List<Vector2I> GetCollisionCells(FootprintData footprint, Vector2I position)
        {
            if (footprint == null)
                return new List<Vector2I>();

            return GetOccupiedCells(footprint, position);
        }
```

Gets all cells that would be occupied by the footprint at the given position.

**Returns:** `List<Vector2I>`

**Parameters:**
- `FootprintData footprint`
- `Vector2I position`

### HasCollision

```csharp
/// <summary>
        /// Checks if the footprint has any collision at the given position.
        /// </summary>
        public bool HasCollision(FootprintData footprint, Vector2I position)
        {
            if (footprint == null)
                return false;

            // Basic implementation - just check if position is valid
            return position.X >= 0 && position.Y >= 0;
        }
```

Checks if the footprint has any collision at the given position.

**Returns:** `bool`

**Parameters:**
- `FootprintData footprint`
- `Vector2I position`

