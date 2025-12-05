---
title: "ManipulationContextCreatedEvent"
description: "Event fired when a manipulation context is created."
weight: 10
url: "/gridbuilding/v6-0/api/core/manipulationcontextcreatedevent/"
---

# ManipulationContextCreatedEvent

```csharp
GridBuilding.Core.Services.Manipulation
class ManipulationContextCreatedEvent
{
    // Members...
}
```

Event fired when a manipulation context is created.

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

