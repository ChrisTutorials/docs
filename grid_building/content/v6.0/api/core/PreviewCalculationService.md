---
title: "PreviewCalculationService"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/previewcalculationservice/"
---

# PreviewCalculationService

```csharp
GridBuilding.Core.Services.Placement
class PreviewCalculationService
{
    // Members...
}
```

Core service for calculating placement preview data.
Contains pure business logic without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Placement/PreviewCalculationService.cs`  
**Namespace:** `GridBuilding.Core.Services.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CalculatePreview

```csharp
/// <summary>
    /// Calculates preview data for a building at the given grid position.
    /// </summary>
    public PreviewCalculationResult CalculatePreview(
        FootprintData footprintData,
        Vector2I gridPosition,
        IGridOccupancy existingOccupancy,
        bool validityCheck = true)
    {
        var result = new PreviewCalculationResult
        {
            FootprintData = footprintData
        };
        
        try
        {
            // Validate inputs
            if (footprintData == null)
            {
                result.AddIssue("Footprint data is null");
                return result;
            }
            
            if (existingOccupancy == null)
            {
                result.AddIssue("Grid occupancy data is null");
                return result;
            }
            
            // Calculate footprint positions
            result.FootprintPositions = footprintData.GetOccupiedPositions(gridPosition);
            
            // Calculate bounds
            result.Bounds = CalculateBounds(result.FootprintPositions);
            
            // Check grid bounds
            var gridSize = existingOccupancy.GetGridSize();
            var inBounds = CheckGridBounds(footprintData, gridPosition, gridSize);
            
            if (!inBounds)
            {
                result.IsValidPlacement = false;
                result.AddIssue($"Building extends beyond grid bounds");
            }
            
            // Perform validity check if requested
            if (validityCheck)
            {
                // Check for collisions
                var hasCollision = existingOccupancy.HasOccupancy(result.FootprintPositions);
                
                if (hasCollision)
                {
                    result.IsValidPlacement = false;
                    result.AddIssue("Building would collide with existing objects");
                }
                else if (inBounds)
                {
                    result.IsValidPlacement = true;
                }
            }
            else
            {
                result.IsValidPlacement = true; // Assume valid for preview-only mode
            }
            
            // Calculate shape configuration
            result.ShapeData = CalculateShapeConfiguration(buildingData.Footprint);
            
            // Calculate visual appearance
            var visualSettings = CalculateVisualAppearance(
                result.IsValidPlacement,
                buildingData.DefaultTransparency,
                buildingData.ValidColor,
                buildingData.InvalidColor);
            
            result.Transparency = visualSettings.Transparency;
            result.TintColor = visualSettings.TintColor;
            
            result.AddNote($"Preview calculated for {buildingData.Name} at position {gridPosition}");
            result.AddNote($"Footprint: {result.FootprintPositions.Count} tiles, Valid: {result.IsValidPlacement}");
        }
        catch (System.Exception ex)
        {
            result.AddIssue($"Exception during preview calculation: {ex.Message}");
        }
        
        return result;
    }
```

Calculates preview data for a building at the given grid position.

**Returns:** `PreviewCalculationResult`

**Parameters:**
- `FootprintData footprintData`
- `Vector2I gridPosition`
- `IGridOccupancy existingOccupancy`
- `bool validityCheck`

### UpdatePreviewPosition

