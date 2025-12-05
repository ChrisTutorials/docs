---
title: "TileCheckRuleTest"
description: "Unit tests for TileCheckRule."
weight: 20
url: "/gridbuilding/v6-0/api/godot/tilecheckruletest/"
---

# TileCheckRuleTest

```csharp
GridBuilding.Godot.Tests.Placement
class TileCheckRuleTest
{
    // Members...
}
```

Unit tests for TileCheckRule.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/TileCheckRuleTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "TileCheckRule Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests tile check rule base functionality";
```


## Methods

### SetUp

```csharp
[SetUp]
    public void SetUp()
    {
        _rule = new MockTileCheckRule();
        _targetingState = new GridTargetingState();
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
    }
```

**Returns:** `void`

### TileCheckRule_Constructor_ShouldCreateValidInstance

```csharp
#endregion

    #region Tests

    [Test]
    public void TileCheckRule_Constructor_ShouldCreateValidInstance()
    {
        // When
        var rule = new MockTileCheckRule();

        // Then
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### TileCheckRule_Setup_WithValidState_ShouldSucceed

```csharp
[Test]
    public void TileCheckRule_Setup_WithValidState_ShouldSucceed()
    {
        // Given
        var rule = new MockTileCheckRule();

        // When
        var issues = rule.Setup(_targetingState!);

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### TileCheckRule_GetFailingIndicators_WithValidIndicators_ShouldReturnCorrectOnes

```csharp
[Test]
    public void TileCheckRule_GetFailingIndicators_WithValidIndicators_ShouldReturnCorrectOnes()
    {
        // Given
        var rule = new MockTileCheckRule();
        var validIndicator = new MockRuleCheckIndicator { Valid = true };
        var invalidIndicator = new MockRuleCheckIndicator { Valid = false };
        rule.Indicators.Add(validIndicator);
        rule.Indicators.Add(invalidIndicator);

        // When
        var failingIndicators = rule.GetFailingIndicators(rule.Indicators);

        // Then
        ;
        ;

        // Cleanup
        validIndicator.QueueFree();
        invalidIndicator.QueueFree();
    }
```

**Returns:** `void`

### TileCheckRule_GetFailingIndicators_WithAllValid_ShouldReturnEmpty

```csharp
[Test]
    public void TileCheckRule_GetFailingIndicators_WithAllValid_ShouldReturnEmpty()
    {
        // Given
        var rule = new MockTileCheckRule();
        var validIndicator1 = new MockRuleCheckIndicator { Valid = true };
        var validIndicator2 = new MockRuleCheckIndicator { Valid = true };
        rule.Indicators.Add(validIndicator1);
        rule.Indicators.Add(validIndicator2);

        // When
        var failingIndicators = rule.GetFailingIndicators(rule.Indicators);

        // Then
        ;

        // Cleanup
        validIndicator1.QueueFree();
        validIndicator2.QueueFree();
    }
```

**Returns:** `void`

### TileCheckRule_GetTilePositions_WithValidTargetMap_ShouldReturnPositions

```csharp
[Test]
    public void TileCheckRule_GetTilePositions_WithValidTargetMap_ShouldReturnPositions()
    {
        // Given
        var rule = new MockTileCheckRule();
        rule.Setup(_targetingState!);
        
        // Setup mock target map
        var targetMap = new TileMapLayer();
        _targetingState!.TargetMap = targetMap;
        
        var indicator1 = new MockRuleCheckIndicator();
        var indicator2 = new MockRuleCheckIndicator();
        rule.Indicators.Add(indicator1);
        rule.Indicators.Add(indicator2);

        // When
        var positions = rule.GetTilePositions();

        // Then
        ;

        // Cleanup
        indicator1.QueueFree();
        indicator2.QueueFree();
        targetMap.QueueFree();
    }
```

**Returns:** `void`

### TileCheckRule_GetTilePositions_WithNullTargetMap_ShouldReturnEmpty

```csharp
[Test]
    public void TileCheckRule_GetTilePositions_WithNullTargetMap_ShouldReturnEmpty()
    {
        // Given
        var rule = new MockTileCheckRule();
        rule.Setup(_targetingState!);
        // TargetMap is null by default

        var indicator = new MockRuleCheckIndicator();
        rule.Indicators.Add(indicator);

        // When
        var positions = rule.GetTilePositions();

        // Then
        ;

        // Cleanup
        indicator.QueueFree();
    }
```

**Returns:** `void`

### TileCheckRule_TearDown_ShouldClearIndicators

```csharp
[Test]
    public void TileCheckRule_TearDown_ShouldClearIndicators()
    {
        // Given
        var rule = new MockTileCheckRule();
        var indicator = new MockRuleCheckIndicator();
        rule.Indicators.Add(indicator);
        rule.Setup(_targetingState!);

        // When
        rule.TearDown();

        // Then
        ;
        ;

        // Cleanup
        indicator.QueueFree();
    }
```

**Returns:** `void`

### TileCheckRule_GetEditorIssues_WithNoMask_ShouldReportIssue

```csharp
[Test]
    public void TileCheckRule_GetEditorIssues_WithNoMask_ShouldReportIssue()
    {
        // Given
        var rule = new MockTileCheckRule();
        rule.ApplyToObjectsMask = 0;

        // When
        var issues = rule.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### TileCheckRule_GetEditorIssues_WithValidMask_ShouldReturnEmpty

```csharp
[Test]
    public void TileCheckRule_GetEditorIssues_WithValidMask_ShouldReturnEmpty()
    {
        // Given
        var rule = new MockTileCheckRule();
        rule.ApplyToObjectsMask = 1;

        // When
        var issues = rule.GetEditorIssues();

        // Then
        ;
    }
```

**Returns:** `void`

### TileCheckRule_Properties_ShouldBeSettable

```csharp
[Test]
    public void TileCheckRule_Properties_ShouldBeSettable()
    {
        // Given
        var rule = new MockTileCheckRule();
        var visualSettings = new IndicatorVisualSettings();

        // When
        rule.ApplyToObjectsMask = 5;
        rule.VisualPriority = 3;
        rule.FailVisualSettings = visualSettings;

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

