---
title: "PlacementReport"
description: "Report generated for a placement action outcome.
Encapsulates all relevant information about a placement attempt including
the entity performing the action, the object being placed, validation results,
and any issues or notes encountered during the process.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/placement_report.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/placementreport/"
---

# PlacementReport

```csharp
GridBuilding.Godot.Systems.Placement.Validators
class PlacementReport
{
    // Members...
}
```

Report generated for a placement action outcome.
Encapsulates all relevant information about a placement attempt including
the entity performing the action, the object being placed, validation results,
and any issues or notes encountered during the process.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/placement_report.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Validators/PlacementReport.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Validators`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Placer

```csharp
#region Properties

    /// <summary>
    /// GBOwner for the root entity responsible for placing the preview_instance into the game world.
    /// </summary>
    public IOwner? Placer { get; private set; }
```

GBOwner for the root entity responsible for placing the preview_instance into the game world.

### PreviewInstance

```csharp
/// <summary>
    /// The preview instance for the object being manipulated (built, placed, etc.).
    /// </summary>
    public Node? PreviewInstance { get; private set; }
```

The preview instance for the object being manipulated (built, placed, etc.).

### Placed

```csharp
/// <summary>
    /// The placed instance representing the object successfully placed into the game world.
    /// This is different from preview_instance - preview shows where object WILL be placed,
    /// while placed is the actual object instance that WAS placed.
    /// </summary>
    public Node? Placed { get; set; }
```

The placed instance representing the object successfully placed into the game world.
This is different from preview_instance - preview shows where object WILL be placed,
while placed is the actual object instance that WAS placed.

### IndicatorsReport

```csharp
/// <summary>
    /// The report from RuleCheckIndicator generation for the preview object.
    /// </summary>
    public GridBuilding.Godot.Systems.Placement.Data.IndicatorSetupReport? IndicatorsReport { get; private set; }
```

The report from RuleCheckIndicator generation for the preview object.

### ActionType

```csharp
/// <summary>
    /// The type of action that was attempted for this placement.
    /// </summary>
    public ManipulationAction ActionType { get; private set; }
```

The type of action that was attempted for this placement.

### Issues

```csharp
/// <summary>
    /// General setup issues encountered during placement.
    /// </summary>
    public Array<string> Issues { get; } = new();
```

General setup issues encountered during placement.

### Notes

```csharp
/// <summary>
    /// Additional diagnostic notes collected at setup time.
    /// </summary>
    public Array<string> Notes { get; } = new();
```

Additional diagnostic notes collected at setup time.


## Methods

### AddIssue

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Adds an issue to the report's issues list.
    /// Issues represent problems or validation failures that occurred during placement.
    /// </summary>
    /// <param name="issue">The issue message to add</param>
    public void AddIssue(string issue)
    {
        if (!string.IsNullOrEmpty(issue))
        {
            Issues.Add(issue);
        }
    }
```

Adds an issue to the report's issues list.
Issues represent problems or validation failures that occurred during placement.

**Returns:** `void`

**Parameters:**
- `string issue`

### AddNote

```csharp
/// <summary>
    /// Adds a diagnostic note to the report's notes list.
    /// Notes contain additional information about the placement process that may be
    /// useful for debugging or logging, but don't represent errors.
    /// </summary>
    /// <param name="note">The diagnostic note to add</param>
    public void AddNote(string note)
    {
        if (!string.IsNullOrEmpty(note))
        {
            Notes.Add(note);
        }
    }
```

Adds a diagnostic note to the report's notes list.
Notes contain additional information about the placement process that may be
useful for debugging or logging, but don't represent errors.

**Returns:** `void`

**Parameters:**
- `string note`

### GetPlacerRoot

```csharp
/// <summary>
    /// Returns the root node of the entity responsible for placement.
    /// </summary>
    /// <returns>The root Node of the GBOwner entity, or null if no placer is set</returns>
    public Node? GetPlacerRoot()
    {
        return Placer?.OwnerRoot;
    }
```

Returns the root node of the entity responsible for placement.

**Returns:** `Node?`

### IsSuccessful

```csharp
/// <summary>
    /// Checks if the placement was successful (no issues or validation failures).
    /// </summary>
    /// <returns>True if placement succeeded, false if any issues occurred</returns>
    public bool IsSuccessful()
    {
        return GetIssues().Count == 0;
    }
```

Checks if the placement was successful (no issues or validation failures).

**Returns:** `bool`

### GetIssues

```csharp
/// <summary>
    /// Returns all issues associated with this placement attempt,
    /// including any indicator validation failures collected in the
    /// associated IndicatorSetupReport.
    /// </summary>
    /// <returns>An array of issue strings aggregated from both primary report issues and indicator validation failures</returns>
    public Array<string> GetIssues()
    {
        var aggregatedIssues = new Array<string>();
        aggregatedIssues.AddRange(Issues);
        
        if (IndicatorsReport != null)
        {
            var indicatorIssues = IndicatorsReport.Issues;
            aggregatedIssues.AddRange(indicatorIssues);
        }
        
        return aggregatedIssues;
    }
```

Returns all issues associated with this placement attempt,
including any indicator validation failures collected in the
associated IndicatorSetupReport.

**Returns:** `Array<string>`

### ToVerboseString

```csharp
/// <summary>
    /// Converts the report to a verbose string representation for debugging.
    /// </summary>
    /// <returns>A formatted string containing all report information</returns>
    public string ToVerboseString()
    {
        var parts = new System.Collections.Generic.List<string>
        {
            "PlacementReport",
            $"  success: {IsSuccessful()}",
            $"  action: {ActionType}",
            $"  preview: {PreviewInstance?.Name ?? "<null>"}",
            $"  placed: {Placed?.Name ?? "<null>"}"
        };

        if (IndicatorsReport != null)
        {
            parts.Add($"  indicators_report:\n{IndicatorsReport.ToVerboseString()}");
        }

        if (Issues.Count > 0)
        {
            parts.Add($"  issues: {string.Join(", ", Issues)}");
        }

        if (Notes.Count > 0)
        {
            parts.Add($"  notes: {string.Join(", ", Notes)}");
        }

        return string.Join("\n", parts);
    }
```

Converts the report to a verbose string representation for debugging.

**Returns:** `string`

### FromFailedValidation

```csharp
#endregion

    #region Static Factory Methods

    /// <summary>
    /// Creates a PlacementReport for failed validation scenarios.
    /// Static factory method that builds a failed report with validation issues.
    /// </summary>
    /// <param name="validatorIssues">Dictionary of validation issues from validator</param>
    /// <param name="owner">The GBOwner entity responsible for the placement attempt</param>
    /// <param name="previewInstance">The Node being tested for placement validity</param>
    /// <returns>A PlacementReport configured with validation failure state</returns>
    public static PlacementReport FromFailedValidation(
        SystemCollectionsGeneric.Dictionary<PlacementRule, GDCollections.Array> validatorIssues,
        GBOwner owner,
        Node previewInstance
    )
    {
        var report = new PlacementReport(owner, previewInstance, null, ManipulationAction.Build);

        // Add validator issues to the report
        if (validatorIssues.Count > 0)
        {
            AddValidatorIssuesToReport(validatorIssues, report);
        }

        return report;
    }
```

Creates a PlacementReport for failed validation scenarios.
Static factory method that builds a failed report with validation issues.

**Returns:** `PlacementReport`

**Parameters:**
- `SystemCollectionsGeneric.Dictionary<PlacementRule, GDCollections.Array> validatorIssues`
- `GBOwner owner`
- `Node previewInstance`

