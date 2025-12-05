---
title: "PhysicsMatchingUtils2D"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/physicsmatchingutils2d/"
---

# PhysicsMatchingUtils2D

```csharp
GridBuilding.Godot.Shared.Utils
class PhysicsMatchingUtils2D
{
    // Members...
}
```

Utilities for Getting Collision Shapes, Objects, and Polygons for Collision Tasks.
Ported from: godot/addons/grid_building/shared/utils/general/physics_matching_utils_2d.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/PhysicsMatchingUtils2D.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetMatchingCollisionObjects

```csharp
#region Public Methods

    /// <summary>
    /// Gets all collision objects from the preview_instance including self and children for matching nodes.
    /// Must have layers matching at least one of the mask layers from the tile collision template.
    /// </summary>
    /// <param name="container">Container to search for collision objects</param>
    /// <param name="shapeCast">Shape cast providing collision mask for matching</param>
    /// <param name="requireAllMaskLayers">Whether objects must match all mask layers (default false)</param>
    /// <returns>Array of matching collision objects</returns>
    public static global::Godot.Collections.Array<CollisionObject2D> GetMatchingCollisionObjects(
        Node2D? container,
        ShapeCast2D shapeCast,
        bool requireAllMaskLayers = false)
    {
        if (container == null)
        {
            GD.PrintErr("Root node container for collision object cannot be null.");
            return new global::Godot.Collections.Array<CollisionObject2D>();
        }

        var collisionObjects = new global::Godot.Collections.Array<CollisionObject2D>();

        if (container is CollisionObject2D containerCollision)
        {
            collisionObjects.Add(containerCollision);
        }

        var childCollisionObjects = container.FindChildren("", "CollisionObject2D");
        foreach (var child in childCollisionObjects)
        {
            if (child is CollisionObject2D childCollision)
            {
                collisionObjects.Add(childCollision);
            }
        }

        var collidableObjects = new global::Godot.Collections.Array<CollisionObject2D>();

        foreach (var colObj in collisionObjects)
        {
            var matched = false;

            for (int i = 1; i < 32; i++)
            {
                if (shapeCast.GetCollisionMaskValue(i))
                {
                    if (colObj.GetCollisionLayerValue(i))
                    {
                        matched = true;

                        if (!requireAllMaskLayers)
                        {
                            break;
                        }
                    }
                    else if (requireAllMaskLayers)
                    {
                        // Failed to match on needed mask layer
                        matched = false;
                        break;
                    }
                }
            }

            if (matched)
            {
                collidableObjects.Add(colObj);
            }
        }

        return collidableObjects;
    }
```

Gets all collision objects from the preview_instance including self and children for matching nodes.
Must have layers matching at least one of the mask layers from the tile collision template.

**Returns:** `global::Godot.Collections.Array<CollisionObject2D>`

**Parameters:**
- `Node2D? container`
- `ShapeCast2D shapeCast`
- `bool requireAllMaskLayers`

### GetPhysicsLayerNamesFromMask

```csharp
/// <summary>
    /// Gets physics layer names from a collision mask.
    /// </summary>
    /// <param name="mask">The collision mask</param>
    /// <returns>Array of layer names</returns>
    public static global::Godot.Collections.Array<string> GetPhysicsLayerNamesFromMask(uint mask)
    {
        var layerNames = new global::Godot.Collections.Array<string>();
        
        // Get the project settings for layer names
        var layerNamesSetting = ProjectSettings.GetSetting("layer_names/2d_physics/layer_1") as string;
        
        // Check each bit in the mask and add corresponding layer name
        for (int i = 0; i < 32; i++)
        {
            if ((mask & (1U << i)) != 0)
            {
                var layerSettingKey = $"layer_names/2d_physics/layer_{i + 1}";
                var layerName = ProjectSettings.GetSetting(layerSettingKey) as string ?? $"Layer {i + 1}";
                layerNames.Add(layerName);
            }
        }

        return layerNames;
    }
```

Gets physics layer names from a collision mask.

**Returns:** `global::Godot.Collections.Array<string>`

**Parameters:**
- `uint mask`

