---
title: "BuildingRequirements"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/buildingrequirements/"
---

# BuildingRequirements

```csharp
GridBuilding.Core.Services.DI
class BuildingRequirements
{
    // Members...
}
```

Building requirements configuration.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/PlacementValidator.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### RequiredNearbyBuildings

```csharp
public Dictionary<string, List<string>> RequiredNearbyBuildings { get; set; } = new();
```

### RequiredDistance

```csharp
public int RequiredDistance { get; set; } = 3;
```

### ForbiddenNearbyBuildings

```csharp
public Dictionary<string, List<string>> ForbiddenNearbyBuildings { get; set; } = new();
```

