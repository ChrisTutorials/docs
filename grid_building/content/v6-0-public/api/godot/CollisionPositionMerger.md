---
title: "CollisionPositionMerger"
description: "Collision position merging utilities.
Ported from GDScript collision_processor.gd merge methods."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/collisionpositionmerger/"
---

# CollisionPositionMerger

```csharp
GridBuilding.Godot.Systems.Placement.Processors
class CollisionPositionMerger
{
    // Members...
}
```

Collision position merging utilities.
Ported from GDScript collision_processor.gd merge methods.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Processors/CollisionProcessorHelpers.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Processors`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### MergeOffsetsIntoPositions

```csharp
/// <summary>
    /// Merge offsets into positions with center tile conversion.
    /// 
    /// FINAL COORDINATE VALIDATION:
    /// At this point, shapeOffsets contains relative tile offsets (Vector2i)
    /// calculated as (tile_pos - center_tile) where center_tile is based on
    /// positioner.global_position. These offsets are ready for IndicatorFactory
    /// to convert back to world positions as: positioner_position + (offset * tile_size)
    /// </summary>
    public static void MergeOffsetsIntoPositions(
        List<Vector2I> shapeOffsets,
        Dictionary<Vector2I, List<Node2D>> collisionPositions,
        Node2D colObj,
        Vector2I centerTile
    )
    {
        // Keep keys as relative offsets (tile_pos - center_tile). IndicatorFactory
        // expects relative offsets and will convert them back to absolute tiles
        // by adding the positioner's tile coordinate.
        foreach (var offset in shapeOffsets)
        {
            if (collisionPositions.ContainsKey(offset))
            {
                if (!collisionPositions[offset].Contains(colObj))
                    collisionPositions[offset].Add(colObj);
            }
            else
            {
                collisionPositions[offset] = new List<Node2D> { colObj };
            }
        }

        // Diagnostic: only log merge summary at verbose level to reduce test noise
        if (shapeOffsets.Count > 0)
        {
            GD.Print($"[CollisionProcessor] merged_offsets_count={shapeOffsets.Count}, sample_offset={shapeOffsets[0]}, total_positions={collisionPositions.Count}");
            
            // Print a compact list of offsets (limit to first 40 to avoid huge logs)
            var sampleList = shapeOffsets;
            if (sampleList.Count > 40)
                sampleList = sampleList.GetRange(0, 40);
            GD.Print($"[CollisionProcessor] merged_offsets_list_sample={string.Join(", ", sampleList)}");
        }
    }
```

Merge offsets into positions with center tile conversion.
/// FINAL COORDINATE VALIDATION:
At this point, shapeOffsets contains relative tile offsets (Vector2i)
calculated as (tile_pos - center_tile) where center_tile is based on
positioner.global_position. These offsets are ready for IndicatorFactory
to convert back to world positions as: positioner_position + (offset * tile_size)

**Returns:** `void`

**Parameters:**
- `List<Vector2I> shapeOffsets`
- `Dictionary<Vector2I, List<Node2D>> collisionPositions`
- `Node2D colObj`
- `Vector2I centerTile`

### MergeCollisionPositions

```csharp
/// <summary>
    /// Merge two collision position dictionaries.
    /// </summary>
    public static void MergeCollisionPositions(
        Dictionary<Vector2I, List<Node2D>> targetPositions,
        Dictionary<Vector2I, List<Node2D>> sourcePositions
    )
    {
        foreach (var tileOffset in sourcePositions.Keys)
        {
            var collisionObjects = sourcePositions[tileOffset];
            if (targetPositions.ContainsKey(tileOffset))
            {
                foreach (var colObj in collisionObjects)
                {
                    if (!targetPositions[tileOffset].Contains(colObj))
                        targetPositions[tileOffset].Add(colObj);
                }
            }
            else
            {
                targetPositions[tileOffset] = new List<Node2D>(collisionObjects);
            }
        }
    }
```

Merge two collision position dictionaries.

**Returns:** `void`

**Parameters:**
- `Dictionary<Vector2I, List<Node2D>> targetPositions`
- `Dictionary<Vector2I, List<Node2D>> sourcePositions`

