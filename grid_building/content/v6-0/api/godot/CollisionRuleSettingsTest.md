---
title: "CollisionRuleSettingsTest"
description: "Unit tests for CollisionRuleSettings."
weight: 20
url: "/gridbuilding/v6-0/api/godot/collisionrulesettingstest/"
---

# CollisionRuleSettingsTest

```csharp
GridBuilding.Godot.Tests.Placement
class CollisionRuleSettingsTest
{
    // Members...
}
```

Unit tests for CollisionRuleSettings.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/CollisionRuleSettingsTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "CollisionRuleSettings Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests collision rule settings functionality";
```


## Methods

### CollisionRuleSettings_Constructor_ShouldCreateValidInstance

```csharp
#endregion

    #region Tests

    [Test]
    public void CollisionRuleSettings_Constructor_ShouldCreateValidInstance()
    {
        // When
        var settings = new CollisionRuleSettings();

        // Then
        ;
        ;
        ;
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CollisionRuleSettings_GetEditorIssues_WithEmptyMessages_ShouldReportIssues

```csharp
[Test]
    public void CollisionRuleSettings_GetEditorIssues_WithEmptyMessages_ShouldReportIssues()
    {
        // Given
        var settings = new CollisionRuleSettings();
        settings.SuccessMessage = "";
        settings.FailBlockedMessage = "";
        settings.FailMissingOverlapMessage = "";

        // When
        var issues = settings.GetEditorIssues();

        // Then
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CollisionRuleSettings_GetEditorIssues_WithValidMessages_ShouldReturnEmpty

```csharp
[Test]
    public void CollisionRuleSettings_GetEditorIssues_WithValidMessages_ShouldReturnEmpty()
    {
        // Given
        var settings = new CollisionRuleSettings();
        // All messages have valid defaults

        // When
        var issues = settings.GetEditorIssues();

        // Then
        ;
    }
```

**Returns:** `void`

### CollisionRuleSettings_GetRuntimeIssues_ShouldIncludeEditorIssues

```csharp
[Test]
    public void CollisionRuleSettings_GetRuntimeIssues_ShouldIncludeEditorIssues()
    {
        // Given
        var settings = new CollisionRuleSettings();
        settings.SuccessMessage = "";

        // When
        var runtimeIssues = settings.GetRuntimeIssues();
        var editorIssues = settings.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### CollisionRuleSettings_Properties_ShouldBeSettable

```csharp
[Test]
    public void CollisionRuleSettings_Properties_ShouldBeSettable()
    {
        // Given
        var settings = new CollisionRuleSettings();

        // When
        settings.SuccessMessage = "Custom success";
        settings.ExpectedNoCollisionsMessage = "Custom no collisions";
        settings.ExpectedCollisionMessage = "Custom collision";
        settings.ExpectedCollisionsMessage = "Custom collisions";
        settings.NoIndicatorsMessage = "Custom no indicators";
        settings.FailBlockedMessage = "Custom blocked %d";
        settings.FailMissingOverlapMessage = "Custom missing %d";
        settings.SuccessReason = "Custom success reason";
        settings.FailureReason = "Custom failure reason";
        settings.NoIndicatorsReason = "Custom no indicators reason";
        settings.PrependResourceName = true;
        settings.AppendLayerNames = true;
        settings.LayersTestedPrefix = "Custom prefix: ";

        // Then
        ;
        ;
        ;
        ;
        ;
        ;
        ;
        ;
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CollisionRuleSettings_DefaultValues_ShouldBeCorrect

```csharp
[Test]
    public void CollisionRuleSettings_DefaultValues_ShouldBeCorrect()
    {
        // Given
        var settings = new CollisionRuleSettings();

        // When/Then - Verify all default values
        ;
        ;
        ;
        ;
        ;
        ;
        ;
        ;
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CollisionRuleSettings_MessageFormatting_ShouldHandlePlaceholders

```csharp
[Test]
    public void CollisionRuleSettings_MessageFormatting_ShouldHandlePlaceholders()
    {
        // Given
        var settings = new CollisionRuleSettings();
        var failingCount = 3;

        // When
        var blockedMessage = settings.FailBlockedMessage.Replace("%d", failingCount.ToString());
        var missingMessage = settings.FailMissingOverlapMessage.Replace("%d", failingCount.ToString());

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### CollisionRuleSettings_DisplaySettings_ShouldWorkCorrectly

```csharp
[Test]
    public void CollisionRuleSettings_DisplaySettings_ShouldWorkCorrectly()
    {
        // Given
        var settings = new CollisionRuleSettings();
        settings.PrependResourceName = true;
        settings.AppendLayerNames = true;
        settings.LayersTestedPrefix = "Test: ";

        // When/Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

