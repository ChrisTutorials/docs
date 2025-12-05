---
title: "CollisionProcessorOutput"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/collisionprocessoroutput/"
---

# CollisionProcessorOutput

```csharp
GridBuilding.Core.Types
class CollisionProcessorOutput
{
    // Members...
}
```

Output data from collision processing operations

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/CollisionProcessorTypes.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### AffectedTiles

```csharp
/// <summary>
    /// List of affected tile positions
    /// </summary>
    public List<Vector2I> AffectedTiles { get; set; } = new();
```

List of affected tile positions

### HasCollision

```csharp
/// <summary>
    /// Whether collision was detected
    /// </summary>
    public bool HasCollision { get; set; }
```

Whether collision was detected

### CollisionPoints

```csharp
/// <summary>
    /// Collision points or contact areas
    /// </summary>
    public List<Vector2I> CollisionPoints { get; set; } = new();
```

Collision points or contact areas

### OffsetAdjustment

```csharp
/// <summary>
    /// Offset adjustments needed for valid placement
    /// </summary>
    public Vector2I OffsetAdjustment { get; set; }
```

Offset adjustments needed for valid placement

### Metadata

```csharp
/// <summary>
    /// Additional metadata about the collision result
    /// </summary>
    public Dictionary<string, object> Metadata { get; set; } = new();
```

Additional metadata about the collision result

