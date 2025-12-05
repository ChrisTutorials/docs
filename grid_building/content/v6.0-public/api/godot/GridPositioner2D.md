---
title: "GridPositioner2D"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/gridpositioner2d/"
---

# GridPositioner2D

```csharp
GridBuilding.Godot.Utilities
class GridPositioner2D
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/GridPositioner2D.cs`  
**Namespace:** `GridBuilding.Godot.Utilities`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### GridSize

```csharp
[Export] public Vector2I GridSize 
        { 
            get => _gridSize; 
            set => SetGridSize(value);
        }
```

### TileSize

```csharp
[Export] public Vector2 TileSize 
        { 
            get => _tileSize; 
            set => SetTileSize(value);
        }
```

### SnapToGrid

```csharp
[Export] public bool SnapToGrid 
        { 
            get => _snapToGrid; 
            set => SetSnapToGrid(value);
        }
```

### ConstrainToBounds

```csharp
[Export] public bool ConstrainToBounds 
        { 
            get => _constrainToBounds; 
            set => SetConstrainToBounds(value);
        }
```

### CurrentGridPosition

```csharp
public Vector2I CurrentGridPosition => _currentGridPosition;
```

### GridBounds

```csharp
public Rect2I GridBounds => _gridBounds;
```

### WorldPosition

