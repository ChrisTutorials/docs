---
title: "ModeConstraint"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/modeconstraint/"
---

# ModeConstraint

```csharp
GridBuilding.Core.Types
class ModeConstraint
{
    // Members...
}
```

Mode constraint for transition validation.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ModeTypes.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; } = string.Empty;
```

### Description

```csharp
public string Description { get; set; } = string.Empty;
```


## Methods

### AllowsTransition

```csharp
public virtual bool AllowsTransition<T>(T mode) where T : System.Enum => true;
```

**Returns:** `bool`

**Parameters:**
- `T mode`

