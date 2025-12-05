---
title: "ApplicationModeChangedEvent"
description: "Event fired when application mode changes"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/applicationmodechangedevent/"
---

# ApplicationModeChangedEvent

```csharp
GridBuilding.Core.State.Mode
class ApplicationModeChangedEvent
{
    // Members...
}
```

Event fired when application mode changes

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/State/Mode/ModeEvents.cs`  
**Namespace:** `GridBuilding.Core.State.Mode`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### OldMode

```csharp
public ApplicationMode OldMode { get; }
```

### NewMode

```csharp
public ApplicationMode NewMode { get; }
```

