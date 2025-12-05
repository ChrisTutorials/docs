---
title: "Positioning2DUtils"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/positioning2dutils/"
---

# Positioning2DUtils

```csharp
GridBuilding.Godot.Utilities
class Positioning2DUtils
{
    // Members...
}
```

Advanced 2D positioning utilities for grid-based systems
Ported from GDScript: addons/grid_building/shared/utils/positioning/gb_positioning_2d_utils.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/Positioning2DUtils.cs`  
**Namespace:** `GridBuilding.Godot.Utilities`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### WorldToGrid

```csharp
/// <summary>
        /// Converts world position to grid position with snapping
        /// </summary>
        /// <param name="worldPosition">World position</param>
        /// <param name="tileSize">Tile size</param>
        /// <param name="snapToCenter">Whether to snap to tile center</param>
        /// <returns>Grid position</returns>
        public static Vector2I WorldToGrid(Vector2 worldPosition, Vector2 tileSize, bool snapToCenter = true)
        {
            var gridPos = new Vector2I(
                Mathf.FloorToInt(worldPosition.X / tileSize.X),
                Mathf.FloorToInt(worldPosition.Y / tileSize.Y)
            );
            
            if (snapToCenter)
            {
                // Adjust to center of tile
                return gridPos;
            }
            
            return gridPos;
        }
```

Converts world position to grid position with snapping

**Returns:** `Vector2I`

**Parameters:**
- `Vector2 worldPosition`
- `Vector2 tileSize`
- `bool snapToCenter`

### GridToWorld

```csharp
/// <summary>
        /// Converts grid position to world position
        /// </summary>
        /// <param name="gridPosition">Grid position</param>
        /// <param name="tileSize">Tile size</param>
        /// <param name="centerOnTile">Whether to center on tile</param>
        /// <returns>World position</returns>
        public static Vector2 GridToWorld(Vector2I gridPosition, Vector2 tileSize, bool centerOnTile = true)
        {
            var worldPos = new Vector2(
                gridPosition.X * tileSize.X,
                gridPosition.Y * tileSize.Y
            );
            
            if (centerOnTile)
            {
                worldPos += tileSize / 2.0f;
            }
            
            return worldPos;
        }
```

Converts grid position to world position

**Returns:** `Vector2`

**Parameters:**
- `Vector2I gridPosition`
- `Vector2 tileSize`
- `bool centerOnTile`

### SnapToGrid

```csharp
/// <summary>
        /// Snaps a world position to the grid
        /// </summary>
        /// <param name="worldPosition">World position to snap</param>
        /// <param name="tileSize">Tile size</param>
        /// <param name="centerOnTile">Whether to center on tile</param>
        /// <returns>Snapped world position</returns>
        public static Vector2 SnapToGrid(Vector2 worldPosition, Vector2 tileSize, bool centerOnTile = true)
        {
            var gridPos = WorldToGrid(worldPosition, tileSize, false);
            return GridToWorld(gridPos, tileSize, centerOnTile);
        }
```

Snaps a world position to the grid

**Returns:** `Vector2`

**Parameters:**
- `Vector2 worldPosition`
- `Vector2 tileSize`
- `bool centerOnTile`

### GetTileCenter

```csharp
/// <summary>
        /// Gets the tile center position
        /// </summary>
        /// <param name="gridPosition">Grid position</param>
        /// <param name="tileSize">Tile size</param>
        /// <returns>Tile center world position</returns>
        public static Vector2 GetTileCenter(Vector2I gridPosition, Vector2 tileSize)
        {
            return GridToWorld(gridPosition, tileSize, true);
        }
```

Gets the tile center position

**Returns:** `Vector2`

**Parameters:**
- `Vector2I gridPosition`
- `Vector2 tileSize`

### GetTileBounds

```csharp
/// <summary>
        /// Gets the tile bounds
        /// </summary>
        /// <param name="gridPosition">Grid position</param>
        /// <param name="tileSize">Tile size</param>
        /// <returns>Tile bounds in world coordinates</returns>
        public static Rect2 GetTileBounds(Vector2I gridPosition, Vector2 tileSize)
        {
            var topLeft = GridToWorld(gridPosition, tileSize, false);
            return new Rect2(topLeft, tileSize);
        }
