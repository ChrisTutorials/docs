---
title: "ManipulationConstraint"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/manipulationconstraint/"
---

# ManipulationConstraint

```csharp
GridBuilding.Core.State.Manipulation
class ManipulationConstraint
{
    // Members...
}
```

Constraint for manipulation operations.
Defines conditions that must be met for manipulation to proceed.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/State/Manipulation/ManipulationTypes.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
/// <summary>
    /// Constraint identifier
    /// </summary>
    public string Id { get; set; } = string.Empty;
```

Constraint identifier

### Description

```csharp
/// <summary>
    /// Constraint description
    /// </summary>
    public string Description { get; set; } = string.Empty;
```

Constraint description

### IsEnabled

```csharp
/// <summary>
    /// Whether this constraint is enabled
    /// </summary>
    public bool IsEnabled { get; set; } = true;
```

Whether this constraint is enabled


## Methods

### IsSatisfied

```csharp
/// <summary>
    /// Checks if the constraint is satisfied
    /// </summary>
    public virtual bool IsSatisfied(object context) => true;
```

Checks if the constraint is satisfied

**Returns:** `bool`

**Parameters:**
- `object context`

