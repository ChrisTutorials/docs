---
title: "PreviewShapeData"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/previewshapedata/"
---

# PreviewShapeData

```csharp
GridBuilding.Core.Services.Placement
class PreviewShapeData
{
    // Members...
}
```

Preview shape data for rendering
Pure C# implementation without Godot dependencies

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Placement/PlacementTypes.cs`  
**Namespace:** `GridBuilding.Core.Services.Placement`  
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

### Shape

```csharp
public string Shape { get; set; } = "Rectangle"; // Rectangle, Circle, etc.
```

### Color

```csharp
public string Color { get; set; } = "#00FF00";
```

### Opacity

```csharp
public float Opacity { get; set; } = 0.5f;
```

### IsValid

```csharp
public bool IsValid { get; set; } = true;
```

