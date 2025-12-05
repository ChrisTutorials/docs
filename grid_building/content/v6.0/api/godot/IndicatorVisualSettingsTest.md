---
title: "IndicatorVisualSettingsTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/indicatorvisualsettingstest/"
---

# IndicatorVisualSettingsTest

```csharp
GridBuilding.Godot.Tests.Placement
class IndicatorVisualSettingsTest
{
    // Members...
}
```

Unit tests for IndicatorVisualSettings.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/IndicatorVisualSettingsTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "IndicatorVisualSettings Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests indicator visual settings functionality";
```


## Methods

### IndicatorVisualSettings_Constructor_ShouldCreateValidInstance

```csharp
#endregion

    #region Tests

    [Test]
    public void IndicatorVisualSettings_Constructor_ShouldCreateValidInstance()
    {
        // When
        var settings = new IndicatorVisualSettings();

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### IndicatorVisualSettings_GetValidDefault_ShouldReturnGreenSettings

```csharp
[Test]
    public void IndicatorVisualSettings_GetValidDefault_ShouldReturnGreenSettings()
    {
        // When
        var settings = IndicatorVisualSettings.GetValidDefault();

        // Then
        ;
        ;
        ; // Green
    }
```

**Returns:** `void`

### IndicatorVisualSettings_GetInvalidDefault_ShouldReturnRedSettings

```csharp
[Test]
    public void IndicatorVisualSettings_GetInvalidDefault_ShouldReturnRedSettings()
    {
        // When
        var settings = IndicatorVisualSettings.GetInvalidDefault();

        // Then
        ;
        ;
        ; // Red
    }
```

**Returns:** `void`

### IndicatorVisualSettings_GetEditorIssues_WithNullTexture_ShouldReportIssue

```csharp
[Test]
    public void IndicatorVisualSettings_GetEditorIssues_WithNullTexture_ShouldReportIssue()
    {
        // Given
        var settings = new IndicatorVisualSettings();
        settings.Texture = null;

        // When
        var issues = settings.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### IndicatorVisualSettings_GetEditorIssues_WithValidTexture_ShouldReturnEmpty

```csharp
[Test]
    public void IndicatorVisualSettings_GetEditorIssues_WithValidTexture_ShouldReturnEmpty()
    {
        // Given
        var settings = new IndicatorVisualSettings();
        settings.Texture = new Texture2D();

        // When
        var issues = settings.GetEditorIssues();

        // Then
        ;
    }
```

**Returns:** `void`

### IndicatorVisualSettings_GetRuntimeIssues_ShouldIncludeEditorIssues

```csharp
[Test]
    public void IndicatorVisualSettings_GetRuntimeIssues_ShouldIncludeEditorIssues()
    {
        // Given
        var settings = new IndicatorVisualSettings();
        settings.Texture = null;

        // When
        var runtimeIssues = settings.GetRuntimeIssues();
        var editorIssues = settings.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### IndicatorVisualSettings_Properties_ShouldBeSettable

```csharp
[Test]
    public void IndicatorVisualSettings_Properties_ShouldBeSettable()
    {
        // Given
        var settings = new IndicatorVisualSettings();
        var texture = new Texture2D();
        var color = new Color(0.5f, 0.3f, 0.7f, 1.0f);

        // When
        settings.Texture = texture;
        settings.Modulate = color;

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### IndicatorVisualSettings_DefaultTextures_ShouldHaveCorrectSize

```csharp
[Test]
    public void IndicatorVisualSettings_DefaultTextures_ShouldHaveCorrectSize()
    {
        // Given
        var validSettings = IndicatorVisualSettings.GetValidDefault();
        var invalidSettings = IndicatorVisualSettings.GetInvalidDefault();

        // When
        var validTexture = validSettings.Texture as ImageTexture;
        var invalidTexture = invalidSettings.Texture as ImageTexture;

        // Then
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### IndicatorVisualSettings_DefaultTextures_ShouldHaveCorrectColors

```csharp
[Test]
    public void IndicatorVisualSettings_DefaultTextures_ShouldHaveCorrectColors()
    {
        // Given
        var validSettings = IndicatorVisualSettings.GetValidDefault();
        var invalidSettings = IndicatorVisualSettings.GetInvalidDefault();

        // When
        var validTexture = validSettings.Texture as ImageTexture;
        var invalidTexture = invalidSettings.Texture as ImageTexture;

        // Then
        ;
        ;
        
        // Verify colors by checking modulate property
        ; // Green
        ; // Red
    }
```

**Returns:** `void`

