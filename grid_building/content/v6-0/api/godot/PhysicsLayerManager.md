---
title: "PhysicsLayerManager"
description: "Manages physics layer disable/enable during manipulation operations.
Maintains list of objects with disabled physics layers and coordinates
bulk disable/enable operations to avoid physics interactions during moves.
Ported from: godot/addons/grid_building/systems/manipulation/managers/physics_layer_manager.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/physicslayermanager/"
---

# PhysicsLayerManager

```csharp
GridBuilding.Godot.Systems.Manipulation.Internal
class PhysicsLayerManager
{
    // Members...
}
```

Manages physics layer disable/enable during manipulation operations.
Maintains list of objects with disabled physics layers and coordinates
bulk disable/enable operations to avoid physics interactions during moves.
Ported from: godot/addons/grid_building/systems/manipulation/managers/physics_layer_manager.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/Internal/PhysicsLayerManager.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Internal`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### DisableLayer

```csharp
#region Public Methods

    /// <summary>
    /// Disables a physics layer on all collision objects within target node hierarchy.
    /// 
    /// Searches for CollisionObject2D instances and disables specified physics layer.
    /// Tracks disabled objects for later re-enabling.
    /// </summary>
    /// <param name="target">Node containing objects to disable</param>
    /// <param name="layer">Physics layer to disable (0-31)</param>
    /// <param name="disabledTrack">Dictionary to track disabled objects</param>
    /// <returns>True if any objects were disabled, false otherwise</returns>
    public bool DisableLayer(Node2D? target, int layer, global::Godot.Collections.Dictionary<CollisionObject2D, bool> disabledTrack)
    {
        if (target == null)
            return false;

        if (!IsValidLayer(layer))
            return false;

        var collisionObjects = new global::Godot.Collections.Array<CollisionObject2D>();
        CollectCollisionObjects(target, collisionObjects);

        var disabledCount = 0;
        foreach (CollisionObject2D obj in collisionObjects)
        {
            if (!GodotObject.IsInstanceValid(obj))
                continue;

            // Only disable if layer is currently enabled
            if (obj.GetCollisionLayerValue(layer))
            {
                obj.SetCollisionLayerValue(layer, false);
                disabledTrack[obj] = true;
                disabledCount++;
            }
        }

        return disabledCount > 0;
    }
```

Disables a physics layer on all collision objects within target node hierarchy.
/// Searches for CollisionObject2D instances and disables specified physics layer.
Tracks disabled objects for later re-enabling.

**Returns:** `bool`

**Parameters:**
- `Node2D? target`
- `int layer`
- `global::Godot.Collections.Dictionary<CollisionObject2D, bool> disabledTrack`

### ReenableLayer

```csharp
/// <summary>
    /// Re-enables physics layers on all previously disabled objects.
    /// 
    /// Iterates through tracked disabled objects and restores their physics layer.
    /// Clears tracking dictionary when complete.
    /// </summary>
    /// <param name="disabledTrack">Dictionary of objects that were disabled</param>
    /// <param name="layer">Physics layer to re-enable (0-31)</param>
    public void ReenableLayer(global::Godot.Collections.Dictionary<CollisionObject2D, bool> disabledTrack, int layer)
    {
        if (!IsValidLayer(layer))
            return;

        var keys = new global::Godot.Collections.Array<CollisionObject2D>(disabledTrack.Keys);
        
        foreach (CollisionObject2D obj in keys)
        {
            if (!GodotObject.IsInstanceValid(obj))
                continue;

            // Only re-enable if layer is currently disabled
            if (!obj.GetCollisionLayerValue(layer))
            {
                obj.SetCollisionLayerValue(layer, true);
            }
        }

        disabledTrack.Clear();
    }
