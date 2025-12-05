---
title: "PathCalculatedEventArgs"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/pathcalculatedeventargs/"
---

# PathCalculatedEventArgs

```csharp
GridBuilding.Core.Services.Targeting
class PathCalculatedEventArgs
{
    // Members...
}
```

Event arguments for path calculation completion

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Targeting/IGridTargetingService.cs`  
**Namespace:** `GridBuilding.Core.Services.Targeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Path

```csharp
public List<Vector2I> Path { get; }
```

### Distance

```csharp
public float Distance { get; }
```

### StartPosition

```csharp
public Vector2I StartPosition { get; }
```

### EndPosition

```csharp
public Vector2I EndPosition { get; }
```

