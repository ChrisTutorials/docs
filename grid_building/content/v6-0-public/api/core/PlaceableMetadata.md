---
title: "PlaceableMetadata"
description: "Metadata for the placeable collection"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/placeablemetadata/"
---

# PlaceableMetadata

```csharp
GridBuilding.Core.Systems.Data
class PlaceableMetadata
{
    // Members...
}
```

Metadata for the placeable collection

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Data/PlaceableCollection.cs`  
**Namespace:** `GridBuilding.Core.Systems.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; } = "";
```

### Description

```csharp
public string Description { get; set; } = "";
```

### Author

```csharp
public string Author { get; set; } = "";
```

### Version

```csharp
public string Version { get; set; } = "1.0";
```

### CustomData

```csharp
public Dictionary<string, object> CustomData { get; set; } = new();
```

