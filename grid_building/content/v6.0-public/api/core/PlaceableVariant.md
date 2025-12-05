---
title: "PlaceableVariant"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/placeablevariant/"
---

# PlaceableVariant

```csharp
GridBuilding.Core.Systems.Data
class PlaceableVariant
{
    // Members...
}
```

Variant of a placeable with different properties

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

### Scene

```csharp
public string? Scene { get; set; } // Override default scene
```

### Icon

```csharp
public string? Icon { get; set; }
```

### Requirements

```csharp
public PlaceableRequirements? Requirements { get; set; }
```

### CustomData

```csharp
public Dictionary<string, object> CustomData { get; set; } = new();
```

