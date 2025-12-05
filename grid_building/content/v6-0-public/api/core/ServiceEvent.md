---
title: "ServiceEvent"
description: "Base class for service-related events"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/serviceevent/"
---

# ServiceEvent

```csharp
GridBuilding.Core.Events
class ServiceEvent
{
    // Members...
}
```

Base class for service-related events

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Events/ServiceEvent.cs`  
**Namespace:** `GridBuilding.Core.Events`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Timestamp

```csharp
/// <summary>
    /// Timestamp when the event occurred
    /// </summary>
    public DateTime Timestamp { get; }
```

Timestamp when the event occurred

### Source

```csharp
/// <summary>
    /// Source of the event
    /// </summary>
    public object Source { get; }
```

Source of the event

### Data

```csharp
/// <summary>
    /// Event data
    /// </summary>
    public object? Data { get; }
```

Event data

