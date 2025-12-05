---
title: "PlaceableEditorPlugin"
description: "Main editor plugin for managing placeable configurations"
weight: 20
url: "/gridbuilding/v6-0/api/godot/placeableeditorplugin/"
---

# PlaceableEditorPlugin

```csharp
GridBuilding.Godot.Editor
class PlaceableEditorPlugin
{
    // Members...
}
```

Main editor plugin for managing placeable configurations

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Editor/PlaceableEditorPlugin.cs`  
**Namespace:** `GridBuilding.Godot.Editor`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _EnterTree

```csharp
public override void _EnterTree()
        {
            // Add the placeable editor dock
            _editorDock = new PlaceableEditorDock();
            AddControlToDock(DockSlot.LeftBr, _editorDock);

            // Add tool menu items
            AddToolMenuItem("GridBuilding/Placeable Editor", ShowPlaceableEditor);
            AddToolMenuItem("GridBuilding/New Placeable Collection", CreateNewCollection);
        }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
        {
            // Remove dock
            if (_editorDock != null)
            {
                RemoveControlFromDocks(_editorDock);
                _editorDock.QueueFree();
            }

            // Remove tool menu items
            RemoveToolMenuItem("GridBuilding/Placeable Editor");
            RemoveToolMenuItem("GridBuilding/New Placeable Collection");
        }
```

**Returns:** `void`

