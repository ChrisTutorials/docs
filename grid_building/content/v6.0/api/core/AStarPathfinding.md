---
title: "AStarPathfinding"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/astarpathfinding/"
---

# AStarPathfinding

```csharp
GridBuilding.Core.Services.Targeting
class AStarPathfinding
{
    // Members...
}
```

Static helper methods for A* pathfinding algorithm

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Targeting/GridTargetingService.cs`  
**Namespace:** `GridBuilding.Core.Services.Targeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### FindPath

```csharp
/// <summary>
        /// Implements A* pathfinding algorithm
        /// </summary>
        /// <param name="start">Starting position</param>
        /// <param name="end">Ending position</param>
        /// <param name="navigationData">Navigation data</param>
        /// <param name="config">Configuration</param>
        /// <returns>Path from start to end</returns>
        public static List<Vector2I> FindPath(Vector2I start, Vector2I end, GridNavigationData navigationData, GridTargetingConfiguration config)
        {
            var openSet = new Dictionary<Vector2I, PathNode>();
            var closedSet = new HashSet<Vector2I>();
            var cameFrom = new Dictionary<Vector2I, Vector2I>();

            var startNode = new PathNode(start, 0, Heuristic(start, end, config));
            openSet[start] = startNode;

            while (openSet.Count > 0)
            {
                // Get node with lowest f score
                var current = openSet.OrderBy(kvp => kvp.Value.FScore).First().Key;
                
                if (current == end)
                {
                    return ReconstructPath(cameFrom, current);
                }

                openSet.Remove(current);
                closedSet.Add(current);

                foreach (var neighbor in GetNeighbors(current, navigationData, config))
                {
                    if (closedSet.Contains(neighbor))
                        continue;

                    var tentativeGScore = openSet[current].GScore + 1;

                    if (!openSet.ContainsKey(neighbor) || tentativeGScore < openSet[neighbor].GScore)
                    {
                        cameFrom[neighbor] = current;
                        var gScore = tentativeGScore;
                        var hScore = Heuristic(neighbor, end, config);
                        openSet[neighbor] = new PathNode(neighbor, gScore, hScore);
                    }
                }
            }

            return new List<Vector2I>(); // No path found
        }
```

Implements A* pathfinding algorithm

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I start`
- `Vector2I end`
- `GridNavigationData navigationData`
- `GridTargetingConfiguration config`

