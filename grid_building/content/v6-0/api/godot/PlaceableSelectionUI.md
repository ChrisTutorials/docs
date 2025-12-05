---
title: "PlaceableSelectionUI"
description: "Unified UI component for selecting placeable objects and placeable sequences to build.
Provides a tabbed, grid-based interface for selecting placeables and placeable sequences to place in the world.
Supports folder-based asset loading with AssetResolver for automatic discovery of content and category tags.
Integrates with BuildingSystem to initiate placement mode when items are selected.
Key Features:
- Mixed content grids supporting both individual placeables and sequences
- Configurable sizing for consistent template height and icon dimensions
- Variant cycling for sequences through enhanced PlaceableListEntry components
- Automatic asset loading from configured folders
- Category-based organization with tabs
Usage:
var selectionUI = PlaceableSelectionUI.New();
selectionUI.PlaceablesFolder = "res://my_placeables";
selectionUI.CategoryTagsFolder = "res://my_categories";
selectionUI.FixedTemplateHeight = 48;
selectionUI.FixedIconSize = 40;"
weight: 20
url: "/gridbuilding/v6-0/api/godot/placeableselectionui/"
---

# PlaceableSelectionUI

```csharp
GridBuilding.Godot.Systems.UI.Placeable
class PlaceableSelectionUI
{
    // Members...
}
```

Unified UI component for selecting placeable objects and placeable sequences to build.
Provides a tabbed, grid-based interface for selecting placeables and placeable sequences to place in the world.
Supports folder-based asset loading with AssetResolver for automatic discovery of content and category tags.
Integrates with BuildingSystem to initiate placement mode when items are selected.
Key Features:
- Mixed content grids supporting both individual placeables and sequences
- Configurable sizing for consistent template height and icon dimensions
- Variant cycling for sequences through enhanced PlaceableListEntry components
- Automatic asset loading from configured folders
- Category-based organization with tabs
Usage:
var selectionUI = PlaceableSelectionUI.New();
selectionUI.PlaceablesFolder = "res://my_placeables";
selectionUI.CategoryTagsFolder = "res://my_categories";
selectionUI.FixedTemplateHeight = 48;
selectionUI.FixedIconSize = 40;

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/UI/Placeable/PlaceableSelectionUI.cs`  
**Namespace:** `GridBuilding.Godot.Systems.UI.Placeable`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CategoryTagsFolder

```csharp
#endregion

        #region Exported Properties - Asset Loading
        /// <summary>
        /// Path to folder containing category tag resources.
        /// Tags found here are automatically loaded and added to CategoryTags.
        /// </summary>
        [ExportGroup("Asset Loading")]
        [Export]
        public string CategoryTagsFolder { get; set; } = "";
```

Path to folder containing category tag resources.
Tags found here are automatically loaded and added to CategoryTags.

### PlaceablesFolder

```csharp
/// <summary>
        /// Path to folder containing placeable resources.
        /// Placeables found here are automatically loaded and added to Placeables.
        /// </summary>
        [Export]
        public string PlaceablesFolder { get; set; } = "";
```

Path to folder containing placeable resources.
Placeables found here are automatically loaded and added to Placeables.

### SequencesFolder

```csharp
/// <summary>
        /// Path to folder containing placeable sequence resources.
        /// Sequences found here are automatically loaded and added to Sequences.
        /// </summary>
        [Export]
        public string SequencesFolder { get; set; } = "";
```

Path to folder containing placeable sequence resources.
Sequences found here are automatically loaded and added to Sequences.

### CategoryTags

```csharp
/// <summary>
        /// Category tags to include alongside folder-loaded ones.
        /// These tags are combined with tags loaded from CategoryTagsFolder.
        /// </summary>
        public Array<CategoricalTag> CategoryTags { get; set; } = new Array<CategoricalTag>();
