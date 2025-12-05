---
title: "ModeTransition"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/modetransition/"
---

# ModeTransition

```csharp
GridBuilding.Core.Types
class ModeTransition
{
    // Members...
}
```

Mode transition data structure.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ModeTypes.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ModeType

```csharp
public string ModeType { get; set; } = string.Empty;
```

### FromMode

```csharp
public string FromMode { get; set; } = string.Empty;
```

### ToMode

```csharp
public string ToMode { get; set; } = string.Empty;
```

### Timestamp

```csharp
public double Timestamp { get; set; }
```

### Context

```csharp
public string Context { get; set; } = string.Empty;
```

