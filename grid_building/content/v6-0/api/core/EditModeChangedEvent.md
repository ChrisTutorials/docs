---
title: "EditModeChangedEvent"
description: "Event fired when edit mode changes"
weight: 10
url: "/gridbuilding/v6-0/api/core/editmodechangedevent/"
---

# EditModeChangedEvent

```csharp
GridBuilding.Core.State.Mode
class EditModeChangedEvent
{
    // Members...
}
```

Event fired when edit mode changes

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/State/Mode/ModeEvents.cs`  
**Namespace:** `GridBuilding.Core.State.Mode`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### OldMode

```csharp
public EditMode OldMode { get; }
```

### NewMode

```csharp
public EditMode NewMode { get; }
```

