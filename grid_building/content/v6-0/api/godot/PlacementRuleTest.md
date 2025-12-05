---
title: "PlacementRuleTest"
description: "Unit tests for PlacementRule."
weight: 20
url: "/gridbuilding/v6-0/api/godot/placementruletest/"
---

# PlacementRuleTest

```csharp
GridBuilding.Godot.Tests.Placement
class PlacementRuleTest
{
    // Members...
}
```

Unit tests for PlacementRule.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/PlacementRuleTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "PlacementRule Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests placement rule base functionality";
```


## Methods

### PlacementRule_Constructor_ShouldCreateValidInstance

```csharp
#endregion

    #region Tests

    [Test]
    public void PlacementRule_Constructor_ShouldCreateValidInstance()
    {
        // When
        var rule = new MockPlacementRule();

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### PlacementRule_Setup_WithValidState_ShouldSucceed

```csharp
[Test]
    public void PlacementRule_Setup_WithValidState_ShouldSucceed()
    {
        // Given
        var rule = new MockPlacementRule();
        var targetingState = new GridTargetingState();

        // When
        var issues = rule.Setup(targetingState);

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### PlacementRule_Setup_WithNullState_ShouldReportIssues

```csharp
[Test]
    public void PlacementRule_Setup_WithNullState_ShouldReportIssues()
    {
        // Given
        var rule = new MockPlacementRule();

        // When
        var issues = rule.Setup(null!);

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### PlacementRule_Setup_CalledTwice_ShouldTearDownFirst

```csharp
[Test]
    public void PlacementRule_Setup_CalledTwice_ShouldTearDownFirst()
    {
        // Given
        var rule = new MockPlacementRule();
        var targetingState = new GridTargetingState();
        rule.Setup(targetingState);

        // When
        var issues = rule.Setup(targetingState);

        // Then
        ;
        ;
        // The rule should have been torn down and set up again
    }
```

**Returns:** `void`

### PlacementRule_ValidatePlacement_WithoutSetup_ShouldReturnVirtualError

```csharp
[Test]
    public void PlacementRule_ValidatePlacement_WithoutSetup_ShouldReturnVirtualError()
    {
        // Given
        var rule = new MockPlacementRule();

        // When
        var result = rule.ValidatePlacement();

        // Then
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### PlacementRule_ValidatePlacement_AfterSetup_ShouldWork

```csharp
[Test]
    public void PlacementRule_ValidatePlacement_AfterSetup_ShouldWork()
    {
        // Given
        var rule = new MockPlacementRule();
        var targetingState = new GridTargetingState();
        rule.Setup(targetingState);

        // When
        var result = rule.ValidatePlacement();

        // Then
        ;
        // Mock rule returns success after setup
    }
```

**Returns:** `void`

### PlacementRule_Apply_ShouldReturnEmptyIssues

```csharp
[Test]
    public void PlacementRule_Apply_ShouldReturnEmptyIssues()
    {
        // Given
        var rule = new MockPlacementRule();

        // When
        var issues = rule.Apply();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### PlacementRule_TearDown_ShouldResetReadyState

```csharp
[Test]
    public void PlacementRule_TearDown_ShouldResetReadyState()
    {
        // Given
        var rule = new MockPlacementRule();
        var targetingState = new GridTargetingState();
        rule.Setup(targetingState);

        // When
        rule.TearDown();

        // Then
        ;
    }
```

**Returns:** `void`

### PlacementRule_GetRuntimeIssues_WithoutSetup_ShouldReportNotReady

```csharp
[Test]
    public void PlacementRule_GetRuntimeIssues_WithoutSetup_ShouldReportNotReady()
    {
        // Given
        var rule = new MockPlacementRule();

        // When
        var issues = rule.GetRuntimeIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### PlacementRule_GetRuntimeIssues_WithSetup_ShouldBeValid

```csharp
[Test]
    public void PlacementRule_GetRuntimeIssues_WithSetup_ShouldBeValid()
    {
        // Given
        var rule = new MockPlacementRule();
        var targetingState = new GridTargetingState();
        rule.Setup(targetingState);

        // When
        var issues = rule.GetRuntimeIssues();

        // Then
        // Should have no issues if targeting state is valid
        // Note: This depends on the targeting state having no issues
    }
```

**Returns:** `void`

### PlacementRule_ToString_ShouldReturnCorrectFormat

```csharp
[Test]
    public void PlacementRule_ToString_ShouldReturnCorrectFormat()
    {
        // Given
        var rule = new MockPlacementRule();
        rule.ResourcePath = "res://test_rule.tres";

        // When
        var result = rule.ToString();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### PlacementRule_GetEditorIssues_ShouldReturnEmptyByDefault

```csharp
[Test]
    public void PlacementRule_GetEditorIssues_ShouldReturnEmptyByDefault()
    {
        // Given
        var rule = new MockPlacementRule();

        // When
        var issues = rule.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