```

Category tags to include alongside folder-loaded ones.
These tags are combined with tags loaded from CategoryTagsFolder.

### Placeables

```csharp
/// <summary>
        /// Individual placeables to include alongside folder-loaded ones.
        /// These are displayed in grids alongside sequences. Combined with placeables from PlaceablesFolder.
        /// </summary>
        public Array<Placeable> Placeables { get; set; } = new Array<Placeable>();
```

Individual placeables to include alongside folder-loaded ones.
These are displayed in grids alongside sequences. Combined with placeables from PlaceablesFolder.

### Sequences

```csharp
/// <summary>
        /// Placeable sequences to include alongside folder-loaded ones.
        /// These are displayed as tabs alongside sequences. Combined with sequences from SequencesFolder.
        /// </summary>
        public Array<PlaceableSequence> Sequences { get; set; } = new Array<PlaceableSequence>();
```

Placeable sequences to include alongside folder-loaded ones.
These are displayed as tabs alongside sequences. Combined with sequences from SequencesFolder.

### GridColumns

```csharp
#endregion

        #region Exported Properties - Display Settings
        /// <summary>
        /// Number of columns for the grid layout.
        /// Default: 1 (single column list layout).
        /// </summary>
        [ExportGroup("Display Settings")]
        [Export(PropertyHint.Range, "1,10,1")]
        public int GridColumns { get; set; } = 1;
```

Number of columns for the grid layout.
Default: 1 (single column list layout).

### PlaceableEntryTemplate

```csharp
/// <summary>
        /// Template scene for individual placeable entries.
        /// Should be a PlaceableView that displays icon and name.
        /// </summary>
        [Export]
        public PackedScene PlaceableEntryTemplate { get; set; }
```

Template scene for individual placeable entries.
Should be a PlaceableView that displays icon and name.

### SequenceEntryTemplate

```csharp
/// <summary>
        /// Template scene for sequence entries with variant cycling.
        /// Should be a PlaceableListEntry that supports cycling through sequence variants.
        /// </summary>
        [Export]
        public PackedScene SequenceEntryTemplate { get; set; }
```

Template scene for sequence entries with variant cycling.
Should be a PlaceableListEntry that supports cycling through sequence variants.

### FixedTemplateHeight

```csharp
#endregion

        #region Exported Properties - Sizing Settings
        /// <summary>
        /// Fixed height for all templates to prevent resizing when cycling through sequence variants.
        /// When set to a positive value, enforces consistent height for all template entries.
        /// When set to 0, disables PlaceableSelectionUI-level height enforcement and allows templates to size naturally.
        /// Note: Individual PlaceableView instances may still enforce their own height via their FixedViewHeight property.
        /// Default: 48 pixels for consistent template sizing.
        /// </summary>
        [ExportGroup("Sizing Settings")]
        [Export]
        public int FixedTemplateHeight { get; set; } = 48;
```

Fixed height for all templates to prevent resizing when cycling through sequence variants.
When set to a positive value, enforces consistent height for all template entries.
When set to 0, disables PlaceableSelectionUI-level height enforcement and allows templates to size naturally.
Note: Individual PlaceableView instances may still enforce their own height via their FixedViewHeight property.
Default: 48 pixels for consistent template sizing.

### FixedIconSize

```csharp
/// <summary>
        /// Fixed icon size for all placeable view icons to ensure consistent icon dimensions.
        /// When set to a positive value, enforces both width and height for all icon TextureRects in PlaceableView instances.
        /// When set to 0, icon sizing is not enforced and will use template defaults.
        /// Default: 40 pixels for standard icon sizing.
        /// </summary>
        [Export]
        public int FixedIconSize { get; set; } = 40;
```

Fixed icon size for all placeable view icons to ensure consistent icon dimensions.
When set to a positive value, enforces both width and height for all icon TextureRects in PlaceableView instances.
When set to 0, icon sizing is not enforced and will use template defaults.
Default: 40 pixels for standard icon sizing.

### ShowCategoryTabNames

```csharp
/// <summary>
        /// Whether category tab titles should be visible for manual category selection.
        /// When false, tabs are hidden and only grid content is shown.
        /// </summary>
        [Export]
        public bool ShowCategoryTabNames { get; set; } = true;
