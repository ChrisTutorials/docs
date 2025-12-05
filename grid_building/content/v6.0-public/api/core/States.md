---
title: "States"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/states/"
---

# States

```csharp
GridBuilding.Core.Contexts
class States
{
    // Members...
}
```

Shared states for plugin systems.
Type alias for States to maintain backward compatibility.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/States.cs`  
**Namespace:** `GridBuilding.Core.Contexts`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Building

```csharp
/// <summary>
    /// Building state
    /// </summary>
    public BuildingState? Building { get; set; }
```

Building state

### Targeting

```csharp
/// <summary>
    /// Targeting state
    /// </summary>
    public GridTargetingState? Targeting { get; set; }
```

Targeting state

