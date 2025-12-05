---
title: "GridPosition"
description: "Represents a position in 2D grid coordinates with utility methods for coordinate conversion.
Provides POCS implementation of grid positioning logic without Godot dependencies.
Supports conversion between world coordinates and grid coordinates, adjacency calculations,
and grid-based movement operations.
Ported from: godot/addons/grid_building/shared/utils/positioning/gb_positioning_2d_utils.gd"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/gridposition/"
---

# GridPosition

```csharp
GridBuilding.Core.Grid
struct GridPosition
{
    // Members...
}
```

Represents a position in 2D grid coordinates with utility methods for coordinate conversion.
Provides POCS implementation of grid positioning logic without Godot dependencies.
Supports conversion between world coordinates and grid coordinates, adjacency calculations,
and grid-based movement operations.
Ported from: godot/addons/grid_building/shared/utils/positioning/gb_positioning_2d_utils.gd

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/GridPosition.cs`  
**Namespace:** `GridBuilding.Core.Grid`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ToWorldCoordinates

```csharp
/// <summary>
    /// Convert grid position to world coordinates (tile center).
    /// </summary>
    public Vector2 ToWorldCoordinates()
    {
        return new Vector2(X * TileSize.X + TileSize.X * 0.5f, 
                          Y * TileSize.Y + TileSize.Y * 0.5f);
    }
```

Convert grid position to world coordinates (tile center).

**Returns:** `Vector2`

### ToWorldCoordinates

```csharp
/// <summary>
    /// Convert grid position to world coordinates with custom tile size.
    /// </summary>
    public Vector2 ToWorldCoordinates(Vector2 customTileSize)
    {
        return new Vector2(X * customTileSize.X + customTileSize.X * 0.5f, 
                          Y * customTileSize.Y + customTileSize.Y * 0.5f);
    }
```

Convert grid position to world coordinates with custom tile size.

**Returns:** `Vector2`

**Parameters:**
- `Vector2 customTileSize`

### FromWorldCoordinates

```csharp
/// <summary>
    /// Convert world coordinates to grid position.
    /// </summary>
    public static GridPosition FromWorldCoordinates(Vector2 worldPos, Vector2 tileSize)
    {
        var gridX = (int)MathF.Floor(worldPos.X / tileSize.X);
        var gridY = (int)MathF.Floor(worldPos.Y / tileSize.Y);
        return new GridPosition(gridX, gridY, tileSize);
    }
```

Convert world coordinates to grid position.

**Returns:** `GridPosition`

**Parameters:**
- `Vector2 worldPos`
- `Vector2 tileSize`

### ManhattanDistanceTo

```csharp
/// <summary>
    /// Get the Manhattan distance to another grid position.
    /// </summary>
    public int ManhattanDistanceTo(GridPosition other)
    {
        return System.Math.Abs(X - other.X) + System.Math.Abs(Y - other.Y);
    }
```

Get the Manhattan distance to another grid position.

**Returns:** `int`

**Parameters:**
- `GridPosition other`

### ChebyshevDistanceTo

```csharp
/// <summary>
    /// Get the Chebyshev distance (king's move distance) to another grid position.
    /// </summary>
    public int ChebyshevDistanceTo(GridPosition other)
    {
        return System.Math.Max(System.Math.Abs(X - other.X), System.Math.Abs(Y - other.Y));
    }
```

Get the Chebyshev distance (king's move distance) to another grid position.

**Returns:** `int`

**Parameters:**
- `GridPosition other`

### IsAdjacentTo

```csharp
/// <summary>
    /// Check if this position is adjacent to another position (including diagonals).
    /// </summary>
    public bool IsAdjacentTo(GridPosition other, bool includeDiagonals = true)
    {
        var distance = includeDiagonals ? ChebyshevDistanceTo(other) : ManhattanDistanceTo(other);
        return distance == 1;
    }
```

Check if this position is adjacent to another position (including diagonals).

**Returns:** `bool`

**Parameters:**
- `GridPosition other`
- `bool includeDiagonals`

### GetAdjacentPositions

```csharp
/// <summary>
    /// Get all adjacent positions (8-directional).
    /// </summary>
    public GridPosition[] GetAdjacentPositions()
    {
        var positions = new GridPosition[8];
        var index = 0;
        
        for (var dx = -1; dx <= 1; dx++)
        {
            for (var dy = -1; dy <= 1; dy++)
            {
                if (dx == 0 && dy == 0) continue;
                positions[index++] = new GridPosition(X + dx, Y + dy, TileSize);
            }
        }
        
        return positions;
    }
```

Get all adjacent positions (8-directional).

**Returns:** `GridPosition[]`

### GetOrthogonalPositions

```csharp
/// <summary>
    /// Get orthogonal adjacent positions (4-directional).
    /// </summary>
    public GridPosition[] GetOrthogonalPositions()
    {
        return new[]
        {
            new GridPosition(X + 1, Y, TileSize),     // East
            new GridPosition(X - 1, Y, TileSize),     // West
            new GridPosition(X, Y + 1, TileSize),     // South
            new GridPosition(X, Y - 1, TileSize)      // North
        };
    }
