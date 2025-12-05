---
title: "PreviewShapeDataGodot"
description: "Godot-compatible preview shape data."
weight: 20
url: "/gridbuilding/v6-0/api/godot/previewshapedatagodot/"
---

# PreviewShapeDataGodot

```csharp
GridBuilding.Godot.Systems.Placement.Adapters
class PreviewShapeDataGodot
{
    // Members...
}
```

Godot-compatible preview shape data.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Adapters/PreviewCalculationWrapper.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Adapters`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ShapeType

```csharp
public PreviewShapeTypeGodot ShapeType { get; set; }
```

### Size

```csharp
public Godot.Vector2I Size { get; set; }
```

### Radius

```csharp
public int Radius { get; set; }
```

### PolygonPoints

```csharp
public List<Godot.Vector2I> PolygonPoints { get; set; } = new();
```

