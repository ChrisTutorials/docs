---
title: "SpendMaterialsRuleGenericTest"
description: "Unit tests for SpendMaterialsRuleGeneric."
weight: 20
url: "/gridbuilding/v6-0/api/godot/spendmaterialsrulegenerictest/"
---

# SpendMaterialsRuleGenericTest

```csharp
GridBuilding.Godot.Tests.Placement
class SpendMaterialsRuleGenericTest
{
    // Members...
}
```

Unit tests for SpendMaterialsRuleGeneric.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/SpendMaterialsRuleGenericTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "SpendMaterialsRuleGeneric Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests spend materials rule generic functionality";
```


## Methods

### SetUp

```csharp
[SetUp]
    public void SetUp()
    {
        _rule = new MockSpendMaterialsRuleGeneric();
        _targetingState = new GridTargetingState();
        _mockContainer = new MockMaterialContainer();
        _mockOwner = new Node();
        _targetingState.OwnerRoot = _mockOwner;
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
        _mockContainer?.QueueFree();
        _mockContainer = null;
        _mockOwner?.QueueFree();
        _mockOwner = null;
    }
```

**Returns:** `void`

### SpendMaterialsRuleGeneric_Constructor_ShouldCreateValidInstance

```csharp
#endregion

    #region Tests

    [Test]
    public void SpendMaterialsRuleGeneric_Constructor_ShouldCreateValidInstance()
    {
        // Given
        var resourceStacks = new Godot.Collections.Array<ResourceStack>
        {
            new ResourceStack(new Resource(), 5)
        };
        var locator = new NodeLocator(NodeLocator.SearchMethod.NodeName, "Inventory");

        // When
        var rule = new MockSpendMaterialsRuleGeneric(resourceStacks, locator);

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### SpendMaterialsRuleGeneric_Setup_WithValidState_ShouldSucceed

```csharp
[Test]
    public void SpendMaterialsRuleGeneric_Setup_WithValidState_ShouldSucceed()
    {
        // Given
        _rule!.Locator = new MockNodeLocator(_mockContainer!);

        // When
        var issues = _rule.Setup(_targetingState!);

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### SpendMaterialsRuleGeneric_ValidatePlacement_WithNoContainer_ShouldReturnFailure

```csharp
[Test]
    public void SpendMaterialsRuleGeneric_ValidatePlacement_WithNoContainer_ShouldReturnFailure()
    {
        // Given
        _rule!.Setup(_targetingState!);
        // No material container found

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

### SpendMaterialsRuleGeneric_ValidatePlacement_WithEnoughResources_ShouldSucceed

```csharp
[Test]
    public void SpendMaterialsRuleGeneric_ValidatePlacement_WithEnoughResources_ShouldSucceed()
    {
        // Given
        _rule!.Locator = new MockNodeLocator(_mockContainer!);
        _rule.Setup(_targetingState!);
        
        var resource = new Resource();
        _rule.ResourceStacksToSpend.Add(new ResourceStack(resource, 5));
        _mockContainer!.SetResourceCount(resource, 10); // Enough resources

        // When
        var result = _rule.ValidatePlacement();

        // Then
        ;
        ;
        ;

        // Cleanup
        resource.QueueFree();
        result.QueueFree();
    }
```

**Returns:** `void`

### SpendMaterialsRuleGeneric_ValidatePlacement_WithInsufficientResources_ShouldReturnFailure

```csharp
[Test]
    public void SpendMaterialsRuleGeneric_ValidatePlacement_WithInsufficientResources_ShouldReturnFailure()
    {
        // Given
        _rule!.Locator = new MockNodeLocator(_mockContainer!);
        _rule.Setup(_targetingState!);
        
        var resource = new Resource();
        _rule.ResourceStacksToSpend.Add(new ResourceStack(resource, 10));
        _mockContainer!.SetResourceCount(resource, 5); // Not enough resources

        // When
        var result = _rule.ValidatePlacement();

        // Then
        ;
        ;
        ;
        ;

        // Cleanup
        resource.QueueFree();
        result.QueueFree();
    }
```

**Returns:** `void`

### SpendMaterialsRuleGeneric_Apply_WithNoContainer_ShouldReturnFailure

```csharp
[Test]
    public void SpendMaterialsRuleGeneric_Apply_WithNoContainer_ShouldReturnFailure()
    {
        // Given
        _rule!.Setup(_targetingState!);
        // No material container found

        // When
        var issues = _rule.Apply();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### SpendMaterialsRuleGeneric_Apply_WithValidContainer_ShouldSucceed

```csharp
[Test]
    public void SpendMaterialsRuleGeneric_Apply_WithValidContainer_ShouldSucceed()
    {
        // Given
        _rule!.Locator = new MockNodeLocator(_mockContainer!);
        _rule.Setup(_targetingState!);
        
        var resource = new Resource();
        _rule.ResourceStacksToSpend.Add(new ResourceStack(resource, 5));
        _mockContainer!.SetResourceCount(resource, 10); // Enough resources

        // When
        var issues = _rule.Apply();

        // Then
        ;
        ; // 10 - 5 = 5 remaining

        // Cleanup
        resource.QueueFree();
    }
```

**Returns:** `void`

### SpendMaterialsRuleGeneric_Apply_WithInsufficientResources_ShouldReturnFailure

```csharp
[Test]
    public void SpendMaterialsRuleGeneric_Apply_WithInsufficientResources_ShouldReturnFailure()
    {
        // Given
        _rule!.Locator = new MockNodeLocator(_mockContainer!);
        _rule.Setup(_targetingState!);
        
        var resource = new Resource();
        _rule.ResourceStacksToSpend.Add(new ResourceStack(resource, 10));
        _mockContainer!.SetResourceCount(resource, 5); // Not enough resources

        // When
        var issues = _rule.Apply();

        // Then
        ;
        ;

        // Cleanup
        resource.QueueFree();
    }
```

**Returns:** `void`

### SpendMaterialsRuleGeneric_GetEditorIssues_WithNoResources_ShouldReportIssue

```csharp
[Test]
    public void SpendMaterialsRuleGeneric_GetEditorIssues_WithNoResources_ShouldReportIssue()
    {
        // Given
        var rule = new MockSpendMaterialsRuleGeneric();
        rule.ResourceStacksToSpend.Clear();

        // When
        var issues = rule.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### SpendMaterialsRuleGeneric_GetEditorIssues_WithNullResourceType_ShouldReportIssue

```csharp
[Test]
    public void SpendMaterialsRuleGeneric_GetEditorIssues_WithNullResourceType_ShouldReportIssue()
    {
        // Given
        var rule = new MockSpendMaterialsRuleGeneric();
        rule.ResourceStacksToSpend.Add(new ResourceStack(null!, 5));

        // When
        var issues = rule.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### SpendMaterialsRuleGeneric_GetRuntimeIssues_WithNoContainer_ShouldReportIssue

```csharp
[Test]
    public void SpendMaterialsRuleGeneric_GetRuntimeIssues_WithNoContainer_ShouldReportIssue()
    {
        // Given
        _rule!.Setup(_targetingState!);
        // No material container found

        // When
        var issues = _rule.GetRuntimeIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### SpendMaterialsRuleGeneric_Properties_ShouldBeSettable

```csharp
[Test]
    public void SpendMaterialsRuleGeneric_Properties_ShouldBeSettable()
    {
        // Given
        var rule = new MockSpendMaterialsRuleGeneric();
        var resourceStacks = new Godot.Collections.Array<ResourceStack>
        {
            new ResourceStack(new Resource(), 3)
        };
        var locator = new NodeLocator(NodeLocator.SearchMethod.ScriptNameWithExtension, "Inventory.gd");

        // When
        rule.ResourceStacksToSpend = resourceStacks;
        rule.Locator = locator;

        // Then
        ;
        ;
    }
```

**Returns:** `void`

