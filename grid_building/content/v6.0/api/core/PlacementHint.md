---
title: "PlacementHint"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/placementhint/"
---

# PlacementHint

```csharp
GridBuilding.Core.Services.Manipulation
class PlacementHint
{
    // Members...
}
```

Placement hint for user feedback

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Manipulation/PlacementManager.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Type

```csharp
public PlacementHintType Type { get; set; }
```

### Message

```csharp
public string Message { get; set; } = string.Empty;
```

### Position

```csharp
public Vector2I Position { get; set; }
```

### Suggestion

```csharp
public string Suggestion { get; set; } = string.Empty;
```

