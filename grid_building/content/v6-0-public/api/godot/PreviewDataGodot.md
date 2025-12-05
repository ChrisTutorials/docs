---
title: "PreviewDataGodot"
description: "Godot-compatible preview data."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/previewdatagodot/"
---

# PreviewDataGodot

```csharp
GridBuilding.Godot.Systems.Placement.Adapters
class PreviewDataGodot
{
    // Members...
}
```

Godot-compatible preview data.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Adapters/PreviewCalculationWrapper.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Adapters`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### FootprintPositions

```csharp
public List<Godot.Vector2I> FootprintPositions { get; set; } = new();
```

### Bounds

```csharp
public RectangleGodot Bounds { get; set; }
```

### IsValidPlacement

```csharp
public bool IsValidPlacement { get; set; }
```

### Transparency

```csharp
public float Transparency { get; set; }
```

### TintColor

```csharp
public Godot.Color TintColor { get; set; }
```

### ShapeData

```csharp
public PreviewShapeDataGodot ShapeData { get; set; }
```

### Issues

```csharp
public List<string> Issues { get; set; } = new();
```

### Notes

```csharp
public List<string> Notes { get; set; } = new();
```

