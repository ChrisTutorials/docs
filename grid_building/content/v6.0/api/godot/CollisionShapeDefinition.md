---
title: "CollisionShapeDefinition"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionshapedefinition/"
---

# CollisionShapeDefinition

```csharp
GridBuilding.Godot.Test.Factories
class CollisionShapeDefinition
{
    // Members...
}
```

Definition of a collision shape for testing

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/PlaceableTestFactory.cs`  
**Namespace:** `GridBuilding.Godot.Test.Factories`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Type

```csharp
public CollisionShapeType Type { get; set; } = CollisionShapeType.Rectangle;
```

### Size

```csharp
public Vector2 Size { get; set; } = Vector2.One;
```

### Offset

```csharp
public Vector2 Offset { get; set; } = Vector2.Zero;
```

### Radius

```csharp
public float Radius { get; set; } = 0f;
```

### Points

```csharp
public Vector2[] Points { get; set; } = new Vector2[0];
```

