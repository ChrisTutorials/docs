---
title: "BuildActionData"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/buildactiondata/"
---

# BuildActionData

```csharp
GridBuilding.Core.Data
class BuildActionData
{
    // Members...
}
```

Core POCS implementation of BuildActionData for state management.
Contains data about a build action for signal emission.
Ported from: godot/addons/grid_building/shared/data/build_action_data.gd

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Data/BuildActionData.cs`  
**Namespace:** `GridBuilding.Core.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Placeable

```csharp
#region Properties

    /// <summary>
    /// The placeable resource that was built.
    /// </summary>
    public object? Placeable { get; }
```

The placeable resource that was built.

### Report

```csharp
/// <summary>
    /// The placement report from the build operation.
    /// </summary>
    public PlacementReport? Report { get; }
```

The placement report from the build operation.

### BuildType

```csharp
/// <summary>
    /// The type of build operation performed.
    /// </summary>
    public BuildType BuildType { get; }
```

The type of build operation performed.

### Timestamp

```csharp
/// <summary>
    /// The timestamp when the action occurred.
    /// </summary>
    public long Timestamp { get; }
```

The timestamp when the action occurred.


## Methods

### IsSuccessful

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Checks if the build action was successful.
    /// </summary>
    /// <returns>True if successful, false otherwise</returns>
    public bool IsSuccessful()
    {
        return Report?.IsSuccessful() ?? false;
    }
```

Checks if the build action was successful.

**Returns:** `bool`

### IsFailed

```csharp
/// <summary>
    /// Checks if the build action failed.
    /// </summary>
    /// <returns>True if failed, false otherwise</returns>
    public bool IsFailed()
    {
        return Report?.IsFailed() ?? true;
    }
```

Checks if the build action failed.

**Returns:** `bool`

### GetPlacedObject

```csharp
/// <summary>
    /// Gets the placed object from the report.
    /// </summary>
    /// <returns>The placed object, or null if not available</returns>
    public object? GetPlacedObject()
    {
        return Report?.Placed;
    }
```

Gets the placed object from the report.

**Returns:** `object?`

### GetIssues

```csharp
/// <summary>
    /// Gets the issues from the report.
    /// </summary>
    /// <returns>List of issues, or empty if none</returns>
    public List<string> GetIssues()
    {
        return Report?.GetIssues() ?? new List<string>();
    }
```

Gets the issues from the report.

**Returns:** `List<string>`

### ToString

```csharp
/// <summary>
    /// Gets a string representation of the build action.
    /// </summary>
    /// <returns>String representation</returns>
    public override string ToString()
    {
        var placeableName = GetPlaceableName();
        var status = IsSuccessful() ? "SUCCESS" : "FAILED";
        return $"BuildAction[{placeableName}]: {status} ({BuildType})";
    }
```

Gets a string representation of the build action.

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
        result += $"Placeable: {GetPlaceableName()}\n";
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

