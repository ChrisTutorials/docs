---
title: "ManipulationUpdatedEvent"
description: "Event fired when a manipulation operation is updated"
weight: 10
url: "/gridbuilding/v6-0/api/core/manipulationupdatedevent/"
---

# ManipulationUpdatedEvent

```csharp
GridBuilding.Core.Services.Manipulation
class ManipulationUpdatedEvent
{
    // Members...
}
```

Event fired when a manipulation operation is updated

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

### CurrentTarget

```csharp
public Vector2I CurrentTarget { get; }
```

### PreviousTarget

```csharp
public Vector2I PreviousTarget { get; }
```

### AffectedTileCount

```csharp
public int AffectedTileCount { get; }
```

### AffectedBounds

```csharp
public Rect2I AffectedBounds { get; }
```

