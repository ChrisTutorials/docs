---
title: "GridNavigationData"
description: "Grid navigation data for pathfinding"
weight: 10
url: "/gridbuilding/v6-0/api/core/gridnavigationdata/"
---

# GridNavigationData

```csharp
GridBuilding.Core.Services.Targeting
class GridNavigationData
{
    // Members...
}
```

Grid navigation data for pathfinding

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Targeting/IGridTargetingService.cs`  
**Namespace:** `GridBuilding.Core.Services.Targeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### GridSize

```csharp
public Vector2I GridSize { get; set; }
```

### Tiles

```csharp
public Dictionary<Vector2I, TileNavigationData> Tiles { get; set; } = new();
```

### EnableDiagonalMovement

```csharp
public bool EnableDiagonalMovement { get; set; } = true;
```

### DefaultHeuristicWeight

```csharp
public float DefaultHeuristicWeight { get; set; } = 1.0f;
```

