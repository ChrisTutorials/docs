---
title: "AStarPathManager"
description: ""
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/astarpathmanager/"
---

# AStarPathManager

```csharp
GridBuilding.Godot.Navigation
class AStarPathManager
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Navigation/AStarPathManager.cs`  
**Namespace:** `GridBuilding.Godot.Navigation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### EnableDiagonalMovement

```csharp
[Export] public bool EnableDiagonalMovement { get; set; } = true;
```

### HeuristicWeight

```csharp
[Export] public float HeuristicWeight { get; set; } = 1.0f;
```

### MaxPathLength

```csharp
[Export] public int MaxPathLength { get; set; } = 1000;
```

### RecalculateOnTileChange

```csharp
[Export] public bool RecalculateOnTileChange { get; set; } = true;
```

### GridSize

```csharp
[Export] public Vector2I GridSize { get; set; } = new Vector2I(100, 100);
```

### IsInitialized

```csharp
public bool IsInitialized { get; private set; }
```

### PointCount

```csharp
public int PointCount => _pointIds?.Count ?? 0;
```


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            base._Ready();
            
            // Initialize A* system
            InitializeAStar();
            
            // Set up navigation layer if available
            SetupNavigationLayer();
        }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
        {
            CleanupAStar();
            base._ExitTree();
        }
```

**Returns:** `void`

### FindPath

```csharp
/// <summary>
        /// Finds a path between two points
        /// </summary>
        /// <param name="startPoint">Starting point</param>
        /// <param name="endPoint">Ending point</param>
        /// <returns>List of points representing the path</returns>
        public List<Vector2I> FindPath(Vector2I startPoint, Vector2I endPoint)
        {
            if (!IsInitialized)
            {
                EmitSignal(SignalName.PathCalculationFailed, "A* system not initialized");
                return new List<Vector2I>();
            }
            
            // Validate points
            if (!IsPointInBounds(startPoint) || !IsPointInBounds(endPoint))
            {
                EmitSignal(SignalName.PathCalculationFailed, "Start or end point out of bounds");
                return new List<Vector2I>();
            }
            
            // Get point IDs
            if (!_pointIds.TryGetValue(startPoint, out var startId) || 
                !_pointIds.TryGetValue(endPoint, out var endId))
            {
                EmitSignal(SignalName.PathCalculationFailed, "Start or end point not found in A* system");
                return new List<Vector2I>();
            }
            
            // Calculate path
            var pathIds = _astar.GetIdPath(startId, endId);
            
            if (pathIds.Count == 0)
            {
                EmitSignal(SignalName.PathCalculationFailed, "No path found");
                return new List<Vector2I>();
            }
            
            // Convert IDs back to points
            var path = new List<Vector2I>();
            foreach (var id in pathIds)
            {
                if (_idToPoints.TryGetValue(id, out var point))
                {
                    path.Add(point);
                }
            }
            
            // Check path length
            if (path.Count > MaxPathLength)
            {
                EmitSignal(SignalName.PathCalculationFailed, $"Path too long: {path.Count} > {MaxPathLength}");
                return new List<Vector2I>();
            }
            
            EmitSignal(SignalName.PathCalculated, path);
            return path;
        }
```

Finds a path between two points

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I startPoint`
- `Vector2I endPoint`

### IsPathClear

```csharp
/// <summary>
        /// Checks if a path is clear between two points
        /// </summary>
        /// <param name="startPoint">Starting point</param>
        /// <param name="endPoint">Ending point</param>
        /// <returns>True if path is clear</returns>
        public bool IsPathClear(Vector2I startPoint, Vector2I endPoint)
        {
            var path = FindPath(startPoint, endPoint);
            return path.Count > 0;
        }
```

Checks if a path is clear between two points

**Returns:** `bool`

**Parameters:**
- `Vector2I startPoint`
- `Vector2I endPoint`

### GetDistance

```csharp
/// <summary>
        /// Gets the distance between two points
        /// </summary>
        /// <param name="startPoint">Starting point</param>
        /// <param name="endPoint">Ending point</param>
        /// <returns>Distance between points</returns>
        public float GetDistance(Vector2I startPoint, Vector2I endPoint)
        {
            if (!_pointIds.TryGetValue(startPoint, out var startId) || 
                !_pointIds.TryGetValue(endPoint, out var endId))
            {
                return float.MaxValue;
            }
            
            return _astar.GetIdPath(startId, endId).Count - 1; // Number of steps
        }
```

Gets the distance between two points

**Returns:** `float`

**Parameters:**
- `Vector2I startPoint`
- `Vector2I endPoint`

### AddPoint

```csharp
/// <summary>
        /// Adds a point to the A* system
        /// </summary>
        /// <param name="point">Point to add</param>
        /// <param name="weight">Weight of the point (higher = more difficult to traverse)</param>
        public void AddPoint(Vector2I point, float weight = 1.0f)
        {
            if (_pointIds.ContainsKey(point))
                return; // Point already exists
                
            var id = _nextId++;
            _pointIds[point] = id;
            _idToPoints[id] = point;
            
            _astar.AddPoint(id, point.ToGodot(), weight);
        }
