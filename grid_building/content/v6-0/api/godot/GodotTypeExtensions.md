---
title: "GodotTypeExtensions"
description: "Godot-specific extension methods for type conversions"
weight: 20
url: "/gridbuilding/v6-0/api/godot/godottypeextensions/"
---

# GodotTypeExtensions

```csharp
GridBuilding.Godot.Extensions
class GodotTypeExtensions
{
    // Members...
}
```

Godot-specific extension methods for type conversions

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Extensions/GodotTypeExtensions.cs`  
**Namespace:** `GridBuilding.Godot.Extensions`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ToCore

```csharp
#region TileShape Conversions

    /// <summary>
    /// Converts Godot TileSet.TileShapeEnum to Core TileShape
    /// </summary>
    public static TileShape ToCore(this TileSet.TileShapeEnum godotTileShape)
    {
        return godotTileShape switch
        {
            TileSet.TileShapeEnum.Square => TileShape.Square,
            TileSet.TileShapeEnum.Isometric => TileShape.Isometric,
            TileSet.TileShapeEnum.HalfOffsetSquare => TileShape.HalfOffsetSquare,
            TileSet.TileShapeEnum.Hexagon => TileShape.Hexagon,
            _ => TileShape.Square
        };
    }
```

Converts Godot TileSet.TileShapeEnum to Core TileShape

**Returns:** `TileShape`

**Parameters:**
- `TileSet.TileShapeEnum godotTileShape`

### ToGodot

```csharp
/// <summary>
    /// Converts Core TileShape to Godot TileSet.TileShapeEnum
    /// </summary>
    public static TileSet.TileShapeEnum ToGodot(this TileShape coreTileShape)
    {
        return coreTileShape switch
        {
            TileShape.Square => TileSet.TileShapeEnum.Square,
            TileShape.Isometric => TileSet.TileShapeEnum.Isometric,
            TileShape.HalfOffsetSquare => TileSet.TileShapeEnum.HalfOffsetSquare,
            TileShape.Hexagon => TileSet.TileShapeEnum.Hexagon,
            _ => TileSet.TileShapeEnum.Square
        };
    }
```

Converts Core TileShape to Godot TileSet.TileShapeEnum

**Returns:** `TileSet.TileShapeEnum`

**Parameters:**
- `TileShape coreTileShape`

