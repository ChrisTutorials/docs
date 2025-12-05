---
title: "ManipulationSystemTestNew"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/manipulationsystemtestnew/"
---

# ManipulationSystemTestNew

```csharp
GridBuilding.Godot.Tests.Manipulation
class ManipulationSystemTestNew
{
    // Members...
}
```

Integration tests for ManipulationSystemNode with new DI pattern.
Migrated from original ManipulationSystemTest to use TestServiceRegistry.
Score: 3/10 - Heavy Godot scene tree integration, requires Godot runtime.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ManipulationSystemTestNew.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _Ready

```csharp
public override void _Ready()
    {
        Name = "ManipulationSystemTestNew";
    }
```

**Returns:** `void`

### Dispose

```csharp
public void Dispose()
    {
        // Xunit Dispose replaces [TearDown]
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
#endregion

    #region Tests

    [Fact]
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
[Fact]
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
[Fact]
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
[Fact]
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
[Fact]
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
[Fact]
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
[Fact]
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
[Fact]
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
[Fact]
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

