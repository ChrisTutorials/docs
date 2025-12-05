---
title: "ManipulationCompletedEvent"
description: "Event fired when a manipulation operation completes successfully"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/manipulationcompletedevent/"
---

# ManipulationCompletedEvent

```csharp
GridBuilding.Core.Services.Manipulation
class ManipulationCompletedEvent
{
    // Members...
}
```

Event fired when a manipulation operation completes successfully

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

### FinalPosition

```csharp
public Vector2I FinalPosition { get; }
```

### Duration

```csharp
public double Duration { get; }
```

### WasSuccessful

```csharp
public bool WasSuccessful { get; }
```

### ResultMessage

```csharp
public string ResultMessage { get; }
```

