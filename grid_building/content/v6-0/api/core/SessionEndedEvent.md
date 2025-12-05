---
title: "SessionEndedEvent"
description: "Event fired when a user session ends"
weight: 10
url: "/gridbuilding/v6-0/api/core/sessionendedevent/"
---

# SessionEndedEvent

```csharp
GridBuilding.Core.Services.User
class SessionEndedEvent
{
    // Members...
}
```

Event fired when a user session ends

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

### SessionDuration

```csharp
public double SessionDuration { get; }
```

### TotalPlayTime

```csharp
public double TotalPlayTime { get; }
```

### AverageSessionTime

```csharp
public double AverageSessionTime { get; }
```

