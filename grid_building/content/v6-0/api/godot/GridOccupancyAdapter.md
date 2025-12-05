---
title: "GridOccupancyAdapter"
description: "Godot adapter for IGridOccupancy interface.
Bridges Godot's GridTargetingState to Core's IGridOccupancy interface."
weight: 20
url: "/gridbuilding/v6-0/api/godot/gridoccupancyadapter/"
---

# GridOccupancyAdapter

```csharp
GridBuilding.Godot.Systems.Placement.Adapters
class GridOccupancyAdapter
{
    // Members...
}
```

Godot adapter for IGridOccupancy interface.
Bridges Godot's GridTargetingState to Core's IGridOccupancy interface.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Adapters/GridOccupancyAdapter.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Adapters`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### IsOccupied

```csharp
/// <summary>
    /// Checks if a grid position is occupied.
    /// </summary>
    public bool IsOccupied(Vector2I position)
    {
        var godotPos = position.ToGodot();
        return _targetingState.IsPositionOccupied(godotPos);
    }
```

Checks if a grid position is occupied.

**Returns:** `bool`

**Parameters:**
- `Vector2I position`

### GetOccupant

```csharp
/// <summary>
    /// Gets the occupant at a grid position.
    /// </summary>
    public IOccupantData GetOccupant(Vector2I position)
    {
        var godotPos = position.ToGodot();
        var occupant = _targetingState.GetOccupant(godotPos);
        
        if (occupant == null)
            return null;
        
        return new OccupantDataAdapter(occupant);
    }
```

Gets the occupant at a grid position.

**Returns:** `IOccupantData`

**Parameters:**
- `Vector2I position`

### GetOccupiedPositions

```csharp
/// <summary>
    /// Gets all occupied positions in the grid.
    /// </summary>
    public ISet<Vector2I> GetOccupiedPositions()
    {
        var occupiedPositions = _targetingState.GetOccupiedPositions();
        var result = new HashSet<Vector2I>();
        
        foreach (var pos in occupiedPositions)
        {
            result.Add(pos.ToCore());
        }
        
        return result;
    }
```

Gets all occupied positions in the grid.

**Returns:** `ISet<Vector2I>`

### HasOccupancy

```csharp
/// <summary>
    /// Checks if any position in a collection is occupied.
    /// </summary>
    public bool HasOccupancy(IEnumerable<Vector2I> positions)
    {
        foreach (var position in positions)
        {
            if (IsOccupied(position))
                return true;
        }
        return false;
    }
```

Checks if any position in a collection is occupied.

**Returns:** `bool`

**Parameters:**
- `IEnumerable<Vector2I> positions`

### GetGridSize

```csharp
/// <summary>
    /// Gets the size of the grid.
    /// </summary>
    public Vector2I GetGridSize()
    {
        var mapRect = _targetingState.TargetMap?.GetUsedRect();
        if (mapRect.HasValue)
        {
            return new Vector2I(mapRect.Value.Size.X, mapRect.Value.Size.Y);
        }
        
        // Fallback to a reasonable default
        return new Vector2I(100, 100);
    }
```

Gets the size of the grid.

**Returns:** `Vector2I`

### IsInBounds

```csharp
/// <summary>
    /// Checks if a position is within grid bounds.
    /// </summary>
    public bool IsInBounds(Vector2I position)
    {
        var gridSize = GetGridSize();
        return position.X >= 0 && position.X < gridSize.X &&
               position.Y >= 0 && position.Y < gridSize.Y;
    }
```

Checks if a position is within grid bounds.

**Returns:** `bool`

**Parameters:**
- `Vector2I position`

