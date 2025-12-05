---
title: "ExternalSourceMetadata"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/externalsourcemetadata/"
---

# ExternalSourceMetadata

```csharp
GridBuilding.Core.Interfaces
class ExternalSourceMetadata
{
    // Members...
}
```

Metadata about external data sources

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Interfaces/IPlaceableDataProvider.cs`  
**Namespace:** `GridBuilding.Core.Interfaces`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; }
```

### Version

```csharp
public string Version { get; set; }
```

### Format

```csharp
public string Format { get; set; }
```

### PlaceableCount

```csharp
public int PlaceableCount { get; set; }
```

### Properties

```csharp
public Dictionary<string, object> Properties { get; set; } = new();
```

