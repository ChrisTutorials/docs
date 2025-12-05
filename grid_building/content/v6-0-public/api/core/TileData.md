---
title: "TileData"
description: "Tile data for pure C# processing"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/tiledata/"
---

# TileData

```csharp
GridBuilding.Core.Geometry
class TileData
{
    // Members...
}
```

Tile data for pure C# processing

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/CollisionProcessor.cs`  
**Namespace:** `GridBuilding.Core.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TileId

```csharp
public int TileId { get; set; }
```

### IsCollidable

```csharp
public bool IsCollidable { get; set; }
```

### CustomData

```csharp
public Dictionary<string, object> CustomData { get; set; } = new();
```

