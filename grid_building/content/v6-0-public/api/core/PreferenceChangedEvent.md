---
title: "PreferenceChangedEvent"
description: "Event fired when a user preference is changed"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/preferencechangedevent/"
---

# PreferenceChangedEvent

```csharp
GridBuilding.Core.Services.User
class PreferenceChangedEvent
{
    // Members...
}
```

Event fired when a user preference is changed

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

### Key

```csharp
public string Key { get; }
```

### OldValue

```csharp
public object OldValue { get; }
```

### NewValue

```csharp
public object NewValue { get; }
```

