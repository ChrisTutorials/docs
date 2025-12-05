---
title: "CollisionProcessorBridge"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionprocessorbridge/"
---

# CollisionProcessorBridge

```csharp
GridBuilding.Godot.Systems.Placement.Processors
class CollisionProcessorBridge
{
    // Members...
}
```

Bridge between Godot runtime and Core CollisionProcessor.
This class converts Godot node-based collision data into Core data structures,
processes them using the pure C# CollisionProcessor, and converts results back
to Godot-compatible formats.
This maintains the POCS architecture while providing Godot integration.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Processors/CollisionProcessorBridge.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Processors`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _Notification

```csharp
public override void _Notification(int what)
    {
        if (what == NotificationReady)
        {
            _cacheManager = Resolve<GeometryCacheManager>();
            _logger = Resolve<Logger>();
        }
    }
```

**Returns:** `void`

**Parameters:**
- `int what`

### GetTileOffsetsForCollision

```csharp
/// <summary>
    /// Processes collision data from Godot nodes using Core logic
    /// </summary>
    /// <param name="collisionObj">Godot collision object</param>
    /// <param name="testData">Collision test scenario data</param>
    /// <param name="map">Tile map layer</param>
    /// <param name="positioner">Position reference node</param>
    /// <returns>Godot-compatible collision positions</returns>
    public global::Godot.Collections.Dictionary<Vector2I, global::Godot.Collections.Array> GetTileOffsetsForCollision(
        Node2D collisionObj,
        CollisionScenarioBuilder2D? testData,
        TileMapLayer map,
        Node2D positioner)
    {
        var godotResult = new global::Godot.Collections.Dictionary<Vector2I, global::Godot.Collections.Array>();

        // Validate inputs
        if (collisionObj == null || map == null || positioner == null || testData == null)
        {
            _logger?.LogWarning("Invalid inputs for collision processing");
            return godotResult;
        }

        try
        {
            // Convert Godot data to Core data structures
            var scenarioData = ConvertToCoreScenarioData(testData, positioner);
            var mapData = ConvertToCoreMapData(map);
            var centerTile = map.LocalToMap(map.ToLocal(positioner.GlobalPosition));

            // Process using Core logic
            var coreResult = _coreProcessor.ProcessCollisions(scenarioData, mapData, centerTile);

            // Convert Core results back to Godot format
            godotResult = ConvertToGodotResult(coreResult);

            _logger?.LogVerbose($"Collision processing complete. Found {godotResult.Count} collision positions");
        }
        catch (System.Exception ex)
        {
            _logger?.LogError($"Error in collision processing bridge: {ex.Message}");
        }

        return godotResult;
    }
```

Processes collision data from Godot nodes using Core logic

**Returns:** `global::Godot.Collections.Dictionary<Vector2I, global::Godot.Collections.Array>`

**Parameters:**
- `Node2D collisionObj`
- `CollisionScenarioBuilder2D? testData`
- `TileMapLayer map`
- `Node2D positioner`

### CreateWithCoreProcessor

```csharp
/// <summary>
    /// Creates a collision processor bridge with custom Core processor
    /// </summary>
    public static CollisionProcessorBridge CreateWithCoreProcessor(CollisionProcessor coreProcessor)
    {
        return new CollisionProcessorBridge
        {
            _coreProcessor = coreProcessor
        };
    }
```

Creates a collision processor bridge with custom Core processor

**Returns:** `CollisionProcessorBridge`

**Parameters:**
- `CollisionProcessor coreProcessor`

