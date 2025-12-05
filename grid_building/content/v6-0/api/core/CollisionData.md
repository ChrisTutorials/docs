---
title: "CollisionData"
description: "Collision data for placeables"
weight: 10
url: "/gridbuilding/v6-0/api/core/collisiondata/"
---

# CollisionData

```csharp
GridBuilding.Core.Data
class CollisionData
{
    // Members...
}
```

Collision data for placeables

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Data/CollisionData.cs`  
**Namespace:** `GridBuilding.Core.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### HasCollision

```csharp
/// <summary>
        /// Whether this placeable has collision
        /// </summary>
        public bool HasCollision { get; set; } = true;
```

Whether this placeable has collision

### CollisionShape

```csharp
/// <summary>
        /// Collision shape type
        /// </summary>
        public string CollisionShape { get; set; } = "rectangle";
```

Collision shape type

### Bounds

```csharp
/// <summary>
        /// Collision bounds
        /// </summary>
        public GridBuilding.Core.Types.Rect2I Bounds { get; set; }
```

Collision bounds

### CollisionLayer

```csharp
/// <summary>
        /// Layer mask for collision
        /// </summary>
        public int CollisionLayer { get; set; } = 1;
```

Layer mask for collision

### CollisionMask

```csharp
/// <summary>
        /// Layer mask for what this collides with
        /// </summary>
        public int CollisionMask { get; set; } = 1;
```

Layer mask for what this collides with

