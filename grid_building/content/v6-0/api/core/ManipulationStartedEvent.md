---
title: "ManipulationStartedEvent"
description: "Event fired when a manipulation operation starts"
weight: 10
url: "/gridbuilding/v6-0/api/core/manipulationstartedevent/"
---

# ManipulationStartedEvent

```csharp
GridBuilding.Core.Services.Manipulation
class ManipulationStartedEvent
{
    // Members...
}
```

Event fired when a manipulation operation starts

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Manipulation/ManipulationEvents.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ManipulationState

```csharp
public ManipulationState ManipulationState { get; }
```

### ManipulationId

```csharp
public string ManipulationId { get; }
```

### Mode

```csharp
public ManipulationMode Mode { get; }
```

### Origin

```csharp
public Vector2I Origin { get; }
```

