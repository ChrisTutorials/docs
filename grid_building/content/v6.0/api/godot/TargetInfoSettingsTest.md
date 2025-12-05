---
title: "TargetInfoSettingsTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/targetinfosettingstest/"
---

# TargetInfoSettingsTest

```csharp
GridBuilding.Godot.Tests.Core.Resources.Visual
class TargetInfoSettingsTest
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Visual/TargetInfoSettingsTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Resources.Visual`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_SetsDefaultValues

```csharp
#region Default Value Tests

    [Fact]
    public void Constructor_SetsDefaultValues()
    {
        var settings = new TargetInfoSettings();

        settings.PositionDecimals.ShouldBe(0);
        settings.PositionFormat.ShouldBe("({0}, {1})");
    }
```

**Returns:** `void`

### PositionDecimals_CanBeSet

```csharp
#endregion

    #region Property Setting Tests

    [Fact]
    public void PositionDecimals_CanBeSet()
    {
        var settings = new TargetInfoSettings();

        settings.PositionDecimals = 2;

        settings.PositionDecimals.ShouldBe(2);
    }
```

**Returns:** `void`

### PositionFormat_CanBeSet

```csharp
[Fact]
    public void PositionFormat_CanBeSet()
    {
        var settings = new TargetInfoSettings();

        settings.PositionFormat = "X: {0}, Y: {1}";

        settings.PositionFormat.ShouldBe("X: {0}, Y: {1}");
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
        var settings = new TargetInfoSettings();

        var issues = settings.GetEditorIssues();

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetEditorIssues_NegativeDecimals_ReturnsIssue

```csharp
[Fact]
    public void GetEditorIssues_NegativeDecimals_ReturnsIssue()
    {
        var settings = new TargetInfoSettings { PositionDecimals = -1 };

        var issues = settings.GetEditorIssues();

        issues.ShouldContain("TargetInfoSettings position_decimals cannot be negative");
    }
```

**Returns:** `void`

### GetEditorIssues_InvalidFormat_ReturnsIssue

```csharp
[Fact]
    public void GetEditorIssues_InvalidFormat_ReturnsIssue()
    {
        var settings = new TargetInfoSettings { PositionFormat = "no placeholders" };

        var issues = settings.GetEditorIssues();

        issues.ShouldContain("TargetInfoSettings position_format must contain at least one placeholder");
    }
```

**Returns:** `void`

### GetEditorIssues_GDScriptStyleFormat_IsValid

```csharp
[Fact]
    public void GetEditorIssues_GDScriptStyleFormat_IsValid()
    {
        // Support GDScript-style %s placeholders
        var settings = new TargetInfoSettings { PositionFormat = "(%s, %s)" };

        var issues = settings.GetEditorIssues();

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetRuntimeIssues_IncludesEditorIssues

```csharp
[Fact]
    public void GetRuntimeIssues_IncludesEditorIssues()
    {
        var settings = new TargetInfoSettings { PositionDecimals = -5 };

        var runtimeIssues = settings.GetRuntimeIssues();
        var editorIssues = settings.GetEditorIssues();

        foreach (var issue in editorIssues)
        {
            runtimeIssues.ShouldContain(issue);
        }
    }
```

**Returns:** `void`

### FormatPosition_ZeroDecimals_FormatsAsInteger

```csharp
#endregion

    #region FormatPosition Tests

    [Fact]
    public void FormatPosition_ZeroDecimals_FormatsAsInteger()
    {
        var settings = new TargetInfoSettings { PositionDecimals = 0 };

        var result = settings.FormatPosition(10.5f, 20.7f);

        result.ShouldBe("(10, 21)"); // F0 truncates toward zero
    }
```

**Returns:** `void`

### FormatPosition_TwoDecimals_FormatsWithDecimals

```csharp
[Fact]
    public void FormatPosition_TwoDecimals_FormatsWithDecimals()
    {
        var settings = new TargetInfoSettings { PositionDecimals = 2 };

        var result = settings.FormatPosition(10.123f, 20.456f);

        result.ShouldBe("(10.12, 20.46)");
    }
```

**Returns:** `void`

### FormatPosition_CustomFormat_UsesFormat

```csharp
[Fact]
    public void FormatPosition_CustomFormat_UsesFormat()
    {
        var settings = new TargetInfoSettings
        {
            PositionFormat = "X={0} Y={1}",
            PositionDecimals = 1
        };

        var result = settings.FormatPosition(5.55f, 10.15f);

        result.ShouldBe("X=5.6 Y=10.1"); // F1 rounds 5.55->5.6, 10.15->10.1
    }
```

**Returns:** `void`

### FormatPosition_NegativeValues_FormatsCorrectly

```csharp
[Fact]
    public void FormatPosition_NegativeValues_FormatsCorrectly()
    {
        var settings = new TargetInfoSettings { PositionDecimals = 0 };

        var result = settings.FormatPosition(-15.5f, -25.5f);

        result.ShouldBe("(-16, -26)");
    }
```

**Returns:** `void`

