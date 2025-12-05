---
title: "PlaceableSelectionUITest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/placeableselectionuitest/"
---

# PlaceableSelectionUITest

```csharp
GridBuilding.Godot.Tests.Systems.UI.Placeable
class PlaceableSelectionUITest
{
    // Members...
}
```

Comprehensive test suite for PlaceableSelectionUI to ensure it can correctly select
both Placeable and PlaceableSequence types and properly trigger the BuildingSystem.
Test Coverage:
- Placeable selection triggers BuildingSystem.EnterBuildMode()
- PlaceableSequence selection with variant cycling
- UI state management and validation
- Error handling and edge cases

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Integration/Systems/UI/Placeable/PlaceableSelectionUITest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Systems.UI.Placeable`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### PlaceableSelectionUI_WhenPlaceableSelected_CallsBuildingSystemEnterBuildMode

```csharp
#endregion

    #region Placeable Selection Tests

    [Fact]
    public void PlaceableSelectionUI_WhenPlaceableSelected_CallsBuildingSystemEnterBuildMode()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        var testPlaceable = _fixture.CreateTestPlaceable("Test Building", "res://test_building.tscn");
        var buildingSystem = _fixture.MockBuildingSystem;
        
        // Add placeable to UI
        ui.Placeables.Add(testPlaceable);
        ui.Rebuild();

        // Act
        // Simulate placeable selection via the UI
        _fixture.SimulatePlaceableSelection(ui, testPlaceable);

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WhenPlaceableSelected_HidesUIIfConfigured

```csharp
[Fact]
    public void PlaceableSelectionUI_WhenPlaceableSelected_HidesUIIfConfigured()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        ui.HideUIOnSelection = true;
        var testPlaceable = _fixture.CreateTestPlaceable("Test Building");
        
        ui.Placeables.Add(testPlaceable);
        ui.Rebuild();

        // Act
        _fixture.SimulatePlaceableSelection(ui, testPlaceable);

        // Assert
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WhenPlaceableSelected_DoesNotHideUIIfNotConfigured

```csharp
[Fact]
    public void PlaceableSelectionUI_WhenPlaceableSelected_DoesNotHideUIIfNotConfigured()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        ui.HideUIOnSelection = false;
        var testPlaceable = _fixture.CreateTestPlaceable("Test Building");
        
        ui.Placeables.Add(testPlaceable);
        ui.Rebuild();

        // Act
        _fixture.SimulatePlaceableSelection(ui, testPlaceable);

        // Assert
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WhenPlaceableSequenceSelected_CallsBuildingSystemWithActiveVariant

```csharp
#endregion

    #region PlaceableSequence Selection Tests

    [Fact]
    public void PlaceableSelectionUI_WhenPlaceableSequenceSelected_CallsBuildingSystemWithActiveVariant()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        var sequence = _fixture.CreateTestPlaceableSequence(
            "Building Sequence",
            new[] { "Variant1", "Variant2", "Variant3" }
        );
        var buildingSystem = _fixture.MockBuildingSystem;
        
        ui.Sequences.Add(sequence);
        ui.Rebuild();

        // Act - Select the sequence (defaults to first variant)
        _fixture.SimulateSequenceSelection(ui, sequence, 0);

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WhenSequenceVariantCycled_UpdatesActivePlaceable

```csharp
[Fact]
    public void PlaceableSelectionUI_WhenSequenceVariantCycled_UpdatesActivePlaceable()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        var sequence = _fixture.CreateTestPlaceableSequence(
            "Building Sequence",
            new[] { "Variant1", "Variant2", "Variant3" }
        );
        
        ui.Sequences.Add(sequence);
        ui.Rebuild();

        // Act - Cycle to second variant
        var listEntry = _fixture.GetSequenceListEntry(ui, sequence);
        listEntry.Call("_cycle_variant", 1); // Cycle to next variant

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WhenSequenceVariantSelected_CallsBuildingSystemWithCorrectVariant

