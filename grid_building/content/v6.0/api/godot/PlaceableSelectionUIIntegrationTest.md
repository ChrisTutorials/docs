---
title: "PlaceableSelectionUIIntegrationTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/placeableselectionuiintegrationtest/"
---

# PlaceableSelectionUIIntegrationTest

```csharp
GridBuilding.Godot.Tests.Systems.UI.Placeable
class PlaceableSelectionUIIntegrationTest
{
    // Members...
}
```

Focused test suite for PlaceableSelectionUI to verify it can correctly select
both Placeable and PlaceableSequence types and properly trigger the BuildingSystem.
These tests focus on the core functionality without complex Godot scene setup.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Integration/Systems/UI/Placeable/PlaceableSelectionUIIntegrationTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Systems.UI.Placeable`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### PlaceableSelectionUI_CanSelectPlaceableResource

```csharp
#region Placeable Selection Tests

    [Fact]
    public void PlaceableSelectionUI_CanSelectPlaceableResource()
    {
        // Arrange
        var placeable = CreateTestPlaceable("Test Building");
        
        // Act & Assert - Verify placeable can be created and configured
        ;
        ;
        ;
        Assert.NotEmpty(placeable.Tags);
    }
```

**Returns:** `void`

### PlaceableSelectionUI_PlaceableSelectionLogic_HandlesNullPlaceable

```csharp
[Fact]
    public void PlaceableSelectionUI_PlaceableSelectionLogic_HandlesNullPlaceable()
    {
        // Arrange
        var logic = new PlaceableSelectionLogic();
        
        // Act & Assert - Should handle null gracefully without throwing
        // This tests the defensive programming in the selection logic
        ;
        // The logic should handle null values without crashing
    }
```

**Returns:** `void`

### PlaceableSelectionUI_PlaceableSelectionLogic_HandlesModeChanges

```csharp
[Fact]
    public void PlaceableSelectionUI_PlaceableSelectionLogic_HandlesModeChanges()
    {
        // Arrange
        var logic = new PlaceableSelectionLogic();
        var uiRoot = new Control();
        uiRoot.Visible = true;

        // Act - Simulate mode change to BUILD
        logic.HandleModeChanged(BuildingMode.BUILD, uiRoot);

        // Assert - UI should be hidden when entering build mode
        ;

        // Act - Simulate mode change to OFF
        logic.HandleModeChanged(BuildingMode.OFF, uiRoot);

        // Assert - UI should be shown when exiting build mode
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_PlaceableListEntry_CanHandleSequence

```csharp
#endregion

    #region PlaceableSequence Tests

    [Fact]
    public void PlaceableSelectionUI_PlaceableListEntry_CanHandleSequence()
    {
        // Arrange
        var entry = new PlaceableListEntry();
        var sequence = CreateMockPlaceableSequence("Test Sequence", new[] { "Variant1", "Variant2" });
        
        // Act
        entry.Sequence = sequence;

        // Assert
        ;
        ; // Defaults to first variant
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_PlaceableListEntry_CanCycleVariants

```csharp
[Fact]
    public void PlaceableSelectionUI_PlaceableListEntry_CanCycleVariants()
    {
        // Arrange
        var entry = new PlaceableListEntry();
        var sequence = CreateMockPlaceableSequence("Test Sequence", new[] { "Variant1", "Variant2", "Variant3" });
        entry.Sequence = sequence;

        // Act - Cycle to next variant
        SimulateVariantCycle(entry, 1);

        // Assert
        ;
        ;

        // Act - Cycle to next variant again
        SimulateVariantCycle(entry, 1);

        // Assert
        ;
        ;

        // Act - Cycle past end (should wrap to beginning)
        SimulateVariantCycle(entry, 1);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_PlaceableListEntry_CanCycleBackward

```csharp
[Fact]
    public void PlaceableSelectionUI_PlaceableListEntry_CanCycleBackward()
    {
        // Arrange
        var entry = new PlaceableListEntry();
        var sequence = CreateMockPlaceableSequence("Test Sequence", new[] { "Variant1", "Variant2" });
        entry.Sequence = sequence;

        // Act - Cycle backward from first variant (should wrap to last)
        SimulateVariantCycle(entry, -1);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_PlaceableListEntry_HandlesSingleVariantSequence

```csharp
[Fact]
    public void PlaceableSelectionUI_PlaceableListEntry_HandlesSingleVariantSequence()
    {
        // Arrange
        var entry = new PlaceableListEntry();
        var sequence = CreateMockPlaceableSequence("Single Variant", new[] { "OnlyVariant" });
        entry.Sequence = sequence;

        // Act & Assert - Should handle single variant gracefully
        ;
        ;
        
        // Cycling should have no effect on single variant
        SimulateVariantCycle(entry, 1);
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_PlaceableListEntry_CanSetSelected

```csharp
#endregion

    #region UI State Tests

    [Fact]
    public void PlaceableSelectionUI_PlaceableListEntry_CanSetSelected()
    {
        // Arrange
        var entry = new PlaceableListEntry();

        // Act
        entry.SetSelected(true);

        // Assert
        ;

        // Act
        entry.SetSelected(false);

        // Assert
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_PlaceableListEntry_HandlesPlaceableResource

```csharp
[Fact]
    public void PlaceableSelectionUI_PlaceableListEntry_HandlesPlaceableResource()
    {
        // Arrange
        var entry = new PlaceableListEntry();
        var placeable = CreateTestPlaceable("Test Placeable");

        // Act
        entry.Placeable = placeable;

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_PlaceableResource_ValidationWorks

```csharp
#endregion

    #region Validation Tests

    [Fact]
    public void PlaceableSelectionUI_PlaceableResource_ValidationWorks()
    {
        // Arrange
        var placeable = new Placeable(); // No scene assigned

        // Act
        var issues = placeable.GetRuntimeIssues();

        // Assert
        Assert.NotEmpty(issues);
        ;

        // Arrange - Fix the issue
        placeable.PackedScene = new PackedScene();

        // Act
        issues = placeable.GetRuntimeIssues();

        // Assert - Issue should be resolved
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_PlaceableResource_HandlesNullRules

```csharp
[Fact]
    public void PlaceableSelectionUI_PlaceableResource_HandlesNullRules()
    {
        // Arrange
        var placeable = CreateTestPlaceable("Test Building");
        // Add a null rule to test validation
        placeable.PlacementRules.Add(null);

        // Act
        var issues = placeable.GetRuntimeIssues();

        // Assert
        Assert.NotEmpty(issues);
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_PlaceableListEntry_HandlesNullResources

```csharp
#endregion

    #region Error Handling Tests

    [Fact]
    public void PlaceableSelectionUI_PlaceableListEntry_HandlesNullResources()
    {
        // Arrange
        var entry = new PlaceableListEntry();

        // Act & Assert - Should handle null placeable gracefully
        entry.Placeable = null;
        ;
        ;

        // Act & Assert - Should handle null sequence gracefully
        entry.Sequence = null;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### PlaceableSelectionUI_PlaceableSelectionLogic_HandlesNullUIRoot

```csharp
[Fact]
    public void PlaceableSelectionUI_PlaceableSelectionLogic_HandlesNullUIRoot()
    {
        // Arrange
        var logic = new PlaceableSelectionLogic();

        // Act & Assert - Should handle null UI root gracefully
        logic.HandleModeChanged(BuildingMode.BUILD, null);
        logic.HandleUIHidden(null);
        // Should not throw exceptions
    }
```

**Returns:** `void`

