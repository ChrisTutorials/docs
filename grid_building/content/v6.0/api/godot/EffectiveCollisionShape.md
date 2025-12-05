---
title: "EffectiveCollisionShape"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/effectivecollisionshape/"
---

# EffectiveCollisionShape

```csharp
GridBuilding.Godot.Shared.Utils.Collision
class EffectiveCollisionShape
{
    // Members...
}
```

Effective collision shape representation.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/CollisionObjectResolver.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Utils.Collision`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Type

```csharp
public EffectiveShapeType Type { get; set; }
```

### Bounds

```csharp
public Rect2 Bounds { get; set; }
```

### Polygon

```csharp
public Vector2[] Polygon { get; set; } = Array.Empty<Vector2>();
```

