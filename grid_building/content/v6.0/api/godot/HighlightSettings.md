---
title: "HighlightSettings"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/highlightsettings/"
---

# HighlightSettings

```csharp
GridBuilding.Godot.Tests.Resources.Visual
class HighlightSettings
{
    // Members...
}
```

Settings for manipulating an object in the game world to indicate it as
a valid, invalid target, etc.
Ported from: godot/addons/grid_building/systems/grid_targeting/highlight_settings.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Visual/HighlightSettings.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Resources.Visual`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### BuildPreviewColor

```csharp
/// <summary>
    /// Adjustment color for any preview sprites to indicate that the
    /// instance is a preview and not actually an interactable object
    /// in the game
    /// </summary>
    public GBColor BuildPreviewColor { get; set; } = new(0.6f, 0.6f, 1.0f, 0.8f);
```

Adjustment color for any preview sprites to indicate that the
instance is a preview and not actually an interactable object
in the game

### InfoHoverColor

```csharp
/// <summary>
    /// Color to highlight a hover target in info mode
    /// </summary>
    public GBColor InfoHoverColor { get; set; } = new(0.6f, 0.7f, 0.7f, 0.85f);
```

Color to highlight a hover target in info mode

### MoveValidColor

```csharp
/// <summary>
    /// When move is possible
    /// </summary>
    public GBColor MoveValidColor { get; set; } = new(0.2f, 1.0f, 0.2f, 1.0f);
```

When move is possible

### MoveInvalidColor

```csharp
/// <summary>
    /// When move is not possible
    /// </summary>
    public GBColor MoveInvalidColor { get; set; } = new(1.0f, 0.2f, 0.2f, 1.0f);
```

When move is not possible

### ActiveManipulationColor

```csharp
/// <summary>
    /// For objects being moved
    /// </summary>
    public GBColor ActiveManipulationColor { get; set; } = new(0.2f, 0.2f, 1.0f, 0.7f);
```

For objects being moved

### DemolishValidColor

```csharp
/// <summary>
    /// When demolishing is possible
    /// </summary>
    public GBColor DemolishValidColor { get; set; } = new(0.2f, 1.0f, 0.2f, 1.0f);
```

When demolishing is possible

### DemolishInvalidColor

```csharp
/// <summary>
    /// When demolishing is not possible
    /// </summary>
    public GBColor DemolishInvalidColor { get; set; } = new(1.0f, 0.2f, 0.2f, 1.0f);
```

When demolishing is not possible

### ResetColor

```csharp
/// <summary>
    /// Default reset modulate color
    /// </summary>
    public GBColor ResetColor { get; set; } = GBColor.White;
```

Default reset modulate color


## Methods

### GetEditorIssues

```csharp
/// <summary>
    /// Returns an array of issues found during editor validation
    /// </summary>
    public List<string> GetEditorIssues()
    {
        // Color validation is generally not needed as colors are value types
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
        var issues = new List<string>();
        issues.AddRange(GetEditorIssues());
        return issues;
    }
```

Returns an array of issues found during runtime validation

**Returns:** `List<string>`

