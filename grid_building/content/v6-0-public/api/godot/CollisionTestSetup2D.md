---
title: "CollisionTestSetup2D"
description: "Test setup data structure for collision testing."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/collisiontestsetup2d/"
---

# CollisionTestSetup2D

```csharp
GridBuilding.Godot.Systems.Placement.Processors
class CollisionTestSetup2D
{
    // Members...
}
```

Test setup data structure for collision testing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Processors/CollisionMapper.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Processors`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CollisionObject

```csharp
public Node2D? CollisionObject { get; set; }
```

### RectCollisionTestSetups

```csharp
public List<RectCollisionTestingSetup> RectCollisionTestSetups { get; set; } = new();
```

