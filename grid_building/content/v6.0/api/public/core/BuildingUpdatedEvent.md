---
title: "BuildingUpdatedEvent"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/buildingupdatedevent/"
---

# BuildingUpdatedEvent

```csharp
GridBuilding.Core.Events
class BuildingUpdatedEvent
{
    // Members...
}
```

Event raised when a building is updated

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Events/BuildingUpdatedEvent.cs`  
**Namespace:** `GridBuilding.Core.Events`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Building

```csharp
public BuildingState Building { get; }
```

### UpdatedProperty

```csharp
public string UpdatedProperty { get; }
```

### PreviousValue

```csharp
public object? PreviousValue { get; }
```

### NewValue

```csharp
public object? NewValue { get; }
```

