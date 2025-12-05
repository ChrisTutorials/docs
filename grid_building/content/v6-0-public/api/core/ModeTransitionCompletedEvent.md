---
title: "ModeTransitionCompletedEvent"
description: "Event fired when mode transition completes"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/modetransitioncompletedevent/"
---

# ModeTransitionCompletedEvent

```csharp
GridBuilding.Core.State.Mode
class ModeTransitionCompletedEvent
{
    // Members...
}
```

Event fired when mode transition completes

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/State/Mode/ModeEvents.cs`  
**Namespace:** `GridBuilding.Core.State.Mode`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ModeType

```csharp
public string ModeType { get; }
```

### FromMode

```csharp
public string FromMode { get; }
```

### ToMode

```csharp
public string ToMode { get; }
```

