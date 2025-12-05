---
title: "PlaceableSelectionUITestFixture"
description: "Test fixture for PlaceableSelectionUI tests providing mock objects and helper methods."
weight: 20
url: "/gridbuilding/v6-0/api/godot/placeableselectionuitestfixture/"
---

# PlaceableSelectionUITestFixture

```csharp
GridBuilding.Godot.Tests.Systems.UI.Placeable
class PlaceableSelectionUITestFixture
{
    // Members...
}
```

Test fixture for PlaceableSelectionUI tests providing mock objects and helper methods.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Integration/Systems/UI/Placeable/PlaceableSelectionUITest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Systems.UI.Placeable`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### MockBuildingSystem

```csharp
public MockBuildingSystem MockBuildingSystem { get; private set; }
```

### MockModeState

```csharp
public MockModeState MockModeState { get; private set; }
```

### SystemsContext

```csharp
public MockGBSystemsContext SystemsContext { get; private set; }
```

### IndicatorContext

```csharp
public MockIndicatorContext IndicatorContext { get; private set; }
```


## Methods

### CreatePlaceableSelectionUI

```csharp
public PlaceableSelectionUI CreatePlaceableSelectionUI()
    {
        var ui = new PlaceableSelectionUI();
        
        // Set up required UI nodes
        ui.UiRoot = new Control();
        ui.UiRoot.Visible = true;
        
        ui.TabContainer = new TabContainer();
        ui.UiRoot.AddChild(ui.TabContainer);
        
        // Set up templates
        ui.PlaceableEntryTemplate = CreateMockPlaceableViewTemplate();
        ui.SequenceEntryTemplate = CreateMockPlaceableListEntryTemplate();
        
        // Set up category tags
        var categoryTag = new CategoricalTag();
        categoryTag.DisplayName = "Test Category";
        ui.CategoryTags.Add(categoryTag);
        
        // Inject dependencies
        var container = new MockCompositionContainer();
        container.SetSystemsContext(SystemsContext);
        container.SetModeState(MockModeState);
        ui.ResolveGBDependencies(container);
        
        return ui;
    }
```

**Returns:** `PlaceableSelectionUI`

### CreateTestPlaceable

```csharp
public Placeable CreateTestPlaceable(string displayName, string scenePath = "res://test.tscn")
    {
        var placeable = new Placeable();
        placeable.DisplayName = displayName;
        placeable.PackedScene = GD.Load<PackedScene>(scenePath) ?? new PackedScene();
        
        // Add test category tag
        var categoryTag = new CategoricalTag();
        categoryTag.DisplayName = "Test Category";
        placeable.Tags.Add(categoryTag);
        
        return placeable;
    }
```

**Returns:** `Placeable`

**Parameters:**
- `string displayName`
- `string scenePath`

### CreateTestPlaceableSequence

```csharp
public Resource CreateTestPlaceableSequence(string displayName, string[] variantNames)
    {
        // Create a mock sequence resource that implements the expected interface
        var sequence = new MockPlaceableSequence(displayName, variantNames);
        return sequence;
    }
```

**Returns:** `Resource`

**Parameters:**
- `string displayName`
- `string[] variantNames`

### CreateMockPlaceableViewTemplate

```csharp
public PackedScene CreateMockPlaceableViewTemplate()
    {
        var scene = new PackedScene();
        // In a real test, this would be a proper scene with PlaceableView
        // For now, we'll create a mock that works for testing
        return scene;
    }
```

**Returns:** `PackedScene`

### CreateMockPlaceableListEntryTemplate

```csharp
public PackedScene CreateMockPlaceableListEntryTemplate()
    {
        var scene = new PackedScene();
        // In a real test, this would be a proper scene with PlaceableListEntry
        // For now, we'll create a mock that works for testing
        return scene;
    }
```

**Returns:** `PackedScene`

### SimulatePlaceableSelection

```csharp
public void SimulatePlaceableSelection(PlaceableSelectionUI ui, Placeable placeable)
    {
        // Find the placeable entry and simulate selection
        // This would typically be done through UI interaction
        // For testing, we'll call the internal method directly
        ui.Call("_on_placeable_selected", placeable);
    }
```

**Returns:** `void`

**Parameters:**
- `PlaceableSelectionUI ui`
- `Placeable placeable`

### SimulateSequenceSelection

```csharp
public void SimulateSequenceSelection(PlaceableSelectionUI ui, Resource sequence, int variantIndex)
    {
        // Find the sequence entry and simulate selection
        var entry = new MockPlaceableListEntry();
        entry.Sequence = sequence;
        entry.Call("_set_current_variant_index", variantIndex);
        
        ui.Call("_on_sequence_entry_selected", entry);
    }
```

**Returns:** `void`

**Parameters:**
- `PlaceableSelectionUI ui`
- `Resource sequence`
- `int variantIndex`

### GetSequenceListEntry

```csharp
public PlaceableListEntry GetSequenceListEntry(PlaceableSelectionUI ui, Resource sequence)
    {
        // In a real implementation, this would find the actual UI entry
        // For testing, we'll return a mock
        var entry = new PlaceableListEntry();
        entry.Sequence = sequence;
        return entry;
    }
```

**Returns:** `PlaceableListEntry`

**Parameters:**
- `PlaceableSelectionUI ui`
- `Resource sequence`

### Dispose

```csharp
public void Dispose()
    {
        // Clean up test resources
        MockBuildingSystem?.Dispose();
        MockModeState?.Dispose();
    }
```

**Returns:** `void`

