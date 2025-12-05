---
title: "ActionDefinition"
description: "Definition of an action that can be performed during manipulation.
Represents a specific operation that can be executed."
weight: 10
url: "/gridbuilding/v6-0/api/core/actiondefinition/"
---

# ActionDefinition

```csharp
GridBuilding.Core.State.Manipulation
class ActionDefinition
{
    // Members...
}
```

Definition of an action that can be performed during manipulation.
Represents a specific operation that can be executed.

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
    /// Action identifier
    /// </summary>
    public string Id { get; set; } = string.Empty;
```

Action identifier

### Name

```csharp
/// <summary>
    /// Action name
    /// </summary>
    public string Name { get; set; } = string.Empty;
```

Action name

### Description

```csharp
/// <summary>
    /// Action description
    /// </summary>
    public string Description { get; set; } = string.Empty;
```

Action description

### IsAvailable

```csharp
/// <summary>
    /// Whether this action is available
    /// </summary>
    public bool IsAvailable { get; set; } = true;
```

Whether this action is available


## Methods

### Execute

```csharp
/// <summary>
    /// Executes the action
    /// </summary>
    public virtual object Execute(object context) => new();
```

Executes the action

**Returns:** `object`

**Parameters:**
- `object context`

