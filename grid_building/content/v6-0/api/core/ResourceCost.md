---
title: "ResourceCost"
description: "Resource cost data for building placement."
weight: 10
url: "/gridbuilding/v6-0/api/core/resourcecost/"
---

# ResourceCost

```csharp
GridBuilding.Core.Data.Placement
class ResourceCost
{
    // Members...
}
```

Resource cost data for building placement.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/Placement/BuildingData.cs`  
**Namespace:** `GridBuilding.Core.Data.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Gold

```csharp
/// <summary>
    /// Gold cost.
    /// </summary>
    public int Gold { get; set; } = 0;
```

Gold cost.

### Wood

```csharp
/// <summary>
    /// Wood cost.
    /// </summary>
    public int Wood { get; set; } = 0;
```

Wood cost.

### Stone

```csharp
/// <summary>
    /// Stone cost.
    /// </summary>
    public int Stone { get; set; } = 0;
```

Stone cost.

### Food

```csharp
/// <summary>
    /// Food cost.
    /// </summary>
    public int Food { get; set; } = 0;
```

Food cost.

### CustomResources

```csharp
/// <summary>
    /// Custom resource costs.
    /// Key: Resource name, Value: Amount
    /// </summary>
    public Dictionary<string, int> CustomResources { get; set; } = new();
```

Custom resource costs.
Key: Resource name, Value: Amount


## Methods

### CanAfford

```csharp
/// <summary>
    /// Checks if the player can afford this cost.
    /// </summary>
    public bool CanAfford(IResourceProvider resources)
    {
        return resources.HasGold(Gold) &&
               resources.HasWood(Wood) &&
               resources.HasStone(Stone) &&
               resources.HasFood(Food) &&
               CustomResources.All(entry => resources.HasCustomResource(entry.Key, entry.Value));
    }
```

Checks if the player can afford this cost.

**Returns:** `bool`

**Parameters:**
- `IResourceProvider resources`

