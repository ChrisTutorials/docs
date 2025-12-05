---
title: "RectBounds"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/rectbounds/"
---

# RectBounds

```csharp
GridBuilding.Godot.Tests.Validation
class RectBounds
{
    // Members...
}
```

Represents rectangular bounds in world coordinates.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Validation/BoundsValidationTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### X

```csharp
public float X { get; }
```

### Y

```csharp
public float Y { get; }
```

### Width

```csharp
public float Width { get; }
```

### Height

```csharp
public float Height { get; }
```

### Right

```csharp
public float Right => X + Width;
```

### Bottom

```csharp
public float Bottom => Y + Height;
```

### Area

```csharp
public float Area => Width * Height;
```

### Perimeter

```csharp
public float Perimeter => 2 * (Width + Height);
```


## Methods

### Contains

```csharp
public bool Contains(float px, float py)
    {
        return px >= X && px < Right && py >= Y && py < Bottom;
    }
```

**Returns:** `bool`

**Parameters:**
- `float px`
- `float py`

### Intersects

```csharp
public bool Intersects(RectBounds other)
    {
        return X < other.Right && Right > other.X && Y < other.Bottom && Bottom > other.Y;
    }
```

**Returns:** `bool`

**Parameters:**
- `RectBounds other`

### GetIntersection

```csharp
public RectBounds? GetIntersection(RectBounds other)
    {
        if (!Intersects(other)) return null;
        
        var x = Math.Max(X, other.X);
        var y = Math.Max(Y, other.Y);
        var right = Math.Min(Right, other.Right);
        var bottom = Math.Min(Bottom, other.Bottom);
        
        return new RectBounds(x, y, right - x, bottom - y);
    }
```

**Returns:** `RectBounds?`

**Parameters:**
- `RectBounds other`

### ToTileBounds

```csharp
public TileBounds ToTileBounds(int tileSize)
    {
        var startX = (int)Math.Floor(X / tileSize);
        var startY = (int)Math.Floor(Y / tileSize);
        var endX = (int)Math.Ceiling(Right / tileSize);
        var endY = (int)Math.Ceiling(Bottom / tileSize);
        
        return new TileBounds(startX, startY, endX, endY);
    }
```

**Returns:** `TileBounds`

**Parameters:**
- `int tileSize`

