---
title: "BuildingFailedEvent"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/buildingfailedevent/"
---

# BuildingFailedEvent

```csharp
GridBuilding.Core.Events
class BuildingFailedEvent
{
    // Members...
}
```

Event raised when a building operation fails

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Events/BuildingFailedEvent.cs`  
**Namespace:** `GridBuilding.Core.Events`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Building

```csharp
public BuildingState? Building { get; }
```

### BuildingType

```csharp
public string? BuildingType { get; }
```

### Position

```csharp
public Vector2I? Position { get; }
```

### FailureReason

```csharp
public string FailureReason { get; }
```

### Exception

```csharp
public System.Exception? Exception { get; }
```

