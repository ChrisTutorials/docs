---
title: "PlacementRule"
description: "Base class for placement validation conditions.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/placement_rule.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/placementrule/"
---

# PlacementRule

```csharp
GridBuilding.Godot.Systems.Placement.Validators.PlacementRules
class PlacementRule
{
    // Members...
}
```

Base class for placement validation conditions.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/placement_rule.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Validators/PlacementRules/PlacementRule.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Validators.PlacementRules`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
#region IPlacementRule Implementation

    /// <summary>
    /// Unique identifier for the rule.
    /// </summary>
    public virtual string Id => GetRuleId();
```

Unique identifier for the rule.

### Name

```csharp
/// <summary>
    /// Human-readable name for the rule.
    /// </summary>
    public virtual string Name => GetRuleName();
```

Human-readable name for the rule.


## Methods

### ValidatePlacement

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Checks a set of shape casts for building validity and
    /// returns whether the condition has been met or not.
    /// </summary>
    /// <returns>RuleResult indicating validation outcome</returns>
    public virtual RuleResult ValidatePlacement()
    {
        return RuleResult.Build(this, new[] { REASON_VIRTUAL });
    }
```

Checks a set of shape casts for building validity and
returns whether the condition has been met or not.

**Returns:** `RuleResult`

### Setup

```csharp
/// <summary>
    /// The base function sets the grid targeting state for context which sources the target object being placed and the placer.
    /// Returns any issues found in the setup as an Array.
    /// </summary>
    /// <param name="systemsContext">Systems context holding contextual state information</param>
    /// <returns>Array of setup issues</returns>
    public virtual string[] Setup(GBSystemsContext systemsContext)
    {
        if (_ready)
        {
            TearDown();
        }

        _systemsContext = systemsContext;
        var issues = GetRuntimeIssues().ToArray();
        _ready = issues.Length == 0;
        return issues;
    }
```

The base function sets the grid targeting state for context which sources the target object being placed and the placer.
Returns any issues found in the setup as an Array.

**Returns:** `string[]`

**Parameters:**
- `GBSystemsContext systemsContext`

### Apply

```csharp
/// <summary>
    /// Optional code to be executed if this and all other tested rules validate successfully.
    /// </summary>
    /// <returns>Array of issues during apply (empty if successful)</returns>
    public virtual string[] Apply()
    {
        return Array.Empty<string>();
    }
```

Optional code to be executed if this and all other tested rules validate successfully.

**Returns:** `string[]`

### TearDown

```csharp
/// <summary>
    /// Any cleanup code to run after the system changes preview instances or stops building.
    /// Runs before the building system changes placeable preview.
    /// </summary>
    public virtual void TearDown()
    {
        _ready = false;
        _systemsContext = null;
    }
```

Any cleanup code to run after the system changes preview instances or stops building.
Runs before the building system changes placeable preview.

**Returns:** `void`

### GetEditorIssues

```csharp
/// <summary>
    /// Returns an array of issues found during editor validation.
    /// </summary>
    /// <returns>Array of editor validation issues</returns>
    public virtual List<string> GetEditorIssues()
    {
        return new List<string>();
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
    public virtual List<string> GetRuntimeIssues()
    {
        var issues = new List<string>();

        issues.AddRange(GetEditorIssues());

        if (_systemsContext == null)
        {
            issues.Add("[systems_context] is null");
        }

        if (!_ready)
        {
            issues.Add("PlacementRule is not ready - Setup() must be called before use");
        }

        return issues;
    }
```

Returns an array of issues found during runtime validation.

**Returns:** `List<string>`

### ToString

```csharp
#endregion

    #region Godot Overrides

    public override string ToString()
    {
        return $"PlacementRule: {ResourcePath}";
    }
```

**Returns:** `string`