```

Gets the tile bounds

**Returns:** `Rect2`

**Parameters:**
- `Vector2I gridPosition`
- `Vector2 tileSize`

### GetGridPositionsInArea

```csharp
/// <summary>
        /// Gets grid positions in a rectangular area
        /// </summary>
        /// <param name="startPosition">Start position</param>
        /// <param name="size">Size of area</param>
        /// <returns>List of grid positions</returns>
        public static List<Vector2I> GetGridPositionsInArea(Vector2I startPosition, Vector2I size)
        {
            var positions = new List<Vector2I>();
            
            for (int x = 0; x < size.X; x++)
            {
                for (int y = 0; y < size.Y; y++)
                {
                    positions.Add(startPosition + new Vector2I(x, y));
                }
            }
            
            return positions;
        }
```

Gets grid positions in a rectangular area

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I startPosition`
- `Vector2I size`

### GetGridPositionsInCircle

```csharp
/// <summary>
        /// Gets grid positions in a circular area
        /// </summary>
        /// <param name="centerPosition">Center position</param>
        /// <param name="radius">Radius in grid units</param>
        /// <returns>List of grid positions</returns>
        public static List<Vector2I> GetGridPositionsInCircle(Vector2I centerPosition, int radius)
        {
            var positions = new List<Vector2I>();
            
            for (int x = -radius; x <= radius; x++)
            {
                for (int y = -radius; y <= radius; y++)
                {
                    var distance = Mathf.Sqrt(x * x + y * y);
                    if (distance <= radius)
                    {
                        positions.Add(centerPosition + new Vector2I(x, y));
                    }
                }
            }
            
            return positions;
        }
```

Gets grid positions in a circular area

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I centerPosition`
- `int radius`

### GetNeighboringPositions

```csharp
/// <summary>
        /// Gets neighboring grid positions
        /// </summary>
        /// <param name="gridPosition">Center position</param>
        /// <param name="includeDiagonal">Whether to include diagonal neighbors</param>
        /// <returns>List of neighboring positions</returns>
        public static List<Vector2I> GetNeighboringPositions(Vector2I gridPosition, bool includeDiagonal = false)
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
                neighbors.Add(gridPosition + direction);
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
                    neighbors.Add(gridPosition + direction);
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
        public static float GetGridDistance(Vector2I from, Vector2I to, bool useManhattan = true)
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

### IsPositionInBounds

```csharp
/// <summary>
        /// Checks if a grid position is within bounds
        /// </summary>
        /// <param name="gridPosition">Grid position to check</param>
        /// <param name="bounds">Bounds to check against</param>
        /// <returns>True if within bounds</returns>
        public static bool IsPositionInBounds(Vector2I gridPosition, Rect2I bounds)
        {
            return bounds.HasPoint(gridPosition);
        }
```

Checks if a grid position is within bounds

**Returns:** `bool`

**Parameters:**
- `Vector2I gridPosition`
- `Rect2I bounds`

### ConstrainToBounds

```csharp
/// <summary>
        /// Constrains a grid position to bounds
        /// </summary>
        /// <param name="gridPosition">Grid position to constrain</param>
        /// <param name="bounds">Bounds to constrain to</param>
        /// <returns>Constrained grid position</returns>
        public static Vector2I ConstrainToBounds(Vector2I gridPosition, Rect2I bounds)
        {
            return new Vector2I(
                Mathf.Clamp(gridPosition.X, bounds.Position.X, bounds.Position.X + bounds.Size.X - 1),
                Mathf.Clamp(gridPosition.Y, bounds.Position.Y, bounds.Position.Y + bounds.Size.Y - 1)
            );
        }
```

Constrains a grid position to bounds

**Returns:** `Vector2I`

**Parameters:**
- `Vector2I gridPosition`
- `Rect2I bounds`

### GetDirection

```csharp
/// <summary>
        /// Gets the direction from one grid position to another
        /// </summary>
        /// <param name="from">Starting position</param>
        /// <param name="to">Ending position</param>
        /// <returns>Direction vector</returns>
        public static Vector2I GetDirection(Vector2I from, Vector2I to)
        {
            var delta = to - from;
            
            // Normalize to cardinal directions
            if (Mathf.Abs(delta.X) > Mathf.Abs(delta.Y))
            {
                return new Vector2I(Mathf.Sign(delta.X), 0);
            }
            else if (Mathf.Abs(delta.Y) > 0)
            {
                return new Vector2I(0, Mathf.Sign(delta.Y));
            }
            
            return Vector2I.Zero;
        }
```

