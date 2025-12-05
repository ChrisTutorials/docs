---
title: "GridBuildingGameNode"
description: "Base class for a node that is attached to gameplay objects for grid building operations"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gridbuildinggamenode/"
---

# GridBuildingGameNode

```csharp
GridBuilding.Godot.Core.Base
class GridBuildingGameNode
{
    // Members...
}
```

Base class for a node that is attached to gameplay objects for grid building operations

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Base/GridBuildingGameNode.cs`  
**Namespace:** `GridBuilding.Godot.Core.Base`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _Ready

```csharp
// Additional gameplay-specific functionality can be added here
    // This class extends GridBuildingNode with gameplay-specific features
    
    /// <summary>
    /// Called when the node enters the scene tree for the first time
    /// </summary>
    public override void _Ready()
    {
        base._Ready();
        // Gameplay-specific initialization can be added here
    }
```

Called when the node enters the scene tree for the first time

**Returns:** `void`

### GetGameplayIssues

```csharp
/// <summary>
    /// Validates gameplay-specific requirements
    /// </summary>
    /// <returns>Array of gameplay-specific validation issue messages</returns>
    public virtual global::Godot.Collections.Array<string> GetGameplayIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();
        
        // Add gameplay-specific validation logic here
        
        return issues;
    }
```

Validates gameplay-specific requirements

**Returns:** `global::Godot.Collections.Array<string>`

