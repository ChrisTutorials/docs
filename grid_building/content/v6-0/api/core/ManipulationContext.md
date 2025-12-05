---
title: "ManipulationContext"
description: "Context for manipulation operations."
weight: 10
url: "/gridbuilding/v6-0/api/core/manipulationcontext/"
---

# ManipulationContext

```csharp
GridBuilding.Core.Systems.Manipulation
class ManipulationContext
{
    // Members...
}
```

Context for manipulation operations.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Placement/Manipulation/ManipulationTypes.cs`  
**Namespace:** `GridBuilding.Core.Systems.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TargetPosition

```csharp
public Vector2 TargetPosition { get; set; }
```

### TargetGridPosition

```csharp
public GridPosition TargetGridPosition { get; set; }
```

### Properties

```csharp
public Dictionary<string, object> Properties { get; set; } = new();
```

