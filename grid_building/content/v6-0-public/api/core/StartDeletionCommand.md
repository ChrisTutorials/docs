---
title: "StartDeletionCommand"
description: "Command to start a deletion operation"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/startdeletioncommand/"
---

# StartDeletionCommand

```csharp
GridBuilding.Core.State.Manipulation
class StartDeletionCommand
{
    // Members...
}
```

Command to start a deletion operation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationCommands.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CommandType

```csharp
public string CommandType => "StartDeletion";
```

### Data

```csharp
public ManipulationState? Data { get; }
```

