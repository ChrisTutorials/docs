---
title: "ManipulationContextRemovedEvent"
description: "Event fired when a manipulation context is removed."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/manipulationcontextremovedevent/"
---

# ManipulationContextRemovedEvent

```csharp
GridBuilding.Core.Services.Manipulation
class ManipulationContextRemovedEvent
{
    // Members...
}
```

Event fired when a manipulation context is removed.

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

