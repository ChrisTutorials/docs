---
title: "HighlightSettingsTest"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/highlightsettingstest/"
---

# HighlightSettingsTest

```csharp
GridBuilding.Godot.Tests.Core.Resources.Visual
class HighlightSettingsTest
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Visual/HighlightSettingsTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Resources.Visual`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_SetsDefaultColors

```csharp
#region Default Value Tests

    [Fact]
    public void Constructor_SetsDefaultColors()
    {
        var settings = new HighlightSettings();

        // Build preview: rgba(0.6, 0.6, 1.0, 0.8)
        settings.BuildPreviewColor.R.ShouldBeInRange(0.59f, 0.61f);
        settings.BuildPreviewColor.G.ShouldBeInRange(0.59f, 0.61f);
        settings.BuildPreviewColor.B.ShouldBeInRange(0.99f, 1.01f);
        settings.BuildPreviewColor.A.ShouldBeInRange(0.79f, 0.81f);

        // Info hover: rgba(0.6, 0.7, 0.7, 0.85)
        settings.InfoHoverColor.R.ShouldBeInRange(0.59f, 0.61f);
        settings.InfoHoverColor.G.ShouldBeInRange(0.69f, 0.71f);
        settings.InfoHoverColor.B.ShouldBeInRange(0.69f, 0.71f);

        // Move valid: rgba(0.2, 1.0, 0.2, 1.0)
        settings.MoveValidColor.R.ShouldBeInRange(0.19f, 0.21f);
        settings.MoveValidColor.G.ShouldBeInRange(0.99f, 1.01f);
        settings.MoveValidColor.B.ShouldBeInRange(0.19f, 0.21f);

        // Move invalid: rgba(1.0, 0.2, 0.2, 1.0)
        settings.MoveInvalidColor.R.ShouldBeInRange(0.99f, 1.01f);
        settings.MoveInvalidColor.G.ShouldBeInRange(0.19f, 0.21f);
        settings.MoveInvalidColor.B.ShouldBeInRange(0.19f, 0.21f);

        // Reset color: white
        settings.ResetColor.R.ShouldBeInRange(0.99f, 1.01f);
        settings.ResetColor.G.ShouldBeInRange(0.99f, 1.01f);
        settings.ResetColor.B.ShouldBeInRange(0.99f, 1.01f);
    }
```

**Returns:** `void`

### Constructor_SetsDemolishColors

```csharp
[Fact]
    public void Constructor_SetsDemolishColors()
    {
        var settings = new HighlightSettings();

        // Demolish valid: rgba(0.2, 1.0, 0.2, 1.0)
        settings.DemolishValidColor.R.ShouldBeInRange(0.19f, 0.21f);
        settings.DemolishValidColor.G.ShouldBeInRange(0.99f, 1.01f);
        settings.DemolishValidColor.B.ShouldBeInRange(0.19f, 0.21f);

        // Demolish invalid: rgba(1.0, 0.2, 0.2, 1.0)
        settings.DemolishInvalidColor.R.ShouldBeInRange(0.99f, 1.01f);
        settings.DemolishInvalidColor.G.ShouldBeInRange(0.19f, 0.21f);
        settings.DemolishInvalidColor.B.ShouldBeInRange(0.19f, 0.21f);
    }
```

**Returns:** `void`

### Constructor_SetsActiveManipulationColor

```csharp
[Fact]
    public void Constructor_SetsActiveManipulationColor()
    {
        var settings = new HighlightSettings();

        // Active manipulation: rgba(0.2, 0.2, 1.0, 0.7)
        settings.ActiveManipulationColor.R.ShouldBeInRange(0.19f, 0.21f);
        settings.ActiveManipulationColor.G.ShouldBeInRange(0.19f, 0.21f);
        settings.ActiveManipulationColor.B.ShouldBeInRange(0.99f, 1.01f);
        settings.ActiveManipulationColor.A.ShouldBeInRange(0.69f, 0.71f);
    }
```

**Returns:** `void`

### BuildPreviewColor_CanBeSet

```csharp
#endregion

    #region Property Setting Tests

    [Fact]
    public void BuildPreviewColor_CanBeSet()
    {
        var settings = new HighlightSettings();
        var newColor = new GBColor(0.5f, 0.5f, 0.5f, 0.5f);

        settings.BuildPreviewColor = newColor;

        settings.BuildPreviewColor.R.ShouldBe(0.5f);
        settings.BuildPreviewColor.G.ShouldBe(0.5f);
        settings.BuildPreviewColor.B.ShouldBe(0.5f);
        settings.BuildPreviewColor.A.ShouldBe(0.5f);
    }
```

**Returns:** `void`

### ResetColor_CanBeSetToBlack

```csharp
[Fact]
    public void ResetColor_CanBeSetToBlack()
    {
        var settings = new HighlightSettings();

        settings.ResetColor = GBColor.Black;

        settings.ResetColor.R.ShouldBe(0.0f);
        settings.ResetColor.G.ShouldBe(0.0f);
        settings.ResetColor.B.ShouldBe(0.0f);
    }
```

**Returns:** `void`

### GetEditorIssues_ReturnsEmpty

```csharp
#endregion

    #region Validation Tests

    [Fact]
    public void GetEditorIssues_ReturnsEmpty()
    {
        var settings = new HighlightSettings();

        var issues = settings.GetEditorIssues();

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetRuntimeIssues_ReturnsEmpty

```csharp
[Fact]
    public void GetRuntimeIssues_ReturnsEmpty()
    {
        var settings = new HighlightSettings();

        var issues = settings.GetRuntimeIssues();

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

