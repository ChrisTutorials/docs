---
title: "ManipulationData"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/manipulationdata/"
---

# ManipulationData

```csharp
GridBuilding.Core.State.Manipulation
class ManipulationData
{
    // Members...
}
```

Data associated with manipulation operations

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/State/Manipulation/ManipulationData.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### StartPosition

```csharp
/// <summary>
        /// Start position of the manipulation
        /// </summary>
        public Vector2I StartPosition { get; set; }
```

Start position of the manipulation

### CurrentPosition

```csharp
/// <summary>
        /// Current position during manipulation
        /// </summary>
        public Vector2I CurrentPosition { get; set; }
```

Current position during manipulation

### Context

```csharp
/// <summary>
        /// Additional context data
        /// </summary>
        public System.Collections.Generic.Dictionary<string, object> Context { get; set; } = new();
```

Additional context data

