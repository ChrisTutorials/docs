---
title: "OwnerContextTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/ownercontexttest/"
---

# OwnerContextTest

```csharp
GridBuilding.Godot.Tests.Core.Contexts
class OwnerContextTest
{
    // Members...
}
```

Unit tests for OwnerContext
Mirrors GDScript owner_context.gd behavior

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/OwnerContextTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Contexts`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_WithNoOwner_HasNullOwner

```csharp
#region Constructor Tests

    [Fact]
    public void Constructor_WithNoOwner_HasNullOwner()
    {
        // Arrange & Act
        var context = new OwnerContext();

        // Assert
        context.GetOwner().ShouldBeNull();
    }
```

**Returns:** `void`

### Constructor_WithOwner_SetsOwner

```csharp
[Fact]
    public void Constructor_WithOwner_SetsOwner()
    {
        // Arrange
        var mockOwner = new MockOwner();

        // Act
        var context = new OwnerContext(mockOwner);

        // Assert
        context.GetOwner().ShouldBe(mockOwner);
    }
```

**Returns:** `void`

### SetOwner_ValidOwner_SetsOwner

```csharp
#endregion

    #region SetOwner Tests

    [Fact]
    public void SetOwner_ValidOwner_SetsOwner()
    {
        // Arrange
        var context = new OwnerContext();
        var mockOwner = new MockOwner();

        // Act
        context.SetOwner(mockOwner);

        // Assert
        context.GetOwner().ShouldBe(mockOwner);
    }
```

**Returns:** `void`

### SetOwner_Null_SetsOwnerToNull

```csharp
[Fact]
    public void SetOwner_Null_SetsOwnerToNull()
    {
        // Arrange
        var context = new OwnerContext();
        var mockOwner = new MockOwner();
        context.SetOwner(mockOwner);

        // Act
        context.SetOwner(null!);

        // Assert
        context.GetOwner().ShouldBeNull();
    }
```

**Returns:** `void`

### SetOwner_SameOwner_DoesNotFireEvent

```csharp
[Fact]
    public void SetOwner_SameOwner_DoesNotFireEvent()
    {
        // Arrange
        var context = new OwnerContext();
        var mockOwner = new MockOwner();
        var eventCount = 0;
        context.OwnerChanged += (owner) => eventCount++;

        // Act
        context.SetOwner(mockOwner); // First set
        context.SetOwner(mockOwner); // Second set (same owner)

        // Assert
        eventCount.ShouldBe(1); // Should only fire once
    }
```

**Returns:** `void`

### SetOwner_DifferentOwner_FiresEvent

```csharp
[Fact]
    public void SetOwner_DifferentOwner_FiresEvent()
    {
        // Arrange
        var context = new OwnerContext();
        var owner1 = new MockOwner();
        var owner2 = new MockOwner();
        IOwner? firedOwner = null;
        context.OwnerChanged += (owner) => firedOwner = owner;

        // Act
        context.SetOwner(owner1);
        context.SetOwner(owner2);

        // Assert
        firedOwner.ShouldBe(owner2);
    }
```

**Returns:** `void`

### GetOwnerRoot_NoOwner_ReturnsNull

```csharp
#endregion

    #region GetOwnerRoot Tests

    [Fact]
    public void GetOwnerRoot_NoOwner_ReturnsNull()
    {
        // Arrange
        var context = new OwnerContext();

        // Act
        var result = context.GetOwnerRoot();

        // Assert
        result.ShouldBeNull();
    }
```

**Returns:** `void`

### GetOwnerRoot_WithOwner_ReturnsOwnerRoot

```csharp
[Fact]
    public void GetOwnerRoot_WithOwner_ReturnsOwnerRoot()
    {
        // Arrange
        var context = new OwnerContext();
        var mockRoot = new object();
        var mockOwner = new MockOwner { OwnerRoot = mockRoot };
        context.SetOwner(mockOwner);

        // Act
        var result = context.GetOwnerRoot();

        // Assert
        result.ShouldBe(mockRoot);
    }
```

**Returns:** `void`

### GetOwnerRoot_OwnerWithNullRoot_ReturnsNull

```csharp
[Fact]
    public void GetOwnerRoot_OwnerWithNullRoot_ReturnsNull()
    {
        // Arrange
        var context = new OwnerContext();
        var mockOwner = new MockOwner { OwnerRoot = null };
        context.SetOwner(mockOwner);

        // Act
        var result = context.GetOwnerRoot();

        // Assert
        result.ShouldBeNull();
    }
