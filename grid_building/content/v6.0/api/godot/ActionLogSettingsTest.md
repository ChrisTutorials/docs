---
title: "ActionLogSettingsTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/actionlogsettingstest/"
---

# ActionLogSettingsTest

```csharp
GridBuilding.Godot.Tests.Core.Resources.Settings
class ActionLogSettingsTest
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Settings/ActionLogSettingsTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Resources.Settings`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_SetsDefaultValues

```csharp
#region Default Values Tests

    [Fact]
    public void Constructor_SetsDefaultValues()
    {
        var settings = new ActionLogSettings();
        
        settings.OnReadyMessage.ShouldBe("");
        settings.BulletStyle.ShouldBe("•");
        settings.ShowValidationMessage.ShouldBeFalse();
        settings.PrintFailedReasons.ShouldBeTrue();
        settings.PrintOnDragBuild.ShouldBeFalse();
        settings.PrintSuccessReasons.ShouldBeFalse();
        settings.ShowDemolish.ShouldBeTrue();
        settings.ShowMoveStarted.ShouldBeFalse();
        settings.ShowMoveFinished.ShouldBeTrue();
        settings.ShowModeChanges.ShouldBeTrue();
        settings.ModeChangeMessage.ShouldBe("Mode changed to: {0}");
        settings.BuiltMessage.ShouldBe("Built {0}.");
        settings.FailBuildMessage.ShouldBe("Unable to build a {0}.");
        settings.ManipulationMessage.ShouldBe("Manipulation: {0}");
        settings.MaxFailureReasons.ShouldBe(5);
        settings.IssueBulletPrefix.ShouldBe("- ");
    }
```

**Returns:** `void`

### Constructor_SetsDefaultColors

```csharp
[Fact]
    public void Constructor_SetsDefaultColors()
    {
        var settings = new ActionLogSettings();
        
        // Verify colors are approximately Light Coral and Light Blue
        settings.FailedColor.R.ShouldBeInRange(0.93f, 0.95f);
        settings.FailedColor.G.ShouldBeInRange(0.49f, 0.51f);
        settings.FailedColor.B.ShouldBeInRange(0.49f, 0.51f);
        
        settings.SuccessColor.R.ShouldBeInRange(0.67f, 0.69f);
        settings.SuccessColor.G.ShouldBeInRange(0.84f, 0.86f);
        settings.SuccessColor.B.ShouldBeInRange(0.89f, 0.91f);
    }
```

**Returns:** `void`

### OnReadyMessage_CanBeSet

```csharp
#endregion

    #region Property Modification Tests

    [Fact]
    public void OnReadyMessage_CanBeSet()
    {
        var settings = new ActionLogSettings();
        
        settings.OnReadyMessage = "Welcome to Grid Building!";
        
        settings.OnReadyMessage.ShouldBe("Welcome to Grid Building!");
    }
```

**Returns:** `void`

### BulletStyle_CanBeSet

```csharp
[Fact]
    public void BulletStyle_CanBeSet()
    {
        var settings = new ActionLogSettings();
        
        settings.BulletStyle = "→";
        
        settings.BulletStyle.ShouldBe("→");
    }
```

**Returns:** `void`

### MaxFailureReasons_CanBeSet

```csharp
[Fact]
    public void MaxFailureReasons_CanBeSet()
    {
        var settings = new ActionLogSettings();
        
        settings.MaxFailureReasons = 10;
        
        settings.MaxFailureReasons.ShouldBe(10);
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
        var settings = new ActionLogSettings();
        
        var issues = settings.GetEditorIssues();
        
        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetEditorIssues_EmptyBulletStyle_ReturnsIssue

```csharp
[Fact]
    public void GetEditorIssues_EmptyBulletStyle_ReturnsIssue()
    {
        var settings = new ActionLogSettings { BulletStyle = "" };
        
        var issues = settings.GetEditorIssues();
        
        issues.ShouldContain("ActionLogSettings bullet_style is empty");
    }
```

**Returns:** `void`

### GetRuntimeIssues_DefaultSettings_ReturnsEmpty

```csharp
[Fact]
    public void GetRuntimeIssues_DefaultSettings_ReturnsEmpty()
    {
        var settings = new ActionLogSettings();
        
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
        var settings = new ActionLogSettings { BulletStyle = "" };
        
        var runtimeIssues = settings.GetRuntimeIssues();
        var editorIssues = settings.GetEditorIssues();
        
        foreach (var issue in editorIssues)
        {
            runtimeIssues.ShouldContain(issue);
        }
    }
```

**Returns:** `void`

### BuiltMessage_CanFormatWithPlaceholder

```csharp
#endregion

    #region Message Formatting Tests

    [Fact]
    public void BuiltMessage_CanFormatWithPlaceholder()
    {
        var settings = new ActionLogSettings();
        
        var formatted = string.Format(settings.BuiltMessage, "Wall");
        
        formatted.ShouldBe("Built Wall.");
    }
```

**Returns:** `void`

### ModeChangeMessage_CanFormatWithPlaceholder

```csharp
[Fact]
    public void ModeChangeMessage_CanFormatWithPlaceholder()
    {
        var settings = new ActionLogSettings();
        
        var formatted = string.Format(settings.ModeChangeMessage, "BUILD");
        
        formatted.ShouldBe("Mode changed to: BUILD");
    }
```

**Returns:** `void`

### FailBuildMessage_CanFormatWithPlaceholder

```csharp
[Fact]
    public void FailBuildMessage_CanFormatWithPlaceholder()
    {
        var settings = new ActionLogSettings();
        
        var formatted = string.Format(settings.FailBuildMessage, "Tower");
        
        formatted.ShouldBe("Unable to build a Tower.");
    }
```

**Returns:** `void`

