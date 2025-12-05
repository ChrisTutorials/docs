---
title: "ExperienceGainedEvent"
description: "Event fired when a user gains experience"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/experiencegainedevent/"
---

# ExperienceGainedEvent

```csharp
GridBuilding.Core.Services.User
class ExperienceGainedEvent
{
    // Members...
}
```

Event fired when a user gains experience

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

### AmountGained

```csharp
public int AmountGained { get; }
```

### PreviousExperience

```csharp
public int PreviousExperience { get; }
```

### CurrentExperience

```csharp
public int CurrentExperience { get; }
```

### Source

```csharp
public string Source { get; }
```

