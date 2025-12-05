---
title: "ValidPlacementTileRule"
description: "A rule that validates a tile position based on a tilemap's custom data fields.
This rule checks if a tile at a potential placement position has all the required custom data fields and matching values defined in its ExpectedTileCustomData dictionary. It's used to ensure that a tile can only be placed on a specific type of ground, such as "walkable" or "buildable" tiles.
Usage:
- Assign this rule to a GBCompositionContainer for context wide injection or to a Placeable for placeable specific rule evaluation
- Set the ExpectedTileCustomData dictionary to define the required key-value pairs (e.g., { "type": "ground", "variant": "grass" })
- The rule will fail if the tile at the indicator's position does not contain all the required custom data or if any values do not match
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/template_rules/valid_placement_tile_rule.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/validplacementtilerule/"
---

# ValidPlacementTileRule

```csharp
GridBuilding.Godot.Systems.Placement.Validators
class ValidPlacementTileRule
{
    // Members...
}
```

A rule that validates a tile position based on a tilemap's custom data fields.
This rule checks if a tile at a potential placement position has all the required custom data fields and matching values defined in its ExpectedTileCustomData dictionary. It's used to ensure that a tile can only be placed on a specific type of ground, such as "walkable" or "buildable" tiles.
Usage:
- Assign this rule to a GBCompositionContainer for context wide injection or to a Placeable for placeable specific rule evaluation
- Set the ExpectedTileCustomData dictionary to define the required key-value pairs (e.g., { "type": "ground", "variant": "grass" })
- The rule will fail if the tile at the indicator's position does not contain all the required custom data or if any values do not match
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/template_rules/valid_placement_tile_rule.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Validators/ValidPlacementTileRule.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Validators`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ExpectedTileCustomData

```csharp
#region Exported Properties

    /// <summary>
    /// Expected custom data fields and values for valid tiles.
    /// </summary>
    public GDCollections.Dictionary<string, Variant> ExpectedTileCustomData { get; set; } = new();
```

Expected custom data fields and values for valid tiles.

### Settings

```csharp
/// <summary>
    /// Settings for the valid placement tile rule. Defines custom messages for this rule's validation.
    /// </summary>
    [Export]
    public ValidPlacementTileRuleSettings? Settings { get; set; }
```

Settings for the valid placement tile rule. Defines custom messages for this rule's validation.


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
        // Delegate to base PlacementRule.setup for initializing _grid_targeting_state and readiness state
        var baseIssues = base.Setup(gts.GetSystemsContext());
        return new Array<string>(baseIssues);
    }
```

Setup the rule with the provided GridTargetingState.

**Returns:** `Array<string>`

**Parameters:**
- `GridTargetingState gts`

### ValidatePlacement

```csharp
/// <summary>
    /// Check each tile indicator of this test to ensure that they collide with the tilemap.
    /// </summary>
    /// <returns>RuleResult indicating validation outcome</returns>
    public override RuleResult ValidatePlacement()
    {
        var ruleSettings = EnsureSettings();

        if (Indicators.Count == 0)
        {
            return RuleResult.Build(this, new Array<string> { ruleSettings.NoIndicatorsMessage });
        }

        var invalidTileCount = GetFailingIndicators(Indicators).Count;

        if (invalidTileCount == 0)
        {
            return RuleResult.Build(this, new Array<string>());
        }
        else
        {
            return RuleResult.Build(this, new Array<string> { ruleSettings.FailedMessage });
        }
    }
```

Check each tile indicator of this test to ensure that they collide with the tilemap.

**Returns:** `RuleResult`

### TearDown

```csharp
/// <summary>
    /// Tears down the rule, cleaning up indicators and state.
    /// </summary>
    public override void TearDown()
    {
        base.TearDown();
    }
```

Tears down the rule, cleaning up indicators and state.

**Returns:** `void`

### DoesTileHaveValidData

```csharp
/// <summary>
    /// Validates if tile data contains all expected custom data across provided maps.
    /// Returns true only if all expected custom data keys match at least one layer in the tile data.
    /// </summary>
    /// <param name="indicator">The indicator object marking the tile position to check</param>
    /// <param name="maps">Array of TileMapLayer or TileMap nodes to check against</param>
    /// <returns>True if tile has valid data, false otherwise</returns>
    public bool DoesTileHaveValidData(
        RuleCheckIndicator indicator,
        Array<TileMapLayer> maps)
    {
        // Validate input parameter
        if (indicator == null)
            return false; // Early return if indicator is null

        // Check if indicator itself is valid
        if (!indicator.ValidateRuntime())
            return false; // Early return if indicator validation fails

        // There must be a match on the singular tile in the rule check indicator
        const int requiredMatches = 1;
        var matchCount = 0;

        // Check each map for matching tile data
        foreach (var map in maps)
        {
            var tilePos = GetTilePosition(map, indicator);
            if (TileHasMatchingData(map, tilePos))
            {
                matchCount++;
            }
        }

        // Return true only if all expected data was found
        return matchCount == requiredMatches;
    }
```

Validates if tile data contains all expected custom data across provided maps.
Returns true only if all expected custom data keys match at least one layer in the tile data.

**Returns:** `bool`

**Parameters:**
- `RuleCheckIndicator indicator`
- `Array<TileMapLayer> maps`

### GetEditorIssues

```csharp
/// <summary>
    /// Returns an array of issues found during editor validation.
    /// </summary>
    /// <returns>Array of editor validation issues</returns>
    public override Array<string> GetEditorIssues()
    {
        var issues = base.GetEditorIssues();

        if (ExpectedTileCustomData.Count == 0)
        {
            issues.Add($"No expected tile custom data entered. This ValidPlacementTileRule {ResourceName} has nothing to evaluate.");
        }

        return issues;
    }
```

Returns an array of issues found during editor validation.

**Returns:** `Array<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Returns an array of issues found during runtime validation.
    /// </summary>
    /// <returns>Array of runtime validation issues</returns>
    public override Array<string> GetRuntimeIssues()
    {
        var issues = base.GetRuntimeIssues();

        if (ExpectedTileCustomData.Count == 0)
        {
            issues.Add($"No expected tile custom data entered. This ValidPlacementTileRule {ResourceName} has nothing to evaluate.");
        }

        return issues;
    }
```

Returns an array of issues found during runtime validation.

**Returns:** `Array<string>`

### GetFailingIndicators

```csharp
/// <summary>
    /// Runs the rule against an array of indicators and returns the failing indicators.
    /// </summary>
    /// <param name="indicators">The indicators to check</param>
    /// <returns>Array of failing indicators</returns>
    public override Array<RuleCheckIndicator> GetFailingIndicators(Array<RuleCheckIndicator> indicators)
    {
        var failingIndicators = new Array<RuleCheckIndicator>();

        foreach (var indicator in indicators)
        {
            if (!DoesTileHaveValidData(indicator, GridTargetingState?.Maps ?? new Array<TileMapLayer>()))
            {
                // No collision means rule fails
                failingIndicators.Add(indicator);
            }
        }

        return failingIndicators;
    }
```

Runs the rule against an array of indicators and returns the failing indicators.

**Returns:** `Array<RuleCheckIndicator>`

**Parameters:**
- `Array<RuleCheckIndicator> indicators`

