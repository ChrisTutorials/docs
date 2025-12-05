---
title: "TileCheckRule"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/tilecheckrule/"
---

# TileCheckRule

```csharp
GridBuilding.Godot.Systems.Placement.Validators
class TileCheckRule
{
    // Members...
}
```

Base class for rules that check tile properties for placement validation.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/tile_check_rule.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Validators/TileCheckRule.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Validators`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ApplyToObjectsMask

```csharp
#region Exported Properties

    /// <summary>
    /// Physics layers for collision object detection.
    /// </summary>
    [Export]
    public uint ApplyToObjectsMask { get; set; } = 1;
```

Physics layers for collision object detection.

### VisualPriority

```csharp
/// <summary>
    /// Priority for handling multiple rule failures.
    /// Rule with the highest priority and a fail display settings set will be used in the indicator's sprite to display.
    /// </summary>
    [Export(PropertyHint.Range, "0,10,1,or_greater")]
    public int VisualPriority { get; set; } = 0;
```

Priority for handling multiple rule failures.
Rule with the highest priority and a fail display settings set will be used in the indicator's sprite to display.

### FailVisualSettings

```csharp
/// <summary>
    /// Display settings for an indicator to use with an override priority.
    /// </summary>
    [Export]
    public IndicatorVisualSettings? FailVisualSettings { get; set; }
```

Display settings for an indicator to use with an override priority.

### Indicators

```csharp
#endregion

    #region Properties

    /// <summary>
    /// List of all indicators that are currently using the rule for evaluation.
    /// </summary>
    public Array<RuleCheckIndicator> Indicators { get; private set; } = new();
```

List of all indicators that are currently using the rule for evaluation.


## Methods

### GetFailingIndicators

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Runs the rule against an array of indicators.
    /// Returns the indicators that fail the test.
    /// </summary>
    /// <param name="indicators">The indicators to check</param>
    /// <returns>Array of failing indicators</returns>
    public virtual Array<RuleCheckIndicator> GetFailingIndicators(Array<RuleCheckIndicator> indicators)
    {
        var failingIndicators = new Array<RuleCheckIndicator>();

        foreach (var indicator in indicators)
        {
            if (!indicator.Valid)
            {
                failingIndicators.Add(indicator);
            }
        }

        return failingIndicators;
    }
```

Runs the rule against an array of indicators.
Returns the indicators that fail the test.

**Returns:** `Array<RuleCheckIndicator>`

**Parameters:**
- `Array<RuleCheckIndicator> indicators`

### GetTilePositions

```csharp
/// <summary>
    /// Returns the tile locations that the indicators are currently positioned over on the tilemap.
    /// You can call this after the rules have been setup for the object being manipulated.
    /// </summary>
    /// <returns>Array of tile positions</returns>
    public Array<Vector2I> GetTilePositions()
    {
        var positions = new Array<Vector2I>();
        var targetMap = GridTargetingState?.TargetMap;

        if (targetMap == null)
            return positions;

        foreach (var indicator in Indicators)
        {
            positions.Add(indicator.GetTilePosition(targetMap));
        }

        return positions;
    }
```

Returns the tile locations that the indicators are currently positioned over on the tilemap.
You can call this after the rules have been setup for the object being manipulated.

**Returns:** `Array<Vector2I>`

### TearDown

```csharp
/// <summary>
    /// Tears down the rule, cleaning up indicators and state.
    /// </summary>
    public override void TearDown()
    {
        Indicators.Clear();
        base.TearDown();
    }
```

Tears down the rule, cleaning up indicators and state.

**Returns:** `void`

### GetEditorIssues

```csharp
/// <summary>
    /// Returns an array of issues found during editor validation.
    /// </summary>
    /// <returns>Array of editor validation issues</returns>
    public override Array<string> GetEditorIssues()
    {
        var issues = base.GetEditorIssues();

        if (ApplyToObjectsMask == 0)
        {
            issues.Add("TileCheckRule has no collision layers set in apply_to_objects_mask");
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

        // Add any TileCheckRule-specific runtime validation here

        return issues;
    }
```

Returns an array of issues found during runtime validation.

**Returns:** `Array<string>`

