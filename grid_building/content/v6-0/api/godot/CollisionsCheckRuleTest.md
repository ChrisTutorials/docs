---
title: "CollisionsCheckRuleTest"
description: "Unit tests for CollisionsCheckRule."
weight: 20
url: "/gridbuilding/v6-0/api/godot/collisionscheckruletest/"
---

# CollisionsCheckRuleTest

```csharp
GridBuilding.Godot.Tests.Placement
class CollisionsCheckRuleTest
{
    // Members...
}
```

Unit tests for CollisionsCheckRule.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/CollisionsCheckRuleTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "CollisionsCheckRule Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests collision check rule functionality";
```


## Methods

### SetUp

```csharp
[SetUp]
    public void SetUp()
    {
        _rule = new MockCollisionsCheckRule();
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

### CollisionsCheckRule_Constructor_ShouldCreateValidInstance

```csharp
#endregion

    #region Tests

    [Test]
    public void CollisionsCheckRule_Constructor_ShouldCreateValidInstance()
    {
        // When
        var rule = new MockCollisionsCheckRule();

        // Then
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CollisionsCheckRule_Setup_WithValidState_ShouldSucceed

```csharp
[Test]
    public void CollisionsCheckRule_Setup_WithValidState_ShouldSucceed()
    {
        // Given
        var rule = new MockCollisionsCheckRule();

        // When
        var issues = rule.Setup(_targetingState!);

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CollisionsCheckRule_ValidatePlacement_WithNoIndicators_ShouldReturnFailure

```csharp
[Test]
    public void CollisionsCheckRule_ValidatePlacement_WithNoIndicators_ShouldReturnFailure()
    {
        // Given
        var rule = new MockCollisionsCheckRule();
        rule.Setup(_targetingState!);
        // No indicators added

        // When
        var result = rule.ValidatePlacement();

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

### CollisionsCheckRule_ValidatePlacement_WithAllValidIndicators_ShouldSucceed

```csharp
[Test]
    public void CollisionsCheckRule_ValidatePlacement_WithAllValidIndicators_ShouldSucceed()
    {
        // Given
        var rule = new MockCollisionsCheckRule();
        rule.Setup(_targetingState!);
        
        var validIndicator1 = new MockRuleCheckIndicator { Valid = true };
        var validIndicator2 = new MockRuleCheckIndicator { Valid = true };
        rule.Indicators.Add(validIndicator1);
        rule.Indicators.Add(validIndicator2);

        // When
        var result = rule.ValidatePlacement();

        // Then
        ;
        ;
        ;
        ;

        // Cleanup
        result.QueueFree();
        validIndicator1.QueueFree();
        validIndicator2.QueueFree();
    }
```

**Returns:** `void`

### CollisionsCheckRule_ValidatePlacement_WithFailingIndicators_ShouldReturnFailure

```csharp
[Test]
    public void CollisionsCheckRule_ValidatePlacement_WithFailingIndicators_ShouldReturnFailure()
    {
        // Given
        var rule = new MockCollisionsCheckRule();
        rule.Setup(_targetingState!);
        
        var validIndicator = new MockRuleCheckIndicator { Valid = true };
        var invalidIndicator = new MockRuleCheckIndicator { Valid = false };
        rule.Indicators.Add(validIndicator);
        rule.Indicators.Add(invalidIndicator);

        // When
        var result = rule.ValidatePlacement();

        // Then
        ;
        ;
        ;
        ;
        ;

        // Cleanup
        result.QueueFree();
        validIndicator.QueueFree();
        invalidIndicator.QueueFree();
    }
```

**Returns:** `void`

### CollisionsCheckRule_ValidatePlacement_WithPassOnCollisionTrue_ShouldUseCorrectMessages

```csharp
[Test]
    public void CollisionsCheckRule_ValidatePlacement_WithPassOnCollisionTrue_ShouldUseCorrectMessages()
    {
        // Given
        var rule = new MockCollisionsCheckRule();
        rule.PassOnCollision = true;
        rule.Setup(_targetingState!);
        
        var invalidIndicator = new MockRuleCheckIndicator { Valid = false };
        rule.Indicators.Add(invalidIndicator);

        // When
        var result = rule.ValidatePlacement();

        // Then
        ;
        ;
        ;

        // Cleanup
        result.QueueFree();
        invalidIndicator.QueueFree();
    }
```

**Returns:** `void`

### CollisionsCheckRule_ValidatePlacement_WithPrependResourceName_ShouldIncludeResourceName

```csharp
[Test]
    public void CollisionsCheckRule_ValidatePlacement_WithPrependResourceName_ShouldIncludeResourceName()
    {
        // Given
        var rule = new MockCollisionsCheckRule();
        rule.Setup(_targetingState!);
        rule.Messages!.PrependResourceName = true;
        rule.ResourceName = "TestRule";
        
        var invalidIndicator = new MockRuleCheckIndicator { Valid = false };
        rule.Indicators.Add(invalidIndicator);

        // When
        var result = rule.ValidatePlacement();

        // Then
        ;
        ;
        ;

        // Cleanup
        result.QueueFree();
        invalidIndicator.QueueFree();
    }
```

**Returns:** `void`

### CollisionsCheckRule_TearDown_ShouldDisconnectFromTargetingState

```csharp
[Test]
    public void CollisionsCheckRule_TearDown_ShouldDisconnectFromTargetingState()
    {
        // Given
        var rule = new MockCollisionsCheckRule();
        rule.Setup(_targetingState!);

        // When
        rule.TearDown();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### CollisionsCheckRule_Properties_ShouldBeSettable

```csharp
[Test]
    public void CollisionsCheckRule_Properties_ShouldBeSettable()
    {
        // Given
        var rule = new MockCollisionsCheckRule();
        var messages = new CollisionRuleSettings();

        // When
        rule.PassOnCollision = true;
        rule.CollisionMask = 7;
        rule.Messages = messages;

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CollisionsCheckRule_Messages_ShouldHaveDefaults

```csharp
[Test]
    public void CollisionsCheckRule_Messages_ShouldHaveDefaults()
    {
        // Given
        var rule = new MockCollisionsCheckRule();

        // When
        var messages = rule.Messages;

        // Then
        ;
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CollisionsCheckRule_GetFailingIndicators_ShouldWorkCorrectly

```csharp
[Test]
    public void CollisionsCheckRule_GetFailingIndicators_ShouldWorkCorrectly()
    {
        // Given
        var rule = new MockCollisionsCheckRule();
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

