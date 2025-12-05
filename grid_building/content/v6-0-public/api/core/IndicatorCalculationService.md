---
title: "IndicatorCalculationService"
description: "Core service for calculating placement indicators.
Contains pure business logic without Godot dependencies."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/indicatorcalculationservice/"
---

# IndicatorCalculationService

```csharp
GridBuilding.Core.Services.Placement
class IndicatorCalculationService
{
    // Members...
}
```

Core service for calculating placement indicators.
Contains pure business logic without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Placement/IndicatorCalculationService.cs`  
**Namespace:** `GridBuilding.Core.Services.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CalculateIndicators

```csharp
/// <summary>
    /// Calculates indicator positions and validity for a given footprint.
    /// </summary>
    public IndicatorCalculationResult CalculateIndicators(
        FootprintData footprint,
        Vector2I gridPosition,
        IEnumerable<PlacementRuleData> rules,
        IGridOccupancy existingOccupancy)
    {
        var result = new IndicatorCalculationResult();
        
        try
        {
            // Validate inputs
            if (footprint == null)
            {
                result.AddIssue("Footprint data is null");
                return result;
            }
            
            if (rules == null)
            {
                result.AddIssue("Rules collection is null");
                return result;
            }
            
            if (existingOccupancy == null)
            {
                result.AddIssue("Grid occupancy data is null");
                return result;
            }
            
            // Get footprint positions
            var footprintPositions = GetFootprintPositions(footprint, gridPosition);
            result.IndicatorPositions = footprintPositions;
            
            result.AddNote($"Calculated {footprintPositions.Count} footprint positions for {footprint.ShapeType} footprint");
            
            // Check grid bounds
            var gridSize = existingOccupancy.GetGridSize();
            var outOfBoundsPositions = footprintPositions.Where(pos => !existingOccupancy.IsInBounds(pos)).ToList();
            
            if (outOfBoundsPositions.Count > 0)
            {
                result.AddIssue($"Footprint extends beyond grid bounds at positions: {string.Join(", ", outOfBoundsPositions)}");
                
                // Mark out-of-bounds positions as invalid
                foreach (var pos in outOfBoundsPositions)
                {
                    result.PositionValidityMap[pos] = false;
                    result.PositionRulesMap[pos] = new List<string> { "OutOfBounds" };
                }
            }
            
            // Apply placement rules
            var validPositions = new List<Vector2I>();
            var rulesList = rules.ToList();
            
            foreach (var position in footprintPositions)
            {
                if (!existingOccupancy.IsInBounds(position))
                    continue;
                
                var positionRules = new List<string>();
                var isValid = true;
                
                // Check each rule
                foreach (var rule in rulesList.Where(r => r.IsEnabled))
                {
                    if (!EvaluateRule(rule, position, existingOccupancy))
                    {
                        isValid = false;
                        positionRules.Add(rule.Id);
                    }
                }
                
                // Check occupancy
                if (existingOccupancy.IsOccupied(position))
                {
                    isValid = false;
                    positionRules.Add("Occupied");
                }
                
                result.PositionValidityMap[position] = isValid;
                result.PositionRulesMap[position] = positionRules;
                
                if (isValid)
                {
                    validPositions.Add(position);
                }
            }
            
            // Determine overall validity
            result.IsOverallValid = validPositions.Count == footprintPositions.Count && outOfBoundsPositions.Count == 0;
            
            result.AddNote($"Overall placement validity: {result.IsOverallValid} ({validPositions.Count}/{footprintPositions.Count} positions valid)");
            
            if (!result.IsOverallValid)
            {
                var invalidCount = footprintPositions.Count - validPositions.Count;
                result.AddNote($"{invalidCount} positions failed validation");
            }
        }
        catch (System.Exception ex)
        {
            result.AddIssue($"Exception during indicator calculation: {ex.Message}");
        }
        
        return result;
    }
```

Calculates indicator positions and validity for a given footprint.

**Returns:** `IndicatorCalculationResult`

**Parameters:**
- `FootprintData footprint`
- `Vector2I gridPosition`
- `IEnumerable<PlacementRuleData> rules`
- `IGridOccupancy existingOccupancy`

### CalculateIndicatorCount

```csharp
/// <summary>
    /// Calculates the number of indicators that would be created without creating them.
    /// </summary>
    public int CalculateIndicatorCount(
        FootprintData footprint,
        Vector2I gridPosition,
        IEnumerable<PlacementRuleData> rules,
        IGridOccupancy existingOccupancy)
    {
        try
        {
            if (footprint == null || existingOccupancy == null)
                return 0;
            
            var positions = GetFootprintPositions(footprint, gridPosition);
            
            // Only count positions within grid bounds
            var validPositions = positions.Where(pos => existingOccupancy.IsInBounds(pos)).Count();
            
            return validPositions;
        }
        catch
        {
            return 0;
        }
    }
```

Calculates the number of indicators that would be created without creating them.

**Returns:** `int`

**Parameters:**
- `FootprintData footprint`
- `Vector2I gridPosition`
- `IEnumerable<PlacementRuleData> rules`
- `IGridOccupancy existingOccupancy`

### ValidatePlacement

```csharp
/// <summary>
    /// Validates that a footprint can be placed at the given position.
    /// </summary>
    public bool ValidatePlacement(
        FootprintData footprint,
        Vector2I gridPosition,
        IEnumerable<PlacementRuleData> rules,
        IGridOccupancy existingOccupancy)
    {
        var result = CalculateIndicators(footprint, gridPosition, rules, existingOccupancy);
        return result.IsOverallValid && !result.HasIssues();
    }
```

Validates that a footprint can be placed at the given position.

**Returns:** `bool`

**Parameters:**
- `FootprintData footprint`
- `Vector2I gridPosition`
- `IEnumerable<PlacementRuleData> rules`
- `IGridOccupancy existingOccupancy`

### GetFootprintPositions

```csharp
/// <summary>
    /// Gets the footprint positions for a given footprint at a grid position.
    /// </summary>
    public List<Vector2I> GetFootprintPositions(FootprintData footprint, Vector2I gridPosition)
    {
        if (footprint == null)
            return new List<Vector2I>();
        
        return footprint.GetOccupiedPositions(gridPosition);
    }
```

Gets the footprint positions for a given footprint at a grid position.

**Returns:** `List<Vector2I>`

**Parameters:**
- `FootprintData footprint`
- `Vector2I gridPosition`

