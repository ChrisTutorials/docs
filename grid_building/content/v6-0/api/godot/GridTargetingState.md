---
title: "GridTargetingState"
description: "Godot-specific implementation of GridTargetingState that wraps the Core POCS implementation.
Provides Godot Resource compatibility and Godot-specific signal emission.
Ported from: godot/addons/grid_building/systems/grid_targeting/grid_targeting_state.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gridtargetingstate/"
---

# GridTargetingState

```csharp
GridBuilding.Godot.Systems.GridTargeting
class GridTargetingState
{
    // Members...
}
```

Godot-specific implementation of GridTargetingState that wraps the Core POCS implementation.
Provides Godot Resource compatibility and Godot-specific signal emission.
Ported from: godot/addons/grid_building/systems/grid_targeting/grid_targeting_state.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/GridTargeting/GridTargetingState.cs`  
**Namespace:** `GridBuilding.Godot.Systems.GridTargeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Positioner

```csharp
/// <summary>
    /// Parent node for positioning grid building objects onto the game world.
    /// </summary>
    public Node2D? Positioner
    {
        get => _coreState.Positioner as Node2D;
        set
        {
            _coreState.Positioner = value;
        }
    }
```

Parent node for positioning grid building objects onto the game world.

### TargetMap

```csharp
/// <summary>
    /// The TileMapLayer or TileMap node to be used when determining grid distances in your game world.
    /// </summary>
    public TileMapLayer? TargetMap
    {
        get => _coreState.TargetMap as TileMapLayer;
        set
        {
            _coreState.TargetMap = value;
        }
    }
```

The TileMapLayer or TileMap node to be used when determining grid distances in your game world.

### Maps

```csharp
/// <summary>
    /// All maps to be known by the targeting state for testing against without casting for collisions.
    /// </summary>
    public global::Godot.Collections.Array<TileMapLayer> Maps
    {
        get
        {
            var result = new global::Godot.Collections.Array<TileMapLayer>();
            if (_coreState.Maps != null)
            {
                foreach (var map in _coreState.Maps)
                {
                    if (map is TileMapLayer tileMap)
                    {
                        result.Add(tileMap);
                    }
                }
            }
            return result;
        }
        set
        {
            var mapsList = value?.Select(m => (object)m).ToList() ?? new List<object>();
            _coreState.Maps = mapsList;
        }
    }
```

All maps to be known by the targeting state for testing against without casting for collisions.

### TileSize

```csharp
/// <summary>
    /// Tile size property that delegates to the target map's tile set
    /// </summary>
    public Vector2I TileSize
    {
        get => _coreState.TileSize;
        set => _coreState.TileSize = value;
    }
```

Tile size property that delegates to the target map's tile set

### CollisionExclusions

```csharp
/// <summary>
    /// Nodes that should be excluded from collision detection during indicator validation.
    /// </summary>
    public global::Godot.Collections.Array<Node> CollisionExclusions
    {
        get
        {
            var result = new global::Godot.Collections.Array<Node>();
            if (_coreState.CollisionExclusions != null)
            {
                foreach (var exclusion in _coreState.CollisionExclusions)
                {
                    if (exclusion is Node node)
                    {
                        result.Add(node);
                    }
                }
            }
            return result;
        }
        set
        {
            var exclusionsList = value?.Select(e => (object)e).ToList() ?? new List<object>();
            _coreState.CollisionExclusions = exclusionsList;
        }
    }
```

Nodes that should be excluded from collision detection during indicator validation.


## Methods

### IsReady

```csharp
public bool IsReady() => _coreState.IsReady();
```

**Returns:** `bool`

### IsManualTargetingActive

```csharp
public bool IsManualTargetingActive() => _coreState.IsManualTargetingActive();
```

**Returns:** `bool`

### ClearCollisionExclusions

```csharp
public void ClearCollisionExclusions() => _coreState.ClearCollisionExclusions();
```

**Returns:** `void`

### SetManualTarget

```csharp
public void SetManualTarget(object? target) => _coreState.SetManualTarget(target);
```

**Returns:** `void`

**Parameters:**
- `object? target`

### Clear

```csharp
public void Clear() => _coreState.Clear();
```

**Returns:** `void`

### GetTarget

```csharp
public object? GetTarget() => _coreState.GetTarget();
```

**Returns:** `object?`

### GetCollider

```csharp
public object? GetCollider() => _coreState.GetCollider();
```

