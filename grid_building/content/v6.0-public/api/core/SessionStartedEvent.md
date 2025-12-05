---
title: "SessionStartedEvent"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/sessionstartedevent/"
---

# SessionStartedEvent

```csharp
GridBuilding.Core.Services.User
class SessionStartedEvent
{
    // Members...
}
```

Event fired when a user session starts

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/User/UserEvents.cs`  
**Namespace:** `GridBuilding.Core.Services.User`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### UserState

```csharp
public UserState UserState { get; }
```

### SessionStartTime

```csharp
public double SessionStartTime { get; }
```

### TotalSessions

```csharp
public int TotalSessions { get; }
```

