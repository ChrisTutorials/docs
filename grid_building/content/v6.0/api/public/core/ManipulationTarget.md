---
title: "ManipulationTarget"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/manipulationtarget/"
---

# ManipulationTarget

```csharp
GridBuilding.Core.Systems.Manipulation
class ManipulationTarget
{
    // Members...
}
```

Target for manipulation operations.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Placement/Manipulation/ManipulationTypes.cs`  
**Namespace:** `GridBuilding.Core.Systems.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; }
```

### Position

```csharp
public Vector2 Position { get; set; }
```

### Rotation

```csharp
public float Rotation { get; set; }
```

### Scale

```csharp
public Vector2 Scale { get; set; }
```

### CanMove

```csharp
public bool CanMove { get; set; } = true;
```

### CanRotate

```csharp
public bool CanRotate { get; set; } = true;
```

### CanFlip

```csharp
public bool CanFlip { get; set; } = true;
```

### CanDemolish

```csharp
public bool CanDemolish { get; set; } = true;
```


## Methods

### Rotate

```csharp
public void Rotate(float angle)
    {
        Rotation += angle;
    }
```

**Returns:** `void`

**Parameters:**
- `float angle`

### Flip

```csharp
public void Flip(FlipDirection direction)
    {
        Scale = direction switch
        {
            FlipDirection.Horizontal => new Vector2(-Scale.X, Scale.Y),
            FlipDirection.Vertical => new Vector2(Scale.X, -Scale.Y),
            _ => Scale
        };
    }
```

**Returns:** `void`

**Parameters:**
- `FlipDirection direction`

### Demolish

```csharp
public void Demolish()
    {
        // Demolish logic would be implemented here
    }
```

**Returns:** `void`

