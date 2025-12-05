---
title: "PlacementRequirements"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/placementrequirements/"
---

# PlacementRequirements

```csharp
GridBuilding.Core.Data.Placement
class PlacementRequirements
{
    // Members...
}
```

Placement requirements for a building.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/Placement/BuildingData.cs`  
**Namespace:** `GridBuilding.Core.Data.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TerrainTypes

```csharp
/// <summary>
    /// Required terrain types.
    /// </summary>
    public List<string> TerrainTypes { get; set; } = new();
```

Required terrain types.

### ZoneTypes

```csharp
/// <summary>
    /// Required zone types.
    /// </summary>
    public List<string> ZoneTypes { get; set; } = new();
```

Required zone types.

### MinDistanceFromBuildings

```csharp
/// <summary>
    /// Minimum distance from other buildings.
    /// </summary>
    public int MinDistanceFromBuildings { get; set; } = 0;
```

Minimum distance from other buildings.

### MaxDistanceFromBuildingTypes

```csharp
/// <summary>
    /// Maximum distance from certain building types.
    /// Key: Building type, Value: Maximum distance
    /// </summary>
    public Dictionary<string, int> MaxDistanceFromBuildingTypes { get; set; } = new();
```

Maximum distance from certain building types.
Key: Building type, Value: Maximum distance

### RequiresWater

```csharp
/// <summary>
    /// Whether the building must be placed near water.
    /// </summary>
    public bool RequiresWater { get; set; } = false;
```

Whether the building must be placed near water.

### RequiresFlatTerrain

```csharp
/// <summary>
    /// Whether the building must be placed on flat terrain.
    /// </summary>
    public bool RequiresFlatTerrain { get; set; } = false;
```

Whether the building must be placed on flat terrain.

### CustomRequirements

```csharp
/// <summary>
    /// Custom requirements.
    /// Key: Requirement name, Value: Requirement data
    /// </summary>
    public Dictionary<string, object> CustomRequirements { get; set; } = new();
```

Custom requirements.
Key: Requirement name, Value: Requirement data