```

Adds a point to the A* system

**Returns:** `void`

**Parameters:**
- `Vector2I point`
- `float weight`

### RemovePoint

```csharp
/// <summary>
        /// Removes a point from the A* system
        /// </summary>
        /// <param name="point">Point to remove</param>
        public void RemovePoint(Vector2I point)
        {
            if (!_pointIds.TryGetValue(point, out var id))
                return; // Point doesn't exist
                
            _astar.RemovePoint(id);
            _pointIds.Remove(point);
            _idToPoints.Remove(id);
        }
```

Removes a point from the A* system

**Returns:** `void`

**Parameters:**
- `Vector2I point`

### ConnectPoints

```csharp
/// <summary>
        /// Connects two points in the A* system
        /// </summary>
        /// <param name="fromPoint">Source point</param>
        /// <param name="toPoint">Target point</param>
        /// <param name="weight">Weight of the connection</param>
        public void ConnectPoints(Vector2I fromPoint, Vector2I toPoint, float weight = 1.0f)
        {
            if (!_pointIds.TryGetValue(fromPoint, out var fromId) || 
                !_pointIds.TryGetValue(toPoint, out var toId))
                return; // Points don't exist
                
            // Check if points are adjacent
            if (!ArePointsAdjacent(fromPoint, toPoint))
                return; // Only connect adjacent points
                
            _astar.ConnectPoints(fromId, toId, bidirectional: true);
        }
```

Connects two points in the A* system

**Returns:** `void`

**Parameters:**
- `Vector2I fromPoint`
- `Vector2I toPoint`
- `float weight`

### DisconnectPoints

```csharp
/// <summary>
        /// Disconnects two points in the A* system
        /// </summary>
        /// <param name="fromPoint">Source point</param>
        /// <param name="toPoint">Target point</param>
        public void DisconnectPoints(Vector2I fromPoint, Vector2I toPoint)
        {
            if (!_pointIds.TryGetValue(fromPoint, out var fromId) || 
                !_pointIds.TryGetValue(toPoint, out var toId))
                return; // Points don't exist
                
            _astar.DisconnectPoints(fromId, toId);
        }
```

Disconnects two points in the A* system

**Returns:** `void`

**Parameters:**
- `Vector2I fromPoint`
- `Vector2I toPoint`

### UpdatePointWeight

```csharp
/// <summary>
        /// Updates a point's weight
        /// </summary>
        /// <param name="point">Point to update</param>
        /// <param name="weight">New weight</param>
        public void UpdatePointWeight(Vector2I point, float weight)
        {
            if (!_pointIds.TryGetValue(point, out var id))
                return; // Point doesn't exist
                
            _astar.SetPointWeightScale(id, weight);
        }
```

Updates a point's weight

**Returns:** `void`

**Parameters:**
- `Vector2I point`
- `float weight`

### GetPointsInRadius

```csharp
/// <summary>
        /// Gets all points in a radius around a center point
        /// </summary>
        /// <param name="centerPoint">Center point</param>
        /// <param name="radius">Search radius</param>
        /// <returns>List of points within radius</returns>
        public List<Vector2I> GetPointsInRadius(Vector2I centerPoint, int radius)
        {
            var points = new List<Vector2I>();
            
            for (int x = -radius; x <= radius; x++)
            {
                for (int y = -radius; y <= radius; y++)
                {
                    var point = centerPoint + new Vector2I(x, y);
                    
                    // Check if point is within bounds and in the A* system
                    if (IsPointInBounds(point) && _pointIds.ContainsKey(point))
                    {
                        // Check if point is within circular radius
                        var distance = Mathf.Sqrt(x * x + y * y);
                        if (distance <= radius)
                        {
                            points.Add(point);
                        }
                    }
                }
            }
            
            return points;
        }
```

Gets all points in a radius around a center point

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I centerPoint`
- `int radius`

### ClearAllPoints

```csharp
/// <summary>
        /// Clears all points from the A* system
        /// </summary>
        public void ClearAllPoints()
        {
            _astar.Clear();
            _pointIds.Clear();
            _idToPoints.Clear();
            _nextId = 1;
        }
```

Clears all points from the A* system

**Returns:** `void`

### RecalculateNavigationGrid

```csharp
/// <summary>
        /// Recalculates the entire navigation grid
        /// </summary>
        public void RecalculateNavigationGrid()
        {
            ClearAllPoints();
            CreateDefaultGrid();
        }
```

Recalculates the entire navigation grid

**Returns:** `void`

### SetNavigationLayer

```csharp
/// <summary>
        /// Sets the navigation layer
        /// </summary>
        /// <param name="navigationLayer">Navigation layer to use</param>
        public void SetNavigationLayer(TileMapLayer navigationLayer)
        {
            _navigationLayer = navigationLayer;
            
            if (navigationLayer != null)
            {
                // Update grid based on navigation layer
                UpdateGridFromNavigationLayer();
            }
        }
```

Sets the navigation layer

**Returns:** `void`

**Parameters:**
- `TileMapLayer navigationLayer`

