---
title: "BuildingSettings"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/buildingsettings/"
---

# BuildingSettings

```csharp
GridBuilding.Godot.Tests.Resources.Settings
class BuildingSettings
{
    // Members...
}
```

Configuration settings for the building system's behavior and appearance.
Controls preview display, multi-build functionality, instance management, and other building-related parameters.
Ported from: godot/addons/grid_building/systems/building/building_settings.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Settings/BuildingSettings.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Resources.Settings`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### PreviewKeptScriptTypes

```csharp
/// <summary>
    /// List of Script Global Class Names that will be kept for preview instances when placing objects in build mode.
    /// </summary>
    public List<string> PreviewKeptScriptTypes { get; set; } = new() { "Manipulatable" };
```

List of Script Global Class Names that will be kept for preview instances when placing objects in build mode.

### PreviewInstanceZIndex

```csharp
/// <summary>
    /// The z index value to set preview instances to in order to control their rendering order.
    /// </summary>
    public int PreviewInstanceZIndex { get; set; } = 100;
```

The z index value to set preview instances to in order to control their rendering order.

### PreviewRootScriptPath

```csharp
/// <summary>
    /// Path to the script to be added to the root of any preview instance node temporarily created by
    /// the building system after non-kept scripts are stripped out.
    /// </summary>
    public string? PreviewRootScriptPath { get; set; }
```

Path to the script to be added to the root of any preview instance node temporarily created by
the building system after non-kept scripts are stripped out.


## Methods

### GetEditorIssues

```csharp
/// <summary>
    /// Returns an array of issues found during editor validation
    /// </summary>
    public List<string> GetEditorIssues()
    {
        return new List<string>();
    }
```

Returns an array of issues found during editor validation

**Returns:** `List<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Returns an array of issues found during runtime validation
    /// </summary>
    public List<string> GetRuntimeIssues()
    {
        return new List<string>();
    }
```

Returns an array of issues found during runtime validation

**Returns:** `List<string>`