```

Whether category tab titles should be visible for manual category selection.
When false, tabs are hidden and only grid content is shown.

### HideUIOnSelection

```csharp
/// <summary>
        /// Whether to hide the selection UI when an item is selected.
        /// When true, the UI automatically hides after the user selects a placeable or sequence.
        /// </summary>
        [Export]
        public bool HideUIOnSelection { get; set; } = false;
```

Whether to hide the selection UI when an item is selected.
When true, the UI automatically hides after the user selects a placeable or sequence.

### UiRoot

```csharp
#endregion

        #region Exported Properties - Internal Nodes
        /// <summary>
        /// Root control node for showing and hiding the entire UI.
        /// </summary>
        [ExportGroup("Internal Nodes")]
        [Export]
        public Control UiRoot { get; set; }
```

Root control node for showing and hiding the entire UI.

### TabContainer

```csharp
/// <summary>
        /// Tab container that handles category-based organization.
        /// Each tab represents a category tag and contains a grid of matching placeables/sequences.
        /// </summary>
        [Export]
        public TabContainer TabContainer { get; set; }
```

Tab container that handles category-based organization.
Each tab represents a category tag and contains a grid of matching placeables/sequences.

### ModeState

```csharp
#endregion

        #region Mode State Property
        /// <summary>
        /// System mode state for tracking build mode changes.
        /// Automatically connects to mode changes to show/hide the UI appropriately.
        /// </summary>
        public ModeState ModeState
        {
            get => _modeState;
            set
            {
                if (IsInstanceValid(_modeState))
                {
                    _modeState.ModeChanged -= _OnModeChanged;
                }

                _modeState = value;

                if (IsInstanceValid(_modeState))
                {
                    _modeState.ModeChanged += _OnModeChanged;
                }
            }
        }
