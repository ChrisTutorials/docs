---
title: "Node2D"
description: "POCS Node2D mock - for testing transform calculations"
weight: 20
url: "/gridbuilding/v6-0/api/godot/node2d/"
---

# Node2D

```csharp
GridBuilding.Godot.Tests.Helpers
class Node2D
{
    // Members...
}
```

POCS Node2D mock - for testing transform calculations

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GodotTypes.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Position

```csharp
public Vector2 Position { get; set; } = Vector2.Zero;
```

### GlobalPosition

```csharp
public Vector2 GlobalPosition { get; set; } = Vector2.Zero;
```

### Rotation

```csharp
public float Rotation { get; set; } = 0f;
```

### RotationDegrees

```csharp
public float RotationDegrees 
    { 
        get => Rotation * 180f / MathF.PI;
        set => Rotation = value * MathF.PI / 180f;
    }
```

### Scale

```csharp
public Vector2 Scale { get; set; } = Vector2.One;
```

### Name

```csharp
public string Name { get; set; } = "";
```

