---
title: "ManipulationContextUpdatedEvent"
description: "Event fired when a manipulation context is updated."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/manipulationcontextupdatedevent/"
---

# ManipulationContextUpdatedEvent

```csharp
GridBuilding.Core.Services.Manipulation
class ManipulationContextUpdatedEvent
{
    // Members...
}
```

Event fired when a manipulation context is updated.

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

### Timestamp

```csharp
public DateTime Timestamp { get; }
```

