---
title: "ValidPlacementTileRuleSettings"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/validplacementtilerulesettings/"
---

# ValidPlacementTileRuleSettings

```csharp
GridBuilding.Godot.Systems.Placement.Resources
class ValidPlacementTileRuleSettings
{
    // Members...
}
```

Settings resource for ValidPlacementTileRule message configuration.
Provides customizable messages for tile placement validation scenarios.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/resources/valid_placement_tile_rule_settings.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Resources/ValidPlacementTileRuleSettings.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Resources`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### SuccessReason

```csharp
#region Summary Reasons

    /// <summary>
    /// Player-friendly reason shown when tile validation succeeds.
    /// </summary>
    [Export]
    public string SuccessReason { get; set; } = "Valid placement";
```

Player-friendly reason shown when tile validation succeeds.

### FailureReason

```csharp
/// <summary>
    /// Player-friendly reason shown when tile validation fails.
    /// </summary>
    [Export]
    public string FailureReason { get; set; } = "Invalid location";
```

Player-friendly reason shown when tile validation fails.

### NoIndicatorsReason

```csharp
/// <summary>
    /// Player-friendly reason shown when no indicators are available.
    /// </summary>
    [Export]
    public string NoIndicatorsReason { get; set; } = "No build area";
```

Player-friendly reason shown when no indicators are available.

### SuccessMessage

```csharp
#endregion

    #region Issues

    /// <summary>
    /// Success message for valid tiles.
    /// </summary>
    [Export]
    public string SuccessMessage { get; set; } = "All expected nearby tiles exist";
```

Success message for valid tiles.

### FailedMessage

```csharp
/// <summary>
    /// Message to be passed along when the rule requirements were not met.
    /// </summary>
    [Export]
    public string FailedMessage { get; set; } = "Tiles in expected tile areas are missing";
```

Message to be passed along when the rule requirements were not met.

### NoIndicatorsMessage

```csharp
/// <summary>
    /// Message to output when there are no tile collision indicators to check against the rule.
    /// </summary>
    [Export]
    public string NoIndicatorsMessage { get; set; } = "No tile collision indicators to check for valid tile placement";
```

Message to output when there are no tile collision indicators to check against the rule.


## Methods

### GetEditorIssues

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Returns an array of issues found during editor validation.
    /// </summary>
    /// <returns>Array of editor validation issues</returns>
    public List<string> GetEditorIssues()
    {
        var issues = new List<string>();

        // Add validation for required fields if needed
        if (string.IsNullOrEmpty(SuccessMessage))
            issues.Add("SuccessMessage is required");
        if (string.IsNullOrEmpty(FailedMessage))
            issues.Add("FailedMessage is required");
        if (string.IsNullOrEmpty(NoIndicatorsMessage))
            issues.Add("NoIndicatorsMessage is required");

        return issues;
    }
```

Returns an array of issues found during editor validation.

**Returns:** `List<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Returns an array of issues found during runtime validation.
    /// </summary>
    /// <returns>Array of runtime validation issues</returns>
    public List<string> GetRuntimeIssues()
    {
        var issues = GetEditorIssues();
        return issues;
    }
```

Returns an array of issues found during runtime validation.

**Returns:** `List<string>`

