---
title: "PlaceableSelectionUI"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/placeableselectionui/"
---

# PlaceableSelectionUI

```csharp
GridBuilding.Godot.Systems.UI
class PlaceableSelectionUI
{
    // Members...
}
```

Unified UI component for selecting placeable objects and placeable sequences to build.
Provides a tabbed, grid-based interface for selecting placeables and placeable sequences to place in the world.
Supports folder-based asset loading with automatic discovery of content and category tags.
Integrates with BuildingSystem to initiate placement mode when items are selected.
Key Features:
- Mixed content grids supporting both individual placeables and sequences
- Configurable sizing for consistent template height and icon dimensions
- Variant cycling for sequences through enhanced PlaceableListEntry components
- Automatic asset loading from configured folders
- Category-based organization with tabs
Ported from: godot/addons/grid_building/systems/ui/placeable/single/placeable_selection_ui.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/PlaceableSelectionUI.cs`  
**Namespace:** `GridBuilding.Godot.Systems.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CategoryTagsFolder

```csharp
#endregion

    #region Exported Properties

    [ExportGroup("Asset Loading")]
    
    /// <summary>
    /// Path to folder containing category tag resources.
    /// Tags found here are automatically loaded and added to category tags.
    /// </summary>
    [Export]
    public string CategoryTagsFolder { get; set; } = "";
```

### PlaceablesFolder

```csharp
/// <summary>
    /// Path to folder containing placeable resources.
    /// Placeables found here are automatically loaded and added to placeables.
    /// </summary>
    [Export]
    public string PlaceablesFolder { get; set; } = "";
```

Path to folder containing placeable resources.
Placeables found here are automatically loaded and added to placeables.

### FixedTemplateHeight

```csharp
[ExportGroup("UI Configuration")]
    
    /// <summary>
    /// Fixed height for placeable templates in the grid.
    /// </summary>
    [Export]
    public int FixedTemplateHeight { get; set; } = 48;
```

### FixedIconSize

```csharp
/// <summary>
    /// Fixed size for placeable icons.
    /// </summary>
    [Export]
    public int FixedIconSize { get; set; } = 40;
```

Fixed size for placeable icons.

### CategoryTags

```csharp
[ExportGroup("Content")]
    
    /// <summary>
    /// List of category tags for organizing placeables.
    /// </summary>
    [Export]
    public global::Godot.Collections.Array<string> CategoryTags { get; set; } = new();
```

### Placeables

```csharp
/// <summary>
    /// List of placeable resources available for selection.
    /// </summary>
    [Export]
    public global::Godot.Collections.Array<Resource> Placeables { get; set; } = new();
```

List of placeable resources available for selection.

### ModeState

```csharp
#endregion

    #region Public Properties

    /// <summary>
    /// System mode state for tracking build mode changes.
    /// Automatically connects to mode changes to show/hide the UI appropriately.
    /// </summary>
    public ModeState ModeState
    {
        get => _modeState;
        set
        {
            if (_modeState != null)
            {
                _modeState.ModeChanged -= OnModeChanged;
            }

            _modeState = value;

            if (_modeState != null)
            {
                _modeState.ModeChanged += OnModeChanged;
            }
        }
    }
```

System mode state for tracking build mode changes.
Automatically connects to mode changes to show/hide the UI appropriately.

### BuildingSystem

```csharp
/// <summary>
    /// Building system for initiating placement mode.
    /// </summary>
    public BuildingSystem BuildingSystem
    {
        get => _buildingSystem;
        set => _buildingSystem = value;
    }
```

Building system for initiating placement mode.

### ActionBar

```csharp
/// <summary>
    /// Action bar for integration with other UI components.
    /// </summary>
    public ActionBar ActionBar
    {
        get => _actionBar;
        set => _actionBar = value;
    }
```

Action bar for integration with other UI components.

### IsValid

```csharp
/// <summary>
    /// Gets whether the UI is properly configured and ready for use.
    /// </summary>
    public bool IsValid => _isValid;
```

Gets whether the UI is properly configured and ready for use.


## Methods

### _Ready

```csharp
#endregion

    #region Godot Lifecycle

    public override void _Ready()
    {
        base._Ready();
        
        CreateUI();
        LoadAssets();
        ValidateConfiguration();
    }
```

**Returns:** `void`

### _EnterTree

```csharp
public override void _EnterTree()
    {
        base._EnterTree();
        
        // Auto-resolve dependencies if available
        ResolveDependencies();
    }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
    {
        base._ExitTree();
        
        // Clean up mode state connections
        if (_modeState != null)
        {
            _modeState.ModeChanged -= OnModeChanged;
        }
    }
```

**Returns:** `void`

### Refresh

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Refreshes the UI content by reloading assets and rebuilding grids.
    /// </summary>
    public void Refresh()
    {
        LoadAssets();
        RebuildGrids();
        ValidateConfiguration();
    }
```

Refreshes the UI content by reloading assets and rebuilding grids.

**Returns:** `void`

### ShowIfInBuildMode

```csharp
/// <summary>
    /// Shows the UI if in build mode.
    /// </summary>
    public void ShowIfInBuildMode()
    {
        if (_modeState?.CurrentMode == ManipulationMode.Build)
        {
            Show();
        }
    }
```

Shows the UI if in build mode.

**Returns:** `void`

### HideUI

```csharp
/// <summary>
    /// Hides the UI.
    /// </summary>
    public void HideUI()
    {
        Hide();
    }
```

Hides the UI.

**Returns:** `void`

### SelectCategory

```csharp
/// <summary>
    /// Selects a specific category tab.
    /// </summary>
    /// <param name="categoryName">Name of the category to select</param>
    public void SelectCategory(string categoryName)
    {
        if (_categoryGrids.TryGetValue(categoryName, out var grid))
        {
            var tabIndex = grid.GetParent().GetIndex();
            _tabContainer.CurrentTab = tabIndex;
        }
    }
```

Selects a specific category tab.

**Returns:** `void`

**Parameters:**
- `string categoryName`

