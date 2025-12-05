---
title: "GridTargetingSettingsTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/gridtargetingsettingstest/"
---

# GridTargetingSettingsTest

```csharp
GridBuilding.Godot.Tests.Core.Resources.Settings
class GridTargetingSettingsTest
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Settings/GridTargetingSettingsTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Resources.Settings`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_SetsDefaultCoreSettings

```csharp
#region Default Value Tests

    [Fact]
    public void Constructor_SetsDefaultCoreSettings()
    {
        var settings = new GridTargetingSettings();

        settings.LimitToAdjacent.ShouldBeFalse();
        settings.MaxTileDistance.ShouldBe(3);
        settings.RestrictToMapArea.ShouldBeFalse();
        settings.ShowDebug.ShouldBeFalse();
    }
```

**Returns:** `void`

### Constructor_SetsDefaultPositionerSettings

```csharp
[Fact]
    public void Constructor_SetsDefaultPositionerSettings()
    {
        var settings = new GridTargetingSettings();

        settings.EnableMouseInput.ShouldBeTrue();
        settings.EnableKeyboardInput.ShouldBeFalse();
        settings.EnableRotationInput.ShouldBeFalse();
        settings.RemainActiveInOffMode.ShouldBeFalse();
        settings.ManualRecenterMode.ShouldBe(CenteringMode.CenterOnScreen);
        settings.PositionOnEnablePolicy.ShouldBe(RecenterOnEnablePolicy.MouseCursor);
        settings.HideOnHandled.ShouldBeTrue();
    }
```

**Returns:** `void`

### Constructor_SetsDefaultAStarSettings

```csharp
[Fact]
    public void Constructor_SetsDefaultAStarSettings()
    {
        var settings = new GridTargetingSettings();

        settings.RegionSize.ShouldBe((50, 50));
        settings.CellShape.ShouldBe(CellShape.Square);
        settings.DiagonalMode.ShouldBe(DiagonalMode.Always);
        settings.DefaultComputeHeuristic.ShouldBe(AStarHeuristic.Euclidean);
        settings.DefaultEstimateHeuristic.ShouldBe(AStarHeuristic.Euclidean);
    }
```

**Returns:** `void`

### MaxTileDistance_CanBeSet

```csharp
#endregion

    #region Property Setting Tests

    [Fact]
    public void MaxTileDistance_CanBeSet()
    {
        var settings = new GridTargetingSettings();

        settings.MaxTileDistance = 10;

        settings.MaxTileDistance.ShouldBe(10);
    }
```

**Returns:** `void`

### RegionSize_CanBeSet

```csharp
[Fact]
    public void RegionSize_CanBeSet()
    {
        var settings = new GridTargetingSettings();

        settings.RegionSize = (100, 100);

        settings.RegionSize.ShouldBe((100, 100));
    }
```

**Returns:** `void`

### DiagonalMode_CanBeSet

```csharp
[Fact]
    public void DiagonalMode_CanBeSet()
    {
        var settings = new GridTargetingSettings();

        settings.DiagonalMode = DiagonalMode.Never;

        settings.DiagonalMode.ShouldBe(DiagonalMode.Never);
    }
```

**Returns:** `void`

### CellShape_CanBeSet

```csharp
[Fact]
    public void CellShape_CanBeSet()
    {
        var settings = new GridTargetingSettings();

        settings.CellShape = CellShape.IsometricRight;

        settings.CellShape.ShouldBe(CellShape.IsometricRight);
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
        var settings = new GridTargetingSettings();

        var issues = settings.GetEditorIssues();

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetEditorIssues_NegativeMaxTileDistance_ReturnsIssue

```csharp
[Fact]
    public void GetEditorIssues_NegativeMaxTileDistance_ReturnsIssue()
    {
        var settings = new GridTargetingSettings { MaxTileDistance = -1 };

        var issues = settings.GetEditorIssues();

        issues.Count.ShouldBe(1);
        issues[0].ShouldContain("Max tile distance must be a positive value");
    }
```

**Returns:** `void`

### GetRuntimeIssues_MatchesEditorIssues

```csharp
[Fact]
    public void GetRuntimeIssues_MatchesEditorIssues()
    {
        var settings = new GridTargetingSettings { MaxTileDistance = -5 };

        var editorIssues = settings.GetEditorIssues();
        var runtimeIssues = settings.GetRuntimeIssues();

        runtimeIssues.Count.ShouldBe(editorIssues.Count);
    }
```

**Returns:** `void`

### RecenterOnEnablePolicy_HasAllValues

```csharp
#endregion

    #region Enum Tests

    [Fact]
    public void RecenterOnEnablePolicy_HasAllValues()
    {
        var values = Enum.GetValues<RecenterOnEnablePolicy>();
        values.Length.ShouldBe(4);
    }
```

**Returns:** `void`

### CellShape_HasAllValues

```csharp
[Fact]
    public void CellShape_HasAllValues()
    {
        var values = Enum.GetValues<CellShape>();
        values.Length.ShouldBe(3);
    }
```

**Returns:** `void`

### DiagonalMode_HasAllValues

```csharp
[Fact]
    public void DiagonalMode_HasAllValues()
    {
        var values = Enum.GetValues<DiagonalMode>();
        values.Length.ShouldBe(4);
    }
```

**Returns:** `void`

### AStarHeuristic_HasAllValues

```csharp
[Fact]
    public void AStarHeuristic_HasAllValues()
    {
        var values = Enum.GetValues<AStarHeuristic>();
        values.Length.ShouldBe(4);
    }
```

**Returns:** `void`

