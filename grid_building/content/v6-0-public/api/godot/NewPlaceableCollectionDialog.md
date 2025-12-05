---
title: "NewPlaceableCollectionDialog"
description: "Dialog for creating new placeable collections"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/newplaceablecollectiondialog/"
---

# NewPlaceableCollectionDialog

```csharp
GridBuilding.Godot.Editor
class NewPlaceableCollectionDialog
{
    // Members...
}
```

Dialog for creating new placeable collections

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Editor/PlaceableEditorPlugin.cs`  
**Namespace:** `GridBuilding.Godot.Editor`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            Title = "New Placeable Collection";
            MinSize = new Vector2I(500, 300);

            SetupUI();
        }
```

**Returns:** `void`

