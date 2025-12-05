---
title: "GBVisualSettings"
description: "Visual settings for displaying grid building information and UI elements
to the player.
Ported from: godot/addons/grid_building/core/resources/settings/gb_visual_settings.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gbvisualsettings/"
---

# GBVisualSettings

```csharp
GridBuilding.Godot.Tests.Resources.Visual
class GBVisualSettings
{
    // Members...
}
```

Visual settings for displaying grid building information and UI elements
to the player.
Ported from: godot/addons/grid_building/core/resources/settings/gb_visual_settings.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Visual/GBVisualSettings.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Resources.Visual`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Cursor

```csharp
/// <summary>
    /// Cursor graphics for different grid building modes
    /// </summary>
    public CursorSettings? Cursor { get; set; }
```

Cursor graphics for different grid building modes

### Highlight

```csharp
/// <summary>
    /// Settings for highlighting targets in the game world during building, move, demolish, etc.
    /// This includes colors for valid and invalid moves, as well as reset colors
    /// </summary>
    public HighlightSettings? Highlight { get; set; }
```

Settings for highlighting targets in the game world during building, move, demolish, etc.
This includes colors for valid and invalid moves, as well as reset colors

### TargetInfo

```csharp
/// <summary>
    /// Settings for target information display
    /// </summary>
    public TargetInfoSettings? TargetInfo { get; set; }
```

Settings for target information display


## Methods

### GetEditorIssues

```csharp
/// <summary>
    /// Returns an array of issues found during editor validation
    /// </summary>
    public List<string> GetEditorIssues()
    {
        var issues = new List<string>();

        if (Cursor == null)
        {
            issues.Add("GBVisualSettings.cursor is null");
        }
        if (Highlight == null)
        {
            issues.Add("GBVisualSettings.highlight is null");
        }
        if (TargetInfo == null)
        {
            issues.Add("GBVisualSettings.target_info is null");
        }

        return issues;
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
        var issues = new List<string>();
        issues.AddRange(GetEditorIssues());
        return issues;
    }
```

Returns an array of issues found during runtime validation

**Returns:** `List<string>`