```

Re-enables physics layers on all previously disabled objects.
/// Iterates through tracked disabled objects and restores their physics layer.
Clears tracking dictionary when complete.

**Returns:** `void`

**Parameters:**
- `global::Godot.Collections.Dictionary<CollisionObject2D, bool> disabledTrack`
- `int layer`

### DisableLayers

```csharp
/// <summary>
    /// Disables multiple physics layers on all collision objects within target node hierarchy.
    /// </summary>
    /// <param name="target">Node containing objects to disable</param>
    /// <param name="layers">Array of physics layers to disable (0-31)</param>
    /// <param name="disabledTrack">Dictionary to track disabled objects</param>
    /// <returns>True if any objects were disabled, false otherwise</returns>
    public bool DisableLayers(Node2D? target, global::Godot.Collections.Array<int> layers, global::Godot.Collections.Dictionary<CollisionObject2D, bool> disabledTrack)
    {
        if (target == null || layers.Count == 0)
            return false;

        var anyDisabled = false;
        foreach (int layer in layers)
        {
            if (DisableLayer(target, layer, disabledTrack))
                anyDisabled = true;
        }

        return anyDisabled;
    }
```

Disables multiple physics layers on all collision objects within target node hierarchy.

**Returns:** `bool`

**Parameters:**
- `Node2D? target`
- `global::Godot.Collections.Array<int> layers`
- `global::Godot.Collections.Dictionary<CollisionObject2D, bool> disabledTrack`

### ReenableLayers

```csharp
/// <summary>
    /// Re-enables multiple physics layers on all previously disabled objects.
    /// </summary>
    /// <param name="disabledTrack">Dictionary of objects that were disabled</param>
    /// <param name="layers">Array of physics layers to re-enable (0-31)</param>
    public void ReenableLayers(global::Godot.Collections.Dictionary<CollisionObject2D, bool> disabledTrack, global::Godot.Collections.Array<int> layers)
    {
        foreach (int layer in layers)
        {
            ReenableLayer(disabledTrack, layer);
        }
    }
```

Re-enables multiple physics layers on all previously disabled objects.

**Returns:** `void`

**Parameters:**
- `global::Godot.Collections.Dictionary<CollisionObject2D, bool> disabledTrack`
- `global::Godot.Collections.Array<int> layers`

### GetCollisionLayerMask

```csharp
#endregion

    #region Helper Methods

    /// <summary>
    /// Gets the current collision layer mask for a collision object.
    /// </summary>
    /// <param name="obj">Collision object to query</param>
    /// <returns>32-bit mask representing enabled layers</returns>
    public static uint GetCollisionLayerMask(CollisionObject2D obj)
    {
        uint mask = 0;
        for (int i = 0; i < 32; i++)
        {
            if (obj.GetCollisionLayerValue(i))
                mask |= (uint)(1 << i);
        }
        return mask;
    }
```

Gets the current collision layer mask for a collision object.

**Returns:** `uint`

**Parameters:**
- `CollisionObject2D obj`

### SetCollisionLayerMask

```csharp
/// <summary>
    /// Sets the collision layer mask for a collision object.
    /// </summary>
    /// <param name="obj">Collision object to modify</param>
    /// <param name="mask">32-bit mask representing enabled layers</param>
    public static void SetCollisionLayerMask(CollisionObject2D obj, uint mask)
    {
        for (int i = 0; i < 32; i++)
        {
            obj.SetCollisionLayerValue(i, (mask & (1 << i)) != 0);
        }
    }
```

Sets the collision layer mask for a collision object.

**Returns:** `void`

**Parameters:**
- `CollisionObject2D obj`
- `uint mask`

### HasAnyCollisionLayers

```csharp
/// <summary>
    /// Checks if a collision object has any collision layers enabled.
    /// </summary>
    /// <param name="obj">Collision object to check</param>
    /// <returns>True if any layers are enabled, false if all are disabled</returns>
    public static bool HasAnyCollisionLayers(CollisionObject2D obj)
    {
        for (int i = 0; i < 32; i++)
        {
            if (obj.GetCollisionLayerValue(i))
                return true;
        }
        return false;
    }
```

Checks if a collision object has any collision layers enabled.

**Returns:** `bool`

**Parameters:**
- `CollisionObject2D obj`

