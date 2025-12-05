---
title: "IndicatorContextTest"
description: "Unit tests for IndicatorContext
Mirrors GDScript indicator_context.gd behavior"
weight: 20
url: "/gridbuilding/v6-0/api/godot/indicatorcontexttest/"
---

# IndicatorContextTest

```csharp
GridBuilding.Godot.Tests.Core.Contexts
class IndicatorContextTest
{
    // Members...
}
```

Unit tests for IndicatorContext
Mirrors GDScript indicator_context.gd behavior

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/IndicatorContextTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Contexts`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetManager_WhenNotSet_ThrowsInvalidOperationException

```csharp
#region Manager Access Tests

    [Fact]
    public void GetManager_WhenNotSet_ThrowsInvalidOperationException()
    {
        // Arrange
        var context = new IndicatorContext();

        // Act & Assert
        Should.Throw<InvalidOperationException>(() => context.GetManager());
    }
```

**Returns:** `void`

### GetManagerOrNull_WhenNotSet_ReturnsNull

```csharp
[Fact]
    public void GetManagerOrNull_WhenNotSet_ReturnsNull()
    {
        // Arrange
        var context = new IndicatorContext();

        // Act
        var result = context.GetManagerOrNull();

        // Assert
        result.ShouldBeNull();
    }
```

**Returns:** `void`

### GetManager_WhenSet_ReturnsManager

```csharp
[Fact]
    public void GetManager_WhenSet_ReturnsManager()
    {
        // Arrange
        var context = new IndicatorContext();
        var mockManager = new MockIndicatorManager();
        context.SetManager(mockManager);

        // Act
        var result = context.GetManager();

        // Assert
        result.ShouldBe(mockManager);
    }
```

**Returns:** `void`

### HasManager_WhenNotSet_ReturnsFalse

```csharp
[Fact]
    public void HasManager_WhenNotSet_ReturnsFalse()
    {
        // Arrange
        var context = new IndicatorContext();

        // Act & Assert
        context.HasManager().ShouldBeFalse();
    }
```

**Returns:** `void`

### HasManager_WhenSet_ReturnsTrue

```csharp
[Fact]
    public void HasManager_WhenSet_ReturnsTrue()
    {
        // Arrange
        var context = new IndicatorContext();
        context.SetManager(new MockIndicatorManager());

        // Act & Assert
        context.HasManager().ShouldBeTrue();
    }
```

**Returns:** `void`

### SetManager_RaisesManagerChangedEvent

```csharp
#endregion

    #region Manager Changed Event Tests

    [Fact]
    public void SetManager_RaisesManagerChangedEvent()
    {
        // Arrange
        var context = new IndicatorContext();
        var mockManager = new MockIndicatorManager();
        IIndicatorManager? eventManager = null;
        context.ManagerChanged += (m) => eventManager = m;

        // Act
        context.SetManager(mockManager);

        // Assert
        eventManager.ShouldBe(mockManager);
    }
```

**Returns:** `void`

### SetManager_WithSameManager_DoesNotRaiseEvent

```csharp
[Fact]
    public void SetManager_WithSameManager_DoesNotRaiseEvent()
    {
        // Arrange
        var context = new IndicatorContext();
        var mockManager = new MockIndicatorManager();
        context.SetManager(mockManager);
        
        int eventCount = 0;
        context.ManagerChanged += (_) => eventCount++;

        // Act
        context.SetManager(mockManager); // Same manager

        // Assert
        eventCount.ShouldBe(0);
    }
```

**Returns:** `void`

### SetManager_WithDifferentManager_RaisesEvent

```csharp
[Fact]
    public void SetManager_WithDifferentManager_RaisesEvent()
    {
        // Arrange
        var context = new IndicatorContext();
        var manager1 = new MockIndicatorManager();
        var manager2 = new MockIndicatorManager();
        context.SetManager(manager1);
        
        int eventCount = 0;
        context.ManagerChanged += (_) => eventCount++;

        // Act
        context.SetManager(manager2); // Different manager

        // Assert
        eventCount.ShouldBe(1);
    }
```

**Returns:** `void`

### ValidatePlacement_WhenManagerNotSet_ReturnsFailure

```csharp
#endregion

    #region Validation Tests

    [Fact]
    public void ValidatePlacement_WhenManagerNotSet_ReturnsFailure()
    {
        // Arrange
        var context = new IndicatorContext();

        // Act
        var result = context.ValidatePlacement();

        // Assert
        result.IsValid.ShouldBeFalse();
        result.Issues.ShouldContain("IndicatorManager not set");
    }
```

**Returns:** `void`

### ValidatePlacement_WhenManagerSet_DelegatesToManager

```csharp
[Fact]
    public void ValidatePlacement_WhenManagerSet_DelegatesToManager()
    {
        // Arrange
        var context = new IndicatorContext();
        var mockManager = new MockIndicatorManager { ValidationResult = ValidationResults.Success() };
        context.SetManager(mockManager);

        // Act
        var result = context.ValidatePlacement();

        // Assert
        result.IsValid.ShouldBeTrue();
        mockManager.ValidatePlacementCalled.ShouldBeTrue();
    }
```

**Returns:** `void`

### GetEditorIssues_ReturnsEmptyList

```csharp
#endregion

    #region Issue Detection Tests

    [Fact]
    public void GetEditorIssues_ReturnsEmptyList()
    {
        // Arrange - Editor issues are runtime-only for IndicatorContext
        var context = new IndicatorContext();

        // Act
        var issues = context.GetEditorIssues();

        // Assert
        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetRuntimeIssues_WhenManagerNotSet_ReturnsIssue

```csharp
[Fact]
    public void GetRuntimeIssues_WhenManagerNotSet_ReturnsIssue()
    {
        // Arrange
        var context = new IndicatorContext();

        // Act
        var issues = context.GetRuntimeIssues();

        // Assert
        issues.ShouldContain("IndicatorManager is not assigned in IndicatorContext");
    }
```

**Returns:** `void`

### GetRuntimeIssues_WhenManagerSet_ReturnsEmptyList

```csharp
[Fact]
    public void GetRuntimeIssues_WhenManagerSet_ReturnsEmptyList()
    {
        // Arrange
        var context = new IndicatorContext();
        context.SetManager(new MockIndicatorManager());

        // Act
        var issues = context.GetRuntimeIssues();

        // Assert
        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