Gets the direction from one grid position to another

**Returns:** `Vector2I`

**Parameters:**
- `Vector2I from`
- `Vector2I to`

### GetCardinalDirection

```csharp
/// <summary>
        /// Gets the cardinal direction from one grid position to another
        /// </summary>
        /// <param name="from">Starting position</param>
        /// <param name="to">Ending position</param>
        /// <returns>Cardinal direction (N, S, E, W, or None)</returns>
        public static string GetCardinalDirection(Vector2I from, Vector2I to)
        {
            var direction = GetDirection(from, to);
            
            if (direction == Vector2I.Up)
                return "North";
            else if (direction == Vector2I.Down)
                return "South";
            else if (direction == Vector2I.Left)
                return "West";
            else if (direction == Vector2I.Right)
                return "East";
            else
                return "None";
        }
```

Gets the cardinal direction from one grid position to another

**Returns:** `string`

**Parameters:**
- `Vector2I from`
- `Vector2I to`

### GetAngle

```csharp
/// <summary>
        /// Gets the angle between two grid positions
        /// </summary>
        /// <param name="from">Starting position</param>
        /// <param name="to">Ending position</param>
        /// <returns>Angle in radians</returns>
        public static float GetAngle(Vector2I from, Vector2I to)
        {
            var delta = to - from;
            return Mathf.Atan2(delta.Y, delta.X);
        }
```

Gets the angle between two grid positions

**Returns:** `float`

**Parameters:**
- `Vector2I from`
- `Vector2I to`

### RotatePosition

```csharp
/// <summary>
        /// Rotates a grid position around a center point
        /// </summary>
        /// <param name="gridPosition">Position to rotate</param>
        /// <param name="center">Center of rotation</param>
        /// <param name="angle">Angle in radians</param>
        /// <returns>Rotated grid position</returns>
        public static Vector2I RotatePosition(Vector2I gridPosition, Vector2I center, float angle)
        {
            var delta = gridPosition - center;
            var rotated = new Vector2(
                delta.X * Mathf.Cos(angle) - delta.Y * Mathf.Sin(angle),
                delta.X * Mathf.Sin(angle) + delta.Y * Mathf.Cos(angle)
            );
            
            return center + new Vector2I(Mathf.RoundToInt(rotated.X), Mathf.RoundToInt(rotated.Y));
        }
```

Rotates a grid position around a center point

**Returns:** `Vector2I`

**Parameters:**
- `Vector2I gridPosition`
- `Vector2I center`
- `float angle`

### GetLineOfSight

```csharp
/// <summary>
        /// Gets the line of sight between two grid positions
        /// </summary>
        /// <param name="from">Starting position</param>
        /// <param name="to">Ending position</param>
        /// <returns>List of grid positions in line of sight</returns>
        public static List<Vector2I> GetLineOfSight(Vector2I from, Vector2I to)
        {
            var positions = new List<Vector2I>();
            
            var dx = Mathf.Abs(to.X - from.X);
            var dy = Mathf.Abs(to.Y - from.Y);
            var sx = from.X < to.X ? 1 : -1;
            var sy = from.Y < to.Y ? 1 : -1;
            var err = dx - dy;
            
            var current = from;
            
            while (true)
            {
                positions.Add(current);
                
                if (current == to)
                    break;
                    
                var e2 = 2 * err;
                
                if (e2 > -dy)
                {
                    err -= dy;
                    current.X += sx;
                }
                
                if (e2 < dx)
                {
                    err += dx;
                    current.Y += sy;
                }
            }
            
            return positions;
        }
```

Gets the line of sight between two grid positions

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I from`
- `Vector2I to`

### GetBoundsForPositions

```csharp
/// <summary>
        /// Gets the bounding rectangle for a set of grid positions
        /// </summary>
        /// <param name="positions">List of grid positions</param>
        /// <returns>Bounding rectangle</returns>
        public static Rect2I GetBoundsForPositions(List<Vector2I> positions)
        {
            if (positions.Count == 0)
                return new Rect2I();
                
            var minX = positions[0].X;
            var minY = positions[0].Y;
            var maxX = positions[0].X;
            var maxY = positions[0].Y;
            
            foreach (var pos in positions)
            {
                minX = Mathf.Min(minX, pos.X);
                minY = Mathf.Min(minY, pos.Y);
                maxX = Mathf.Max(maxX, pos.X);
                maxY = Mathf.Max(maxY, pos.Y);
            }
            
            return new Rect2I(new Vector2I(minX, minY), new Vector2I(maxX - minX + 1, maxY - minY + 1));
        }
