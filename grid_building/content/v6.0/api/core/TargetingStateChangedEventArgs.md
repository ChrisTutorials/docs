---
title: "TargetingStateChangedEventArgs"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/targetingstatechangedeventargs/"
---

# TargetingStateChangedEventArgs

```csharp
GridBuilding.Core.Services.Targeting
class TargetingStateChangedEventArgs
{
    // Members...
}
```

Event arguments for targeting state changes

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Targeting/IGridTargetingService.cs`  
**Namespace:** `GridBuilding.Core.Services.Targeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### OldTarget

```csharp
public Vector2I OldTarget { get; }
```

### NewTarget

```csharp
public Vector2I NewTarget { get; }
```

### IsActive

```csharp
public bool IsActive { get; }
```

