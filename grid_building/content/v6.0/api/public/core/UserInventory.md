---
title: "UserInventory"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/userinventory/"
---

# UserInventory

```csharp
GridBuilding.Core.State.User
class UserInventory
{
    // Members...
}
```

User inventory and resources

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/User/UserState.cs`  
**Namespace:** `GridBuilding.Core.State.User`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Resources

```csharp
public Dictionary<string, int> Resources { get; set; } = new();
```

### Items

```csharp
public Dictionary<string, int> Items { get; set; } = new();
```

### MaxResources

```csharp
public int MaxResources { get; set; } = 10000;
```

### MaxItems

```csharp
public int MaxItems { get; set; } = 100;
```


## Methods

### Clone

```csharp
public UserInventory Clone()
        {
            return new UserInventory
            {
                Resources = new Dictionary<string, int>(Resources),
                Items = new Dictionary<string, int>(Items),
                MaxResources = MaxResources,
                MaxItems = MaxItems
            };
        }
```

**Returns:** `UserInventory`

