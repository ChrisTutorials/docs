---
title: "PlaceableMigrationPlugin"
description: "Editor plugin for migrating legacy placeable resources to YAML configuration"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/placeablemigrationplugin/"
---

# PlaceableMigrationPlugin

```csharp
GridBuilding.Godot.Editor
class PlaceableMigrationPlugin
{
    // Members...
}
```

Editor plugin for migrating legacy placeable resources to YAML configuration

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Editor/PlaceableMigrationPlugin.cs`  
**Namespace:** `GridBuilding.Godot.Editor`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _EnterTree

```csharp
public override void _EnterTree()
        {
            // Add the migration tool to the project menu
            AddToolMenuItem("GridBuilding/Migrate Placeables to YAML", ShowMigrationDialog);
        }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
        {
            // Remove the tool menu item
            RemoveToolMenuItem("GridBuilding/Migrate Placeables to YAML");
        }
```

**Returns:** `void`

