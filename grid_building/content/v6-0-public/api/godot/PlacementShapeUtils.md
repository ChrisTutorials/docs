---
title: "PlacementShapeUtils"
description: ""
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/placementshapeutils/"
---

# PlacementShapeUtils

```csharp
GridBuilding.Godot.Utilities
class PlacementShapeUtils
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/PlacementShapeUtils.cs`  
**Namespace:** `GridBuilding.Godot.Utilities`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CalculateShapePlacement

```csharp
/// <summary>
        /// Calculates valid placement tiles for a given shape
        /// </summary>
        /// <param name="shape">Shape to place</param>
        /// <param name="centerPosition">Center position in world coordinates</param>
        /// <param name="tileSize">Size of tiles</param>
        /// <param name="rotation">Rotation of the shape in radians</param>
        /// <returns>List of valid tile positions</returns>
        public static List<Vector2I> CalculateShapePlacement(Shape2D shape, Vector2 centerPosition, Vector2 tileSize, float rotation = 0.0f)
        {
            var validTiles = new List<Vector2I>();
            
            if (shape == null)
                return validTiles;
                
            // Get shape vertices
            var vertices = GetShapeVertices(shape, rotation);
            
            // Convert to world coordinates
            var worldVertices = new List<Vector2>();
            foreach (var vertex in vertices)
            {
                worldVertices.Add(centerPosition + vertex);
            }
            
            // Convert world vertices to tile positions
            foreach (var worldPos in worldVertices)
            {
                var tilePos = WorldToTile(worldPos, tileSize);
                if (!validTiles.Contains(tilePos))
                {
                    validTiles.Add(tilePos);
                }
            }
            
            return validTiles;
        }
```

Calculates valid placement tiles for a given shape

**Returns:** `List<Vector2I>`

**Parameters:**
- `Shape2D shape`
- `Vector2 centerPosition`
- `Vector2 tileSize`
- `float rotation`

### GetShapeBounds

```csharp
/// <summary>
        /// Gets the bounding rectangle for a shape placement
        /// </summary>
        /// <param name="shape">Shape to place</param>
        /// <param name="centerPosition">Center position</param>
        /// <param name="tileSize">Tile size</param>
        /// <param name="rotation">Rotation in radians</param>
        /// <returns>Bounding rectangle in tile coordinates</returns>
        public static Rect2I GetShapeBounds(Shape2D shape, Vector2 centerPosition, Vector2 tileSize, float rotation = 0.0f)
        {
            var tiles = CalculateShapePlacement(shape, centerPosition, tileSize, rotation);
            
            if (tiles.Count == 0)
                return new Rect2I();
                
            var minX = tiles[0].X;
            var minY = tiles[0].Y;
            var maxX = tiles[0].X;
            var maxY = tiles[0].Y;
            
            foreach (var tile in tiles)
            {
                minX = Mathf.Min(minX, tile.X);
                minY = Mathf.Min(minY, tile.Y);
                maxX = Mathf.Max(maxX, tile.X);
                maxY = Mathf.Max(maxY, tile.Y);
            }
            
            return new Rect2I(new Vector2I(minX, minY), new Vector2I(maxX - minX + 1, maxY - minY + 1));
        }
```

Gets the bounding rectangle for a shape placement

**Returns:** `Rect2I`

**Parameters:**
- `Shape2D shape`
- `Vector2 centerPosition`
- `Vector2 tileSize`
- `float rotation`

### ValidateShapePlacement

```csharp
/// <summary>
        /// Validates if a shape can be placed at the given position
        /// </summary>
        /// <param name="shape">Shape to place</param>
        /// <param name="centerPosition">Center position</param>
        /// <param name="tileMap">TileMap to check against</param>
        /// <param name="validTileData">Array of valid tile data indices</param>
        /// <param name="rotation">Rotation in radians</param>
        /// <returns>True if placement is valid</returns>
        public static bool ValidateShapePlacement(Shape2D shape, Vector2 centerPosition, TileMapLayer tileMap, int[] validTileData, float rotation = 0.0f)
        {
            var tileSize = tileMap.TileSet.TileSize;
            var tiles = CalculateShapePlacement(shape, centerPosition, tileSize, rotation);
            
            foreach (var tile in tiles)
            {
                var tileData = tileMap.GetCellTileData(tile);
                if (tileData == null)
                    return false; // No tile at this position
                    
                // Check if tile is valid for placement
                var sourceId = tileMap.GetCellSourceId(tile);
                if (!IsValidTileForPlacement(sourceId, validTileData))
                    return false;
            }
            
            return true;
        }
```

Validates if a shape can be placed at the given position

**Returns:** `bool`

