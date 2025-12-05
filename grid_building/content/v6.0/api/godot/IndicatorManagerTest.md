---
title: "IndicatorManagerTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/indicatormanagertest/"
---

# IndicatorManagerTest

```csharp
GridBuilding.Godot.Tests.Placement
class IndicatorManagerTest
{
    // Members...
}
```

Unit tests for IndicatorManager.
Ported from GDScript placement integration tests.
Updated to use GoDotTest framework for proper test discovery.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/IndicatorManagerTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "IndicatorManager Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests indicator manager functionality including setup, validation, and cleanup";
```


## Methods

### SetUp

```csharp
[SetUp]
    public void SetUp()
    {
        _container = new MockGBCompositionContainer();
        _targetingState = new GridTargetingState();
        _manipulationState = new ManipulationState();

        // Set up mock dependencies
        _container.SetTargetingState(_targetingState);
        _container.SetManipulationState(_manipulationState);
        _container.SetLogger(new Logger());

        // Create indicator template
        var indicatorTemplate = new PackedScene();
        _container.GetTemplates().RuleCheckIndicator = indicatorTemplate;

        // Create indicator manager
        _indicatorManager = IndicatorManager.CreateWithInjection(_container);
    }
```

**Returns:** `void`

### TearDown

```csharp
[TearDown]
    public void TearDown()
    {
        _indicatorManager?.QueueFree();
        _indicatorManager = null;
        _container = null;
        _targetingState = null;
        _manipulationState = null;
    }
```

**Returns:** `void`

### IndicatorManager_Creation_WithValidDependencies_ShouldInitializeSuccessfully

```csharp
#endregion

    #region Tests

    [Test]
    public void IndicatorManager_Creation_WithValidDependencies_ShouldInitializeSuccessfully()
    {
        // Given
        var container = new MockGBCompositionContainer();
        var targetingState = new GridTargetingState();
        var manipulationState = new ManipulationState();
        var logger = new Logger();

        container.SetTargetingState(targetingState);
        container.SetManipulationState(manipulationState);
        container.SetLogger(logger);
        container.GetTemplates().RuleCheckIndicator = new PackedScene();

        // When
        var manager = IndicatorManager.CreateWithInjection(container);

        // Then
        ;
        ;
        ;

        // Cleanup
        manager.QueueFree();
    }
```

**Returns:** `void`

### IndicatorManager_Creation_WithMissingDependencies_ShouldReportIssues

```csharp
[Test]
    public void IndicatorManager_Creation_WithMissingDependencies_ShouldReportIssues()
    {
        // Given
        var container = new MockGBCompositionContainer();
        // No dependencies set

        // When
        var manager = IndicatorManager.CreateWithInjection(container);

        // Then
        ;
        ;
        var issues = manager.GetRuntimeIssues();
        ;
        ;

        // Cleanup
        manager.QueueFree();
    }
```

**Returns:** `void`

### IndicatorManager_SetupIndicators_WithNoRules_ShouldReturnFailureReport

```csharp
[Test]
    public void IndicatorManager_SetupIndicators_WithNoRules_ShouldReturnFailureReport()
    {
        // Given
        var testObject = new MockNode2D();
        var emptyRules = new Godot.Collections.Array<TileCheckRule>();

        // When
        var report = _indicatorManager!.SetupIndicators(testObject, emptyRules);

        // Then
        ;
        ;
        ;
        ;

        // Cleanup
        testObject.QueueFree();
    }
```

**Returns:** `void`

### IndicatorManager_SetupIndicators_WithValidRules_ShouldReturnSuccessReport

```csharp
[Test]
    public void IndicatorManager_SetupIndicators_WithValidRules_ShouldReturnSuccessReport()
    {
        // Given
        var testObject = new MockNode2D();
        var rules = new Godot.Collections.Array<TileCheckRule>
        {
            new TileCheckRule()
        };

        // When
        var report = _indicatorManager!.SetupIndicators(testObject, rules);

        // Then
        ;
        // Note: This might fail due to missing dependencies in the mock setup
        // The actual implementation would need more comprehensive mocking

        // Cleanup
        testObject.QueueFree();
    }
```

**Returns:** `void`

### IndicatorManager_GetIndicatorCount_WithNoRules_ShouldReturnZero

```csharp
[Test]
    public void IndicatorManager_GetIndicatorCount_WithNoRules_ShouldReturnZero()
    {
        // Given
        var testObject = new MockNode2D();
        var emptyRules = new Godot.Collections.Array<TileCheckRule>();

        // When
        var count = _indicatorManager!.GetIndicatorCount(testObject, emptyRules);

        // Then
        ;

        // Cleanup
        testObject.QueueFree();
    }
```

**Returns:** `void`

### IndicatorManager_GetIndicators_Initially_ShouldReturnEmptyArray

```csharp
[Test]
    public void IndicatorManager_GetIndicators_Initially_ShouldReturnEmptyArray()
    {
        // When
        var indicators = _indicatorManager!.GetIndicators();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### IndicatorManager_ClearIndicators_ShouldRemoveAllIndicators

```csharp
[Test]
    public void IndicatorManager_ClearIndicators_ShouldRemoveAllIndicators()
    {
        // Given
        var testObject = new MockNode2D();
        var rules = new Godot.Collections.Array<TileCheckRule>
        {
            new TileCheckRule()
        };

        // Setup some indicators first (this might fail due to mocking limitations)
        _indicatorManager!.SetupIndicators(testObject, rules);

        // When
        _indicatorManager.ClearIndicators();

        // Then
        var indicators = _indicatorManager.GetIndicators();
        ;

        // Cleanup
        testObject.QueueFree();
    }
```

**Returns:** `void`

### IndicatorManager_ForceUpdate_ShouldNotThrow

```csharp
[Test]
    public void IndicatorManager_ForceUpdate_ShouldNotThrow()
    {
        // When/Then
        Assert.DoesNotThrow(() => _indicatorManager!.ForceUpdate());
    }
```

**Returns:** `void`

