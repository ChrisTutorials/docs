---
title: "PlaceableView"
description: "UI view for a single placeable used in selection lists.
Renders a placeable's icon and display name in a horizontal layout with configurable sizing and padding.
Emits PlaceableSelected when the user clicks on the view.
Usage:
var view = PlaceableView.New();
view.Placeable = myPlaceable;
view.FixedViewHeight = 48;
view.FixedIconSize = 40;
view.PlaceableSelected += _OnPlaceableSelected;"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/placeableview/"
---

# PlaceableView

```csharp
GridBuilding.Godot.Systems.UI.Placeable
class PlaceableView
{
    // Members...
}
```

UI view for a single placeable used in selection lists.
Renders a placeable's icon and display name in a horizontal layout with configurable sizing and padding.
Emits PlaceableSelected when the user clicks on the view.
Usage:
var view = PlaceableView.New();
view.Placeable = myPlaceable;
view.FixedViewHeight = 48;
view.FixedIconSize = 40;
view.PlaceableSelected += _OnPlaceableSelected;

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/UI/Placeable/PlaceableView.cs`  
**Namespace:** `GridBuilding.Godot.Systems.UI.Placeable`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### FixedViewHeight

```csharp
#endregion

        #region Exported Properties
        /// <summary>
        /// Fixed height for placeable views to maintain consistent sizing.
        /// When set to a positive value, enforces a fixed height regardless of content.
        /// When set to 0, height enforcement is disabled and the view will size naturally.
        /// Default: 48 pixels to match template standard sizing.
        /// </summary>
        [ExportGroup("Sizing Settings")]
        [Export]
        public int FixedViewHeight { get; set; } = 48;
```

Fixed height for placeable views to maintain consistent sizing.
When set to a positive value, enforces a fixed height regardless of content.
When set to 0, height enforcement is disabled and the view will size naturally.
Default: 48 pixels to match template standard sizing.

### FixedIconSize

```csharp
/// <summary>
        /// Fixed icon size for consistent icon dimensions across all placeable views.
        /// When set to a positive value, enforces both width and height of icon TextureRect.
        /// When set to 0, icon sizing is not enforced and will use scene file settings.
        /// Default: 40 pixels to match standard icon sizing.
        /// </summary>
        [Export]
        public int FixedIconSize { get; set; } = 40;
```

Fixed icon size for consistent icon dimensions across all placeable views.
When set to a positive value, enforces both width and height of icon TextureRect.
When set to 0, icon sizing is not enforced and will use scene file settings.
Default: 40 pixels to match standard icon sizing.

### Placeable

```csharp
/// <summary>
        /// The placeable object displayed by this view.
        /// When set, updates the icon and label to reflect the placeable's display name and icon texture.
        /// </summary>
        public Placeable Placeable
        {
            get => _placeable;
            set
            {
                _placeable = value;
                _UpdateView();
            }
        }
```

The placeable object displayed by this view.
When set, updates the icon and label to reflect the placeable's display name and icon texture.


## Methods

### _Ready

```csharp
#endregion

        #region Godot Lifecycle
        /// <summary>
        /// Called when the node enters the scene tree.
        /// Initializes the view by wiring child nodes, setting up interaction, and enforcing sizing.
        /// </summary>
        public override void _Ready()
        {
            _WireNodes();
            _InitInteraction();
            _UpdateView();
            _EnforceViewHeight();
            _EnforceIconSize();
        }
```

Called when the node enters the scene tree.
Initializes the view by wiring child nodes, setting up interaction, and enforcing sizing.

**Returns:** `void`

### _EnterTree

```csharp
public override void _EnterTree()
        {
            base._EnterTree();
            _UpdateView();
        }
```

**Returns:** `void`

### _ExitTree

```csharp
#endregion

        #region Cleanup
        /// <summary>
        /// Cleanup when the node is being removed from the tree.
        /// </summary>
        public override void _ExitTree()
        {
            _uiInteraction?.Cleanup();
            base._ExitTree();
        }
```

Cleanup when the node is being removed from the tree.

**Returns:** `void`

