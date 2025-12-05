---
title: "OccupantData"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/occupantdata/"
---

# OccupantData

```csharp
GridBuilding.Core.Data.Placement
class OccupantData
{
    // Members...
}
```

Implementation of occupant data for grid positions.
Contains pure business logic without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/Placement/OccupantData.cs`  
**Namespace:** `GridBuilding.Core.Data.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
public string Id { get; set; } = string.Empty;
```

### Type

```csharp
public string Type { get; set; } = string.Empty;
```

### BlocksPlacement

```csharp
public bool BlocksPlacement { get; set; } = true;
```

### Properties

```csharp
public Dictionary<string, object> Properties { get; set; } = new();
```