```

**Returns:** `void`

### OwnerChanged_FiresWhenOwnerSet

```csharp
#endregion

    #region Event Tests

    [Fact]
    public void OwnerChanged_FiresWhenOwnerSet()
    {
        // Arrange
        var context = new OwnerContext();
        var mockOwner = new MockOwner();
        IOwner? firedOwner = null;
        context.OwnerChanged += (owner) => firedOwner = owner;

        // Act
        context.SetOwner(mockOwner);

        // Assert
        firedOwner.ShouldBe(mockOwner);
    }
```

**Returns:** `void`

### OwnerChanged_FiresWhenOwnerSetToNull

```csharp
[Fact]
    public void OwnerChanged_FiresWhenOwnerSetToNull()
    {
        // Arrange
        var context = new OwnerContext();
        var mockOwner = new MockOwner();
        context.SetOwner(mockOwner);
        IOwner? firedOwner = null;
        context.OwnerChanged += (owner) => firedOwner = owner;

        // Act
        context.SetOwner(null!);

        // Assert
        firedOwner.ShouldBeNull();
    }
```

**Returns:** `void`

### OwnerChanged_MultipleSubscribers_AllFire

```csharp
[Fact]
    public void OwnerChanged_MultipleSubscribers_AllFire()
    {
        // Arrange
        var context = new OwnerContext();
        var mockOwner = new MockOwner();
        var eventCount1 = 0;
        var eventCount2 = 0;
        context.OwnerChanged += (_) => eventCount1++;
        context.OwnerChanged += (_) => eventCount2++;

        // Act
        context.SetOwner(mockOwner);

        // Assert
        eventCount1.ShouldBe(1);
        eventCount2.ShouldBe(1);
    }
```

**Returns:** `void`

### GetRuntimeIssues_NoIssues_ReturnsEmptyList

```csharp
#endregion

    #region Validation Tests

    [Fact]
    public void GetRuntimeIssues_NoIssues_ReturnsEmptyList()
    {
        // Arrange
        var context = new OwnerContext();

        // Act
        var issues = context.GetRuntimeIssues();

        // Assert
        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetRuntimeIssues_WithOwner_ReturnsEmptyList

```csharp
[Fact]
    public void GetRuntimeIssues_WithOwner_ReturnsEmptyList()
    {
        // Arrange
        var context = new OwnerContext();
        var mockOwner = new MockOwner();
        context.SetOwner(mockOwner);

        // Act
        var issues = context.GetRuntimeIssues();

        // Assert
        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetEditorIssues_ReturnsEmptyList

```csharp
[Fact]
    public void GetEditorIssues_ReturnsEmptyList()
    {
        // Arrange
        var context = new OwnerContext();

        // Act
        var issues = context.GetEditorIssues();

        // Assert
        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### OwnerContext_ImplementsIOwnerContext

```csharp
#endregion

    #region Interface Tests

    [Fact]
    public void OwnerContext_ImplementsIOwnerContext()
    {
        // Arrange & Act
        var context = new OwnerContext();

        // Assert
        context.ShouldBeAssignableTo<IOwnerContext>();
    }
```

**Returns:** `void`

### MockOwner_ImplementsIOwner

```csharp
[Fact]
    public void MockOwner_ImplementsIOwner()
    {
        // Arrange & Act
        var owner = new MockOwner();

        // Assert
        owner.ShouldBeAssignableTo<IOwner>();
    }
```

**Returns:** `void`

### SetOwner_MultipleNullSets_DoesNotFireEventAfterFirst

```csharp
#endregion

    #region Edge Cases

    [Fact]
    public void SetOwner_MultipleNullSets_DoesNotFireEventAfterFirst()
    {
        // Arrange
        var context = new OwnerContext();
        var eventCount = 0;
        context.OwnerChanged += (_) => eventCount++;

        // Act
        context.SetOwner(null!); // First null set
        context.SetOwner(null!); // Second null set
        context.SetOwner(null!); // Third null set

        // Assert
        eventCount.ShouldBe(1); // Should only fire once
    }
```

**Returns:** `void`

### GetOwner_AfterMultipleSetOperations_ReturnsCorrectOwner

```csharp
[Fact]
    public void GetOwner_AfterMultipleSetOperations_ReturnsCorrectOwner()
    {
        // Arrange
        var context = new OwnerContext();
        var owner1 = new MockOwner();
        var owner2 = new MockOwner();
        var owner3 = new MockOwner();

        // Act
        context.SetOwner(owner1);
        context.SetOwner(owner2);
        context.SetOwner(owner3);

        // Assert
        context.GetOwner().ShouldBe(owner3);
    }
```

**Returns:** `void`

