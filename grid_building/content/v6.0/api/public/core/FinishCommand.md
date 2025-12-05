---
title: "FinishCommand"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/finishcommand/"
---

# FinishCommand

```csharp
GridBuilding.Core.State.Manipulation
class FinishCommand
{
    // Members...
}
```

Command to finish current manipulation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationCommands.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CommandType

```csharp
public string CommandType => "Finish";
```

### Data

```csharp
public ManipulationState? Data { get; }
```

### ShouldEmitSignal

```csharp
/// <summary>
        /// Whether to emit finished signal
        /// </summary>
        public bool ShouldEmitSignal => Data != null;
```

Whether to emit finished signal

### SignalStatus

```csharp
/// <summary>
        /// Status to set before signal emission
        /// </summary>
        public Status SignalStatus => Data?.IsValid == true ? Status.FINISHED : Status.FAILED;
```

Status to set before signal emission

### ShouldTearDownIndicators

```csharp
/// <summary>
        /// Whether to tear down indicators
        /// </summary>
        public bool ShouldTearDownIndicators => Data != null;
```

Whether to tear down indicators

### ShouldQueueFreeObjects

```csharp
/// <summary>
        /// Whether to queue free manipulation objects
        /// </summary>
        public bool ShouldQueueFreeObjects => Data != null;
```

Whether to queue free manipulation objects

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

