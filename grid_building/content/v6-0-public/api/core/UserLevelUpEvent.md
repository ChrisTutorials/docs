---
title: "UserLevelUpEvent"
description: "Event fired when a user levels up"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/userlevelupevent/"
---

# UserLevelUpEvent

```csharp
GridBuilding.Core.Services.User
class UserLevelUpEvent
{
    // Members...
}
```

Event fired when a user levels up

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

### PreviousLevel

```csharp
public UserLevel PreviousLevel { get; }
```

### NewLevel

```csharp
public UserLevel NewLevel { get; }
```

### TotalExperience

```csharp
public int TotalExperience { get; }
```

### ExperienceToNextLevel

```csharp
public int ExperienceToNextLevel { get; }
```

