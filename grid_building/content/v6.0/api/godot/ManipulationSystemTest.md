---
title: "ManipulationSystemTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/manipulationsystemtest/"
---

# ManipulationSystemTest

```csharp
GridBuilding.Godot.Tests.Manipulation
class ManipulationSystemTest
{
    // Members...
}
```

Integration tests for ManipulationSystemNode with new DI pattern.
Migrated from GB injector to CompositionContainer pattern and GoDotTest framework.
Score: 3/10 - Heavy Godot scene tree integration, requires Godot runtime.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ManipulationSystemTestUpdated.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetUp

```csharp
[SetUp]
    public void SetUp()
    {
        // Create service registry and container
        _registry = new TestServiceRegistry();
        _container = new CompositionContainer(_registry);
        
        // Create test node with manipulatable component
        _testNode = new MockNode2D();
        _testNode.Name = "TestNode";
        AddChild(_testNode);
        
        _testManipulatable = new Manipulatable();
        _testManipulatable.Root = _testNode;
        _testNode.AddChild(_testManipulatable);
        
        // Create manipulation system with new DI
        _manipulationSystem = new ManipulationSystem();
        _manipulationSystem.InjectDependencies(_container);
        
        // Add to scene tree
        AddChild(_manipulationSystem);
    }
```

**Returns:** `void`

### TearDown

```csharp
[TearDown]
    public void TearDown()
    {
        _manipulationSystem?.QueueFree();
        _testNode?.QueueFree();
        _manipulationSystem = null;
        _container = null;
        _registry = null;
        _testNode = null;
        _testManipulatable = null;
    }
```

**Returns:** `void`

### ManipulationSystem_CreateWithNewDI_ValidDependencies_CreatesSuccessfully

```csharp
#region Tests

    [Test]
    public void ManipulationSystem_CreateWithNewDI_ValidDependencies_CreatesSuccessfully()
    {
        // Given
        var system = new ManipulationSystem();
        
        // When
        system.InjectDependencies(_container);
        
        // Then
        ;
        var validation = system.ValidateDependencies(_container);
        ;
        ;
    }
```

**Returns:** `void`

### ManipulationSystem_TryMove_ValidManipulatable_ReturnsSuccessData

```csharp
[Test]
    public void ManipulationSystem_TryMove_ValidManipulatable_ReturnsSuccessData()
    {
        // Act
        var result = _manipulationSystem?.TryMove(_testNode);
        
        // Then
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### ManipulationSystem_TryMove_NullNode_ReturnsFailureData

```csharp
[Test]
    public void ManipulationSystem_TryMove_NullNode_ReturnsFailureData()
    {
        // Act
        var result = _manipulationSystem?.TryMove(null);
        
        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### ManipulationSystem_GetRuntimeIssues_ValidDependencies_NoIssues

```csharp
[Test]
    public void ManipulationSystem_GetRuntimeIssues_ValidDependencies_NoIssues()
    {
        // Act
        var issues = _manipulationSystem?.GetRuntimeIssues();
        
        // Then
        ;
        ;
    }
```

**Returns:** `void`

### ManipulationSystem_InjectDependencies_WithNullContainer_ShouldReportIssues

```csharp
[Test]
    public void ManipulationSystem_InjectDependencies_WithNullContainer_ShouldReportIssues()
    {
        // Given
        var system = new ManipulationSystem();
        
        // When
        system.InjectDependencies(null!);
        
        // Then
        var validation = system.ValidateDependencies(null!);
        ;
        ;
    }
```

**Returns:** `void`

### ManipulationData_CreateWithValidParameters_CreatesSuccessfully

```csharp
[Test]
    public void ManipulationData_CreateWithValidParameters_CreatesSuccessfully()
    {
        // Arrange
        var mockManipulator = new MockNode2D();
        var mockSource = new MockNode2D();
        var manipulatable = new Manipulatable();
        manipulatable.Root = mockSource;
        
        // Act
        var data = new ManipulationData(mockManipulator, manipulatable, null, ManipulationAction.MOVE);
        
        // Then
        ;
        ;
        ;
        ;
        ;
        
        // Cleanup
        mockManipulator.QueueFree();
        mockSource.QueueFree();
    }
```

**Returns:** `void`

### ManipulationSystem_NodeLifecycle_WithSceneTree_ShouldHandleEvents

```csharp
[Test]
    public void ManipulationSystem_NodeLifecycle_WithSceneTree_ShouldHandleEvents()
    {
        // Given
        var system = new ManipulationSystem();
        AddChild(system);
        
        // When/Then - Test Node lifecycle
        ;
        
        // Cleanup
        system.QueueFree();
    }
```

**Returns:** `void`

### ManipulationSystem_Setup_WithValidDependencies_ShouldSucceed

```csharp
[Test]
    public void ManipulationSystem_Setup_WithValidDependencies_ShouldSucceed()
    {
        // Given
        var system = new ManipulationSystem();
        
        // When
        var result = system.Setup(_container);
        
        // Then
        ;
        ;
        
        // Cleanup
        system.QueueFree();
    }
```

**Returns:** `void`

### ManipulationSystem_TearDown_ShouldResetState

```csharp
[Test]
    public void ManipulationSystem_TearDown_ShouldResetState()
    {
        // Given
        var system = new ManipulationSystem();
        system.Setup(_container);
        ;
        
        // When
        system.TearDown();
        
        // Then
        var issues = system.GetRuntimeIssues();
        ;
        ;
        
        // Cleanup
        system.QueueFree();
    }
```

**Returns:** `void`

