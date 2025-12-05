---
title: "PlacementData"
description: "Concrete implementation of placement data"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/placementdata/"
---

# PlacementData

```csharp
GridBuilding.Core.Data
class PlacementData
{
    // Members...
}
```

Concrete implementation of placement data

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/IPlacementData.cs`  
**Namespace:** `GridBuilding.Core.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### GridPosition

```csharp
public GridBuilding.Core.Types.Rect2I GridPosition { get; set; }
```

### Rotation

```csharp
public float Rotation { get; set; } = 0f;
```

### IsMirrored

```csharp
public bool IsMirrored { get; set; } = false;
```

### InstanceId

```csharp
public string InstanceId { get; set; } = System.Guid.NewGuid().ToString();
```

### Definition

```csharp
public PlaceableDefinition Definition { get; set; } = new();
```

### ValidationResult

```csharp
public GridBuilding.Core.Results.ValidationResult ValidationResult { get; set; } = new();
```

### Properties

```csharp
public System.Collections.Generic.Dictionary<string, object> Properties { get; set; } = new();
```

