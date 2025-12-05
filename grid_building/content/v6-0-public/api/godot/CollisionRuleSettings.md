---
title: "CollisionRuleSettings"
description: "Message configuration resource for CollisionsCheckRule.
Provides modular, reusable message settings that can be shared across multiple rules.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/resources/collision_rule_settings.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/collisionrulesettings/"
---

# CollisionRuleSettings

```csharp
GridBuilding.Godot.Systems.Placement.Resources
class CollisionRuleSettings
{
    // Members...
}
```

Message configuration resource for CollisionsCheckRule.
Provides modular, reusable message settings that can be shared across multiple rules.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/resources/collision_rule_settings.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Resources/CollisionRuleSettings.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Resources`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### SuccessMessage

```csharp
#region Issue Messages

    /// <summary>
    /// Message to be passed along when the tile validates as successful.
    /// </summary>
    [Export]
    public string SuccessMessage { get; set; } = "No placement collisions found";
```

Message to be passed along when the tile validates as successful.

### ExpectedNoCollisionsMessage

```csharp
/// <summary>
    /// Message to be passed along when the rule requirements were not met.
    /// </summary>
    [Export]
    public string ExpectedNoCollisionsMessage { get; set; } = "Must have no collisions";
```

Message to be passed along when the rule requirements were not met.

### ExpectedCollisionMessage

```csharp
/// <summary>
    /// When collision is expected (physics overlap), this message will be added to failed results.
    /// </summary>
    [Export]
    public string ExpectedCollisionMessage { get; set; } = "Must have collisions in area";
```

When collision is expected (physics overlap), this message will be added to failed results.

### ExpectedCollisionsMessage

```csharp
/// <summary>
    /// Message for when collisions are expected.
    /// </summary>
    [Export]
    public string ExpectedCollisionsMessage { get; set; } = "Must overlap ";
```

Message for when collisions are expected.

### NoIndicatorsMessage

```csharp
/// <summary>
    /// Message when no indicators are available for collision checking.
    /// </summary>
    [Export]
    public string NoIndicatorsMessage { get; set; } = "No tile collision indicators to check for collisions in placement";
```

Message when no indicators are available for collision checking.

### FailBlockedMessage

```csharp
/// <summary>
    /// Player-friendly failure shown when placement is blocked by overlaps.
    /// %d: number of indicators that detected a blocking overlap.
    /// </summary>
    [Export]
    public string FailBlockedMessage { get; set; } = "Colliding on %d tile(s)";
```

Player-friendly failure shown when placement is blocked by overlaps.
%d: number of indicators that detected a blocking overlap.

### FailMissingOverlapMessage

```csharp
/// <summary>
    /// Player-friendly failure shown when an overlap was required but missing.
    /// %d: number of indicators that did not find a required overlap.
    /// </summary>
    [Export]
    public string FailMissingOverlapMessage { get; set; } = "Missing required overlap on %d tile(s)";
```

Player-friendly failure shown when an overlap was required but missing.
%d: number of indicators that did not find a required overlap.

### SuccessReason

```csharp
#endregion

    #region Reason Messages

    /// <summary>
    /// Player-friendly reason shown when collision validation succeeds.
    /// </summary>
    [Export]
    public string SuccessReason { get; set; } = "Clear to build";
```

Player-friendly reason shown when collision validation succeeds.

### FailureReason

```csharp
/// <summary>
    /// Player-friendly reason shown when collision validation fails.
    /// </summary>
    [Export]
    public string FailureReason { get; set; } = "Cannot build here";
```

Player-friendly reason shown when collision validation fails.

### NoIndicatorsReason

```csharp
/// <summary>
    /// Player-friendly reason shown when no indicators are available.
    /// </summary>
    [Export]
    public string NoIndicatorsReason { get; set; } = "No build area";
```

Player-friendly reason shown when no indicators are available.

### PrependResourceName

```csharp
#endregion

    #region Display Settings

    /// <summary>
    /// Add name of CollisionsCheckRule resource to the start of a fail/success message.
    /// </summary>
    [Export]
    public bool PrependResourceName { get; set; }
```

Add name of CollisionsCheckRule resource to the start of a fail/success message.

### AppendLayerNames

```csharp
/// <summary>
    /// Whether to show a list of layers tested in output messages.
    /// </summary>
    [Export]
    public bool AppendLayerNames { get; set; } = false;
```

Whether to show a list of layers tested in output messages.

### LayersTestedPrefix

```csharp
/// <summary>
    /// Prefix for layer names when displayed.
    /// </summary>
    [Export]
    public string LayersTestedPrefix { get; set; } = " : Layers Checked: ";
```

Prefix for layer names when displayed.


## Methods

### GetEditorIssues

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Returns an array of issues found during editor validation.
    /// </summary>
    /// <returns>Array of editor validation issues</returns>
    public global::Godot.Collections.Array<string> GetEditorIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();

        // Add validation for required fields if needed
        if (string.IsNullOrEmpty(SuccessMessage))
            issues.Add("SuccessMessage is required");
        if (string.IsNullOrEmpty(FailBlockedMessage))
            issues.Add("FailBlockedMessage is required");
        if (string.IsNullOrEmpty(FailMissingOverlapMessage))
            issues.Add("FailMissingOverlapMessage is required");

        return issues;
    }
```

Returns an array of issues found during editor validation.

**Returns:** `global::Godot.Collections.Array<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Returns an array of issues found during runtime validation.
    /// </summary>
    /// <returns>Array of runtime validation issues</returns>
    public global::Godot.Collections.Array<string> GetRuntimeIssues()
    {
        var issues = GetEditorIssues();
        return issues;
    }
```

Returns an array of issues found during runtime validation.

**Returns:** `global::Godot.Collections.Array<string>`

