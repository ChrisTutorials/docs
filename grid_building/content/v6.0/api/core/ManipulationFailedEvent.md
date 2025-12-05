---
title: "ManipulationFailedEvent"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/manipulationfailedevent/"
---

# ManipulationFailedEvent

```csharp
GridBuilding.Core.Services.Manipulation
class ManipulationFailedEvent
{
    // Members...
}
```

Event fired when a manipulation operation fails

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

### FailureReason

```csharp
public string FailureReason { get; }
```

### ValidationErrors

```csharp
public List<string> ValidationErrors { get; }
```

### Duration

```csharp
public double Duration { get; }
```

