---
title: "IndicatorCalculationWrapper"
description: "Godot wrapper for the Core IndicatorCalculationService.
Adapts Godot data structures to Core interfaces and back."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/indicatorcalculationwrapper/"
---

# IndicatorCalculationWrapper

```csharp
GridBuilding.Godot.Systems.Placement.Adapters
class IndicatorCalculationWrapper
{
    // Members...
}
```

Godot wrapper for the Core IndicatorCalculationService.
Adapts Godot data structures to Core interfaces and back.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Adapters/IndicatorCalculationWrapper.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Adapters`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CalculateIndicatorsGodot

```csharp
/// <summary>
    /// Calculates indicators using Core service and converts results to Godot format.
    /// </summary>
    public IndicatorSetupReport CalculateIndicatorsGodot(
        Node2D testObject,
        Array<PlacementRule> rules,
        Vector2I gridPosition)
    {
        // Convert Godot data to Core format
        var coreFootprint = ExtractFootprintFromGodotObject(testObject);
        var coreRules = ConvertRulesToCore(rules);
        var corePosition = gridPosition.ToCore();
        
        // Calculate using Core service
        var coreResult = _coreService.CalculateIndicators(
            coreFootprint,
            corePosition,
            coreRules,
            _occupancyAdapter);
        
        // Convert results back to Godot format
        return ConvertCoreResultToGodot(coreResult, rules);
    }
```

Calculates indicators using Core service and converts results to Godot format.

**Returns:** `IndicatorSetupReport`

**Parameters:**
- `Node2D testObject`
- `Array<PlacementRule> rules`
- `Vector2I gridPosition`

### CalculateIndicatorCountGodot

```csharp
/// <summary>
    /// Calculates indicator count using Core service.
    /// </summary>
    public int CalculateIndicatorCountGodot(
        Node2D testObject,
        Array<TileCheckRule> tileCheckRules)
    {
        var coreFootprint = ExtractFootprintFromGodotObject(testObject);
        var coreRules = ConvertTileCheckRulesToCore(tileCheckRules);
        var corePosition = Vector2I.Zero; // Default position for count calculation
        
        return _coreService.CalculateIndicatorCount(
            coreFootprint,
            corePosition,
            coreRules,
            _occupancyAdapter);
    }
```

Calculates indicator count using Core service.

**Returns:** `int`

**Parameters:**
- `Node2D testObject`
- `Array<TileCheckRule> tileCheckRules`

### ValidatePlacementGodot

```csharp
/// <summary>
    /// Validates placement using Core service.
    /// </summary>
    public bool ValidatePlacementGodot(
        Node2D testObject,
        Vector2I gridPosition,
        Array<PlacementRule> rules)
    {
        var coreFootprint = ExtractFootprintFromGodotObject(testObject);
        var coreRules = ConvertRulesToCore(rules);
        var corePosition = gridPosition.ToCore();
        
        return _coreService.ValidatePlacement(
            coreFootprint,
            corePosition,
            coreRules,
            _occupancyAdapter);
    }
```

Validates placement using Core service.

**Returns:** `bool`

**Parameters:**
- `Node2D testObject`
- `Vector2I gridPosition`
- `Array<PlacementRule> rules`

