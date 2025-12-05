---
title: "StartBuildingCommand"
description: "Command to start a building operation"
weight: 10
url: "/gridbuilding/v6-0/api/core/startbuildingcommand/"
---

# StartBuildingCommand

```csharp
GridBuilding.Core.State.Manipulation
class StartBuildingCommand
{
    // Members...
}
```

Command to start a building operation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationCommands.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CommandType

```csharp
public string CommandType => "StartBuilding";
```

### Data

```csharp
public ManipulationState? Data { get; }
```

### BuildingData

```csharp
/// <summary>
        /// Building data to place
        /// </summary>
        public BuildingData? BuildingData => Data?.GetContextData<BuildingData>("buildingData");
```

Building data to place

### TargetPosition

```csharp
/// <summary>
        /// Target position for building
        /// </summary>
        public Vector2I TargetPosition => Data?.GridTarget ?? Vector2I.Zero;
```

Target position for building

