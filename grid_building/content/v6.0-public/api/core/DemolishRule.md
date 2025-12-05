---
title: "DemolishRule"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/demolishrule/"
---

# DemolishRule

```csharp
GridBuilding.Core.Services.Manipulation
class DemolishRule
{
    // Members...
}
```

Base class for demolish rules

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Manipulation/DemolishManager.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; } = string.Empty;
```

### Priority

```csharp
public int Priority { get; set; } = 0;
```

### IsEnabled

```csharp
public bool IsEnabled { get; set; } = true;
```


## Methods

### Validate

```csharp
public abstract DemolishValidationResult Validate(ManipulationState manipulationState, string targetObjectId, Vector2I targetPosition, ManipulationSettings settings);
```

**Returns:** `DemolishValidationResult`

**Parameters:**
- `ManipulationState manipulationState`
- `string targetObjectId`
- `Vector2I targetPosition`
- `ManipulationSettings settings`

