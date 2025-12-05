---
title: "VisualSettingsTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/visualsettingstest/"
---

# VisualSettingsTest

```csharp
GridBuilding.Godot.Tests.Core.Resources.Visual
class VisualSettingsTest
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Visual/GBVisualSettingsTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Resources.Visual`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_InitializesChildSettings

```csharp
#region Constructor Tests

    [Fact]
    public void Constructor_InitializesChildSettings()
    {
        var settings = new VisualSettings();

        settings.Cursor.ShouldNotBeNull();
        settings.Highlight.ShouldNotBeNull();
        settings.TargetInfo.ShouldNotBeNull();
    }
```

**Returns:** `void`

### Constructor_CreatesDefaultCursorSettings

```csharp
[Fact]
    public void Constructor_CreatesDefaultCursorSettings()
    {
        var settings = new VisualSettings();

        settings.Cursor.ShouldBeOfType<CursorSettings>();
    }
```

**Returns:** `void`

### Constructor_CreatesDefaultHighlightSettings

```csharp
[Fact]
    public void Constructor_CreatesDefaultHighlightSettings()
    {
        var settings = new VisualSettings();

        settings.Highlight.ShouldBeOfType<HighlightSettings>();
    }
```

**Returns:** `void`

### Constructor_CreatesDefaultTargetInfoSettings

```csharp
[Fact]
    public void Constructor_CreatesDefaultTargetInfoSettings()
    {
        var settings = new VisualSettings();

        settings.TargetInfo.ShouldBeOfType<TargetInfoSettings>();
    }
```

**Returns:** `void`

### Cursor_CanBeSet

```csharp
#endregion

    #region Property Setting Tests

    [Fact]
    public void Cursor_CanBeSet()
    {
        var settings = new VisualSettings();
        var newCursor = new CursorSettings { InfoCursor = "custom.png" };

        settings.Cursor = newCursor;

        settings.Cursor.ShouldBe(newCursor);
        settings.Cursor!.InfoCursor.ShouldBe("custom.png");
    }
```

**Returns:** `void`

### Cursor_CanBeSetToNull

```csharp
[Fact]
    public void Cursor_CanBeSetToNull()
    {
        var settings = new VisualSettings();

        settings.Cursor = null;

        settings.Cursor.ShouldBeNull();
    }
```

**Returns:** `void`

### Highlight_CanBeSet

```csharp
[Fact]
    public void Highlight_CanBeSet()
    {
        var settings = new VisualSettings();
        var newHighlight = new HighlightSettings();

        settings.Highlight = newHighlight;

        settings.Highlight.ShouldBe(newHighlight);
    }
```

**Returns:** `void`

### TargetInfo_CanBeSet

```csharp
[Fact]
    public void TargetInfo_CanBeSet()
    {
        var settings = new VisualSettings();
        var newTargetInfo = new TargetInfoSettings { PositionDecimals = 3 };

        settings.TargetInfo = newTargetInfo;

        settings.TargetInfo.ShouldBe(newTargetInfo);
        settings.TargetInfo!.PositionDecimals.ShouldBe(3);
    }
```

**Returns:** `void`

### GetEditorIssues_DefaultSettings_ReturnsEmpty

```csharp
#endregion

    #region Validation Tests

    [Fact]
    public void GetEditorIssues_DefaultSettings_ReturnsEmpty()
    {
        var settings = new VisualSettings();

        var issues = settings.GetEditorIssues();

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetEditorIssues_NullCursor_ReturnsIssue

```csharp
[Fact]
    public void GetEditorIssues_NullCursor_ReturnsIssue()
    {
        var settings = new VisualSettings { Cursor = null };

        var issues = settings.GetEditorIssues();

        issues.ShouldContain("VisualSettings.cursor is null");
    }
```

**Returns:** `void`

### GetEditorIssues_NullHighlight_ReturnsIssue

```csharp
[Fact]
    public void GetEditorIssues_NullHighlight_ReturnsIssue()
    {
        var settings = new VisualSettings { Highlight = null };

        var issues = settings.GetEditorIssues();

        issues.ShouldContain("VisualSettings.highlight is null");
    }
```

**Returns:** `void`

### GetEditorIssues_NullTargetInfo_ReturnsIssue

```csharp
[Fact]
    public void GetEditorIssues_NullTargetInfo_ReturnsIssue()
    {
        var settings = new VisualSettings { TargetInfo = null };

        var issues = settings.GetEditorIssues();

        issues.ShouldContain("VisualSettings.target_info is null");
    }
```

**Returns:** `void`

### GetEditorIssues_AllNull_ReturnsThreeIssues

```csharp
[Fact]
    public void GetEditorIssues_AllNull_ReturnsThreeIssues()
    {
        var settings = new VisualSettings
        {
            Cursor = null,
            Highlight = null,
            TargetInfo = null
        };

        var issues = settings.GetEditorIssues();

        issues.Count.ShouldBe(3);
    }
```

**Returns:** `void`

### GetRuntimeIssues_DefaultSettings_ReturnsEmpty

```csharp
[Fact]
    public void GetRuntimeIssues_DefaultSettings_ReturnsEmpty()
    {
        var settings = new VisualSettings();

        var issues = settings.GetRuntimeIssues();

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetRuntimeIssues_IncludesEditorIssues

```csharp
[Fact]
    public void GetRuntimeIssues_IncludesEditorIssues()
    {
        var settings = new VisualSettings { Cursor = null };

        var runtimeIssues = settings.GetRuntimeIssues();
        var editorIssues = settings.GetEditorIssues();

        foreach (var issue in editorIssues)
        {
            runtimeIssues.ShouldContain(issue);
        }
    }
```

**Returns:** `void`

