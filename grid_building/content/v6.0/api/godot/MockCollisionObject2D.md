---
title: "MockCollisionObject2D"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/mockcollisionobject2d/"
---

# MockCollisionObject2D

```csharp
GridBuilding.Godot.Tests.GoDotTest.Helpers
class MockCollisionObject2D
{
    // Members...
}
```

Mock CollisionObject2D implementation for testing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/GodotMockNode2D.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### HasCollisionLayer

```csharp
/// <summary>
    /// Helper method to test collision layer operations.
    /// </summary>
    public bool HasCollisionLayer(int layer)
    {
        return GetCollisionLayerValue(layer);
    }
```

Helper method to test collision layer operations.

**Returns:** `bool`

**Parameters:**
- `int layer`

### SetCollisionLayerForTest

```csharp
/// <summary>
    /// Helper method to set collision layer for testing.
    /// </summary>
    public void SetCollisionLayerForTest(int layer, bool value)
    {
        SetCollisionLayerValue(layer, value);
    }
```

Helper method to set collision layer for testing.

**Returns:** `void`

**Parameters:**
- `int layer`
- `bool value`

