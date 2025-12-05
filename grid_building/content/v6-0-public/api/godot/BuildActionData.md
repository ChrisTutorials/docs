---
title: "BuildActionData"
description: "Godot-specific implementation of BuildActionData that wraps the Core POCS implementation.
Provides Godot RefCounted compatibility and Godot-specific signal emission.
Contains data about a build action for signal emission.
Ported from: godot/addons/grid_building/shared/data/build_action_data.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/buildactiondata/"
---

# BuildActionData

```csharp
GridBuilding.Godot.Systems.Building.Data
class BuildActionData
{
    // Members...
}
```

Godot-specific implementation of BuildActionData that wraps the Core POCS implementation.
Provides Godot RefCounted compatibility and Godot-specific signal emission.
Contains data about a build action for signal emission.
Ported from: godot/addons/grid_building/shared/data/build_action_data.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Data/BuildActionData.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Building.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Placeable

```csharp
#endregion

    #region Properties

    /// <summary>
    /// The placeable resource that was built.
    /// </summary>
    public Resource? Placeable => _coreData.Placeable as Resource;
```

The placeable resource that was built.

### Report

```csharp
/// <summary>
    /// The placement report from the build operation.
    /// </summary>
    public PlacementReport? Report => _coreData.Report != null ? new PlacementReport(_coreData.Report) : null;
```

The placement report from the build operation.

### BuildType

```csharp
/// <summary>
    /// The type of build operation performed.
    /// </summary>
    public BuildType BuildType => _coreData.BuildType;
```

The type of build operation performed.

### Timestamp

```csharp
/// <summary>
    /// The timestamp when the action occurred.
    /// </summary>
    public long Timestamp => _coreData.Timestamp;
```

The timestamp when the action occurred.


## Methods

### IsSuccessful

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Returns whether the build action was successful.
    /// </summary>
    /// <returns>True if successful, false otherwise</returns>
    public bool IsSuccessful()
    {
        return _coreData.IsSuccessful();
    }
```

Returns whether the build action was successful.

**Returns:** `bool`

### IsFailed

```csharp
/// <summary>
    /// Returns whether the build action failed.
    /// </summary>
    /// <returns>True if failed, false otherwise</returns>
    public bool IsFailed()
    {
        return _coreData.IsFailed();
    }
```

Returns whether the build action failed.

**Returns:** `bool`

### GetPlacedObject

```csharp
/// <summary>
    /// Returns the placed object from the report.
    /// </summary>
    /// <returns>The placed object or null if not available</returns>
    public Node? GetPlacedObject()
    {
        return _coreData.GetPlacedObject() as Node;
    }
```

Returns the placed object from the report.

**Returns:** `Node?`

### GetIssues

```csharp
/// <summary>
    /// Returns all issues from the report.
    /// </summary>
    /// <returns>Array of issue strings</returns>
    public global::Godot.Collections.Array<string> GetIssues()
    {
        var coreIssues = _coreData.GetIssues();
        var godotIssues = new global::Godot.Collections.Array<string>();
        foreach (var issue in coreIssues)
        {
            godotIssues.Add(issue);
        }
        return godotIssues;
    }
```

Returns all issues from the report.

**Returns:** `global::Godot.Collections.Array<string>`

### ToString

```csharp
/// <summary>
    /// Returns a string representation of the build action.
    /// </summary>
    /// <returns>String representation</returns>
    public override string ToString()
    {
        var placeableName = Placeable?.Get("name")?.AsString() ?? "Unknown";
        var status = IsSuccessful() ? "SUCCESS" : "FAILED";
        return $"BuildAction[{placeableName}]: {status} ({BuildType})";
    }
```

Returns a string representation of the build action.

**Returns:** `string`

### ToVerboseString

```csharp
/// <summary>
    /// Gets a verbose string representation of the build action.
    /// </summary>
    /// <returns>Verbose string representation</returns>
    public string ToVerboseString()
    {
        var result = $"BuildActionData:\n";
        result += $"Placeable: {Placeable?.Get("name")?.AsString() ?? "Unknown"}\n";
        result += $"BuildType: {BuildType}\n";
        result += $"Timestamp: {Timestamp}\n";
        result += $"Success: {IsSuccessful()}\n";
        
        if (Report != null)
        {
            result += $"Report: {Report.ToVerboseString()}\n";
        }

        return result;
    }
```

Gets a verbose string representation of the build action.

**Returns:** `string`

