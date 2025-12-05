---
title: "VisualSettings"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/visualsettings/"
---

# VisualSettings

```csharp
GridBuilding.Core.Systems.Configuration
class VisualSettings
{
    // Members...
}
```

Visual settings for the GridBuilding plugin.
Provides configuration for visual effects, rendering options,
and UI display settings. This is a pure C# implementation for Core use.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Configuration/VisualSettings.cs`  
**Namespace:** `GridBuilding.Core.Systems.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ShowGridLines

```csharp
/// <summary>
    /// Whether to show grid lines
    /// </summary>
    public bool ShowGridLines { get; set; } = true;
```

Whether to show grid lines

### GridLineColor

```csharp
/// <summary>
    /// Grid line color
    /// </summary>
    public string GridLineColor { get; set; } = "#FFFFFF";
```

Grid line color

### GridLineOpacity

```csharp
/// <summary>
    /// Grid line opacity (0.0 to 1.0)
    /// </summary>
    public float GridLineOpacity { get; set; } = 0.5f;
```

Grid line opacity (0.0 to 1.0)

### ShowPlacementPreview

```csharp
/// <summary>
    /// Whether to show placement preview
    /// </summary>
    public bool ShowPlacementPreview { get; set; } = true;
```

Whether to show placement preview

### PlacementPreviewColor

```csharp
/// <summary>
    /// Placement preview color
    /// </summary>
    public string PlacementPreviewColor { get; set; } = "#00FF00";
```

Placement preview color

### PlacementPreviewOpacity

```csharp
/// <summary>
    /// Placement preview opacity (0.0 to 1.0)
    /// </summary>
    public float PlacementPreviewOpacity { get; set; } = 0.7f;
```

Placement preview opacity (0.0 to 1.0)

### ShowInvalidPlacementIndicator

```csharp
/// <summary>
    /// Whether to show invalid placement indicator
    /// </summary>
    public bool ShowInvalidPlacementIndicator { get; set; } = true;
```

Whether to show invalid placement indicator

### InvalidPlacementColor

```csharp
/// <summary>
    /// Invalid placement color
    /// </summary>
    public string InvalidPlacementColor { get; set; } = "#FF0000";
```

Invalid placement color

### AnimationSpeed

```csharp
/// <summary>
    /// Animation speed for visual effects
    /// </summary>
    public float AnimationSpeed { get; set; } = 1.0f;
```

Animation speed for visual effects

### EnableVisualEffects

```csharp
/// <summary>
    /// Whether to enable visual effects
    /// </summary>
    public bool EnableVisualEffects { get; set; } = true;
```

Whether to enable visual effects

### UIScale

```csharp
/// <summary>
    /// UI scale factor
    /// </summary>
    public float UIScale { get; set; } = 1.0f;
```

UI scale factor

