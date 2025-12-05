---
title: "ViewModeChangedEvent"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/viewmodechangedevent/"
---

# ViewModeChangedEvent

```csharp
GridBuilding.Core.State.Mode
class ViewModeChangedEvent
{
    // Members...
}
```

Event fired when view mode changes

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/State/Mode/ModeEvents.cs`  
**Namespace:** `GridBuilding.Core.State.Mode`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### OldMode

```csharp
public ViewMode OldMode { get; }
```

### NewMode

```csharp
public ViewMode NewMode { get; }
```

