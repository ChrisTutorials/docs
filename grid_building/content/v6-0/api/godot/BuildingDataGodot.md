---
title: "BuildingDataGodot"
description: "Godot-compatible building data."
weight: 20
url: "/gridbuilding/v6-0/api/godot/buildingdatagodot/"
---

# BuildingDataGodot

```csharp
GridBuilding.Godot.Systems.Placement.Adapters
class BuildingDataGodot
{
    // Members...
}
```

Godot-compatible building data.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Adapters/PreviewCalculationWrapper.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Adapters`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
public string Id { get; set; } = string.Empty;
```

### Name

```csharp
public string Name { get; set; } = string.Empty;
```

### Description

```csharp
public string Description { get; set; } = string.Empty;
```

### BuildingType

```csharp
public string BuildingType { get; set; } = string.Empty;
```

### Footprint

```csharp
public FootprintDataGodot Footprint { get; set; }
```

### CanPlace

```csharp
public bool CanPlace { get; set; } = true;
```

### CanRotate

```csharp
public bool CanRotate { get; set; } = true;
```

### CanFlip

```csharp
public bool CanFlip { get; set; } = false;
```

### ResourceCost

```csharp
public ResourceCostGodot ResourceCost { get; set; }
```

### DefaultTransparency

```csharp
public float DefaultTransparency { get; set; } = 0.5f;
```

### ValidColor

```csharp
public Godot.Color ValidColor { get; set; } = new Godot.Color(0.0f, 1.0f, 0.0f, 0.5f);
```

### InvalidColor

```csharp
public Godot.Color InvalidColor { get; set; } = new Godot.Color(1.0f, 0.0f, 0.0f, 0.35f);
```