```

Gets the bounding rectangle for a set of grid positions

**Returns:** `Rect2I`

**Parameters:**
- `List<Vector2I> positions`

### ArePositionsAdjacent

```csharp
/// <summary>
        /// Checks if two grid positions are adjacent
        /// </summary>
        /// <param name="pos1">First position</param>
        /// <param name="pos2">Second position</param>
        /// <param name="includeDiagonal">Whether to include diagonal adjacency</param>
        /// <returns>True if positions are adjacent</returns>
        public static bool ArePositionsAdjacent(Vector2I pos1, Vector2I pos2, bool includeDiagonal = false)
        {
            var distance = Mathf.Abs(pos1.X - pos2.X) + Mathf.Abs(pos1.Y - pos2.Y);
            
            if (includeDiagonal)
            {
                return distance <= 2 && distance > 0;
            }
            else
            {
                return distance == 1;
            }
        }
```

Checks if two grid positions are adjacent

**Returns:** `bool`

**Parameters:**
- `Vector2I pos1`
- `Vector2I pos2`
- `bool includeDiagonal`

### GetCenterPosition

```csharp
/// <summary>
        /// Gets the center position of multiple grid positions
        /// </summary>
        /// <param name="positions">List of grid positions</param>
        /// <returns>Center grid position</returns>
        public static Vector2I GetCenterPosition(List<Vector2I> positions)
        {
            if (positions.Count == 0)
                return Vector2I.Zero;
                
            var sumX = 0;
            var sumY = 0;
            
            foreach (var pos in positions)
            {
                sumX += pos.X;
                sumY += pos.Y;
            }
            
            return new Vector2I(
                Mathf.RoundToInt((float)sumX / positions.Count),
                Mathf.RoundToInt((float)sumY / positions.Count)
            );
        }
```

Gets the center position of multiple grid positions

**Returns:** `Vector2I`

**Parameters:**
- `List<Vector2I> positions`

### ScreenToGrid

```csharp
/// <summary>
        /// Converts screen coordinates to grid position
        /// </summary>
        /// <param name="screenPosition">Screen position</param>
        /// <param name="camera">Camera to use for conversion</param>
        /// <param name="tileSize">Tile size</param>
        /// <returns>Grid position</returns>
        public static Vector2I ScreenToGrid(Vector2 screenPosition, Camera2D camera, Vector2 tileSize)
        {
            var worldPosition = camera.GetGlobalMousePosition();
            return WorldToGrid(worldPosition, tileSize);
        }
```

Converts screen coordinates to grid position

**Returns:** `Vector2I`

**Parameters:**
- `Vector2 screenPosition`
- `Camera2D camera`
- `Vector2 tileSize`

### GridToScreen

```csharp
/// <summary>
        /// Converts grid position to screen coordinates
        /// </summary>
        /// <param name="gridPosition">Grid position</param>
        /// <param name="camera">Camera to use for conversion</param>
        /// <param name="tileSize">Tile size</param>
        /// <returns>Screen position</returns>
        public static Vector2 GridToScreen(Vector2I gridPosition, Camera2D camera, Vector2 tileSize)
        {
            var worldPosition = GridToWorld(gridPosition, tileSize);
            return camera.GetScreenCenterPosition() - worldPosition + camera.GetViewport().GetVisibleRect().Size / 2.0f;
        }
