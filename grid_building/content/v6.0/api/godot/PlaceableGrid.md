---
title: "PlaceableGrid"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/placeablegrid/"
---

# PlaceableGrid

```csharp
GridBuilding.Godot.Systems.UI.Placeable.Single
class PlaceableGrid
{
    // Members...
}
```

Grid container for displaying placeable items in a grid layout.
Ported from: godot/addons/grid_building/systems/ui/placeable/single/placeable_grid.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/PlaceableGrid.cs`  
**Namespace:** `GridBuilding.Godot.Systems.UI.Placeable.Single`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### PlaceableViewTemplate

```csharp
#endregion

    #region Exported Properties

    /// <summary>
    /// Template for creating placeable view instances.
    /// </summary>
    [Export]
    public PackedScene PlaceableViewTemplate { get; set; }
```

Template for creating placeable view instances.


## Methods

### Setup

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Creates views for each placeable in the provided array.
    /// </summary>
    /// <param name="placeables">Array of placeable nodes to display</param>
    public void Setup(Node[] placeables)
    {
        Clear();

        foreach (var placeable in placeables)
        {
            if (PlaceableViewTemplate == null)
            {
                GD.PushWarning("PlaceableGrid: placeable_view_template not set");
                continue;
            }

            var view = PlaceableViewTemplate.Instantiate<PlaceableView>();
            if (view == null)
            {
                GD.PushWarning("PlaceableGrid: Failed to instantiate PlaceableView from template");
                continue;
            }

            view.Placeable = placeable;
            view.PlaceableSelected += OnViewPlaceableSelected;
            AddChild(view);
            _views.Add(view);
        }
    }
```

Creates views for each placeable in the provided array.

**Returns:** `void`

**Parameters:**
- `Node[] placeables`

### Clear

```csharp
/// <summary>
    /// Clears all placeable views from the grid.
    /// </summary>
    public void Clear()
    {
        foreach (var view in _views)
        {
            if (view != null)
            {
                view.QueueFree();
            }
        }

        _views.Clear();
    }
```

Clears all placeable views from the grid.

**Returns:** `void`

### GetViews

```csharp
/// <summary>
    /// Gets all placeable views currently in the grid.
    /// </summary>
    /// <returns>Read-only list of placeable views</returns>
    public IReadOnlyList<PlaceableView> GetViews()
    {
        return _views.AsReadOnly();
    }
```

Gets all placeable views currently in the grid.

**Returns:** `IReadOnlyList<PlaceableView>`

