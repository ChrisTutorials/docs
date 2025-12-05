---
title: "CollisionScenarioData"
description: "Collision scenario data for pure C# processing"
weight: 10
url: "/gridbuilding/v6-0/api/core/collisionscenariodata/"
---

# CollisionScenarioData

```csharp
GridBuilding.Core.Geometry
class CollisionScenarioData
{
    // Members...
}
```

Collision scenario data for pure C# processing

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/CollisionProcessor.cs`  
**Namespace:** `GridBuilding.Core.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### RectCollisionTestSetups

```csharp
public List<RectCollisionTestingSetup> RectCollisionTestSetups { get; set; } = new();
```

### CollisionObjectPosition

```csharp
public Vector2 CollisionObjectPosition { get; set; }
```

### ShapeOwners

```csharp
public List<ShapeOwnerData> ShapeOwners { get; set; } = new();
```


## Methods

### ValidateSetup

```csharp
public bool ValidateSetup()
    {
        if (RectCollisionTestSetups.Count == 0)
            return false;

        foreach (var setup in RectCollisionTestSetups)
        {
            if (setup.ShapeData == null)
                return false;
        }

        return true;
    }
```

**Returns:** `bool`

