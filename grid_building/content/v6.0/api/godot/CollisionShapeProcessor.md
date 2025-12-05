---
title: "CollisionShapeProcessor"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionshapeprocessor/"
---

# CollisionShapeProcessor

```csharp
GridBuilding.Godot.Systems.Placement.Processors
class CollisionShapeProcessor
{
    // Members...
}
```

Processes collision shapes to determine tile offsets for grid-based placement.
Ported from: godot/addons/grid_building/systems/placement/processors/collision_shape_processor.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Processors/CollisionShapeProcessor.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Processors`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetTileOffsetsForCollisionObject

```csharp
public Dictionary<Vector2I, List<Node2D>> GetTileOffsetsForCollisionObject(
        CollisionTestSetup2D testData, TileMapLayer map, Node2D positioner
    )
    {
        var collisionPositions = new Dictionary<Vector2I, List<Node2D>>();

        if (testData == null)
        {
            GD.PushError("CollisionShapeProcessor: testData is null.");
            return collisionPositions;
        }

        if (testData.CollisionObject == null)
        {
            GD.PushError("CollisionShapeProcessor: testData.CollisionObject is null.");
            return collisionPositions;
        }

        if (testData.CollisionObject is not CollisionObject2D colObj)
        {
            GD.PushError("CollisionShapeProcessor: Expected CollisionObject2D.");
            return collisionPositions;
        }

        if (map == null)
        {
            GD.PushError("CollisionShapeProcessor: map is null.");
            return collisionPositions;
        }

        if (map.TileSet == null)
        {
            GD.PushError("CollisionShapeProcessor: map.TileSet is null.");
            return collisionPositions;
        }

        if (!InitializeCollisionMapping(positioner, collisionPositions))
            return collisionPositions;

        var centerTile = CollisionUtilities.CenterTileForShapeObject(map, colObj);
        var tileSize = map.TileSet.TileSize;
        var shapeEpsilon = 0.035f;

        // Single source of truth: get tile shape directly from TileMapLayer's TileSet
        var tileShape = map.TileSet.TileShape;

        foreach (var rectTestSetup in testData.RectCollisionTestSetups)
        {
            // Use the ShapeOwner from the data structure
            var shapePositions = ProcessShapeOffsets(
                rectTestSetup, testData, map, centerTile, tileSize, shapeEpsilon, colObj, rectTestSetup.ShapeOwner, tileShape
            );
            MergeCollisionPositions(collisionPositions, shapePositions);
        }

        return collisionPositions;
    }
```

**Returns:** `Dictionary<Vector2I, List<Node2D>>`

**Parameters:**
- `CollisionTestSetup2D testData`
- `TileMapLayer map`
- `Node2D positioner`

