---
title: "IndicatorSetupReport"
description: "Report containing diagnostic information from indicator setup operations.
Ported from: godot/addons/grid_building/systems/placement/managers/indicator_setup_report.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/indicatorsetupreport/"
---

# IndicatorSetupReport

```csharp
GridBuilding.Godot.Systems.Placement.Data
class IndicatorSetupReport
{
    // Members...
}
```

Report containing diagnostic information from indicator setup operations.
Ported from: godot/addons/grid_building/systems/placement/managers/indicator_setup_report.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Data/IndicatorSetupReport.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TileCheckRules

```csharp
#region Properties

    /// <summary>
    /// The tile check rules that were applied.
    /// </summary>
    public global::Godot.Collections.Array<TileCheckRule> TileCheckRules { get; }
```

The tile check rules that were applied.

### TargetingState

```csharp
/// <summary>
    /// The targeting state used for setup.
    /// </summary>
    public GridTargetingState? TargetingState { get; }
```

The targeting state used for setup.

### IndicatorTemplate

```csharp
/// <summary>
    /// The indicator template used.
    /// </summary>
    public PackedScene? IndicatorTemplate { get; }
```

The indicator template used.

### Issues

```csharp
/// <summary>
    /// List of issues found during setup.
    /// </summary>
    public global::Godot.Collections.Array<string> Issues { get; } = new();
```

List of issues found during setup.

### Indicators

```csharp
/// <summary>
    /// The created indicators.
    /// </summary>
    public global::Godot.Collections.Array<RuleCheckIndicator> Indicators { get; } = new();
```

The created indicators.

### DiagnosticMetadata

```csharp
/// <summary>
    /// Diagnostic metadata.
    /// </summary>
    public global::Godot.Collections.Dictionary<string, Variant> DiagnosticMetadata { get; } = new();
```

Diagnostic metadata.


## Methods

### AddIssue

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Adds an issue to the report.
    /// </summary>
    /// <param name="issue">The issue to add</param>
    public void AddIssue(string issue)
    {
        if (!string.IsNullOrEmpty(issue))
        {
            Issues.Add(issue);
        }
    }
```

Adds an issue to the report.

**Returns:** `void`

**Parameters:**
- `string issue`

### AddIssues

```csharp
/// <summary>
    /// Adds multiple issues to the report.
    /// </summary>
    /// <param name="issues">The issues to add</param>
    public void AddIssues(global::Godot.Collections.Array<string> issues)
    {
        foreach (var issue in issues)
        {
            AddIssue(issue);
        }
    }
```

Adds multiple issues to the report.

**Returns:** `void`

**Parameters:**
- `global::Godot.Collections.Array<string> issues`

### IsSuccessful

```csharp
/// <summary>
    /// Checks if the setup was successful.
    /// </summary>
    /// <returns>True if successful, false otherwise</returns>
    public bool IsSuccessful()
    {
        return Issues.Count == 0;
    }
```

Checks if the setup was successful.

**Returns:** `bool`

### IsFailed

```csharp
/// <summary>
    /// Checks if the setup failed.
    /// </summary>
    /// <returns>True if failed, false otherwise</returns>
    public bool IsFailed()
    {
        return Issues.Count > 0;
    }
```

Checks if the setup failed.

**Returns:** `bool`

### ToString

```csharp
/// <summary>
    /// Gets a string representation of the report.
    /// </summary>
    /// <returns>String representation</returns>
    public override string ToString()
    {
        var status = IsSuccessful() ? "SUCCESS" : "FAILED";
        return $"IndicatorSetupReport[{TileCheckRules.Count} rules]: {status} ({Issues.Count} issues)";
    }
```

Gets a string representation of the report.

**Returns:** `string`

### ToVerboseString

```csharp
/// <summary>
    /// Gets a verbose string representation of the report.
    /// </summary>
    /// <returns>Verbose string representation</returns>
    public string ToVerboseString()
    {
        var result = $"IndicatorSetupReport:\n";
        result += $"Rules: {TileCheckRules.Count}\n";
        result += $"Indicators: {Indicators.Count}\n";
        result += $"Success: {IsSuccessful()}\n";
        
        if (Issues.Count > 0)
        {
            result += "Issues:\n";
            foreach (var issue in Issues)
            {
                result += $"  - {issue}\n";
            }
        }

        if (DiagnosticMetadata.Count > 0)
        {
            result += "Diagnostic Metadata:\n";
            foreach (var kvp in DiagnosticMetadata)
            {
                result += $"  {kvp.Key}: {kvp.Value}\n";
            }
        }

        return result;
    }
```

Gets a verbose string representation of the report.

**Returns:** `string`

