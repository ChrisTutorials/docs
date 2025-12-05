---
title: "StartDraggingCommand"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/startdraggingcommand/"
---

# StartDraggingCommand

```csharp
GridBuilding.Core.State.Manipulation
class StartDraggingCommand
{
    // Members...
}
```

Command to start a dragging operation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationCommands.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CommandType

```csharp
public string CommandType => "StartDragging";
```

### Data

```csharp
public ManipulationState? Data { get; }
```

### DraggedObject

```csharp
/// <summary>
        /// Object being dragged
        /// </summary>
        public object? DraggedObject => Data?.GetContextData<object>("draggedObject");
```

Object being dragged

### StartPosition

```csharp
/// <summary>
        /// Starting position
        /// </summary>
        public Vector2I StartPosition => Data?.GridOrigin ?? Vector2I.Zero;
```

Starting position