```

Get orthogonal adjacent positions (4-directional).

**Returns:** `GridPosition[]`

### MoveInDirection

```csharp
/// <summary>
    /// Move in a cardinal direction.
    /// </summary>
    public GridPosition MoveInDirection(CardinalDirection direction, int distance = 1)
    {
        var delta = GridRotationUtils.GetDirectionTileDelta(direction);
        return new GridPosition(X + delta.X * distance, Y + delta.Y * distance, TileSize);
    }
```

Move in a cardinal direction.

**Returns:** `GridPosition`

**Parameters:**
- `CardinalDirection direction`
- `int distance`

### Clamp

```csharp
/// <summary>
    /// Clamp position within a rectangular region.
    /// </summary>
    public GridPosition Clamp(GridPosition min, GridPosition max)
    {
        return new GridPosition(
            System.Math.Clamp(X, min.X, max.X),
            System.Math.Clamp(Y, min.Y, max.Y),
            TileSize
        );
    }
```

Clamp position within a rectangular region.

**Returns:** `GridPosition`

**Parameters:**
- `GridPosition min`
- `GridPosition max`

### IsWithinRegion

```csharp
/// <summary>
    /// Check if position is within a rectangular region.
    /// </summary>
    public bool IsWithinRegion(GridPosition min, GridPosition max)
    {
        return X >= min.X && X <= max.X && Y >= min.Y && Y <= max.Y;
    }
```

Check if position is within a rectangular region.

**Returns:** `bool`

**Parameters:**
- `GridPosition min`
- `GridPosition max`

### Equals

```csharp
// IEquatable
    public bool Equals(GridPosition other) => X == other.X && Y == other.Y;
```

**Returns:** `bool`

**Parameters:**
- `GridPosition other`

### Equals

```csharp
public override bool Equals(object? obj) => obj is GridPosition other && Equals(other);
```

**Returns:** `bool`

**Parameters:**
- `object? obj`

### GetHashCode

```csharp
public override int GetHashCode() => HashCode.Combine(X, Y);
```

**Returns:** `int`

### ToString

```csharp
public override string ToString() => $"GridPosition({X}, {Y})";
```

**Returns:** `string`

### GetDirectionTo

```csharp
/// <summary>
    /// Get the direction to another position.
    /// </summary>
    public CardinalDirection GetDirectionTo(GridPosition target)
    {
        var dx = target.X - X;
        var dy = target.Y - Y;
        
        // Normalize to primary direction
        if (System.Math.Abs(dx) > System.Math.Abs(dy))
        {
            return dx > 0 ? CardinalDirection.East : CardinalDirection.West;
        }
        else if (dy != 0)
        {
            return dy > 0 ? CardinalDirection.South : CardinalDirection.North;
        }
        
        return CardinalDirection.North; // Default for same position
    }
```

Get the direction to another position.

**Returns:** `CardinalDirection`

**Parameters:**
- `GridPosition target`

### GetLineTo

```csharp
/// <summary>
    /// Get all positions in a line from this position to target.
    /// </summary>
    public IEnumerable<GridPosition> GetLineTo(GridPosition target)
    {
        var dx = System.Math.Abs(target.X - X);
        var dy = System.Math.Abs(target.Y - Y);
        var sx = X < target.X ? 1 : -1;
        var sy = Y < target.Y ? 1 : -1;
        var err = dx - dy;
        
        var currentX = X;
        var currentY = Y;
        
        while (true)
        {
            yield return new GridPosition(currentX, currentY, TileSize);
            
            if (currentX == target.X && currentY == target.Y) break;
            
            var e2 = 2 * err;
            if (e2 > -dy)
            {
                err -= dy;
                currentX += sx;
            }
            if (e2 < dx)
            {
                err += dx;
                currentY += sy;
            }
        }
    }
```

Get all positions in a line from this position to target.

**Returns:** `IEnumerable<GridPosition>`

**Parameters:**
- `GridPosition target`

### GetPositionsInRadius

```csharp
/// <summary>
    /// Get positions in a radius around this position.
    /// </summary>
    public IEnumerable<GridPosition> GetPositionsInRadius(int radius)
    {
        for (var x = X - radius; x <= X + radius; x++)
        {
            for (var y = Y - radius; y <= Y + radius; y++)
            {
                var pos = new GridPosition(x, y, TileSize);
                if (ChebyshevDistanceTo(pos) <= radius)
                {
                    yield return pos;
                }
            }
        }
    }
```

Get positions in a radius around this position.

**Returns:** `IEnumerable<GridPosition>`

**Parameters:**
- `int radius`

### GetPositionsInRectangle

```csharp
/// <summary>
    /// Get positions in a rectangle around this position.
    /// </summary>
    public IEnumerable<GridPosition> GetPositionsInRectangle(int width, int height)
    {
        var halfWidth = width / 2;
        var halfHeight = height / 2;
        
        for (var x = X - halfWidth; x <= X + halfWidth; x++)
        {
            for (var y = Y - halfHeight; y <= Y + halfHeight; y++)
            {
                yield return new GridPosition(x, y, TileSize);
            }
        }
    }
```

Get positions in a rectangle around this position.

**Returns:** `IEnumerable<GridPosition>`

**Parameters:**
- `int width`
- `int height`

