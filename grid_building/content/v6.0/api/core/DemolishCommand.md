---
title: "DemolishCommand"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/demolishcommand/"
---

# DemolishCommand

```csharp
GridBuilding.Core.State.Manipulation
class DemolishCommand
{
    // Members...
}
```

Command to handle demolish validation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationCommands.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CommandType

```csharp
public string CommandType => "Demolish";
```

### Data

```csharp
public ManipulationState? Data { get; }
```

### ResultStatus

```csharp
/// <summary>
        /// Result status of demolish attempt
        /// </summary>
        public Status ResultStatus { get; }
```

Result status of demolish attempt

### Message

```csharp
/// <summary>
        /// Human-readable message
        /// </summary>
        public string Message { get; }
```

Human-readable message

### ShouldDemolish

```csharp
/// <summary>
        /// Whether demolish should proceed
        /// </summary>
        public bool ShouldDemolish { get; }
```

Whether demolish should proceed

### TargetObject

```csharp
/// <summary>
        /// Target object to demolish
        /// </summary>
        public object? TargetObject => Data?.GetContextData<object>("targetObject");
```

Target object to demolish

