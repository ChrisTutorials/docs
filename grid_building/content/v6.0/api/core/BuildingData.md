---
title: "BuildingData"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/buildingdata/"
---

# BuildingData

```csharp
GridBuilding.Core.Data.Placement
class BuildingData
{
    // Members...
}
```

Core building data without Godot dependencies.
Contains all information needed for placement calculations.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/Placement/BuildingData.cs`  
**Namespace:** `GridBuilding.Core.Data.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
/// <summary>
    /// Unique identifier for the building.
    /// </summary>
    public string Id { get; set; } = string.Empty;
```

Unique identifier for the building.

### Name

```csharp
/// <summary>
    /// Human-readable name of the building.
    /// </summary>
    public string Name { get; set; } = string.Empty;
```

Human-readable name of the building.

### Description

```csharp
/// <summary>
    /// Description of the building.
    /// </summary>
    public string Description { get; set; } = string.Empty;
```

Description of the building.

### BuildingType

```csharp
/// <summary>
    /// Building type/category.
    /// </summary>
    public string BuildingType { get; set; } = string.Empty;
```

Building type/category.

### Footprint

```csharp
/// <summary>
    /// Footprint data for the building.
    /// </summary>
    public FootprintData Footprint { get; set; } = new();
```

Footprint data for the building.

### CanPlace

```csharp
/// <summary>
    /// Whether the building can be placed.
    /// </summary>
    public bool CanPlace { get; set; } = true;
```

Whether the building can be placed.

### CanRotate

```csharp
/// <summary>
    /// Whether the building can be rotated.
    /// </summary>
    public bool CanRotate { get; set; } = true;
```

Whether the building can be rotated.

### CanFlip

```csharp
/// <summary>
    /// Whether the building can be flipped.
    /// </summary>
    public bool CanFlip { get; set; } = false;
```

Whether the building can be flipped.

### ResourceCost

```csharp
/// <summary>
    /// Resource cost for placing the building.
    /// </summary>
    public ResourceCost ResourceCost { get; set; } = new();
```

Resource cost for placing the building.

### Requirements

```csharp
/// <summary>
    /// Placement requirements.
    /// </summary>
    public PlacementRequirements Requirements { get; set; } = new();
```

Placement requirements.

### DefaultTransparency

```csharp
/// <summary>
    /// Default preview transparency.
    /// </summary>
    public float DefaultTransparency { get; set; } = 0.5f;
```

Default preview transparency.

### ValidColor

```csharp
/// <summary>
    /// Default valid placement color.
    /// </summary>
    public Color ValidColor { get; set; } = new Color(0.0f, 1.0f, 0.0f, 0.5f);
```

Default valid placement color.

### InvalidColor

```csharp
/// <summary>
    /// Default invalid placement color.
    /// </summary>
    public Color InvalidColor { get; set; } = new Color(1.0f, 0.0f, 0.0f, 0.35f);
```

Default invalid placement color.

