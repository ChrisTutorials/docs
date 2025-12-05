---
title: "FootprintDataGodot"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/footprintdatagodot/"
---

# FootprintDataGodot

```csharp
GridBuilding.Godot.Systems.Placement.Adapters
class FootprintDataGodot
{
    // Members...
}
```

Godot-compatible footprint data.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Adapters/PreviewCalculationWrapper.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Adapters`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
public string Id { get; set; } = string.Empty;
```

### ShapeType

```csharp
public FootprintShapeTypeGodot ShapeType { get; set; }
```

### Size

```csharp
public Godot.Vector2I Size { get; set; }
```

### Offset

```csharp
public Godot.Vector2I Offset { get; set; }
```

### CanRotate

```csharp
public bool CanRotate { get; set; } = true;
```

### CanFlip

```csharp
public bool CanFlip { get; set; } = false;
```

### Radius

```csharp
public int Radius { get; set; }
```

### PolygonPoints

```csharp
public List<Godot.Vector2I> PolygonPoints { get; set; } = new();
```

