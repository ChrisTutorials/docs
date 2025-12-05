---
title: "BuildingNode"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/buildingnode/"
---

# BuildingNode

```csharp
GridBuilding.Godot.Shared.Components.Placeables
class BuildingNode
{
    // Members...
}
```

Temporary script attached to objects being built in place of their gameplay script.
Removed after the object is built.
Ported from: godot/addons/grid_building/shared/components/placeables/building_node.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/BuildingNode.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Components.Placeables`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ToString

```csharp
/// <summary>
    /// Custom display for objects being built.
    /// </summary>
    public override string ToString()
    {
        // Converts the node name to a readable format
        // e.g., "BuildingNode_123" -> "Building Node 123"
        return ConvertNameToReadable(Name);
    }
```

Custom display for objects being built.

**Returns:** `string`

