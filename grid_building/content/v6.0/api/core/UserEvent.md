---
title: "UserEvent"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/userevent/"
---

# UserEvent

```csharp
GridBuilding.Core.Services.User
class UserEvent
{
    // Members...
}
```

Base event class for user-related events

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/User/UserEvents.cs`  
**Namespace:** `GridBuilding.Core.Services.User`  
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

### UserId

```csharp
public string UserId { get; }
```

