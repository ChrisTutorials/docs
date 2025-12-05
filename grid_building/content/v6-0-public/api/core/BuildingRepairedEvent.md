---
title: "BuildingRepairedEvent"
description: ""
weight: 10
url: "/gridbuilding/v6-0-public/api/core/buildingrepairedevent/"
---

# BuildingRepairedEvent

```csharp
GridBuilding.Core.Events
class BuildingRepairedEvent
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Events/BuildingRepairedEvent.cs`  
**Namespace:** `GridBuilding.Core.Events`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Building

```csharp
public BuildingState Building { get; }
```

### RepairAmount

```csharp
public float RepairAmount { get; }
```

### PreviousHealth

```csharp
public float PreviousHealth { get; }
```

### NewHealth

```csharp
public float NewHealth { get; }
```

