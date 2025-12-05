---
title: "WithinTilemapBoundsRuleTest"
description: "Unit tests for WithinTilemapBoundsRule."
weight: 20
url: "/gridbuilding/v6-0/api/godot/withintilemapboundsruletest/"
---

# WithinTilemapBoundsRuleTest

```csharp
GridBuilding.Godot.Tests.Placement
class WithinTilemapBoundsRuleTest
{
    // Members...
}
```

Unit tests for WithinTilemapBoundsRule.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/WithinTilemapBoundsRuleTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "WithinTilemapBoundsRule Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests within tilemap bounds rule functionality";
```


## Methods

### SetUp

```csharp
[SetUp]
    public void SetUp()
    {
        _rule = new MockWithinTilemapBoundsRule();
        _targetingState = new GridTargetingState();
        _mockMap = new TileMapLayer();
        _targetingState.TargetMap = _mockMap;
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

### WithinTilemapBoundsRule_Constructor_ShouldCreateValidInstance

```csharp
#endregion

    #region Tests

    [Test]
    public void WithinTilemapBoundsRule_Constructor_ShouldCreateValidInstance()
    {
        // When
        var rule = new MockWithinTilemapBoundsRule();

        // Then
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### WithinTilemapBoundsRule_Setup_WithValidState_ShouldSucceed

```csharp
[Test]
    public void WithinTilemapBoundsRule_Setup_WithValidState_ShouldSucceed()
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

### WithinTilemapBoundsRule_ValidatePlacement_WithNoIndicators_ShouldReturnFailure

```csharp
[Test]
    public void WithinTilemapBoundsRule_ValidatePlacement_WithNoIndicators_ShouldReturnFailure()
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

### WithinTilemapBoundsRule_ValidatePlacement_WithValidIndicators_ShouldSucceed

```csharp
[Test]
    public void WithinTilemapBoundsRule_ValidatePlacement_WithValidIndicators_ShouldSucceed()
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

### WithinTilemapBoundsRule_ValidatePlacement_WithInvalidIndicators_ShouldReturnFailure

```csharp
[Test]
    public void WithinTilemapBoundsRule_ValidatePlacement_WithInvalidIndicators_ShouldReturnFailure()
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

### WithinTilemapBoundsRule_GetFailingIndicators_WithNullTargetMap_ShouldReturnAll

```csharp
[Test]
    public void WithinTilemapBoundsRule_GetFailingIndicators_WithNullTargetMap_ShouldReturnAll()
    {
        // Given
        _rule!.Setup(_targetingState!);
        _targetingState!.TargetMap = null;
        var indicator1 = new MockRuleCheckIndicator { Valid = true };
        var indicator2 = new MockRuleCheckIndicator { Valid = false };
        _rule.Indicators.Add(indicator1);
        _rule.Indicators.Add(indicator2);

        // When
        var failingIndicators = _rule.GetFailingIndicators(_rule.Indicators);

        // Then
        ;

        // Cleanup
        indicator1.QueueFree();
        indicator2.QueueFree();
    }
```

**Returns:** `void`

### WithinTilemapBoundsRule_GetFailingIndicators_WithValidTargetMap_ShouldFilterCorrectly

```csharp
[Test]
    public void WithinTilemapBoundsRule_GetFailingIndicators_WithValidTargetMap_ShouldFilterCorrectly()
    {
        // Given
        _rule!.Setup(_targetingState!);
        var validIndicator = new MockRuleCheckIndicator { Valid = true };
        var invalidIndicator = new MockRuleCheckIndicator { Valid = false };
        _rule.Indicators.Add(validIndicator);
        _rule.Indicators.Add(invalidIndicator);

        // When
        var failingIndicators = _rule.GetFailingIndicators(_rule.Indicators);

        // Then
        ;
        ;

        // Cleanup
        validIndicator.QueueFree();
        invalidIndicator.QueueFree();
    }
```

**Returns:** `void`

### WithinTilemapBoundsRule_GetFailingIndicators_WithNullIndicator_ShouldSkip

```csharp
[Test]
    public void WithinTilemapBoundsRule_GetFailingIndicators_WithNullIndicator_ShouldSkip()
    {
        // Given
        _rule!.Setup(_targetingState!);
        var validIndicator = new MockRuleCheckIndicator { Valid = true };
        _rule.Indicators.Add(validIndicator);
        _rule.Indicators.Add(null!); // Add null indicator

        // When
        var failingIndicators = _rule.GetFailingIndicators(_rule.Indicators);

        // Then
        ; // Should skip null indicator

        // Cleanup
        validIndicator.QueueFree();
    }
```

**Returns:** `void`

### WithinTilemapBoundsRule_Properties_ShouldBeSettable

```csharp
[Test]
    public void WithinTilemapBoundsRule_Properties_ShouldBeSettable()
    {
        // Given
        var rule = new MockWithinTilemapBoundsRule();

        // When
        rule.SuccessMessage = "Custom success";
        rule.FailedMessage = "Custom failure";
        rule.NoIndicatorsMessage = "Custom no indicators";
        rule.EnableDebugDiagnostics = true;

        // Then
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### WithinTilemapBoundsRule_DebugDiagnostics_ShouldNotThrow

```csharp
[Test]
    public void WithinTilemapBoundsRule_DebugDiagnostics_ShouldNotThrow()
    {
        // Given
        var rule = new MockWithinTilemapBoundsRule();
        rule.EnableDebugDiagnostics = true;

        // When/Then - Should not throw
        Assert.DoesNotThrow(() => rule.DebugDiagnostic("Test message"));
    }
```

**Returns:** `void`

### WithinTilemapBoundsRule_FilterCriticalIndicatorIssues_ShouldWorkCorrectly

```csharp
[Test]
    public void WithinTilemapBoundsRule_FilterCriticalIndicatorIssues_ShouldWorkCorrectly()
    {
        // Given
        var rule = new MockWithinTilemapBoundsRule();
        var issues = new Godot.Collections.Array<string>
        {
            "valid_settings", // Non-critical
            "Logger not resolved", // Non-critical
            "Critical error", // Critical
            "Another critical issue" // Critical
        };

        // When
        var criticalIssues = rule.FilterCriticalIndicatorIssues(issues);

        // Then
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### WithinTilemapBoundsRule_IsCriticalIndicatorIssue_ShouldWorkCorrectly

```csharp
[Test]
    public void WithinTilemapBoundsRule_IsCriticalIndicatorIssue_ShouldWorkCorrectly()
    {
        // Given
        var rule = new MockWithinTilemapBoundsRule();

        // When/Then
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

