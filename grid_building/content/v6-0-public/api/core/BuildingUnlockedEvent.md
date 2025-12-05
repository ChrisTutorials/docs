---
title: "BuildingUnlockedEvent"
description: "Event fired when a building is unlocked for a user"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/buildingunlockedevent/"
---

# BuildingUnlockedEvent

```csharp
GridBuilding.Core.Services.User
class BuildingUnlockedEvent
{
    // Members...
}
```

Event fired when a building is unlocked for a user

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

### BuildingType

```csharp
public string BuildingType { get; }
```

### ExperienceReward

```csharp
public int ExperienceReward { get; }
```

### TotalUnlockedBuildings

```csharp
public int TotalUnlockedBuildings { get; }
```

