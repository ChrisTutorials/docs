---
title: "WithinTilemapBoundsRule"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/withintilemapboundsrule/"
---

# WithinTilemapBoundsRule

```csharp
GridBuilding.Godot.Systems.Placement.Validators
class WithinTilemapBoundsRule
{
    // Members...
}
```

A rule that validates placement is within the boundaries of a tilemap.
This rule works by checking if a tile exists at a proposed placement position on the target TileMapLayer. It ensures that a player or system cannot place objects in empty, unmapped areas of the scene.
Behavior:
- The rule passes if every indicator is positioned over a cell that has an assigned TileData object on the target map.
- The rule fails if any indicator is over a cell that returns null for TileData, indicating that the cell is outside of the mapped region.
Usage:
- Attach this rule to a GBCompositionContainer for context wide injection OR a Placeable for placeable specific rule evaluation
- The GridTargetingState must provide a valid TileMapLayer for the rule to check against.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/template_rules/within_tilemap_bounds_rule.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Validators/WithinTilemapBoundsRule.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Validators`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### SuccessMessage

```csharp
#endregion

    #region Exported Properties

    /// <summary>
    /// Success message for valid placement.
    /// </summary>
    [Export]
    public string SuccessMessage { get; set; } = "Placement is within map bounds";
```

Success message for valid placement.

### FailedMessage

```csharp
/// <summary>
    /// Failure message for out-of-bounds placement.
    /// </summary>
    [Export]
    public string FailedMessage { get; set; } = "Tried placing outside of valid map area";
```

Failure message for out-of-bounds placement.

### NoIndicatorsMessage

```csharp
/// <summary>
    /// Message when no indicators are available.
    /// </summary>
    [Export]
    public string NoIndicatorsMessage { get; set; } = "No tile collision indicators to check for within tilemap bounds.";
```

Message when no indicators are available.

### EnableDebugDiagnostics

```csharp
/// <summary>
    /// Optional: enable extra per-indicator diagnostics during tile lookups (very verbose).
    /// </summary>
    [Export]
    public bool EnableDebugDiagnostics { get; set; } = false;
```

Optional: enable extra per-indicator diagnostics during tile lookups (very verbose).


## Methods

### Setup

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Setup the rule with the provided GridTargetingState.
    /// </summary>
    /// <param name="gts">The targeting state to use for placement</param>
    /// <returns>Array of issues found during setup</returns>
    public override Array<string> Setup(GridTargetingState gts)
    {
        // Correctly delegate to base PlacementRule.setup so _grid_targeting_state and _ready are initialized
        var baseIssues = base.Setup(gts.GetSystemsContext());
        return new Array<string>(baseIssues);
    }
```

Setup the rule with the provided GridTargetingState.

**Returns:** `Array<string>`

**Parameters:**
- `GridTargetingState gts`

### TearDown

```csharp
/// <summary>
    /// Tears down the rule, cleaning up indicators and state.
    /// </summary>
    public override void TearDown()
    {
        // Clear local state then delegate to base tear_down implementation
        base.TearDown();
    }
```

Tears down the rule, cleaning up indicators and state.

**Returns:** `void`

### ValidatePlacement

```csharp
/// <summary>
    /// For each tilemap indicator, check the tilemap to see if the tile at its position is used on any layer or not.
    /// </summary>
    /// <returns>RuleResult indicating validation outcome</returns>
    public override RuleResult ValidatePlacement()
    {
        if (Indicators.Count == 0)
        {
            return RuleResult.Build(this, new Array<string> { NoIndicatorsMessage });
        }

        var failingIndicators = GetFailingIndicators(Indicators);

        if (failingIndicators.Count > 0)
        {
            return RuleResult.Build(this, new Array<string> { FailedMessage });
        }

        return RuleResult.Build(this, new Array<string>());
    }
```

For each tilemap indicator, check the tilemap to see if the tile at its position is used on any layer or not.

**Returns:** `RuleResult`

### GetFailingIndicators

```csharp
/// <summary>
    /// Evaluates indicators against the rule and returns failing ones.
    /// Returns the failing indicators that are outside valid tilemap bounds.
    /// 
    /// CRITICAL: Overrides TileCheckRule.get_failing_indicators to avoid circular dependency
    /// where the base implementation checks indicator.valid, but indicator.valid depends on rule results
    /// </summary>
    /// <param name="indicators">Array of indicators to check against tilemap bounds</param>
    /// <returns>Array of failing indicators</returns>
    public override Array<RuleCheckIndicator> GetFailingIndicators(Array<RuleCheckIndicator> indicators)
    {
        var failingIndicators = new Array<RuleCheckIndicator>();
        var targetMap = GridTargetingState?.TargetMap;

        if (targetMap == null)
        {
            return indicators; // All fail because there is no target tile map
        }

        foreach (var indicator in indicators)
        {
            if (indicator == null) // Safety against null indicators
                continue;

            var results = IsOverValidTile(indicator, targetMap);
            if (!results.IsSuccessful())
            {
                failingIndicators.Add(indicator);
            }
        }

        return failingIndicators;
    }
```

Evaluates indicators against the rule and returns failing ones.
Returns the failing indicators that are outside valid tilemap bounds.
/// CRITICAL: Overrides TileCheckRule.get_failing_indicators to avoid circular dependency
where the base implementation checks indicator.valid, but indicator.valid depends on rule results

**Returns:** `Array<RuleCheckIndicator>`

**Parameters:**
- `Array<RuleCheckIndicator> indicators`

