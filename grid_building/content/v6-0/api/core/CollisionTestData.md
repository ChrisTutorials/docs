---
title: "CollisionTestData"
description: "Concrete implementation of collision test data"
weight: 10
url: "/gridbuilding/v6-0/api/core/collisiontestdata/"
---

# CollisionTestData

```csharp
GridBuilding.Core.Data
class CollisionTestData
{
    // Members...
}
```

Concrete implementation of collision test data

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Data/ICollisionTestData.cs`  
**Namespace:** `GridBuilding.Core.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestId

```csharp
public string TestId { get; set; } = string.Empty;
```

### Description

```csharp
public string Description { get; set; } = string.Empty;
```

### ExpectedCollision

```csharp
public bool ExpectedCollision { get; set; } = false;
```

### ObjectA

```csharp
public Rect2I ObjectA { get; set; } = new();
```

### ObjectB

```csharp
public Rect2I ObjectB { get; set; } = new();
```

### Parameters

```csharp
public Dictionary<string, object> Parameters { get; set; } = new();
```

### IsEnabled

```csharp
public bool IsEnabled { get; set; } = true;
```

