---
title: "RectangleI"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/rectanglei/"
---

# RectangleI

```csharp
GridBuilding.Core.Types
struct RectangleI
{
    // Members...
}
```

Rectangle integer type for grid operations
Pure C# implementation without Godot dependencies

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/RectangleI.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Position

```csharp
public Vector2I Position { get; set; }
```

### Size

```csharp
public Vector2I Size { get; set; }
```


## Methods

### Contains

```csharp
public bool Contains(Vector2I point)
        {
            return point.X >= Position.X && point.Y >= Position.Y &&
                   point.X < Position.X + Size.X && point.Y < Position.Y + Size.Y;
        }
```

**Returns:** `bool`

**Parameters:**
- `Vector2I point`

