---
title: "IndicatorVisualSettings"
description: "Visual settings for TileCheckIndicator display.
Ported from: godot/addons/grid_building/systems/placement/utilities/rule_check_indicator/indicator_visual_settings.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/indicatorvisualsettings/"
---

# IndicatorVisualSettings

```csharp
GridBuilding.Godot.Systems.Placement.Resources
class IndicatorVisualSettings
{
    // Members...
}
```

Visual settings for TileCheckIndicator display.
Ported from: godot/addons/grid_building/systems/placement/utilities/rule_check_indicator/indicator_visual_settings.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Resources/IndicatorVisualSettings.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Resources`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Texture

```csharp
#region Exported Properties

    /// <summary>
    /// Texture for validation failure display.
    /// </summary>
    [Export]
    public Texture2D? Texture { get; set; }
```

Texture for validation failure display.

### Modulate

```csharp
/// <summary>
    /// Color adjustment for the fail texture.
    /// </summary>
    [Export]
    public Color Modulate { get; set; } = Colors.White;
```

Color adjustment for the fail texture.


## Methods

### GetValidDefault

```csharp
#endregion

    #region Static Factory Methods

    /// <summary>
    /// Returns a fresh IndicatorVisualSettings configured for a "valid" state.
    /// </summary>
    /// <returns>IndicatorVisualSettings configured for valid display</returns>
    public static IndicatorVisualSettings GetValidDefault()
    {
        var settings = new IndicatorVisualSettings();
        settings.Texture = CreateDefaultTexture(new Color(0, 1, 0, 1), 16); // Green
        settings.Modulate = new Color(0, 1, 0, 1); // Green
        return settings;
    }
```

Returns a fresh IndicatorVisualSettings configured for a "valid" state.

**Returns:** `IndicatorVisualSettings`

### GetInvalidDefault

```csharp
/// <summary>
    /// Returns a fresh IndicatorVisualSettings configured for an "invalid" state.
    /// </summary>
    /// <returns>IndicatorVisualSettings configured for invalid display</returns>
    public static IndicatorVisualSettings GetInvalidDefault()
    {
        var settings = new IndicatorVisualSettings();
        settings.Texture = CreateDefaultTexture(new Color(1, 0, 0, 1), 16); // Red
        settings.Modulate = new Color(1, 0, 0, 1); // Red
        return settings;
    }
```

Returns a fresh IndicatorVisualSettings configured for an "invalid" state.

**Returns:** `IndicatorVisualSettings`

### GetEditorIssues

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Returns an array of issues found during editor validation.
    /// </summary>
    /// <returns>Array of editor validation issues</returns>
    public GDCollections.Array<string> GetEditorIssues()
    {
        var issues = new GDCollections.Array<string>();

        if (Texture == null)
        {
            issues.Add("IndicatorVisualSettings texture is not set");
        }

        return issues;
    }
```

Returns an array of issues found during editor validation.

**Returns:** `GDCollections.Array<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Returns an array of issues found during runtime validation.
    /// </summary>
    /// <returns>Array of runtime validation issues</returns>
    public GDCollections.Array<string> GetRuntimeIssues()
    {
        var issues = GetEditorIssues();
        return issues;
    }
```

Returns an array of issues found during runtime validation.

**Returns:** `GDCollections.Array<string>`

