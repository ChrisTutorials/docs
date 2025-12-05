---
title: "ManipulationCancelledEvent"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/manipulationcancelledevent/"
---

# ManipulationCancelledEvent

```csharp
GridBuilding.Core.Services.Manipulation
class ManipulationCancelledEvent
{
    // Members...
}
```

Event fired when a manipulation operation is cancelled

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

### LastPosition

```csharp
public Vector2I LastPosition { get; }
```

### Duration

```csharp
public double Duration { get; }
```

### CancelReason

```csharp
public string CancelReason { get; }
```

