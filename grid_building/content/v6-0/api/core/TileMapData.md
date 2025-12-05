---
title: "TileMapData"
description: "Tile map data for pure C# processing"
weight: 10
url: "/gridbuilding/v6-0/api/core/tilemapdata/"
---

# TileMapData

```csharp
GridBuilding.Core.Geometry
class TileMapData
{
    // Members...
}
```

Tile map data for pure C# processing

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/CollisionProcessor.cs`  
**Namespace:** `GridBuilding.Core.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TileSize

```csharp
public Vector2 TileSize { get; set; }
```

### TileShape

```csharp
public TileShape TileShape { get; set; }
```

### MapSize

```csharp
public Vector2I MapSize { get; set; }
```

### Tiles

```csharp
public Dictionary<Vector2I, TileData> Tiles { get; set; } = new();
```

