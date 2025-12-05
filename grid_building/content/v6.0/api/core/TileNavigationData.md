---
title: "TileNavigationData"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/tilenavigationdata/"
---

# TileNavigationData

```csharp
GridBuilding.Core.Services.Targeting
class TileNavigationData
{
    // Members...
}
```

Navigation data for a single tile

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Targeting/IGridTargetingService.cs`  
**Namespace:** `GridBuilding.Core.Services.Targeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsWalkable

```csharp
public bool IsWalkable { get; set; } = true;
```

### Weight

```csharp
public float Weight { get; set; } = 1.0f;
```

### Position

```csharp
public Vector2I Position { get; set; }
```

