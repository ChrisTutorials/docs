---
title: "UserCreatedEvent"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/usercreatedevent/"
---

# UserCreatedEvent

```csharp
GridBuilding.Core.Services.User
class UserCreatedEvent
{
    // Members...
}
```

Event fired when a new user is created

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

### Username

```csharp
public string Username { get; }
```

### IsGuest

```csharp
public bool IsGuest { get; }
```