```

System mode state for tracking build mode changes.
Automatically connects to mode changes to show/hide the UI appropriately.


## Methods

### _Ready

```csharp
#endregion

        #region Godot Lifecycle
        public override void _Ready()
        {
            _ValidateBasicComponents();
            _LoadAssets();
            _ValidateRequiredTemplates(); // Validate templates after we know what content we have

            Hidden += _OnHidden;
            Clear();
            _SetupTabs();
        }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
        {
            base._Process(delta);
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### ResolveGBDependencies

```csharp
#endregion

        #region Dependency Resolution
        /// <summary>
        /// Called by GBChildInjector to resolve dependencies on the UI.
        /// </summary>
        /// <param name="container">Container with system dependencies and configuration</param>
        public void ResolveGBDependencies(GBCompositionContainer container)
        {
            _systemsContext = container.GetSystemsContext();
            ModeState = container.GetModeState();
        }
```

Called by GBChildInjector to resolve dependencies on the UI.

**Returns:** `void`

**Parameters:**
- `GBCompositionContainer container`

### Rebuild

```csharp
/// <summary>
        /// Rebuild the UI after changing content type or assets at runtime.
        /// </summary>
        public void Rebuild()
        {
            _LoadAssets();
            _ValidateRequiredTemplates(); // Re-validate templates after reloading assets
            Clear();
            _SetupTabs();
        }
```

Rebuild the UI after changing content type or assets at runtime.

**Returns:** `void`

### Clear

```csharp
/// <summary>
        /// Clear existing tabs.
        /// </summary>
        public void Clear()
        {
            foreach (Node tab in TabContainer.GetChildren())
            {
                tab.QueueFree();
            }
        }
```

Clear existing tabs.

**Returns:** `void`

### AddPlaceables

```csharp
#endregion

        #region Placeable Management
        /// <summary>
        /// Adds placeable options to the UI and updates the corresponding visuals.
        /// </summary>
        /// <param name="newPlaceables">Array of new placeable resources to add to the UI</param>
        public void AddPlaceables(Array<Placeable> newPlaceables)
        {
            foreach (Placeable newP in newPlaceables)
            {
                if (!Placeables.Contains(newP))
                {
                    // Add it since it's not already in the UI
                    Placeables.Add(newP);

                    // Add it to each matching category
                    for (int i = 0; i < CategoryTags.Count; i++)
                    {
                        if (newP.Tags.Contains(CategoryTags[i]))
                        {
                            ItemList catItemList = TabContainer.GetChild(i) as ItemList;
                            catItemList?.AddItem(newP.DisplayName, newP.Icon);
                        }
                    }
                }
            }
        }
```

Adds placeable options to the UI and updates the corresponding visuals.

**Returns:** `void`

**Parameters:**
- `Array<Placeable> newPlaceables`

### RemovePlaceables

```csharp
/// <summary>
        /// Removes placeable options from the UI and updates the corresponding visuals.
        /// </summary>
        /// <param name="remPlaceables">Array of placeable resources to remove from the UI</param>
        public void RemovePlaceables(Array<Placeable> remPlaceables)
        {
            foreach (Placeable remP in remPlaceables)
            {
                if (Placeables.Contains(remP))
                {
                    // Remove matching from the placeables array
                    Placeables.Remove(remP);

                    // Remove it from each matching category
                    for (int i = 0; i < CategoryTags.Count; i++)
                    {
                        if (remP.Tags.Contains(CategoryTags[i]))
                        {
                            ItemList catItemList = TabContainer.GetChild(i) as ItemList;

                            for (int listI = 0; listI < catItemList.ItemCount; listI++)
                            {
                                if (
                                    catItemList.GetItemText(listI) == remP.DisplayName
                                    && catItemList.GetItemIcon(listI) == remP.Icon
                                )
                                {
                                    // Match so remove
                                    catItemList.RemoveItem(listI);
                                }
                            }
                        }
                    }
                }
            }
        }
```

Removes placeable options from the UI and updates the corresponding visuals.

**Returns:** `void`

**Parameters:**
- `Array<Placeable> remPlaceables`

### GetRuntimeIssues

```csharp
#endregion

        #region Validation
        /// <summary>
        /// Run setup checks on the UI to ensure proper setup.
        /// Returns validation issues found during setup checks.
        /// </summary>
        /// <returns>List of validation issues (empty if valid)</returns>
        public Array<string> GetRuntimeIssues()
        {
            var issues = new Array<string>();

            issues.AddRange(GBValidation.CheckNotNull(this, new string[] { "_systemsContext" }));
            issues.AddRange(GBValidation.CheckNotNull(this, new string[] { "TabContainer", "UiRoot" }));

            // Smart template validation - only check templates we actually need
            bool hasPlaceables = Placeables.Count > 0;
            bool hasSequences = Sequences.Count > 0;

            if (hasPlaceables && PlaceableEntryTemplate == null)
            {
                issues.Add(
                    "placeable_entry_template is required when placeables are present but not assigned"
                );
            }

            if (hasSequences && SequenceEntryTemplate == null)
            {
                issues.Add(
                    "sequence_entry_template is required when sequences are present but not assigned"
                );
            }

            // Make sure each placeable has a tag in the category tags
            foreach (Placeable placeable in Placeables)
            {
                bool atLeastOneCategory = false;

                foreach (CategoricalTag category in placeable.Tags)
                {
                    if (CategoryTags.Contains(category))
                    {
                        atLeastOneCategory = true;
                        break;
                    }
                }

                if (!atLeastOneCategory)
                {
                    issues.Add(
                        $"Placeable {placeable.DisplayName} has no matching categories with the Placeable Selection UI and will not be selectable."
                    );
                }
            }

            return issues;
        }
```

Run setup checks on the UI to ensure proper setup.
Returns validation issues found during setup checks.

**Returns:** `Array<string>`