**Parameters:**
- `Shape2D shape`
- `Vector2 centerPosition`
- `TileMapLayer tileMap`
- `int[] validTileData`
- `float rotation`

### CalculatePlacementCost

```csharp
/// <summary>
        /// Calculates placement cost for a shape (used for placement scoring)
        /// </summary>
        /// <param name="shape">Shape to place</param>
        /// <param name="centerPosition">Center position</param>
        /// <param name="tileMap">TileMap to check</param>
        /// <param name="costTileData">Array of tile data with placement costs</param>
        /// <param name="rotation">Rotation in radians</param>
        /// <returns>Total placement cost</returns>
        public static float CalculatePlacementCost(Shape2D shape, Vector2 centerPosition, TileMapLayer tileMap, Dictionary<int, float> costTileData, float rotation = 0.0f)
        {
            var tileSize = tileMap.TileSet.TileSize;
            var tiles = CalculateShapePlacement(shape, centerPosition, tileSize, rotation);
            var totalCost = 0.0f;
            
            foreach (var tile in tiles)
            {
                var sourceId = tileMap.GetCellSourceId(tile);
                if (costTileData.TryGetValue(sourceId, out var cost))
                {
                    totalCost += cost;
                }
            }
            
            return totalCost;
        }
```

Calculates placement cost for a shape (used for placement scoring)

**Returns:** `float`

**Parameters:**
- `Shape2D shape`
- `Vector2 centerPosition`
- `TileMapLayer tileMap`
- `Dictionary<int, float> costTileData`
- `float rotation`

### GetValidPlacementPositions

```csharp
/// <summary>
        /// Gets all valid placement positions for a shape within an area
        /// </summary>
        /// <param name="shape">Shape to place</param>
        /// <param name="area">Area to search in (world coordinates)</param>
        /// <param name="tileMap">TileMap to check</param>
        /// <param name="validTileData">Array of valid tile data indices</param>
        /// <param name="stepSize">Step size for searching</param>
        /// <returns>List of valid positions</returns>
        public static List<Vector2> GetValidPlacementPositions(Shape2D shape, Rect2 area, TileMapLayer tileMap, int[] validTileData, float stepSize = 32.0f)
        {
            var validPositions = new List<Vector2>();
            var tileSize = tileMap.TileSet.TileSize;
            
            // Sample positions within the area
            for (float x = area.Position.X; x < area.Position.X + area.Size.X; x += stepSize)
            {
                for (float y = area.Position.Y; y < area.Position.Y + area.Size.Y; y += stepSize)
                {
                    var position = new Vector2(x, y);
                    if (ValidateShapePlacement(shape, position, tileMap, validTileData))
                    {
                        validPositions.Add(position);
                    }
                }
            }
            
            return validPositions;
        }
```

Gets all valid placement positions for a shape within an area

**Returns:** `List<Vector2>`

**Parameters:**
- `Shape2D shape`
- `Rect2 area`
- `TileMapLayer tileMap`
- `int[] validTileData`
- `float stepSize`

### OptimizeShapePlacement

```csharp
/// <summary>
        /// Optimizes shape placement by finding the best position
        /// </summary>
        /// <param name="shape">Shape to place</param>
        /// <param name="targetPosition">Target position</param>
        /// <param name="tileMap">TileMap to check</param>
        /// <param name="validTileData">Array of valid tile data indices</param>
        /// <param name="maxDistance">Maximum distance to search</param>
        /// <param name="rotation">Rotation in radians</param>
        /// <returns>Best position or original if no valid position found</returns>
        public static Vector2 OptimizeShapePlacement(Shape2D shape, Vector2 targetPosition, TileMapLayer tileMap, int[] validTileData, float maxDistance = 100.0f, float rotation = 0.0f)
        {
            // Check if target position is valid
            if (ValidateShapePlacement(shape, targetPosition, tileMap, validTileData, rotation))
            {
                return targetPosition;
            }
            
            // Search for valid positions in expanding circles
            var stepSize = tileMap.TileSet.TileSize.X;
            for (float distance = stepSize; distance <= maxDistance; distance += stepSize)
            {
                var positions = GetValidPositionsAtDistance(shape, targetPosition, tileMap, validTileData, distance, rotation);
                if (positions.Count > 0)
                {
                    // Return the closest valid position
                    return positions[0];
                }
            }
            
            // No valid position found, return original
            return targetPosition;
        }
```

Optimizes shape placement by finding the best position

**Returns:** `Vector2`

**Parameters:**
- `Shape2D shape`
- `Vector2 targetPosition`
- `TileMapLayer tileMap`
- `int[] validTileData`
- `float maxDistance`
- `float rotation`

