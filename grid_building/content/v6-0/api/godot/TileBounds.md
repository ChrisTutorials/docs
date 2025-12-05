---
title: "TileBounds"
description: "Represents bounds in tile coordinates."
weight: 20
url: "/gridbuilding/v6-0/api/godot/tilebounds/"
---

# TileBounds

```csharp
GridBuilding.Godot.Tests.Validation
class TileBounds
{
    // Members...
}
```

Represents bounds in tile coordinates.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Validation/BoundsValidationTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### StartX

```csharp
public int StartX { get; }
```

### StartY

```csharp
public int StartY { get; }
```

### EndX

```csharp
public int EndX { get; }
```

### EndY

```csharp
public int EndY { get; }
```

### TileWidth

```csharp
public int TileWidth => EndX - StartX;
```

### TileHeight

```csharp
public int TileHeight => EndY - StartY;
```

### TileCount

```csharp
public int TileCount => TileWidth * TileHeight;
```


## Methods

### EnumerateTiles

```csharp
public IEnumerable<(int x, int y)> EnumerateTiles()
    {
        for (int y = StartY; y < EndY; y++)
        {
            for (int x = StartX; x < EndX; x++)
            {
                yield return (x, y);
            }
        }
    }
```

**Returns:** `IEnumerable<(int x, int y)>`

