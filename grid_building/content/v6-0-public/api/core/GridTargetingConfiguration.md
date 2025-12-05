---
title: "GridTargetingConfiguration"
description: "Configuration for grid targeting system"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/gridtargetingconfiguration/"
---

# GridTargetingConfiguration

```csharp
GridBuilding.Core.Services.Targeting
class GridTargetingConfiguration
{
    // Members...
}
```

Configuration for grid targeting system

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Targeting/IGridTargetingService.cs`  
**Namespace:** `GridBuilding.Core.Services.Targeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### EnableMouseInput

```csharp
public bool EnableMouseInput { get; set; } = true;
```

### EnableDiagonalMovement

```csharp
public bool EnableDiagonalMovement { get; set; } = true;
```

### LimitToAdjacentTiles

```csharp
public bool LimitToAdjacentTiles { get; set; } = false;
```

### MaxTilesDistance

```csharp
public int MaxTilesDistance { get; set; } = 10;
```

### HeuristicWeight

```csharp
public float HeuristicWeight { get; set; } = 1.0f;
```

### MaxPathLength

```csharp
public int MaxPathLength { get; set; } = 1000;
```

### ShowDebug

```csharp
public bool ShowDebug { get; set; } = false;
```

### DefaultGridSize

```csharp
public Vector2I DefaultGridSize { get; set; } = new Vector2I(100, 100);
```

