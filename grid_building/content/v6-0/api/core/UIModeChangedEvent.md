---
title: "UIModeChangedEvent"
description: "Event fired when UI mode changes"
weight: 10
url: "/gridbuilding/v6-0/api/core/uimodechangedevent/"
---

# UIModeChangedEvent

```csharp
GridBuilding.Core.State.Mode
class UIModeChangedEvent
{
    // Members...
}
```

Event fired when UI mode changes

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/State/Mode/ModeEvents.cs`  
**Namespace:** `GridBuilding.Core.State.Mode`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### OldMode

```csharp
public UIMode OldMode { get; }
```

### NewMode

```csharp
public UIMode NewMode { get; }
```