```csharp
/// <summary>
    /// Updates preview data when the grid position changes.
    /// </summary>
    public PreviewCalculationResult UpdatePreviewPosition(
        PreviewCalculationResult previousResult,
        Vector2I newGridPosition,
        IGridOccupancy existingOccupancy)
    {
        if (previousResult == null)
        {
            return new PreviewCalculationResult
            {
                IsValidPlacement = false,
                Issues = new List<string> { "Previous result is null" }
            };
        }
        
        // Create a new result with updated position
        var updatedResult = new PreviewCalculationResult
        {
            ShapeData = previousResult.ShapeData,
            Transparency = previousResult.Transparency,
            TintColor = previousResult.TintColor
        };
        
        try
        {
            // Recalculate footprint positions for new position
            // Note: We'd need the original building data to do this properly
            // For now, we'll update the positions by offsetting them
            var oldBounds = previousResult.Bounds;
            var offset = newGridPosition - oldBounds.Position;
            
            updatedResult.FootprintPositions = previousResult.FootprintPositions
                .Select(pos => pos + offset)
                .ToList();
            
            updatedResult.Bounds = new RectangleI(newGridPosition, oldBounds.Size);
            
            // Check validity at new position
            var inBounds = existingOccupancy.IsInBounds(newGridPosition) &&
                          updatedResult.FootprintPositions.All(pos => existingOccupancy.IsInBounds(pos));
            
            if (!inBounds)
            {
                updatedResult.IsValidPlacement = false;
                updatedResult.AddIssue("Building extends beyond grid bounds at new position");
            }
            else
            {
                var hasCollision = existingOccupancy.HasOccupancy(updatedResult.FootprintPositions);
                updatedResult.IsValidPlacement = !hasCollision;
                
                if (hasCollision)
                {
                    updatedResult.AddIssue("Building would collide with existing objects at new position");
                }
            }
            
            // Update visual appearance based on new validity
            var visualSettings = CalculateVisualAppearance(
                updatedResult.IsValidPlacement,
                updatedResult.Transparency,
                previousResult.TintColor, // Use previous as "valid" color
                new Color(1.0f, 0.0f, 0.0f, updatedResult.Transparency * 0.7f)); // Red for invalid
            
            updatedResult.Transparency = visualSettings.Transparency;
            updatedResult.TintColor = visualSettings.TintColor;
            
            updatedResult.AddNote($"Preview updated to position {newGridPosition}");
        }
        catch (System.Exception ex)
        {
            updatedResult.AddIssue($"Exception during preview update: {ex.Message}");
        }
        
        return updatedResult;
    }
```

Updates preview data when the grid position changes.

**Returns:** `PreviewCalculationResult`

**Parameters:**
- `PreviewCalculationResult previousResult`
- `Vector2I newGridPosition`
- `IGridOccupancy existingOccupancy`

### CalculateVisualAppearance

```csharp
/// <summary>
    /// Calculates the visual appearance of the preview based on validity.
    /// </summary>
    public GridBuilding.Core.Interfaces.Placement.PreviewVisualSettings CalculateVisualAppearance(
        bool isValid,
        float baseTransparency,
        Color validColor,
        Color invalidColor)
    {
        return new GridBuilding.Core.Interfaces.Placement.PreviewVisualSettings
        {
            Transparency = isValid ? baseTransparency : baseTransparency * 0.7f,
            TintColor = isValid ? validColor : invalidColor,
            ShowGridSnapping = true,
            ZIndex = 10
        };
    }
```

Calculates the visual appearance of the preview based on validity.

**Returns:** `GridBuilding.Core.Interfaces.Placement.PreviewVisualSettings`

**Parameters:**
- `bool isValid`
- `float baseTransparency`
- `Color validColor`
- `Color invalidColor`

### CalculateShapeConfiguration

```csharp
/// <summary>
    /// Calculates shape configuration for a building footprint.
    /// </summary>
    public GridBuilding.Core.Data.Placement.PreviewShapeData CalculateShapeConfiguration(FootprintData footprint)
    {
        if (footprint == null)
        {
            return new GridBuilding.Core.Data.Placement.PreviewShapeData
            {
                ShapeType = PreviewShapeType.Rectangle,
                Size = new Vector2I(1, 1)
            };
        }
        
        return new GridBuilding.Core.Data.Placement.PreviewShapeData
        {
            ShapeType = footprint.ShapeType switch
            {
                FootprintShapeType.Rectangle => PreviewShapeType.Rectangle,
                FootprintShapeType.Circle => PreviewShapeType.Circle,
                FootprintShapeType.Custom => PreviewShapeType.Custom,
                _ => PreviewShapeType.Rectangle
            },
            Size = footprint.Size,
            PolygonPoints = footprint.PolygonPoints,
            Radius = footprint.Radius
        };
    }
```

Calculates shape configuration for a building footprint.

**Returns:** `GridBuilding.Core.Data.Placement.PreviewShapeData`

**Parameters:**
- `FootprintData footprint`

### CheckGridBounds

```csharp
/// <summary>
    /// Checks if a building fits within grid bounds at the given position.
    /// </summary>
    public bool CheckGridBounds(
        FootprintData footprintData,
        Vector2I gridPosition,
        Vector2I gridSize)
    {
        if (footprintData == null)
            return false;
        
        var footprintPositions = footprintData.GetOccupiedPositions(gridPosition);
        
        return footprintPositions.All(pos => 
            pos.X >= 0 && pos.X < gridSize.X &&
            pos.Y >= 0 && pos.Y < gridSize.Y);
    }
```

Checks if a building fits within grid bounds at the given position.

**Returns:** `bool`

**Parameters:**
- `FootprintData footprintData`
- `Vector2I gridPosition`
- `Vector2I gridSize`

