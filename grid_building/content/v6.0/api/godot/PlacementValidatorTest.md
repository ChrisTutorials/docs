---
title: "PlacementValidatorTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/placementvalidatortest/"
---

# PlacementValidatorTest

```csharp
GridBuilding.Godot.Tests.Placement
class PlacementValidatorTest
{
    // Members...
}
```

Unit tests for PlacementValidator.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/PlacementValidatorTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "PlacementValidator Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests placement validation system functionality";
```


## Methods

### SetUp

```csharp
[SetUp]
    public void SetUp()
    {
        _container = new MockGBCompositionContainer();
        _logger = new Logger();
        _container.SetLogger(_logger);
        _container.SetPlacementRules(new Godot.Collections.Array<PlacementRule>());

        _validator = PlacementValidator.CreateWithInjection(_container);
    }
```

**Returns:** `void`

### TearDown

```csharp
[TearDown]
    public void TearDown()
    {
        _validator = null;
        _container = null;
        _logger = null;
    }
```

**Returns:** `void`

### PlacementValidator_Creation_WithValidDependencies_ShouldInitializeSuccessfully

```csharp
#endregion

    #region Tests

    [Test]
    public void PlacementValidator_Creation_WithValidDependencies_ShouldInitializeSuccessfully()
    {
        // Given
        var container = new MockGBCompositionContainer();
        var logger = new Logger();
        container.SetLogger(logger);
        container.SetPlacementRules(new Godot.Collections.Array<PlacementRule>());

        // When
        var validator = PlacementValidator.CreateWithInjection(container);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### PlacementValidator_Creation_WithMissingLogger_ShouldReportIssues

```csharp
[Test]
    public void PlacementValidator_Creation_WithMissingLogger_ShouldReportIssues()
    {
        // Given
        var container = new MockGBCompositionContainer();
        // No logger set

        // When
        var validator = PlacementValidator.CreateWithInjection(container);

        // Then
        ;
        var issues = validator.GetRuntimeIssues();
        ;
        ;
    }
```

**Returns:** `void`

### PlacementValidator_ValidatePlacement_WithNoActiveRules_ShouldReturnError

```csharp
[Test]
    public void PlacementValidator_ValidatePlacement_WithNoActiveRules_ShouldReturnError()
    {
        // Given
        // _validator has no active rules by default

        // When
        var results = _validator!.ValidatePlacement();

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### PlacementValidator_Setup_WithValidRules_ShouldSucceed

```csharp
[Test]
    public void PlacementValidator_Setup_WithValidRules_ShouldSucceed()
    {
        // Given
        var rules = new Godot.Collections.Array<PlacementRule>
        {
            new MockPlacementRule()
        };
        var targetingState = new GridTargetingState();

        // When
        var issues = _validator!.Setup(rules, targetingState);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### PlacementValidator_Setup_WithInvalidRules_ShouldReportIssues

```csharp
[Test]
    public void PlacementValidator_Setup_WithInvalidRules_ShouldReportIssues()
    {
        // Given
        var rules = new Godot.Collections.Array<PlacementRule>
        {
            new MockPlacementRule { ShouldFailSetup = true }
        };
        var targetingState = new GridTargetingState();

        // When
        var issues = _validator!.Setup(rules, targetingState);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### PlacementValidator_GetCombinedRules_ShouldCombineCorrectly

```csharp
[Test]
    public void PlacementValidator_GetCombinedRules_ShouldCombineCorrectly()
    {
        // Given
        var baseRules = new Godot.Collections.Array<PlacementRule>
        {
            new MockPlacementRule()
        };
        var outsideRules = new Godot.Collections.Array<PlacementRule>
        {
            new MockPlacementRule()
        };

        // Set up validator with base rules
        var container = new MockGBCompositionContainer();
        container.SetLogger(new Logger());
        container.SetPlacementRules(baseRules);
        var validator = PlacementValidator.CreateWithInjection(container);

        // When
        var combined = validator.GetCombinedRules(outsideRules);

        // Then
        ;
    }
```

**Returns:** `void`

### PlacementValidator_GetCombinedRules_WithIgnoreBase_ShouldIgnoreBase

```csharp
[Test]
    public void PlacementValidator_GetCombinedRules_WithIgnoreBase_ShouldIgnoreBase()
    {
        // Given
        var baseRules = new Godot.Collections.Array<PlacementRule>
        {
            new MockPlacementRule()
        };
        var outsideRules = new Godot.Collections.Array<PlacementRule>
        {
            new MockPlacementRule()
        };

        // Set up validator with base rules
        var container = new MockGBCompositionContainer();
        container.SetLogger(new Logger());
        container.SetPlacementRules(baseRules);
        var validator = PlacementValidator.CreateWithInjection(container);

        // When
        var combined = validator.GetCombinedRules(outsideRules, ignoreBase: true);

        // Then
        ;
    }
```

**Returns:** `void`

### PlacementValidator_TearDown_ShouldClearActiveRules

```csharp
[Test]
    public void PlacementValidator_TearDown_ShouldClearActiveRules()
    {
        // Given
        var rules = new Godot.Collections.Array<PlacementRule>
        {
            new MockPlacementRule()
        };
        var targetingState = new GridTargetingState();
        _validator!.Setup(rules, targetingState);

        // When
        _validator.TearDown();

        // Then
        ;
    }
```

**Returns:** `void`

