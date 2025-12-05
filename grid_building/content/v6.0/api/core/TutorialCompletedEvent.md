---
title: "TutorialCompletedEvent"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/tutorialcompletedevent/"
---

# TutorialCompletedEvent

```csharp
GridBuilding.Core.Services.User
class TutorialCompletedEvent
{
    // Members...
}
```

Event fired when a tutorial is completed

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

### TutorialId

```csharp
public string TutorialId { get; }
```

### ExperienceReward

```csharp
public int ExperienceReward { get; }
```

### TotalCompletedTutorials

```csharp
public int TotalCompletedTutorials { get; }
```

