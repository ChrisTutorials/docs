---
title: "ManipulationContextStatusChangedEvent"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/manipulationcontextstatuschangedevent/"
---

# ManipulationContextStatusChangedEvent

```csharp
GridBuilding.Core.Services.Manipulation
class ManipulationContextStatusChangedEvent
{
    // Members...
}
```

Event fired when a manipulation context status changes.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Manipulation/ManipulationContextService.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Context

```csharp
public ManipulationContext Context { get; }
```

### PreviousStatus

```csharp
public ManipulationStatus PreviousStatus { get; }
```

### Timestamp

```csharp
public DateTime Timestamp { get; }
```

