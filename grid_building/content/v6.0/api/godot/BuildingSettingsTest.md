---
title: "BuildingSettingsTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/buildingsettingstest/"
---

# BuildingSettingsTest

```csharp
GridBuilding.Godot.Tests.Core.Resources.Settings
class BuildingSettingsTest
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Settings/BuildingSettingsTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Resources.Settings`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_SetsDefaultValues

```csharp
#region Default Value Tests

    [Fact]
    public void Constructor_SetsDefaultValues()
    {
        var settings = new BuildingSettings();

        settings.PreviewKeptScriptTypes.ShouldContain("Manipulatable");
        settings.PreviewInstanceZIndex.ShouldBe(100);
        settings.PreviewRootScriptPath.ShouldBeNull();
    }
```

**Returns:** `void`

### PreviewKeptScriptTypes_CanBeModified

```csharp
#endregion

    #region Property Setting Tests

    [Fact]
    public void PreviewKeptScriptTypes_CanBeModified()
    {
        var settings = new BuildingSettings();

        settings.PreviewKeptScriptTypes.Add("CustomScript");

        settings.PreviewKeptScriptTypes.Count.ShouldBe(2);
        settings.PreviewKeptScriptTypes.ShouldContain("CustomScript");
    }
```

**Returns:** `void`

### PreviewInstanceZIndex_CanBeSet

```csharp
[Fact]
    public void PreviewInstanceZIndex_CanBeSet()
    {
        var settings = new BuildingSettings();

        settings.PreviewInstanceZIndex = 50;

        settings.PreviewInstanceZIndex.ShouldBe(50);
    }
```

**Returns:** `void`

### PreviewRootScriptPath_CanBeSet

```csharp
[Fact]
    public void PreviewRootScriptPath_CanBeSet()
    {
        var settings = new BuildingSettings();

        settings.PreviewRootScriptPath = "res://scripts/preview.gd";

        settings.PreviewRootScriptPath.ShouldBe("res://scripts/preview.gd");
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
        var settings = new BuildingSettings();

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
        var settings = new BuildingSettings();

        var issues = settings.GetRuntimeIssues();

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

