---
title: "GBPlacementPersistence"
description: "Utility class for persisting placement data using metadata.
Ported from: godot/addons/grid_building/helpers/utils/data/placement_persistence.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gbplacementpersistence/"
---

# GBPlacementPersistence

```csharp
GridBuilding.Godot.Data
class GBPlacementPersistence
{
    // Members...
}
```

Utility class for persisting placement data using metadata.
Ported from: godot/addons/grid_building/helpers/utils/data/placement_persistence.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Data/PlacementPersistence.cs`  
**Namespace:** `GridBuilding.Godot.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### MarkObjectAsPlaced

```csharp
/// <summary>
    /// Marks an object as placed with placement metadata.
    /// </summary>
    /// <param name="node">The node to mark</param>
    /// <param name="placeablePath">Path to the placeable resource</param>
    /// <param name="transform">Transform of the placed object</param>
    public static void MarkObjectAsPlaced(Node node, string placeablePath, Transform2D transform)
    {
        if (node == null) return;
        
        node.SetMeta("gb_placed", true);
        node.SetMeta("gb_placeable_path", placeablePath);
        node.SetMeta("gb_placement_transform", new Variant(transform));
    }
```

Marks an object as placed with placement metadata.

**Returns:** `void`

**Parameters:**
- `Node node`
- `string placeablePath`
- `Transform2D transform`

### GetPlacementData

```csharp
/// <summary>
    /// Gets placement data from a marked object.
    /// </summary>
    /// <param name="node">The node to get data from</param>
    /// <returns>Placement data or null if not placed</returns>
    public static PlacementData? GetPlacementData(Node node)
    {
        if (node == null || !node.HasMeta("gb_placed"))
            return null;

        var placeablePath = node.GetMeta("gb_placeable_path").AsString();
        var transform = node.GetMeta("gb_placement_transform").AsTransform2D();

        return new PlacementData
        {
            PlaceablePath = placeablePath,
            Transform = transform,
            NodeName = node.Name
        };
    }
```

Gets placement data from a marked object.

**Returns:** `PlacementData?`

**Parameters:**
- `Node node`

### IsObjectPlaced

```csharp
/// <summary>
    /// Checks if an object is marked as placed.
    /// </summary>
    /// <param name="node">The node to check</param>
    /// <returns>True if marked as placed</returns>
    public static bool IsObjectPlaced(Node node)
    {
        return node != null && node.HasMeta("gb_placed") && node.GetMeta("gb_placed").AsBool();
    }
```

Checks if an object is marked as placed.

**Returns:** `bool`

**Parameters:**
- `Node node`

### UnmarkObject

```csharp
/// <summary>
    /// Removes placement marking from an object.
    /// </summary>
    /// <param name="node">The node to unmark</param>
    public static void UnmarkObject(Node node)
    {
        if (node == null) return;
        
        node.RemoveMeta("gb_placed");
        node.RemoveMeta("gb_placeable_path");
        node.RemoveMeta("gb_placement_transform");
    }
```

Removes placement marking from an object.

**Returns:** `void`

**Parameters:**
- `Node node`

