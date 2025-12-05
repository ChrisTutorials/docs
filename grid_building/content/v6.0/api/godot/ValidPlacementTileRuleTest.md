---
title: "ValidPlacementTileRuleTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/validplacementtileruletest/"
---

# ValidPlacementTileRuleTest

```csharp
GridBuilding.Godot.Tests.Placement
class ValidPlacementTileRuleTest
{
    // Members...
}
```

Unit tests for ValidPlacementTileRule.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/ValidPlacementTileRuleTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "ValidPlacementTileRule Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests valid placement tile rule functionality";
```


## Methods

### SetUp

```csharp
[SetUp]
    public void SetUp()
    {
        _rule = new MockValidPlacementTileRule();
        _targetingState = new GridTargetingState();
        _mockMap = new TileMapLayer();
        _targetingState.Maps = new Godot.Collections.Array<TileMapLayer> { _mockMap };
    }
```

**Returns:** `void`

### TearDown

```csharp
[TearDown]
    public void TearDown()
    {
        _rule?.TearDown();
        _rule = null;
        _targetingState = null;
        _mockMap?.QueueFree();
        _mockMap = null;
    }
```

**Returns:** `void`

### ValidPlacementTileRule_Constructor_ShouldCreateValidInstance

```csharp
#endregion

    #region Tests

    [Test]
    public void ValidPlacementTileRule_Constructor_ShouldCreateValidInstance()
    {
        // Given
        var expectedData = new Godot.Collections.Dictionary<string, Variant>
        {
            ["type"] = "ground",
            ["variant"] = "grass"
        };

        // When
        var rule = new MockValidPlacementTileRule(expectedData);

        // Then
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### ValidPlacementTileRule_Setup_WithValidState_ShouldSucceed

```csharp
[Test]
    public void ValidPlacementTileRule_Setup_WithValidState_ShouldSucceed()
    {
        // When
        var issues = _rule!.Setup(_targetingState!);

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### ValidPlacementTileRule_ValidatePlacement_WithNoIndicators_ShouldReturnFailure

```csharp
[Test]
    public void ValidPlacementTileRule_ValidatePlacement_WithNoIndicators_ShouldReturnFailure()
    {
        // Given
        _rule!.Setup(_targetingState!);
        // No indicators added

        // When
        var result = _rule.ValidatePlacement();

        // Then
        ;
        ;
        ;
        ;

        // Cleanup
        result.QueueFree();
    }
```

**Returns:** `void`

### ValidPlacementTileRule_ValidatePlacement_WithValidIndicators_ShouldSucceed

```csharp
[Test]
    public void ValidPlacementTileRule_ValidatePlacement_WithValidIndicators_ShouldSucceed()
    {
        // Given
        _rule!.Setup(_targetingState!);
        var validIndicator = new MockRuleCheckIndicator { Valid = true };
        _rule.Indicators.Add(validIndicator);

        // When
        var result = _rule.ValidatePlacement();

        // Then
        ;
        ;
        ;

        // Cleanup
        result.QueueFree();
        validIndicator.QueueFree();
    }
```

**Returns:** `void`

### ValidPlacementTileRule_ValidatePlacement_WithInvalidIndicators_ShouldReturnFailure

```csharp
[Test]
    public void ValidPlacementTileRule_ValidatePlacement_WithInvalidIndicators_ShouldReturnFailure()
    {
        // Given
        _rule!.Setup(_targetingState!);
        var invalidIndicator = new MockRuleCheckIndicator { Valid = false };
        _rule.Indicators.Add(invalidIndicator);

        // When
        var result = _rule.ValidatePlacement();

        // Then
        ;
        ;
        ;
        ;

        // Cleanup
        result.QueueFree();
        invalidIndicator.QueueFree();
    }
```

**Returns:** `void`

### ValidPlacementTileRule_DoesTileHaveValidData_WithNullIndicator_ShouldReturnFalse

```csharp
[Test]
    public void ValidPlacementTileRule_DoesTileHaveValidData_WithNullIndicator_ShouldReturnFalse()
    {
        // Given
        _rule!.Setup(_targetingState!);

        // When
        var result = _rule.DoesTileHaveValidData(null!, _targetingState!.Maps);

        // Then
        ;
    }
```

**Returns:** `void`

### ValidPlacementTileRule_DoesTileHaveValidData_WithInvalidIndicator_ShouldReturnFalse

```csharp
[Test]
    public void ValidPlacementTileRule_DoesTileHaveValidData_WithInvalidIndicator_ShouldReturnFalse()
    {
        // Given
        _rule!.Setup(_targetingState!);
        var invalidIndicator = new MockRuleCheckIndicator { Valid = false };

        // When
        var result = _rule.DoesTileHaveValidData(invalidIndicator, _targetingState!.Maps);

        // Then
        ;

        // Cleanup
        invalidIndicator.QueueFree();
    }
```

**Returns:** `void`

### ValidPlacementTileRule_GetEditorIssues_WithNoExpectedData_ShouldReportIssue

```csharp
[Test]
    public void ValidPlacementTileRule_GetEditorIssues_WithNoExpectedData_ShouldReportIssue()
    {
        // Given
        var rule = new MockValidPlacementTileRule();
        rule.ExpectedTileCustomData.Clear();

        // When
        var issues = rule.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### ValidPlacementTileRule_GetEditorIssues_WithValidData_ShouldReturnEmpty

```csharp
[Test]
    public void ValidPlacementTileRule_GetEditorIssues_WithValidData_ShouldReturnEmpty()
    {
        // Given
        var rule = new MockValidPlacementTileRule();
        rule.ExpectedTileCustomData["type"] = "ground";

        // When
        var issues = rule.GetEditorIssues();

        // Then
        ;
    }
```

**Returns:** `void`

### ValidPlacementTileRule_GetRuntimeIssues_WithNoExpectedData_ShouldReportIssue

```csharp
[Test]
    public void ValidPlacementTileRule_GetRuntimeIssues_WithNoExpectedData_ShouldReportIssue()
    {
        // Given
        var rule = new MockValidPlacementTileRule();
        rule.ExpectedTileCustomData.Clear();

        // When
        var issues = rule.GetRuntimeIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### ValidPlacementTileRule_Settings_ShouldBeLazyInitialized

```csharp
[Test]
    public void ValidPlacementTileRule_Settings_ShouldBeLazyInitialized()
    {
        // Given
        var rule = new MockValidPlacementTileRule();
        ;

        // When
        var settings = rule.EnsureSettings();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### ValidPlacementTileRule_Properties_ShouldBeSettable

```csharp
[Test]
    public void ValidPlacementTileRule_Properties_ShouldBeSettable()
    {
        // Given
        var rule = new MockValidPlacementTileRule();
        var expectedData = new Godot.Collections.Dictionary<string, Variant>
        {
            ["type"] = "water",
            ["depth"] = 2
        };
        var settings = new ValidPlacementTileRuleSettings();

        // When
        rule.ExpectedTileCustomData = expectedData;
        rule.Settings = settings;

        // Then
        ;
        ;
    }
```

**Returns:** `void`

