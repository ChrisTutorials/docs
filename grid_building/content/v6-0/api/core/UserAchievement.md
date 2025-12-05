---
title: "UserAchievement"
description: "User achievement data"
weight: 10
url: "/gridbuilding/v6-0/api/core/userachievement/"
---

# UserAchievement

```csharp
GridBuilding.Core.State.User
class UserAchievement
{
    // Members...
}
```

User achievement data

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/User/UserState.cs`  
**Namespace:** `GridBuilding.Core.State.User`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
public string Id { get; set; } = "";
```

### Name

```csharp
public string Name { get; set; } = "";
```

### Description

```csharp
public string Description { get; set; } = "";
```

### ExperienceReward

```csharp
public int ExperienceReward { get; set; } = 0;
```

### EarnedTime

```csharp
public double EarnedTime { get; set; } = 0.0;
```

### IsHidden

```csharp
public bool IsHidden { get; set; } = false;
```

### Metadata

```csharp
public Dictionary<string, object> Metadata { get; set; } = new();
```


## Methods

### Clone

```csharp
public UserAchievement Clone()
        {
            return new UserAchievement
            {
                Id = Id,
                Name = Name,
                Description = Description,
                ExperienceReward = ExperienceReward,
                EarnedTime = EarnedTime,
                IsHidden = IsHidden,
                Metadata = new Dictionary<string, object>(Metadata)
            };
        }
```

**Returns:** `UserAchievement`

