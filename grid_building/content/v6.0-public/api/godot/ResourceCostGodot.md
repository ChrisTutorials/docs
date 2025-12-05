---
title: "ResourceCostGodot"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/resourcecostgodot/"
---

# ResourceCostGodot

```csharp
GridBuilding.Godot.Systems.Placement.Adapters
class ResourceCostGodot
{
    // Members...
}
```

Godot-compatible resource cost data.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Adapters/PreviewCalculationWrapper.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Adapters`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Gold

```csharp
public int Gold { get; set; }
```

### Wood

```csharp
public int Wood { get; set; }
```

### Stone

```csharp
public int Stone { get; set; }
```

### Food

```csharp
public int Food { get; set; }
```

### CustomResources

```csharp
public Dictionary<string, int> CustomResources { get; set; } = new();
```