```csharp
[Fact]
    public void PlaceableSelectionUI_WhenSequenceVariantSelected_CallsBuildingSystemWithCorrectVariant()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        var sequence = _fixture.CreateTestPlaceableSequence(
            "Building Sequence",
            new[] { "Variant1", "Variant2", "Variant3" }
        );
        var buildingSystem = _fixture.MockBuildingSystem;
        
        ui.Sequences.Add(sequence);
        ui.Rebuild();

        // Act - Cycle to second variant then select
        var listEntry = _fixture.GetSequenceListEntry(ui, sequence);
        listEntry.Call("_cycle_variant", 1); // Cycle to Variant2
        _fixture.SimulateSequenceSelection(ui, sequence, 1);

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WhenSequenceVariantCycledWrapsAround_Correctly

```csharp
[Fact]
    public void PlaceableSelectionUI_WhenSequenceVariantCycledWrapsAround_Correctly()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        var sequence = _fixture.CreateTestPlaceableSequence(
            "Building Sequence",
            new[] { "Variant1", "Variant2" }
        );
        
        ui.Sequences.Add(sequence);
        ui.Rebuild();

        var listEntry = _fixture.GetSequenceListEntry(ui, sequence);

        // Act - Cycle forward from last variant
        listEntry.Call("_cycle_variant", 1); // Should wrap to first
        listEntry.Call("_cycle_variant", 1); // Should go to second

        // Assert
        ;

        // Act - Cycle backward from first variant
        listEntry.Call("_cycle_variant", -1); // Should wrap to last

        // Assert
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WhenBuildModeActivated_HidesIfConfigured

```csharp
#endregion

    #region UI State Management Tests

    [Fact]
    public void PlaceableSelectionUI_WhenBuildModeActivated_HidesIfConfigured()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        ui.HideUIOnSelection = true;
        var testPlaceable = _fixture.CreateTestPlaceable("Test Building");
        
        ui.Placeables.Add(testPlaceable);
        ui.Rebuild();

        // Act
        _fixture.SimulatePlaceableSelection(ui, testPlaceable);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WhenExitingBuildMode_ShowsUIAgain

```csharp
[Fact]
    public void PlaceableSelectionUI_WhenExitingBuildMode_ShowsUIAgain()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        ui.HideUIOnSelection = true;
        var testPlaceable = _fixture.CreateTestPlaceable("Test Building");
        
        ui.Placeables.Add(testPlaceable);
        ui.Rebuild();

        // Select placeable to hide UI
        _fixture.SimulatePlaceableSelection(ui, testPlaceable);
        ;

        // Act - Exit build mode
        _fixture.MockModeState.Current = BuildingMode.OFF;

        // Assert
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WhenRebuildCalled_RefreshesContent

