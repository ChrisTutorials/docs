---
title: "AchievementEarnedEvent"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/achievementearnedevent/"
---

# AchievementEarnedEvent

```csharp
GridBuilding.Core.Services.User
class AchievementEarnedEvent
{
    // Members...
}
```

Event fired when an achievement is earned

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

### Achievement

```csharp
public UserAchievement Achievement { get; }
```

### ExperienceReward

```csharp
public int ExperienceReward { get; }
```

### TotalAchievements

```csharp
public int TotalAchievements { get; }
```