**Returns:** `object?`

### GetTileSize

```csharp
public Vector2I GetTileSize() => _coreState.GetTileSize();
```

**Returns:** `Vector2I`

### GetTargetMapTileSet

```csharp
public object? GetTargetMapTileSet() => _coreState.GetTargetMapTileSet();
```

**Returns:** `object?`

### SetCollider

```csharp
public void SetCollider(object? collider) => _coreState.SetCollider(collider);
```

**Returns:** `void`

**Parameters:**
- `object? collider`

### SetMapObjects

```csharp
public void SetMapObjects(object? targetMap, IList<object>? maps) => _coreState.SetMapObjects(targetMap, maps);
```

**Returns:** `void`

**Parameters:**
- `object? targetMap`
- `IList<object>? maps`

### SetTileSize

```csharp
public void SetTileSize(Vector2I size) => _coreState.SetTileSize(size);
```

**Returns:** `void`

**Parameters:**
- `Vector2I size`

### GetEditorIssues

```csharp
public List<string> GetEditorIssues() => _coreState.GetEditorIssues();
```

**Returns:** `List<string>`

### GetRuntimeIssues

```csharp
public List<string> GetRuntimeIssues() => _coreState.GetRuntimeIssues();
```

**Returns:** `List<string>`

### GetTarget

```csharp
#endregion

    #region Godot-Specific Methods

    /// <summary>
    /// Returns the resolved target node (the logical root).
    /// </summary>
    public Node2D? GetTarget()
    {
        return _coreState.GetTarget() as Node2D;
    }
```

Returns the resolved target node (the logical root).

**Returns:** `Node2D?`

### GetCollider

```csharp
/// <summary>
    /// Returns the raw collision object.
    /// </summary>
    public Node2D? GetCollider()
    {
        return _coreState.GetCollider() as Node2D;
    }
```

Returns the raw collision object.

**Returns:** `Node2D?`

### GetTargetMapTileSet

```csharp
/// <summary>
    /// Gets the tileset of the currently targeted TileMapLayer
    /// </summary>
    public TileSet? GetTargetMapTileSet()
    {
        return _coreState.GetTargetMapTileSet() as TileSet;
    }
```

Gets the tileset of the currently targeted TileMapLayer

**Returns:** `TileSet?`

### SetCollider

```csharp
/// <summary>
    /// Sets the collision object and automatically resolves the target.
    /// </summary>
    public void SetCollider(Node2D? pCollider)
    {
        _coreState.SetCollider(pCollider);
    }
```

Sets the collision object and automatically resolves the target.

**Returns:** `void`

**Parameters:**
- `Node2D? pCollider`

### SetMapObjects

```csharp
/// <summary>
    /// Sets the target map and maps array for this targeting state
    /// </summary>
    public void SetMapObjects(TileMapLayer pTargetMap, global::Godot.Collections.Array<TileMapLayer> pMaps)
    {
        var mapsList = pMaps?.Select(m => (object)m).ToList() ?? new List<object>();
        _coreState.SetMapObjects(pTargetMap, mapsList);
    }
```

Sets the target map and maps array for this targeting state

**Returns:** `void`

**Parameters:**
- `TileMapLayer pTargetMap`
- `global::Godot.Collections.Array<TileMapLayer> pMaps`

### GetOwner

```csharp
public Node? GetOwner()
    {
        return _ownerContext?.GetOwner() as Node;
    }
```

**Returns:** `Node?`

### GetOwnerRoot

```csharp
public Node? GetOwnerRoot()
    {
        return _ownerContext?.GetOwnerRoot() as Node;
    }
```

**Returns:** `Node?`

### GetOrigin

```csharp
public Node? GetOrigin()
    {
        return _ownerContext?.GetOrigin() as Node;
    }
```

**Returns:** `Node?`

### GetEditorIssues

```csharp
public global::Godot.Collections.Array<string> GetEditorIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();
        foreach (var issue in _coreState.GetEditorIssues())
        {
            issues.Add(issue);
        }
        return issues;
    }
```

**Returns:** `global::Godot.Collections.Array<string>`

### GetRuntimeIssues

```csharp
public global::Godot.Collections.Array<string> GetRuntimeIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();
        foreach (var issue in _coreState.GetRuntimeIssues())
        {
            issues.Add(issue);
        }
        return issues;
    }
```

**Returns:** `global::Godot.Collections.Array<string>`

