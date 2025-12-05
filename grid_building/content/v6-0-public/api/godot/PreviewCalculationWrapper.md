---
title: "PreviewCalculationWrapper"
description: "Godot wrapper for the Core PreviewCalculationService.
Adapts Godot data structures to Core interfaces and back."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/previewcalculationwrapper/"
---

# PreviewCalculationWrapper

```csharp
GridBuilding.Godot.Systems.Placement.Adapters
class PreviewCalculationWrapper
{
    // Members...
}
```

Godot wrapper for the Core PreviewCalculationService.
Adapts Godot data structures to Core interfaces and back.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Adapters/PreviewCalculationWrapper.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Adapters`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CalculatePreviewGodot

```csharp
/// <summary>
    /// Calculates preview data using Core service and converts results to Godot format.
    /// </summary>
    public PreviewDataGodot CalculatePreviewGodot(
        BuildingDataGodot buildingData,
        Vector2I gridPosition,
        bool validityCheck = true)
    {
        // Convert Godot data to Core format
        var coreBuildingData = ConvertBuildingDataToCore(buildingData);
        var corePosition = gridPosition.ToCore();
        
        // Calculate using Core service
        var coreResult = _coreService.CalculatePreview(
            coreBuildingData,
            corePosition,
            _occupancyAdapter,
            validityCheck);
        
        // Convert results back to Godot format
        return ConvertCoreResultToGodot(coreResult);
    }
```

Calculates preview data using Core service and converts results to Godot format.

**Returns:** `PreviewDataGodot`

**Parameters:**
- `BuildingDataGodot buildingData`
- `Vector2I gridPosition`
- `bool validityCheck`

### UpdatePreviewPositionGodot

```csharp
/// <summary>
    /// Updates preview position using Core service.
    /// </summary>
    public PreviewDataGodot UpdatePreviewPositionGodot(
        PreviewDataGodot previousPreview,
        Vector2I newGridPosition)
    {
        // Convert to Core format
        var corePreviousResult = ConvertGodotPreviewToCore(previousPreview);
        var coreNewPosition = newGridPosition.ToCore();
        
        // Update using Core service
        var coreUpdatedResult = _coreService.UpdatePreviewPosition(
            corePreviousResult,
            coreNewPosition,
            _occupancyAdapter);
        
        // Convert back to Godot format
        return ConvertCoreResultToGodot(coreUpdatedResult);
    }
```

Updates preview position using Core service.

**Returns:** `PreviewDataGodot`

**Parameters:**
- `PreviewDataGodot previousPreview`
- `Vector2I newGridPosition`

### CalculateVisualAppearanceGodot

```csharp
/// <summary>
    /// Calculates visual appearance using Core service.
    /// </summary>
    public PreviewVisualSettingsGodot CalculateVisualAppearanceGodot(
        bool isValid,
        float baseTransparency,
        Godot.Color validColor,
        Godot.Color invalidColor)
    {
        var coreValidColor = validColor.ToCore();
        var coreInvalidColor = invalidColor.ToCore();
        
        var coreSettings = _coreService.CalculateVisualAppearance(
            isValid,
            baseTransparency,
            coreValidColor,
            coreInvalidColor);
        
        return new PreviewVisualSettingsGodot
        {
            Transparency = coreSettings.Transparency,
            TintColor = coreSettings.TintColor.ToGodot(),
            ShowGridSnapping = coreSettings.ShowGridSnapping,
            ZIndex = coreSettings.ZIndex
        };
    }
```

Calculates visual appearance using Core service.

**Returns:** `PreviewVisualSettingsGodot`

**Parameters:**
- `bool isValid`
- `float baseTransparency`
- `Godot.Color validColor`
- `Godot.Color invalidColor`

### CheckGridBoundsGodot

```csharp
/// <summary>
    /// Checks grid bounds using Core service.
    /// </summary>
    public bool CheckGridBoundsGodot(
        BuildingDataGodot buildingData,
        Vector2I gridPosition,
        Vector2I gridSize)
    {
        var coreBuildingData = ConvertBuildingDataToCore(buildingData);
        var corePosition = gridPosition.ToCore();
        var coreGridSize = gridSize.ToCore();
        
        return _coreService.CheckGridBounds(coreBuildingData, corePosition, coreGridSize);
    }
```

Checks grid bounds using Core service.

**Returns:** `bool`

**Parameters:**
- `BuildingDataGodot buildingData`
- `Vector2I gridPosition`
- `Vector2I gridSize`

