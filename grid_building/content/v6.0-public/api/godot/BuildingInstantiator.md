---
title: "BuildingInstantiator"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/buildinginstantiator/"
---

# BuildingInstantiator

```csharp
GridBuilding.Godot.Systems.Building.Internal
class BuildingInstantiator
{
    // Members...
}
```

Handles instantiation of building objects.
Ported from: godot/addons/grid_building/systems/building/building_instantiator.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Building/Internal/BuildingInstantiator.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Building.Internal`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### InstantiateBuilding

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Instantiates a building object from a placeable resource.
    /// </summary>
    /// <param name="placeable">The placeable resource to instantiate</param>
    /// <returns>The instantiated node, or null if failed</returns>
    public Node2D? InstantiateBuilding(Resource placeable)
    {
        if (placeable == null)
            return null;

        // TODO: Implement proper building instantiation logic
        // This would involve:
        // 1. Loading the packed scene from the placeable
        // 2. Instantiating the scene
        // 3. Setting up initial properties
        // 4. Adding to the appropriate parent
        
        return null; // Placeholder until full implementation
    }
```

Instantiates a building object from a placeable resource.

**Returns:** `Node2D?`

**Parameters:**
- `Resource placeable`

### SetupBuilding

```csharp
/// <summary>
    /// Sets up a building instance after instantiation.
    /// </summary>
    /// <param name="instance">The building instance to set up</param>
    /// <param name="placeable">The original placeable resource</param>
    public void SetupBuilding(Node2D instance, Resource placeable)
    {
        if (instance == null || placeable == null)
            return;

        // TODO: Implement building setup logic
        // This would involve:
        // 1. Setting initial transform
        // 2. Applying metadata
        // 3. Setting up collision layers
        // 4. Connecting signals
    }
```

Sets up a building instance after instantiation.

**Returns:** `void`

**Parameters:**
- `Node2D instance`
- `Resource placeable`

