---
title: "CollisionShapeOwner"
description: "Information about a collision shape owner."
weight: 20
url: "/gridbuilding/v6-0/api/godot/collisionshapeowner/"
---

# CollisionShapeOwner

```csharp
GridBuilding.Godot.Shared.Utils.Collision
class CollisionShapeOwner
{
    // Members...
}
```

Information about a collision shape owner.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/CollisionObjectResolver.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Utils.Collision`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### OwnerId

```csharp
public uint OwnerId { get; set; }
```

### OwnerNode

```csharp
public Node2D OwnerNode { get; set; }
```

### Transform

```csharp
public Transform2D Transform { get; set; }
```

### Shapes

```csharp
public List<CollisionShapeInfo> Shapes { get; set; } = new();
```

