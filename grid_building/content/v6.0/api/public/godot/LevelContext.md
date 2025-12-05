---
title: "LevelContext"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/levelcontext/"
---

# LevelContext

```csharp
GridBuilding.Godot.Shared.Components.Context
class LevelContext
{
    // Members...
}
```

Organizes object requirements for building onto a game level for GBCompositeContainers.
Ported from: godot/addons/grid_building/shared/components/context/gb_level_context.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/LevelContext.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Components.Context`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TargetMap

```csharp
/// <summary>
    /// The TileMapLayer to use as the tile selection target for the grid targeting state
    /// </summary>
    [Export]
    public TileMapLayer? TargetMap { get; set; }
```

The TileMapLayer to use as the tile selection target for the grid targeting state

### Maps

```csharp
/// <summary>
    /// All maps in the game level.
    /// Sets this data on the targeting state's maps during gameplay.
    /// </summary>
    public global::Godot.Collections.Array<TileMapLayer>? Maps { get; set; }
```

All maps in the game level.
Sets this data on the targeting state's maps during gameplay.

### ObjectsParent

```csharp
/// <summary>
    /// Where objects should be placed into the scene under in the scene hierarchy
    /// </summary>
    [Export]
    public Node2D? ObjectsParent { get; set; }
```

Where objects should be placed into the scene under in the scene hierarchy


## Methods

### GetEditorIssues

```csharp
// Dependencies (would be injected via composition container)
    // For now, these are placeholders until we port the full DI system
    
    /// <summary>
    /// Validate setup and return a list of issues with the current object.
    /// </summary>
    /// <returns>List of validation issues (empty if valid)</returns>
    public List<string> GetEditorIssues()
    {
        var issues = new List<string>();
        
        if (TargetMap == null)
        {
            issues.Add("No target map set for LevelBuildingContext");
        }
        
        if (ObjectsParent == null)
        {
            issues.Add("No objects parent set for LevelBuildingContext");
        }
        
        if (Maps == null || Maps.Count == 0)
        {
            issues.Add("No maps set for LevelBuildingContext");
        }
        
        return issues;
    }
```

Validate setup and return a list of issues with the current object.

**Returns:** `List<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Get runtime issues - delegates to editor issues for now.
    /// </summary>
    /// <returns>List of validation issues (empty if valid)</returns>
    public List<string> GetRuntimeIssues()
    {
        return GetEditorIssues();
    }
```

Get runtime issues - delegates to editor issues for now.

**Returns:** `List<string>`

