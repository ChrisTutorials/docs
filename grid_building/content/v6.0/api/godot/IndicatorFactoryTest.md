---
title: "IndicatorFactoryTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/indicatorfactorytest/"
---

# IndicatorFactoryTest

```csharp
GridBuilding.Godot.Tests.Placement
class IndicatorFactoryTest
{
    // Members...
}
```

Unit tests for IndicatorFactory.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/IndicatorFactoryTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "IndicatorFactory Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests indicator factory static methods and indicator creation";
```


## Methods

### IndicatorFactory_CreateIndicator_WithNullTemplate_ShouldReturnNull

```csharp
#endregion

    #region Tests

    [Test]
    public void IndicatorFactory_CreateIndicator_WithNullTemplate_ShouldReturnNull()
    {
        // Given
        var position = new Vector2I(1, 1);
        var rules = new Godot.Collections.Array<TileCheckRule>();
        var parentNode = new Node();
        var logger = new Logger();

        // When
        var indicator = IndicatorFactory.CreateIndicator(position, rules, null!, parentNode, logger);

        // Then
        ;

        // Cleanup
        parentNode.QueueFree();
    }
```

**Returns:** `void`

### IndicatorFactory_CreateIndicator_WithNullParent_ShouldReturnNull

```csharp
[Test]
    public void IndicatorFactory_CreateIndicator_WithNullParent_ShouldReturnNull()
    {
        // Given
        var position = new Vector2I(1, 1);
        var rules = new Godot.Collections.Array<TileCheckRule>();
        var template = new PackedScene();
        var logger = new Logger();

        // When
        var indicator = IndicatorFactory.CreateIndicator(position, rules, template, null!, logger);

        // Then
        ;
    }
```

**Returns:** `void`

### IndicatorFactory_CreateIndicator_WithValidParameters_ShouldCreateIndicator

```csharp
[Test]
    public void IndicatorFactory_CreateIndicator_WithValidParameters_ShouldCreateIndicator()
    {
        // Given
        var position = new Vector2I(1, 1);
        var rules = new Godot.Collections.Array<TileCheckRule>
        {
            new TileCheckRule()
        };
        var template = new PackedScene();
        var parentNode = new Node();
        var logger = new Logger();

        // When
        var indicator = IndicatorFactory.CreateIndicator(position, rules, template, parentNode, logger);

        // Then
        // Note: This will likely return null because the template doesn't contain a RuleCheckIndicator
        // In a real test, you'd create a proper template scene
        ; // Expected due to empty template

        // Cleanup
        parentNode.QueueFree();
    }
```

**Returns:** `void`

### IndicatorFactory_GenerateIndicators_WithEmptyMap_ShouldReturnEmptyArray

```csharp
[Test]
    public void IndicatorFactory_GenerateIndicators_WithEmptyMap_ShouldReturnEmptyArray()
    {
        // Given
        var positionRulesMap = new Godot.Collections.Dictionary<Vector2I, Godot.Collections.Array>();
        var template = new PackedScene();
        var parentNode = new Node2D();
        var targetingState = new GridTargetingState();
        var testObject = new Node2D();
        var logger = new Logger();

        // When
        var indicators = IndicatorFactory.GenerateIndicators(
            positionRulesMap, template, parentNode, targetingState, testObject, logger
        );

        // Then
        ;
        ;

        // Cleanup
        parentNode.QueueFree();
        testObject.QueueFree();
    }
```

**Returns:** `void`

### IndicatorFactory_GenerateIndicators_WithValidMap_ShouldCreateIndicators

```csharp
[Test]
    public void IndicatorFactory_GenerateIndicators_WithValidMap_ShouldCreateIndicators()
    {
        // Given
        var positionRulesMap = new Godot.Collections.Dictionary<Vector2I, Godot.Collections.Array>
        {
            [new Vector2I(1, 1)] = new Godot.Collections.Array { new TileCheckRule() }
        };
        var template = new PackedScene();
        var parentNode = new Node2D();
        var targetingState = new GridTargetingState();
        var testObject = new Node2D();
        var logger = new Logger();

        // When
        var indicators = IndicatorFactory.GenerateIndicators(
            positionRulesMap, template, parentNode, targetingState, testObject, logger
        );

        // Then
        // Note: This will likely return empty because the template doesn't contain a RuleCheckIndicator
        // In a real test, you'd create a proper template scene
        ;
        ; // Expected due to empty template

        // Cleanup
        parentNode.QueueFree();
        testObject.QueueFree();
    }
```

**Returns:** `void`

### IndicatorFactory_GenerateIndicators_WithTargetingState_ShouldPositionCorrectly

```csharp
[Test]
    public void IndicatorFactory_GenerateIndicators_WithTargetingState_ShouldPositionCorrectly()
    {
        // Given
        var positionRulesMap = new Godot.Collections.Dictionary<Vector2I, Godot.Collections.Array>
        {
            [new Vector2I(1, 1)] = new Godot.Collections.Array { new TileCheckRule() }
        };
        var template = new PackedScene();
        var parentNode = new Node2D();
        var targetingState = new MockGridTargetingState();
        var testObject = new Node2D();
        var logger = new Logger();

        // Setup mock targeting state
        targetingState.SetupMockTargetMap();

        // When
        var indicators = IndicatorFactory.GenerateIndicators(
            positionRulesMap, template, parentNode, targetingState, testObject, logger
        );

        // Then
        ;
        // Note: Positioning logic would be tested with a proper template

        // Cleanup
        parentNode.QueueFree();
        testObject.QueueFree();
    }
```

**Returns:** `void`

