---
title: "CollisionPositionMerger"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/collisionpositionmerger/"
---

# CollisionPositionMerger

```csharp
GridBuilding.Core.Geometry
class CollisionPositionMerger
{
    // Members...
}
```

Collision position merging utilities for collision processing.
Core implementation without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/CollisionProcessorHelpers.cs`  
**Namespace:** `GridBuilding.Core.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### MergeOffsetsIntoPositions

```csharp
/// <summary>
    /// Merges collision position dictionaries.
    /// </summary>
    public static void MergeOffsetsIntoPositions(
        List<Vector2I> sourceOffsets,
        Dictionary<Vector2I, List<object>> targetPositions,
        object collisionObject,
        Vector2I centerTile)
    {
        foreach (var offset in sourceOffsets)
        {
            if (!targetPositions.ContainsKey(offset))
            {
                targetPositions[offset] = new List<object>();
            }
            
            var targetArray = targetPositions[offset];
            if (!targetArray.Contains(collisionObject))
            {
                targetArray.Add(collisionObject);
            }
        }
    }
```

Merges collision position dictionaries.

**Returns:** `void`

**Parameters:**
- `List<Vector2I> sourceOffsets`
- `Dictionary<Vector2I, List<object>> targetPositions`
- `object collisionObject`
- `Vector2I centerTile`

