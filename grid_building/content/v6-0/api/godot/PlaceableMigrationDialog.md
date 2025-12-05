---
title: "PlaceableMigrationDialog"
description: "Dialog for configuring and executing placeable migration"
weight: 20
url: "/gridbuilding/v6-0/api/godot/placeablemigrationdialog/"
---

# PlaceableMigrationDialog

```csharp
GridBuilding.Godot.Editor
class PlaceableMigrationDialog
{
    // Members...
}
```

Dialog for configuring and executing placeable migration

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Editor/PlaceableMigrationPlugin.cs`  
**Namespace:** `GridBuilding.Godot.Editor`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            Title = "Migrate Placeables to YAML";
            MinSize = new Vector2I(600, 400);

            SetupUI();
        }
```

**Returns:** `void`

