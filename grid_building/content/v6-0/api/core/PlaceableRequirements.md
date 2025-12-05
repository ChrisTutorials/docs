---
title: "PlaceableRequirements"
description: "Requirements for placing a placeable"
weight: 10
url: "/gridbuilding/v6-0/api/core/placeablerequirements/"
---

# PlaceableRequirements

```csharp
GridBuilding.Core.Systems.Data
class PlaceableRequirements
{
    // Members...
}
```

Requirements for placing a placeable

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Data/PlaceableCollection.cs`  
**Namespace:** `GridBuilding.Core.Systems.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Cost

```csharp
public int Cost { get; set; } = 0;
```

### RequiredLevel

```csharp
public int RequiredLevel { get; set; } = 0;
```

### RequiredTags

```csharp
public string[] RequiredTags { get; set; } = Array.Empty<string>();
```

### CustomData

```csharp
public Dictionary<string, object> CustomData { get; set; } = new();
```

