---
title: "PathNode"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/pathnode/"
---

# PathNode

```csharp
GridBuilding.Core.Services.Targeting
record PathNode
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Targeting/GridTargetingService.cs`  
**Namespace:** `GridBuilding.Core.Services.Targeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### FScore

```csharp
public float FScore => GScore + HScore;
```

