---
title: "GameEvent"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/gameevent/"
---

# GameEvent

```csharp
GridBuilding.Core.Services
class GameEvent
{
    // Members...
}
```

Base class for all game events

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Common/EventDispatcher.cs`  
**Namespace:** `GridBuilding.Core.Services`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Timestamp

```csharp
public DateTime Timestamp { get; }
```

### Source

```csharp
public string Source { get; }
```

### EventId

```csharp
public string EventId { get; }
```


## Methods

### ToString

```csharp
public override string ToString()
    {
        return $"{GetType().Name} [{EventId}] from {Source} at {Timestamp:HH:mm:ss.fff}";
    }
```

**Returns:** `string`

