---
title: "PlaceableCategory"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/placeablecategory/"
---

# PlaceableCategory

```csharp
GridBuilding.Core.Systems.Data
class PlaceableCategory
{
    // Members...
}
```

A category of placeables with optional inheritance

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Data/PlaceableCollection.cs`  
**Namespace:** `GridBuilding.Core.Systems.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
public string Id { get; set; } = "";
```

### DisplayName

```csharp
public string DisplayName { get; set; } = "";
```

### Icon

```csharp
public string? Icon { get; set; }
```

### Placeables

```csharp
public Dictionary<string, IPlaceable> Placeables { get; set; } = new();
```

### CustomData

```csharp
public Dictionary<string, object> CustomData { get; set; } = new();
```