```

Converts grid position to screen coordinates

**Returns:** `Vector2`

**Parameters:**
- `Vector2I gridPosition`
- `Camera2D camera`
- `Vector2 tileSize`

### GetOptimalPlacementPosition

```csharp
/// <summary>
        /// Gets the optimal placement position for a shape
        /// </summary>
        /// <param name="targetPosition">Target position</param>
        /// <param name="shapeSize">Size of the shape</param>
        /// <param name="tileMap">TileMap to check</param>
        /// <param name="validTiles">List of valid tile positions</param>
        /// <returns>Optimal placement position</returns>
        public static Vector2I GetOptimalPlacementPosition(Vector2I targetPosition, Vector2I shapeSize, TileMapLayer tileMap, List<Vector2I> validTiles)
        {
            var bestPosition = targetPosition;
            var bestScore = float.MaxValue;
            
            // Check positions around the target
            var searchRadius = Mathf.Max(shapeSize.X, shapeSize.Y) * 2;
            var positions = GetGridPositionsInCircle(targetPosition, searchRadius);
            
            foreach (var pos in positions)
            {
                if (validTiles.Contains(pos))
                {
                    var score = GetPlacementScore(pos, targetPosition, shapeSize, validTiles);
                    if (score < bestScore)
                    {
                        bestScore = score;
                        bestPosition = pos;
                    }
                }
            }
            
            return bestPosition;
        }
```

Gets the optimal placement position for a shape

**Returns:** `Vector2I`

**Parameters:**
- `Vector2I targetPosition`
- `Vector2I shapeSize`
- `TileMapLayer tileMap`
- `List<Vector2I> validTiles`

### ConsistentSnap

```csharp
/// <summary>
        /// Snaps a position consistently to avoid edge case inconsistencies.
        /// Uses deterministic rounding to ensure the same input always produces the same output.
        /// </summary>
        /// <param name="worldPosition">World position to snap</param>
        /// <param name="tileSize">Tile size</param>
        /// <param name="snapMode">Mode for snapping (Center, TopLeft, BottomRight)</param>
        /// <returns>Consistently snapped position</returns>
        public static Vector2 ConsistentSnap(Vector2 worldPosition, Vector2 tileSize, SnapMode snapMode = SnapMode.Center)
        {
            // Use deterministic rounding to avoid floating point inconsistencies
            var gridX = Mathf.FloorToInt(worldPosition.X / tileSize.X);
            var gridY = Mathf.FloorToInt(worldPosition.Y / tileSize.Y);
            
            // Apply epsilon to handle edge cases near boundaries
            const float epsilon = 0.0001f;
            
            // Check if we're very close to the next grid boundary
            var remainderX = (worldPosition.X / tileSize.X) - gridX;
            var remainderY = (worldPosition.Y / tileSize.Y) - gridY;
            
            if (remainderX >= 1.0f - epsilon)
                gridX += 1;
            if (remainderY >= 1.0f - epsilon)
                gridY += 1;
            
            var gridPos = new Vector2I(gridX, gridY);
            
            return snapMode switch
            {
                SnapMode.Center => GetTileCenter(gridPos, tileSize),
                SnapMode.TopLeft => GridToWorld(gridPos, tileSize, false),
                SnapMode.BottomRight => GridToWorld(gridPos, tileSize, false) + tileSize,
                _ => GetTileCenter(gridPos, tileSize)
            };
        }
```

Snaps a position consistently to avoid edge case inconsistencies.
Uses deterministic rounding to ensure the same input always produces the same output.

**Returns:** `Vector2`

**Parameters:**
- `Vector2 worldPosition`
- `Vector2 tileSize`
- `SnapMode snapMode`

### ConsistentWorldToGrid

```csharp
/// <summary>
        /// Gets a consistent grid position regardless of floating point precision issues.
        /// </summary>
        /// <param name="worldPosition">World position</param>
        /// <param name="tileSize">Tile size</param>
        /// <returns>Consistent grid position</returns>
        public static Vector2I ConsistentWorldToGrid(Vector2 worldPosition, Vector2 tileSize)
        {
            // Use the same logic as ConsistentSnap but return grid coordinates
            var gridX = Mathf.FloorToInt(worldPosition.X / tileSize.X);
            var gridY = Mathf.FloorToInt(worldPosition.Y / tileSize.Y);
            
            // Apply epsilon to handle edge cases
            const float epsilon = 0.0001f;
            
            var remainderX = (worldPosition.X / tileSize.X) - gridX;
            var remainderY = (worldPosition.Y / tileSize.Y) - gridY;
            
            if (remainderX >= 1.0f - epsilon)
                gridX += 1;
            if (remainderY >= 1.0f - epsilon)
                gridY += 1;
            
            return new Vector2I(gridX, gridY);
        }
```

Gets a consistent grid position regardless of floating point precision issues.

**Returns:** `Vector2I`

**Parameters:**
- `Vector2 worldPosition`
- `Vector2 tileSize`

