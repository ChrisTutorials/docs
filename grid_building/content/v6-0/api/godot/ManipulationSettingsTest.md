---
title: "ManipulationSettingsTest"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/manipulationsettingstest/"
---

# ManipulationSettingsTest

```csharp
GridBuilding.Godot.Tests.Core.Resources.Settings
class ManipulationSettingsTest
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Settings/ManipulationSettingsTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Resources.Settings`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_SetsDefaultRotation

```csharp
#region Default Value Tests

    [Fact]
    public void Constructor_SetsDefaultRotation()
    {
        var settings = new ManipulationSettings();

        settings.RotateIncrementDegrees.ShouldBe(90.0f);
    }
```

**Returns:** `void`

### Constructor_SetsDefaultEnableFlags

```csharp
[Fact]
    public void Constructor_SetsDefaultEnableFlags()
    {
        var settings = new ManipulationSettings();

        settings.EnableDemolish.ShouldBeFalse();
        settings.DemolishWhileMoving.ShouldBeFalse();
        settings.EnableRotate.ShouldBeTrue();
        settings.EnableFlipHorizontal.ShouldBeTrue();
        settings.EnableFlipVertical.ShouldBeTrue();
        settings.ResetTransformOnManipulation.ShouldBeFalse();
        settings.DisableLayerInManipulation.ShouldBeFalse();
    }
```

**Returns:** `void`

### Constructor_SetsDefaultMessages

```csharp
[Fact]
    public void Constructor_SetsDefaultMessages()
    {
        var settings = new ManipulationSettings();

        settings.DemolishSuccess.ShouldNotBeNullOrEmpty();
        settings.MoveSuccess.ShouldNotBeNullOrEmpty();
        settings.FailedNotDemolishable.ShouldNotBeNullOrEmpty();
        settings.NoMoveTarget.ShouldNotBeNullOrEmpty();
    }
```

**Returns:** `void`

### RotateIncrementDegrees_CanBeSet

```csharp
#endregion

    #region Property Setting Tests

    [Fact]
    public void RotateIncrementDegrees_CanBeSet()
    {
        var settings = new ManipulationSettings();

        settings.RotateIncrementDegrees = 45.0f;

        settings.RotateIncrementDegrees.ShouldBe(45.0f);
    }
```

**Returns:** `void`

### EnableDemolish_CanBeSet

```csharp
[Fact]
    public void EnableDemolish_CanBeSet()
    {
        var settings = new ManipulationSettings();

        settings.EnableDemolish = true;

        settings.EnableDemolish.ShouldBeTrue();
    }
```

**Returns:** `void`

### MoveSuffix_CanBeSet

```csharp
[Fact]
    public void MoveSuffix_CanBeSet()
    {
        var settings = new ManipulationSettings();

        settings.MoveSuffix = "_moving";

        settings.MoveSuffix.ShouldBe("_moving");
    }
```

**Returns:** `void`

### DisabledPhysicsLayer_CanBeSet

```csharp
[Fact]
    public void DisabledPhysicsLayer_CanBeSet()
    {
        var settings = new ManipulationSettings();

        settings.DisabledPhysicsLayer = 5;

        settings.DisabledPhysicsLayer.ShouldBe(5);
    }
```

**Returns:** `void`

### DemolishSuccess_CanFormat

```csharp
#endregion

    #region Message Formatting Tests

    [Fact]
    public void DemolishSuccess_CanFormat()
    {
        var settings = new ManipulationSettings();

        var result = string.Format(settings.DemolishSuccess, "Wall");

        result.ShouldBe("Wall was demolished successfully.");
    }
```

**Returns:** `void`

### MoveStarted_CanFormat

```csharp
[Fact]
    public void MoveStarted_CanFormat()
    {
        var settings = new ManipulationSettings();

        var result = string.Format(settings.MoveStarted, "Tower");

        result.ShouldBe("Moving Tower");
    }
```

**Returns:** `void`

### FailedPlacementInvalid_CanFormat

```csharp
[Fact]
    public void FailedPlacementInvalid_CanFormat()
    {
        var settings = new ManipulationSettings();

        var result = string.Format(settings.FailedPlacementInvalid, "Building");

        result.ShouldBe("Cannot place Building here.");
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
        var settings = new ManipulationSettings();

        var issues = settings.GetEditorIssues();

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetEditorIssues_EmptyDemolishSuccess_ReturnsIssue

```csharp
[Fact]
    public void GetEditorIssues_EmptyDemolishSuccess_ReturnsIssue()
    {
        var settings = new ManipulationSettings { DemolishSuccess = "" };

        var issues = settings.GetEditorIssues();

        issues.ShouldContain("ManipulationSettings: Demolish success message is empty.");
    }
```

**Returns:** `void`

### GetEditorIssues_EmptyMoveSuccess_ReturnsIssue

```csharp
[Fact]
    public void GetEditorIssues_EmptyMoveSuccess_ReturnsIssue()
    {
        var settings = new ManipulationSettings { MoveSuccess = "" };

        var issues = settings.GetEditorIssues();

        issues.ShouldContain("ManipulationSettings: Move success message is empty.");
    }
```

**Returns:** `void`

### GetEditorIssues_MultipleEmptyMessages_ReturnsMultipleIssues

```csharp
[Fact]
    public void GetEditorIssues_MultipleEmptyMessages_ReturnsMultipleIssues()
    {
        var settings = new ManipulationSettings
        {
            DemolishSuccess = "",
            MoveSuccess = "",
            NoMoveTarget = ""
        };

        var issues = settings.GetEditorIssues();

        issues.Count.ShouldBeGreaterThanOrEqualTo(3);
    }
```

**Returns:** `void`

### GetRuntimeIssues_IncludesEditorIssues

```csharp
[Fact]
    public void GetRuntimeIssues_IncludesEditorIssues()
    {
        var settings = new ManipulationSettings { DemolishSuccess = "" };

        var runtimeIssues = settings.GetRuntimeIssues();
        var editorIssues = settings.GetEditorIssues();

        foreach (var issue in editorIssues)
        {
            runtimeIssues.ShouldContain(issue);
        }
    }
```

**Returns:** `void`

### AllRotationFeaturesEnabled_ByDefault

```csharp
#endregion

    #region Feature Flag Tests

    [Fact]
    public void AllRotationFeaturesEnabled_ByDefault()
    {
        var settings = new ManipulationSettings();

        settings.EnableRotate.ShouldBeTrue();
        settings.EnableFlipHorizontal.ShouldBeTrue();
        settings.EnableFlipVertical.ShouldBeTrue();
    }
```

**Returns:** `void`

### AllRotationFeaturesCanBeDisabled

```csharp
[Fact]
    public void AllRotationFeaturesCanBeDisabled()
    {
        var settings = new ManipulationSettings
        {
            EnableRotate = false,
            EnableFlipHorizontal = false,
            EnableFlipVertical = false
        };

        settings.EnableRotate.ShouldBeFalse();
        settings.EnableFlipHorizontal.ShouldBeFalse();
        settings.EnableFlipVertical.ShouldBeFalse();
    }
```

**Returns:** `void`

