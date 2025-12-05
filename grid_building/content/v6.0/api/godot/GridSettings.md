---
title: "GridSettings"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/gridsettings/"
---

# GridSettings

```csharp
GridBuilding.Godot.Tests.Validation
class GridSettings
{
    // Members...
}
```

Handles grid coordinate conversions.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Validation/GridCoordinateTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CellSize

```csharp
public float CellSize { get; }
```

### HalfCellSize

```csharp
public float HalfCellSize => CellSize / 2;
```

### OffsetX

```csharp
public float OffsetX { get; }
```

### OffsetY

```csharp
public float OffsetY { get; }
```


## Methods

### WorldToGrid

```csharp
public GridPos WorldToGrid(float worldX, float worldY)
    {
        float adjustedX = worldX - OffsetX;
        float adjustedY = worldY - OffsetY;
        
        int gridX = (int)MathF.Floor(adjustedX / CellSize);
        int gridY = (int)MathF.Floor(adjustedY / CellSize);
        
        return new GridPos(gridX, gridY);
    }
```

**Returns:** `GridPos`

**Parameters:**
- `float worldX`
- `float worldY`

### GridToWorld

```csharp
public WorldPos GridToWorld(int gridX, int gridY)
    {
        float worldX = gridX * CellSize + HalfCellSize + OffsetX;
        float worldY = gridY * CellSize + HalfCellSize + OffsetY;
        
        return new WorldPos(worldX, worldY);
    }
```

**Returns:** `WorldPos`

**Parameters:**
- `int gridX`
- `int gridY`

### GetCellBounds

```csharp
public WorldRect GetCellBounds(int gridX, int gridY)
    {
        float worldX = gridX * CellSize + OffsetX;
        float worldY = gridY * CellSize + OffsetY;
        
        return new WorldRect(worldX, worldY, CellSize, CellSize);
    }
```

**Returns:** `WorldRect`

**Parameters:**
- `int gridX`
- `int gridY`

### GetCellCorners

```csharp
public WorldPos[] GetCellCorners(int gridX, int gridY)
    {
        var bounds = GetCellBounds(gridX, gridY);
        return new[]
        {
            new WorldPos(bounds.X, bounds.Y),
            new WorldPos(bounds.X + bounds.Width, bounds.Y),
            new WorldPos(bounds.X + bounds.Width, bounds.Y + bounds.Height),
            new WorldPos(bounds.X, bounds.Y + bounds.Height)
        };
    }
```

**Returns:** `WorldPos[]`

**Parameters:**
- `int gridX`
- `int gridY`

### GetCellsInRegion

```csharp
public List<GridPos> GetCellsInRegion(GridPos corner1, GridPos corner2)
    {
        int minX = Math.Min(corner1.X, corner2.X);
        int maxX = Math.Max(corner1.X, corner2.X);
        int minY = Math.Min(corner1.Y, corner2.Y);
        int maxY = Math.Max(corner1.Y, corner2.Y);
        
        var cells = new List<GridPos>();
        for (int y = minY; y <= maxY; y++)
        {
            for (int x = minX; x <= maxX; x++)
            {
                cells.Add(new GridPos(x, y));
            }
        }
        return cells;
    }
```

**Returns:** `List<GridPos>`

**Parameters:**
- `GridPos corner1`
- `GridPos corner2`

### GetCellsInWorldRegion

```csharp
public List<GridPos> GetCellsInWorldRegion(float worldX, float worldY, float width, float height)
    {
        var topLeft = WorldToGrid(worldX, worldY);
        var bottomRight = WorldToGrid(worldX + width - 0.001f, worldY + height - 0.001f);
        
        return GetCellsInRegion(topLeft, bottomRight);
    }
```

**Returns:** `List<GridPos>`

**Parameters:**
- `float worldX`
- `float worldY`
- `float width`
- `float height`

