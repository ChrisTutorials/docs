---
title: "CancelCommand"
description: "Command to cancel current manipulation"
weight: 10
url: "/gridbuilding/v6-0/api/core/cancelcommand/"
---

# CancelCommand

```csharp
GridBuilding.Core.State.Manipulation
class CancelCommand
{
    // Members...
}
```

Command to cancel current manipulation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationCommands.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CommandType

```csharp
public string CommandType => "Cancel";
```

### Data

```csharp
public ManipulationState? Data { get; }
```

### ShouldEmitSignal

```csharp
/// <summary>
        /// Whether to emit cancellation signal
        /// </summary>
        public bool ShouldEmitSignal => Data != null;
```

Whether to emit cancellation signal

### ShouldClearData

```csharp
/// <summary>
        /// Whether to clear manipulation data
        /// </summary>
        public bool ShouldClearData => Data != null;
```

Whether to clear manipulation data

### ShouldClearManipulatable

```csharp
/// <summary>
        /// Whether to clear manipulatable reference
        /// </summary>
        public bool ShouldClearManipulatable => Data != null;
```

Whether to clear manipulatable reference

### ShouldClearTargeting

```csharp
/// <summary>
        /// Whether to clear targeting state
        /// </summary>
        public bool ShouldClearTargeting => Data != null;
```

Whether to clear targeting state

