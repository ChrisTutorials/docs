---
title: "GBInternals"
description: "Centralized registry for internal component classes.
This module provides a single point of access for internal helper classes used
throughout the Grid Building system. By centralizing internal class references here,
we achieve:
- Single source of truth for internal component loading
- Easier maintenance and dependency tracking
- Reduced scattered preload pattern across codebase
- Clearer distinction between public API and internal implementation
WARNING: Internal API - Subject to Change
These components are internal implementation details. While documented here for
advanced users, they are not part of the public API and may change between versions.
Ported from: godot/addons/grid_building/core/resources/gb_internals.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/gbinternals/"
---

# GBInternals

```csharp
GridBuilding.Godot.Core.Resources
class GBInternals
{
    // Members...
}
```

Centralized registry for internal component classes.
This module provides a single point of access for internal helper classes used
throughout the Grid Building system. By centralizing internal class references here,
we achieve:
- Single source of truth for internal component loading
- Easier maintenance and dependency tracking
- Reduced scattered preload pattern across codebase
- Clearer distinction between public API and internal implementation
WARNING: Internal API - Subject to Change
These components are internal implementation details. While documented here for
advanced users, they are not part of the public API and may change between versions.
Ported from: godot/addons/grid_building/core/resources/gb_internals.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Infrastructure/Internals.cs`  
**Namespace:** `GridBuilding.Godot.Core.Resources`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CreateInstance

```csharp
#endregion

    #region Helper Methods

    /// <summary>
    /// Creates an instance of an internal class by its script path.
    /// This method provides a centralized way to create internal instances.
    /// </summary>
    /// <param name="scriptPath">The UID path to the script</param>
    /// <returns>RefCounted instance of the internal class</returns>
    public static RefCounted CreateInstance(string scriptPath)
    {
        var script = GD.Load(scriptPath) as Script;
        if (script == null)
        {
            GD.PrintErr($"Failed to load internal script: {scriptPath}");
            return null;
        }

        return (RefCounted)script.New();
    }
```

Creates an instance of an internal class by its script path.
This method provides a centralized way to create internal instances.

**Returns:** `RefCounted`

**Parameters:**
- `string scriptPath`

### CreateManipulationTransformHandler

```csharp
/// <summary>
    /// Creates an instance of a manipulation transform handler.
    /// </summary>
    /// <returns>ManipulationTransformHandler instance</returns>
    public static RefCounted CreateManipulationTransformHandler()
    {
        return CreateInstance(ManipulationTransformHandler.ScriptPath);
    }
```

Creates an instance of a manipulation transform handler.

**Returns:** `RefCounted`

### CreateDemolishManager

```csharp
/// <summary>
    /// Creates an instance of a demolish manager.
    /// </summary>
    /// <returns>DemolishManager instance</returns>
    public static RefCounted CreateDemolishManager()
    {
        return CreateInstance(DemolishManager.ScriptPath);
    }
```

Creates an instance of a demolish manager.

**Returns:** `RefCounted`

### CreatePhysicsLayerManager

```csharp
/// <summary>
    /// Creates an instance of a physics layer manager.
    /// </summary>
    /// <returns>PhysicsLayerManager instance</returns>
    public static RefCounted CreatePhysicsLayerManager()
    {
        return CreateInstance(PhysicsLayerManager.ScriptPath);
    }
```

Creates an instance of a physics layer manager.

**Returns:** `RefCounted`

### CreateMoveWorkflowManager

```csharp
/// <summary>
    /// Creates an instance of a move workflow manager.
    /// </summary>
    /// <returns>MoveWorkflowManager instance</returns>
    public static RefCounted CreateMoveWorkflowManager()
    {
        return CreateInstance(MoveWorkflowManager.ScriptPath);
    }
```

Creates an instance of a move workflow manager.

**Returns:** `RefCounted`

### CreatePlacementManager

```csharp
/// <summary>
    /// Creates an instance of a placement manager.
    /// </summary>
    /// <returns>PlacementManager instance</returns>
    public static RefCounted CreatePlacementManager()
    {
        return CreateInstance(PlacementManager.ScriptPath);
    }
```

Creates an instance of a placement manager.

**Returns:** `RefCounted`

### CreateCollisionProcessor

```csharp
/// <summary>
    /// Creates an instance of a collision processor.
    /// </summary>
    /// <returns>CollisionProcessor instance</returns>
    public static RefCounted CreateCollisionProcessor()
    {
        return CreateInstance(CollisionProcessor.ScriptPath);
    }
```

Creates an instance of a collision processor.

**Returns:** `RefCounted`

### CreatePolygonTileMapper

```csharp
/// <summary>
    /// Creates an instance of a polygon tile mapper.
    /// </summary>
    /// <returns>PolygonTileMapper instance</returns>
    public static RefCounted CreatePolygonTileMapper()
    {
        return CreateInstance(PolygonTileMapper.ScriptPath);
    }
```

Creates an instance of a polygon tile mapper.

**Returns:** `RefCounted`

### CreateGeometryCacheManager

```csharp
/// <summary>
    /// Creates an instance of a geometry cache manager.
    /// </summary>
    /// <returns>GeometryCacheManager instance</returns>
    public static RefCounted CreateGeometryCacheManager()
    {
        return CreateInstance(GeometryCacheManager.ScriptPath);
    }
```

Creates an instance of a geometry cache manager.

**Returns:** `RefCounted`

