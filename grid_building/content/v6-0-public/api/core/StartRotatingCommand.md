---
title: "StartRotatingCommand"
description: "Command to start a rotating operation"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/startrotatingcommand/"
---

# StartRotatingCommand

```csharp
GridBuilding.Core.State.Manipulation
class StartRotatingCommand
{
    // Members...
}
```

Command to start a rotating operation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationCommands.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CommandType

```csharp
public string CommandType => "StartRotating";
```

### Data

```csharp
public ManipulationState? Data { get; }
```

### RotatingObject

```csharp
/// <summary>
        /// Object being rotated
        /// </summary>
        public object? RotatingObject => Data?.GetContextData<object>("rotatingObject");
```

Object being rotated

### CenterPosition

```csharp
/// <summary>
        /// Center of rotation
        /// </summary>
        public Vector2I CenterPosition => Data?.GridOrigin ?? Vector2I.Zero;
```

Center of rotation

