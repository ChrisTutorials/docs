---
title: "CursorSettingsTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/cursorsettingstest/"
---

# CursorSettingsTest

```csharp
GridBuilding.Godot.Tests.Core.Resources.Visual
class CursorSettingsTest
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Visual/CursorSettingsTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Resources.Visual`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_SetsNullDefaults

```csharp
#region Default Value Tests

    [Fact]
    public void Constructor_SetsNullDefaults()
    {
        var settings = new CursorSettings();

        settings.InfoCursor.ShouldBeNull();
        settings.BuildCursor.ShouldBeNull();
        settings.MoveCursor.ShouldBeNull();
        settings.DemolishCursor.ShouldBeNull();
    }
```

**Returns:** `void`

### InfoCursor_CanBeSet

```csharp
#endregion

    #region Property Setting Tests

    [Fact]
    public void InfoCursor_CanBeSet()
    {
        var settings = new CursorSettings();

        settings.InfoCursor = "res://cursors/info.png";

        settings.InfoCursor.ShouldBe("res://cursors/info.png");
    }
```

**Returns:** `void`

### BuildCursor_CanBeSet

```csharp
[Fact]
    public void BuildCursor_CanBeSet()
    {
        var settings = new CursorSettings();

        settings.BuildCursor = "res://cursors/build.png";

        settings.BuildCursor.ShouldBe("res://cursors/build.png");
    }
```

**Returns:** `void`

### MoveCursor_CanBeSet

```csharp
[Fact]
    public void MoveCursor_CanBeSet()
    {
        var settings = new CursorSettings();

        settings.MoveCursor = "res://cursors/move.png";

        settings.MoveCursor.ShouldBe("res://cursors/move.png");
    }
```

**Returns:** `void`

### DemolishCursor_CanBeSet

```csharp
[Fact]
    public void DemolishCursor_CanBeSet()
    {
        var settings = new CursorSettings();

        settings.DemolishCursor = "res://cursors/demolish.png";

        settings.DemolishCursor.ShouldBe("res://cursors/demolish.png");
    }
```

**Returns:** `void`

### GetEditorIssues_AllNull_ReturnsFourIssues

```csharp
#endregion

    #region Validation Tests

    [Fact]
    public void GetEditorIssues_AllNull_ReturnsFourIssues()
    {
        var settings = new CursorSettings();

        var issues = settings.GetEditorIssues();

        issues.Count.ShouldBe(4);
        issues.ShouldContain("CursorSettings info texture is not set");
        issues.ShouldContain("CursorSettings build texture is not set");
        issues.ShouldContain("CursorSettings move texture is not set");
        issues.ShouldContain("CursorSettings demolish texture is not set");
    }
```

**Returns:** `void`

### GetEditorIssues_AllSet_ReturnsEmpty

```csharp
[Fact]
    public void GetEditorIssues_AllSet_ReturnsEmpty()
    {
        var settings = new CursorSettings
        {
            InfoCursor = "info.png",
            BuildCursor = "build.png",
            MoveCursor = "move.png",
            DemolishCursor = "demolish.png"
        };

        var issues = settings.GetEditorIssues();

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetEditorIssues_PartiallySet_ReturnsPartialIssues

```csharp
[Fact]
    public void GetEditorIssues_PartiallySet_ReturnsPartialIssues()
    {
        var settings = new CursorSettings
        {
            InfoCursor = "info.png",
            BuildCursor = "build.png"
        };

        var issues = settings.GetEditorIssues();

        issues.Count.ShouldBe(2);
        issues.ShouldContain("CursorSettings move texture is not set");
        issues.ShouldContain("CursorSettings demolish texture is not set");
    }
```

**Returns:** `void`

### GetRuntimeIssues_IncludesEditorIssues

```csharp
[Fact]
    public void GetRuntimeIssues_IncludesEditorIssues()
    {
        var settings = new CursorSettings();

        var runtimeIssues = settings.GetRuntimeIssues();
        var editorIssues = settings.GetEditorIssues();

        foreach (var issue in editorIssues)
        {
            runtimeIssues.ShouldContain(issue);
        }
    }
```

**Returns:** `void`

