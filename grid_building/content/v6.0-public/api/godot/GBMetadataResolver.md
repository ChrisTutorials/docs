---
title: "GBMetadataResolver"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/gbmetadataresolver/"
---

# GBMetadataResolver

```csharp
GridBuilding.Godot.Systems.Manipulation.Utils
class GBMetadataResolver
{
    // Members...
}
```

Utility class for resolving metadata from nodes.
Ported from: godot/addons/grid_building/shared/utils/metadata_resolver.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Utils/MetadataResolver.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ResolveManipulationTarget

```csharp
/// <summary>
    /// Resolves a manipulation target from a collision object.
    /// </summary>
    /// <param name="collisionObject">The collision object to resolve</param>
    /// <returns>ManipulationTargetResult with resolved components</returns>
    public static ManipulationTargetResult ResolveManipulationTarget(CollisionObject2D? collisionObject)
    {
        var result = new ManipulationTargetResult();

        if (collisionObject == null)
            return result;

        // Try to find Manipulatable component on the collision object
        var manipulatable = GBSearchUtils.FindFirst<Manipulatable>(collisionObject);
        if (manipulatable != null)
        {
            result.Manipulatable = manipulatable;
            result.TargetNode = manipulatable.Root ?? collisionObject;
        }
        else
        {
            // If no Manipulatable component, use the collision object itself as target
            result.TargetNode = collisionObject;
        }

        return result;
    }
```

Resolves a manipulation target from a collision object.

**Returns:** `ManipulationTargetResult`

**Parameters:**
- `CollisionObject2D? collisionObject`

### ResolveMetadata

```csharp
/// <summary>
    /// Resolves metadata from any node.
    /// </summary>
    /// <param name="node">The node to resolve metadata from</param>
    /// <returns>Dictionary containing resolved metadata</returns>
    public static global::Godot.Collections.Dictionary ResolveMetadata(Node? node)
    {
        var metadata = new global::Godot.Collections.Dictionary();

        if (node == null)
            return metadata;

        // Add basic node information
        metadata["name"] = node.Name;
        metadata["type"] = node.GetType().Name;
        metadata["path"] = node.GetPath();

        // Add transform information if it's a Node2D
        if (node is Node2D node2D)
        {
            metadata["position"] = node2D.Position;
            metadata["global_position"] = node2D.GlobalPosition;
            metadata["rotation"] = node2D.Rotation;
            metadata["scale"] = node2D.Scale;
        }

        // Add collision information if it's a CollisionObject2D
        if (node is CollisionObject2D collisionObj)
        {
            metadata["collision_layer"] = collisionObj.CollisionLayer;
            metadata["collision_mask"] = collisionObj.CollisionMask;
        }

        // Add manipulatable information if present
        var manipulatable = GBSearchUtils.FindFirst<Manipulatable>(node);
        if (manipulatable != null)
        {
            metadata["can_move"] = manipulatable.CanMove;
            metadata["can_rotate"] = manipulatable.CanRotate;
            metadata["can_demolish"] = manipulatable.CanDemolish;
            metadata["can_flip_horizontal"] = manipulatable.CanFlipHorizontal;
            metadata["can_flip_vertical"] = manipulatable.CanFlipVertical;
        }

        return metadata;
    }
```

Resolves metadata from any node.

**Returns:** `global::Godot.Collections.Dictionary`

**Parameters:**
- `Node? node`

### HasMetadata

```csharp
/// <summary>
    /// Checks if a node has specific metadata.
    /// </summary>
    /// <param name="node">The node to check</param>
    /// <param name="key">The metadata key to check for</param>
    /// <returns>True if the metadata key exists and has a value</returns>
    public static bool HasMetadata(Node? node, string key)
    {
        if (node == null || string.IsNullOrEmpty(key))
            return false;

        // Check for metadata in node's meta properties
        if (node.HasMeta(key))
        {
            var value = node.GetMeta(key);
            return value != null && !value.IsNull();
        }

        return false;
    }
```

Checks if a node has specific metadata.

**Returns:** `bool`

**Parameters:**
- `Node? node`
- `string key`

### GetMetadata

```csharp
/// <summary>
    /// Gets metadata value from a node.
    /// </summary>
    /// <param name="node">The node to get metadata from</param>
    /// <param name="key">The metadata key</param>
    /// <param name="defaultValue">Default value if key not found</param>
    /// <returns>Metadata value or default</returns>
    public static Variant GetMetadata(Node? node, string key, Variant? defaultValue = null)
    {
        if (node == null || string.IsNullOrEmpty(key))
            return defaultValue ?? new Variant();

        if (node.HasMeta(key))
        {
            return node.GetMeta(key);
        }

        return defaultValue ?? new Variant();
    }
```

Gets metadata value from a node.

**Returns:** `Variant`

**Parameters:**
- `Node? node`
- `string key`
- `Variant? defaultValue`

### SetMetadata

```csharp
/// <summary>
    /// Sets metadata on a node.
    /// </summary>
    /// <param name="node">The node to set metadata on</param>
    /// <param name="key">The metadata key</param>
    /// <param name="value">The metadata value</param>
    public static void SetMetadata(Node? node, string key, Variant value)
    {
        if (node == null || string.IsNullOrEmpty(key))
            return;

        node.SetMeta(key, value);
    }
```

Sets metadata on a node.

**Returns:** `void`

**Parameters:**
- `Node? node`
- `string key`
- `Variant value`

### RemoveMetadata

```csharp
/// <summary>
    /// Removes metadata from a node.
    /// </summary>
    /// <param name="node">The node to remove metadata from</param>
    /// <param name="key">The metadata key to remove</param>
    public static void RemoveMetadata(Node? node, string key)
    {
        if (node == null || string.IsNullOrEmpty(key))
            return;

        if (node.HasMeta(key))
        {
            node.RemoveMeta(key);
        }
    }
```

Removes metadata from a node.

**Returns:** `void`

**Parameters:**
- `Node? node`
- `string key`

