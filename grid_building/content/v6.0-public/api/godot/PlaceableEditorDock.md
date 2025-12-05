---
title: "PlaceableEditorDock"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/placeableeditordock/"
---

# PlaceableEditorDock

```csharp
GridBuilding.Godot.Editor
class PlaceableEditorDock
{
    // Members...
}
```

Editor dock for managing placeable configurations

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
            Name = "Placeable Editor";
            CustomMinimumSize = new Vector2(300, 400);

            SetupUI();
            RefreshCollections();
        }
```

**Returns:** `void`

### LoadCollection

```csharp
public void LoadCollection(string filePath)
        {
            try
            {
                var loader = PlaceableLoaderFactory.GetLoader(filePath);
                _currentCollection = loader.LoadFromFile(filePath);
                _currentFilePath = filePath;

                if (_currentCollection != null)
                {
                    PopulatePlaceableTree();
                    ShowCollectionInfo();
                    GD.Print($"Loaded collection: {filePath}");
                }
                else
                {
                    GD.PrintErr($"Failed to load collection: {filePath}");
                }
            }
            catch (Exception ex)
            {
                GD.PrintErr($"Error loading collection: {ex.Message}");
            }
        }
```

**Returns:** `void`

**Parameters:**
- `string filePath`

