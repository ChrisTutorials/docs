---
title: "InputMapping"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/inputmapping/"
---

# InputMapping

```csharp
GridBuilding.Core.Systems
class InputMapping
{
    // Members...
}
```

Input mapping configuration

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/InputManager.cs`  
**Namespace:** `GridBuilding.Core.Systems`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### InputName

```csharp
public string InputName { get; set; } = string.Empty;
```

### InputType

```csharp
public InputType InputType { get; set; }
```

### Deadzone

```csharp
public float Deadzone { get; set; } = 0.1f;
```

### Scale

```csharp
public float Scale { get; set; } = 1.0f;
```

