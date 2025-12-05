---
title: "CoreTypeExtensions"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/coretypeextensions/"
---

# CoreTypeExtensions

```csharp
GridBuilding.Godot.Extensions
class CoreTypeExtensions
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/CoreTypeExtensions.cs`  
**Namespace:** `GridBuilding.Godot.Extensions`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ToCore

```csharp
public static CoreVector2 ToCore(this Vector2 v) => new(v.X, v.Y);
```

**Returns:** `CoreVector2`

**Parameters:**
- `Vector2 v`

### ToGodot

```csharp
public static Vector2 ToGodot(this CoreVector2 v) => new(v.X, v.Y);
```

**Returns:** `Vector2`

**Parameters:**
- `CoreVector2 v`

### ToCore

```csharp
public static CoreVector2[] ToCore(this Vector2[] vArray)
    {
        if (vArray == null) return System.Array.Empty<CoreVector2>();
        var result = new CoreVector2[vArray.Length];
        for (int i = 0; i < vArray.Length; i++)
        {
            result[i] = vArray[i].ToCore();
        }
        return result;
    }
```

**Returns:** `CoreVector2[]`

**Parameters:**
- `Vector2[] vArray`

### ToGodot

```csharp
public static Vector2[] ToGodot(this CoreVector2[] vArray)
    {
        if (vArray == null) return System.Array.Empty<Vector2>();
        var result = new Vector2[vArray.Length];
        for (int i = 0; i < vArray.Length; i++)
        {
            result[i] = vArray[i].ToGodot();
        }
        return result;
    }
```

**Returns:** `Vector2[]`

**Parameters:**
- `CoreVector2[] vArray`

### ToCore

```csharp
public static CoreRect2 ToCore(this Rect2 r) => new(r.Position.ToCore(), r.Size.ToCore());
```

**Returns:** `CoreRect2`

**Parameters:**
- `Rect2 r`

### ToGodot

```csharp
public static Rect2 ToGodot(this CoreRect2 r) => new(r.Position.ToGodot(), r.Size.ToGodot());
```

**Returns:** `Rect2`

**Parameters:**
- `CoreRect2 r`

### ToCore

```csharp
public static CoreTileShape ToCore(this TileSet.TileShapeEnum shape) => shape switch
    {
        TileSet.TileShapeEnum.Square => CoreTileShape.Square,
        TileSet.TileShapeEnum.Isometric => CoreTileShape.Isometric,
        TileSet.TileShapeEnum.HalfOffsetSquare => CoreTileShape.HalfOffsetSquare,
        TileSet.TileShapeEnum.Hexagon => CoreTileShape.Hexagon,
        _ => CoreTileShape.Square
    };
```

**Returns:** `CoreTileShape`

**Parameters:**
- `TileSet.TileShapeEnum shape`

