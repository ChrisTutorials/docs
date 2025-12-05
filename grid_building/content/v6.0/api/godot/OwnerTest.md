---
title: "OwnerTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/ownertest/"
---

# OwnerTest

```csharp
GridBuilding.Godot.Tests.Core.Base
class OwnerTest
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/OwnerTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Base`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_NoArgs_OwnerRootIsNull

```csharp
#region Constructor Tests

    [Fact]
    public void Constructor_NoArgs_OwnerRootIsNull()
    {
        var owner = new Owner();
        
        owner.OwnerRoot.ShouldBeNull();
    }
```

**Returns:** `void`

### Constructor_WithOwnerRoot_SetsOwnerRoot

```csharp
[Fact]
    public void Constructor_WithOwnerRoot_SetsOwnerRoot()
    {
        var mockRoot = new object();
        
        var owner = new Owner(mockRoot);
        
        owner.OwnerRoot.ShouldBe(mockRoot);
    }
```

**Returns:** `void`

### OwnerContext_DefaultConstruction_IsValid

```csharp
#endregion

    #region OwnerContext Tests

    [Fact]
    public void OwnerContext_DefaultConstruction_IsValid()
    {
        var context = new OwnerContext();
        
        context.GetOwner().ShouldBeNull();
    }
```

**Returns:** `void`

### OwnerContext_SetOwner_GetOwnerReturnsCorrectValue

```csharp
[Fact]
    public void OwnerContext_SetOwner_GetOwnerReturnsCorrectValue()
    {
        var context = new OwnerContext();
        var owner = new Owner();
        
        context.SetOwner(owner);
        
        context.GetOwner().ShouldBe(owner);
    }
```

**Returns:** `void`

### OwnerContext_SetOwnerNull_GetOwnerReturnsNull

```csharp
[Fact]
    public void OwnerContext_SetOwnerNull_GetOwnerReturnsNull()
    {
        var context = new OwnerContext();
        var owner = new Owner();
        
        context.SetOwner(owner);
        context.SetOwner(null!);
        
        context.GetOwner().ShouldBeNull();
    }
```

**Returns:** `void`

### OwnerContext_OwnerChanged_EventFires

```csharp
[Fact]
    public void OwnerContext_OwnerChanged_EventFires()
    {
        var context = new OwnerContext();
        IOwner? firedOwner = null;
        
        context.OwnerChanged += (newOwner) => firedOwner = newOwner;
        
        var owner = new Owner();
        context.SetOwner(owner);
        
        firedOwner.ShouldBe(owner);
    }
```

**Returns:** `void`

### OwnerContext_SetSameOwner_EventDoesNotFire

```csharp
[Fact]
    public void OwnerContext_SetSameOwner_EventDoesNotFire()
    {
        var context = new OwnerContext();
        var eventCount = 0;
        
        context.OwnerChanged += (_) => eventCount++;
        
        var owner = new Owner();
        context.SetOwner(owner);
        eventCount.ShouldBe(1); // First set
        
        context.SetOwner(owner); // Set same owner
        eventCount.ShouldBe(1); // Should not increment
    }
```

**Returns:** `void`

### Owner_ImplementsIOwner

```csharp
#endregion

    #region Interface Tests

    [Fact]
    public void Owner_ImplementsIOwner()
    {
        var owner = new Owner();
        
        owner.ShouldBeAssignableTo<IOwner>();
    }
```

**Returns:** `void`

### OwnerContext_ImplementsIOwnerContext

```csharp
[Fact]
    public void OwnerContext_ImplementsIOwnerContext()
    {
        var context = new OwnerContext();
        
        context.ShouldBeAssignableTo<IOwnerContext>();
    }
```

**Returns:** `void`

### OwnerContext_GetOwnerRoot_WithoutOwner_ReturnsNull

```csharp
#endregion

    #region Edge Cases

    [Fact]
    public void OwnerContext_GetOwnerRoot_WithoutOwner_ReturnsNull()
    {
        var context = new OwnerContext();
        
        var result = context.GetOwnerRoot();
        
        result.ShouldBeNull();
    }
```

**Returns:** `void`

### OwnerContext_GetOwnerRoot_WithOwner_ReturnsOwnerRoot

```csharp
[Fact]
    public void OwnerContext_GetOwnerRoot_WithOwner_ReturnsOwnerRoot()
    {
        var context = new OwnerContext();
        var mockRoot = new object();
        var owner = new Owner(mockRoot);
        
        context.SetOwner(owner);
        
        var result = context.GetOwnerRoot();
        
        result.ShouldBe(mockRoot);
    }
```

**Returns:** `void`

### OwnerContext_GetRuntimeIssues_NoIssues_ReturnsEmptyList

```csharp
#endregion

    #region Validation Tests

    [Fact]
    public void OwnerContext_GetRuntimeIssues_NoIssues_ReturnsEmptyList()
    {
        var context = new OwnerContext();
        
        var issues = context.GetRuntimeIssues();
        
        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### OwnerContext_GetRuntimeIssues_WithOwner_ReturnsEmptyList

```csharp
[Fact]
    public void OwnerContext_GetRuntimeIssues_WithOwner_ReturnsEmptyList()
    {
        var context = new OwnerContext();
        var owner = new Owner();
        
        context.SetOwner(owner);
        
        var issues = context.GetRuntimeIssues();
        
        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