```csharp
[Fact]
    public void PlaceableSelectionUI_WhenRebuildCalled_RefreshesContent()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        var initialPlaceable = _fixture.CreateTestPlaceable("Initial Building");
        
        ui.Placeables.Add(initialPlaceable);
        ui.Rebuild();

        // Act - Add new placeable and rebuild
        var newPlaceable = _fixture.CreateTestPlaceable("New Building");
        ui.Placeables.Add(newPlaceable);
        ui.Rebuild();

        // Assert
        ;
        var issues = ui.GetRuntimeIssues();
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WithMissingDependencies_ReturnsValidationIssues

```csharp
#endregion

    #region Validation Tests

    [Fact]
    public void PlaceableSelectionUI_WithMissingDependencies_ReturnsValidationIssues()
    {
        // Arrange
        var ui = new PlaceableSelectionUI();
        // Don't set up dependencies

        // Act
        var issues = ui.GetRuntimeIssues();

        // Assert
        Assert.NotEmpty(issues);
        ;
        ;
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WithValidDependencies_ReturnsNoIssues

```csharp
[Fact]
    public void PlaceableSelectionUI_WithValidDependencies_ReturnsNoIssues()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();

        // Act
        var issues = ui.GetRuntimeIssues();

        // Assert
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WithPlaceablesButNoTemplate_ReturnsTemplateIssue

```csharp
[Fact]
    public void PlaceableSelectionUI_WithPlaceablesButNoTemplate_ReturnsTemplateIssue()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        ui.PlaceableEntryTemplate = null; // Remove template
        var testPlaceable = _fixture.CreateTestPlaceable("Test Building");
        
        ui.Placeables.Add(testPlaceable);

        // Act
        var issues = ui.GetRuntimeIssues();

        // Assert
        Assert.NotEmpty(issues);
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WithSequencesButNoTemplate_ReturnsTemplateIssue

```csharp
[Fact]
    public void PlaceableSelectionUI_WithSequencesButNoTemplate_ReturnsTemplateIssue()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        ui.SequenceEntryTemplate = null; // Remove template
        var sequence = _fixture.CreateTestPlaceableSequence("Test Sequence", new[] { "Variant1" });
        
        ui.Sequences.Add(sequence);

        // Act
        var issues = ui.GetRuntimeIssues();

        // Assert
        Assert.NotEmpty(issues);
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WithPlaceableMissingCategory_ReturnsCategoryIssue

```csharp
[Fact]
    public void PlaceableSelectionUI_WithPlaceableMissingCategory_ReturnsCategoryIssue()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        var uncategorizedPlaceable = _fixture.CreateTestPlaceable("Uncategorized Building");
        // Don't add any category tags
        
        ui.Placeables.Add(uncategorizedPlaceable);
        ui.Rebuild();

        // Act
        var issues = ui.GetRuntimeIssues();

        // Assert
        Assert.NotEmpty(issues);
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WhenNullPlaceableSelected_DoesNotCrash

```csharp
#endregion

    #region Error Handling Tests

    [Fact]
    public void PlaceableSelectionUI_WhenNullPlaceableSelected_DoesNotCrash()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        var buildingSystem = _fixture.MockBuildingSystem;

        // Act - Should not throw exception
        ui.Placeables.Add(null);
        ui.Rebuild();

        // Assert
        ;
        var issues = ui.GetRuntimeIssues();
        // Should handle null gracefully
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WhenNullSequenceSelected_DoesNotCrash

```csharp
[Fact]
    public void PlaceableSelectionUI_WhenNullSequenceSelected_DoesNotCrash()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        var buildingSystem = _fixture.MockBuildingSystem;

        // Act
        ui.Sequences.Add(null);
        ui.Rebuild();

        // Assert
        ;
        var issues = ui.GetRuntimeIssues();
        // Should handle null gracefully
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WhenBuildingSystemIsNull_HandlesGracefully

```csharp
[Fact]
    public void PlaceableSelectionUI_WhenBuildingSystemIsNull_HandlesGracefully()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        _fixture.SystemsContext.SetBuildingSystem(null); // Remove building system
        var testPlaceable = _fixture.CreateTestPlaceable("Test Building");
        
        ui.Placeables.Add(testPlaceable);
        ui.Rebuild();

        // Act - Should not throw exception
        _fixture.SimulatePlaceableSelection(ui, testPlaceable);

        // Assert - Should handle missing building system gracefully
        // No exception should be thrown
    }
```

**Returns:** `void`

### PlaceableSelectionUI_WhenModeStateIsNull_HandlesGracefully

```csharp
[Fact]
    public void PlaceableSelectionUI_WhenModeStateIsNull_HandlesGracefully()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        ui.ModeState = null; // Remove mode state
        var testPlaceable = _fixture.CreateTestPlaceable("Test Building");
        
        ui.Placeables.Add(testPlaceable);
        ui.Rebuild();

        // Act - Should not throw exception
        _fixture.SimulatePlaceableSelection(ui, testPlaceable);

        // Assert - Should handle missing mode state gracefully
        // No exception should be thrown
    }
```

**Returns:** `void`

### PlaceableSelectionUI_FullWorkflow_PlaceableSelection

```csharp
#endregion

    #region Integration Tests

    [Fact]
    public void PlaceableSelectionUI_FullWorkflow_PlaceableSelection()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        var testPlaceable = _fixture.CreateTestPlaceable("Test Building");
        var buildingSystem = _fixture.MockBuildingSystem;
        
        ui.Placeables.Add(testPlaceable);
        ui.Rebuild();

        // Act - Full selection workflow
        _fixture.SimulatePlaceableSelection(ui, testPlaceable);

        // Assert - Complete workflow verification
        ;
        ;
        ;
        
        // Verify UI state changes
        if (ui.HideUIOnSelection)
        {
            ;
        }
    }
```

**Returns:** `void`

### PlaceableSelectionUI_FullWorkflow_SequenceSelectionWithCycling

```csharp
[Fact]
    public void PlaceableSelectionUI_FullWorkflow_SequenceSelectionWithCycling()
    {
        // Arrange
        var ui = _fixture.CreatePlaceableSelectionUI();
        var sequence = _fixture.CreateTestPlaceableSequence(
            "Building Sequence",
            new[] { "Variant1", "Variant2", "Variant3" }
        );
        var buildingSystem = _fixture.MockBuildingSystem;
        
        ui.Sequences.Add(sequence);
        ui.Rebuild();

        // Act - Full workflow with variant cycling
        var listEntry = _fixture.GetSequenceListEntry(ui, sequence);
        
        // Cycle to second variant
        listEntry.Call("_cycle_variant", 1);
        ;
        
        // Select the variant
        _fixture.SimulateSequenceSelection(ui, sequence, 1);

        // Assert - Complete workflow verification
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

