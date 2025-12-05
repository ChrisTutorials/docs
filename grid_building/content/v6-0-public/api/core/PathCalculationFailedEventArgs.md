---
title: "PathCalculationFailedEventArgs"
description: "Event arguments for path calculation failure"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/pathcalculationfailedeventargs/"
---

# PathCalculationFailedEventArgs

```csharp
GridBuilding.Core.Services.Targeting
class PathCalculationFailedEventArgs
{
    // Members...
}
```

Event arguments for path calculation failure

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Targeting/IGridTargetingService.cs`  
**Namespace:** `GridBuilding.Core.Services.Targeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Reason

```csharp
public string Reason { get; }
```

### StartPosition

```csharp
public Vector2I StartPosition { get; }
```

### EndPosition

```csharp
public Vector2I EndPosition { get; }
```

