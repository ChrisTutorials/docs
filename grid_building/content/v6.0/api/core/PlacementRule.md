---
title: "PlacementRule"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/placementrule/"
---

# PlacementRule

```csharp
GridBuilding.Core.Systems.Data
class PlacementRule
{
    // Members...
}
```

Placement rule for a placeable

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Data/PlaceableCollection.cs`  
**Namespace:** `GridBuilding.Core.Systems.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Type

```csharp
public string Type { get; set; } = "";
```

### Parameters

```csharp
public Dictionary<string, object> Parameters { get; set; } = new();
```

### Invert

```csharp
public bool? Invert { get; set; }
```

### RequiredTags

```csharp
public string[]? RequiredTags { get; set; }
```

### ExcludedTags

```csharp
public string[]? ExcludedTags { get; set; }
```

