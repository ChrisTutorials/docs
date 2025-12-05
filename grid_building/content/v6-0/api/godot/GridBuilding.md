---
title: "GridBuilding"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/gridbuilding/"
---

# GridBuilding

```csharp
GridBuilding
class GridBuilding
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/GridBuilding.cs`  
**Namespace:** `GridBuilding`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _EnterTree

```csharp
public override void _EnterTree()
    {
        // Initialization of the plugin
        GD.Print("Grid Building C# plugin loaded");
    }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
    {
        // Clean-up of the plugin
        GD.Print("Grid Building C# plugin unloaded");
    }
```

**Returns:** `void`

