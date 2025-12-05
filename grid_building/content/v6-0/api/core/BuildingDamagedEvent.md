---
title: "BuildingDamagedEvent"
description: ""
weight: 10
url: "/gridbuilding/v6-0/api/core/buildingdamagedevent/"
---

# BuildingDamagedEvent

```csharp
GridBuilding.Core.Events
class BuildingDamagedEvent
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Events/BuildingDamagedEvent.cs`  
**Namespace:** `GridBuilding.Core.Events`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Building

```csharp
public BuildingState Building { get; }
```

### DamageAmount

```csharp
public float DamageAmount { get; }
```