```csharp
public Vector2 WorldPosition => Position;
```


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            base._Ready();
            
            UpdateGridBounds();
            UpdateGridPosition();
        }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
        {
            base._Process(delta);
            
            // Update grid position if position changed
            UpdateGridPosition();
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### WorldToGrid

```csharp
/// <summary>
        /// Converts world position to grid position
        /// </summary>
        /// <param name="worldPosition">World position</param>
        /// <returns>Grid position</returns>
        public Vector2I WorldToGrid(Vector2 worldPosition)
        {
            var gridX = Mathf.FloorToInt(worldPosition.X / _tileSize.X);
            var gridY = Mathf.FloorToInt(worldPosition.Y / _tileSize.Y);
            
            return new Vector2I(gridX, gridY);
        }
```

Converts world position to grid position

**Returns:** `Vector2I`

**Parameters:**
- `Vector2 worldPosition`

### GridToWorld

```csharp
/// <summary>
        /// Converts grid position to world position
        /// </summary>
        /// <param name="gridPosition">Grid position</param>
        /// <param name="centerOnTile">Whether to center on tile</param>
        /// <returns>World position</returns>
        public Vector2 GridToWorld(Vector2I gridPosition, bool centerOnTile = false)
        {
            var worldX = gridPosition.X * _tileSize.X;
            var worldY = gridPosition.Y * _tileSize.Y;
            
            if (centerOnTile)
            {
                worldX += _tileSize.X / 2.0f;
                worldY += _tileSize.Y / 2.0f;
            }
            
            return new Vector2(worldX, worldY);
        }
```

Converts grid position to world position

**Returns:** `Vector2`

**Parameters:**
- `Vector2I gridPosition`
- `bool centerOnTile`

### SnapToGridPosition

```csharp
/// <summary>
        /// Snaps a world position to the grid
        /// </summary>
        /// <param name="worldPosition">World position to snap</param>
        /// <param name="centerOnTile">Whether to center on tile</param>
        /// <returns>Snapped world position</returns>
        public Vector2 SnapToGridPosition(Vector2 worldPosition, bool centerOnTile = false)
        {
            var gridPos = WorldToGrid(worldPosition);
            return GridToWorld(gridPos, centerOnTile);
        }
```

Snaps a world position to the grid

**Returns:** `Vector2`

**Parameters:**
- `Vector2 worldPosition`
- `bool centerOnTile`

### SetGridPosition

```csharp
/// <summary>
        /// Sets the grid position
        /// </summary>
        /// <param name="gridPosition">New grid position</param>
        public void SetGridPosition(Vector2I gridPosition)
        {
            var oldPosition = _currentGridPosition;
            
            // Constrain to bounds if enabled
            if (_constrainToBounds)
            {
                gridPosition = ConstrainToGridBounds(gridPosition);
            }
            
            _currentGridPosition = gridPosition;
            
            // Update world position
            Position = GridToWorld(gridPosition);
            
            if (oldPosition != gridPosition)
            {
                EmitSignal(SignalName.GridPositionChanged, oldPosition, gridPosition);
            }
        }
```

Sets the grid position

**Returns:** `void`

**Parameters:**
- `Vector2I gridPosition`

### SetWorldPosition

```csharp
/// <summary>
        /// Sets the world position
        /// </summary>
        /// <param name="worldPosition">New world position</param>
        public void SetWorldPosition(Vector2 worldPosition)
        {
            var oldGridPosition = _currentGridPosition;
            
            // Snap to grid if enabled
            if (_snapToGrid)
            {
                worldPosition = SnapToGridPosition(worldPosition);
            }
            
            // Constrain to bounds if enabled
            if (_constrainToBounds)
            {
                var gridPos = WorldToGrid(worldPosition);
                gridPos = ConstrainToGridBounds(gridPos);
                worldPosition = GridToWorld(gridPos);
            }
            
            Position = worldPosition;
            UpdateGridPosition();
            
            if (oldGridPosition != _currentGridPosition)
            {
                EmitSignal(SignalName.GridPositionChanged, oldGridPosition, _currentGridPosition);
            }
        }
```

Sets the world position

**Returns:** `void`

**Parameters:**
- `Vector2 worldPosition`

### ConstrainToGridBounds

```csharp
/// <summary>
        /// Constrains a grid position to the grid bounds
        /// </summary>
        /// <param name="gridPosition">Grid position to constrain</param>
        /// <returns>Constrained grid position</returns>
        public Vector2I ConstrainToGridBounds(Vector2I gridPosition)
        {
            var constrained = gridPosition;
            
            constrained.X = Mathf.Clamp(constrained.X, _gridBounds.Position.X, _gridBounds.Position.X + _gridBounds.Size.X - 1);
            constrained.Y = Mathf.Clamp(constrained.Y, _gridBounds.Position.Y, _gridBounds.Position.Y + _gridBounds.Size.Y - 1);
            
            return constrained;
        }
```

Constrains a grid position to the grid bounds

**Returns:** `Vector2I`

**Parameters:**
- `Vector2I gridPosition`

### IsGridPositionInBounds

```csharp
/// <summary>
        /// Checks if a grid position is within bounds
        /// </summary>
        /// <param name="gridPosition">Grid position to check</param>
        /// <returns>True if within bounds</returns>
        public bool IsGridPositionInBounds(Vector2I gridPosition)
        {
            return _gridBounds.HasPoint(gridPosition);
        }
```

Checks if a grid position is within bounds

**Returns:** `bool`

**Parameters:**
- `Vector2I gridPosition`

### IsWorldPositionInBounds

```csharp
/// <summary>
        /// Checks if a world position is within bounds
        /// </summary>
        /// <param name="worldPosition">World position to check</param>
        /// <returns>True if within bounds</returns>
        public bool IsWorldPositionInBounds(Vector2 worldPosition)
        {
            var gridPos = WorldToGrid(worldPosition);
            return IsGridPositionInBounds(gridPos);
        }
```

Checks if a world position is within bounds

**Returns:** `bool`

**Parameters:**
- `Vector2 worldPosition`

### GetGridPositionsInArea

```csharp
/// <summary>
        /// Gets all grid positions in a rectangular area
        /// </summary>
        /// <param name="startPos">Starting position</param>
        /// <param name="size">Size of area</param>
        /// <returns>List of grid positions</returns>
        public List<Vector2I> GetGridPositionsInArea(Vector2I startPos, Vector2I size)
        {
            var positions = new List<Vector2I>();
            
            for (int x = 0; x < size.X; x++)
            {
                for (int y = 0; y < size.Y; y++)
                {
                    var pos = startPos + new Vector2I(x, y);
                    if (IsGridPositionInBounds(pos))
                    {
                        positions.Add(pos);
                    }
                }
            }
            
            return positions;
        }
```

Gets all grid positions in a rectangular area

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I startPos`
- `Vector2I size`

### GetGridPositionsInCircle

```csharp
/// <summary>
        /// Gets all grid positions in a circular area
        /// </summary>
        /// <param name="centerPos">Center position</param>
        /// <param name="radius">Radius in grid units</param>
        /// <returns>List of grid positions</returns>
        public List<Vector2I> GetGridPositionsInCircle(Vector2I centerPos, int radius)
        {
            var positions = new List<Vector2I>();
            
            for (int x = -radius; x <= radius; x++)
            {
                for (int y = -radius; y <= radius; y++)
                {
                    var distance = Mathf.Sqrt(x * x + y * y);
                    if (distance <= radius)
                    {
                        var pos = centerPos + new Vector2I(x, y);
                        if (IsGridPositionInBounds(pos))
                        {
                            positions.Add(pos);
                        }
                    }
                }
            }
            
            return positions;
        }
```

Gets all grid positions in a circular area

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I centerPos`
- `int radius`

### GetNeighboringPositions

```csharp
/// <summary>
        /// Gets neighboring grid positions
        /// </summary>
        /// <param name="gridPosition">Center position</param>
        /// <param name="includeDiagonal">Whether to include diagonal neighbors</param>
        /// <returns>List of neighboring positions</returns>
        public List<Vector2I> GetNeighboringPositions(Vector2I gridPosition, bool includeDiagonal = false)
        {
            var neighbors = new List<Vector2I>();
            
            // Cardinal directions
            var cardinalDirections = new[]
            {
                new Vector2I(0, -1), // North
                new Vector2I(0, 1),  // South
                new Vector2I(-1, 0), // West
                new Vector2I(1, 0)   // East
            };
            
            foreach (var direction in cardinalDirections)
            {
                var neighbor = gridPosition + direction;
                if (IsGridPositionInBounds(neighbor))
                {
                    neighbors.Add(neighbor);
                }
            }
            
            // Diagonal directions
            if (includeDiagonal)
            {
                var diagonalDirections = new[]
                {
                    new Vector2I(-1, -1), // Northwest
                    new Vector2I(1, -1),  // Northeast
                    new Vector2I(-1, 1),  // Southwest
                    new Vector2I(1, 1)    // Southeast
                };
                
                foreach (var direction in diagonalDirections)
                {
                    var neighbor = gridPosition + direction;
                    if (IsGridPositionInBounds(neighbor))
                    {
                        neighbors.Add(neighbor);
                    }
                }
            }
            
            return neighbors;
        }
```

Gets neighboring grid positions

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I gridPosition`
- `bool includeDiagonal`

### GetGridDistance

```csharp
/// <summary>
        /// Gets the distance between two grid positions
        /// </summary>
        /// <param name="from">Starting position</param>
        /// <param name="to">Ending position</param>
        /// <param name="useManhattan">Whether to use Manhattan distance</param>
        /// <returns>Distance between positions</returns>
        public float GetGridDistance(Vector2I from, Vector2I to, bool useManhattan = true)
        {
            if (useManhattan)
            {
                return Mathf.Abs(from.X - to.X) + Mathf.Abs(from.Y - to.Y);
            }
            else
            {
                return from.DistanceTo(to);
            }
        }
```

Gets the distance between two grid positions

**Returns:** `float`

**Parameters:**
- `Vector2I from`
- `Vector2I to`
- `bool useManhattan`

### SetGridSize

```csharp
/// <summary>
        /// Sets the grid size
        /// </summary>
        /// <param name="size">New grid size</param>
        public void SetGridSize(Vector2I size)
        {
            _gridSize = size;
            UpdateGridBounds();
            
            // Constrain current position to new bounds
            if (_constrainToBounds)
            {
                SetGridPosition(_currentGridPosition);
            }
        }
```

Sets the grid size

**Returns:** `void`

**Parameters:**
- `Vector2I size`

### SetTileSize

```csharp
/// <summary>
        /// Sets the tile size
        /// </summary>
        /// <param name="size">New tile size</param>
        public void SetTileSize(Vector2 size)
        {
            _tileSize = size;
            
            // Update world position to match new tile size
            SetGridPosition(_currentGridPosition);
        }
```

Sets the tile size

**Returns:** `void`

**Parameters:**
- `Vector2 size`

### SetSnapToGrid

```csharp
/// <summary>
        /// Sets whether to snap to grid
        /// </summary>
        /// <param name="snap">Whether to snap to grid</param>
        public void SetSnapToGrid(bool snap)
        {
            _snapToGrid = snap;
            
            if (snap)
            {
                SetWorldPosition(Position);
            }
        }
```

Sets whether to snap to grid

**Returns:** `void`

**Parameters:**
- `bool snap`

### SetConstrainToBounds

```csharp
/// <summary>
        /// Sets whether to constrain to bounds
        /// </summary>
        /// <param name="constrain">Whether to constrain to bounds</param>
        public void SetConstrainToBounds(bool constrain)
        {
            _constrainToBounds = constrain;
            
            if (constrain)
            {
                SetGridPosition(_currentGridPosition);
            }
        }
```

Sets whether to constrain to bounds

**Returns:** `void`

**Parameters:**
- `bool constrain`

### GetWorldBounds

```csharp
/// <summary>
        /// Gets the world bounds of the grid
        /// </summary>
        /// <returns>World bounds rectangle</returns>
        public Rect2 GetWorldBounds()
        {
            var topLeft = GridToWorld(_gridBounds.Position);
            var bottomRight = GridToWorld(_gridBounds.Position + _gridBounds.Size);
            
            return new Rect2(topLeft, bottomRight - topLeft);
        }
```

Gets the world bounds of the grid

**Returns:** `Rect2`

### GetGridInfo

```csharp
/// <summary>
        /// Gets grid information as a dictionary
        /// </summary>
        /// <returns>Grid information</returns>
        public Dictionary<string, Variant> GetGridInfo()
        {
            var info = new Dictionary<string, Variant>
            {
                ["grid_size"] = _gridSize,
                ["tile_size"] = _tileSize,
                ["grid_bounds"] = _gridBounds,
                ["current_grid_position"] = _currentGridPosition,
                ["current_world_position"] = Position,
                ["snap_to_grid"] = _snapToGrid,
                ["constrain_to_bounds"] = _constrainToBounds
            };
            
            return info;
        }
```

Gets grid information as a dictionary

**Returns:** `Dictionary<string, Variant>`

