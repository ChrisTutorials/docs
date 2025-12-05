---
title: "ServiceErrorEvent"
description: "Event raised when a service encounters an error"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/serviceerrorevent/"
---

# ServiceErrorEvent

```csharp
GridBuilding.Core.Events
class ServiceErrorEvent
{
    // Members...
}
```

Event raised when a service encounters an error

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Events/ServiceEvent.cs`  
**Namespace:** `GridBuilding.Core.Events`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Exception

```csharp
public Exception Exception { get; }
```

