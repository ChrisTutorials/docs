---
title: "GodotMockNode2D"
description: "Mock Node2D implementation for GoDotTest integration tests.
Inherits from Godot.Node2D and requires Godot runtime.
For POCS tests, use MockNode2D in Manipulation/Types instead."
weight: 20
url: "/gridbuilding/v6-0/api/godot/godotmocknode2d/"
---

# GodotMockNode2D

```csharp
GridBuilding.Godot.Tests.GoDotTest.Helpers
class GodotMockNode2D
{
    // Members...
}
```

Mock Node2D implementation for GoDotTest integration tests.
Inherits from Godot.Node2D and requires Godot runtime.
For POCS tests, use MockNode2D in Manipulation/Types instead.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/GodotMockNode2D.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _Ready

```csharp
/// <summary>
    /// Override to make testing easier without requiring scene tree.
    /// </summary>
    public override void _Ready()
    {
        base._Ready();
    }
```

Override to make testing easier without requiring scene tree.

**Returns:** `void`

### SetTestPosition

```csharp
/// <summary>
    /// Helper method to set position without requiring scene tree.
    /// </summary>
    public void SetTestPosition(Vector2 position)
    {
        if (IsInsideTree())
        {
            GlobalPosition = position;
        }
        else
        {
            Position = position;
        }
    }
```

Helper method to set position without requiring scene tree.

**Returns:** `void`

**Parameters:**
- `Vector2 position`

### GetTestPosition

```csharp
/// <summary>
    /// Helper method to get position without requiring scene tree.
    /// </summary>
    public Vector2 GetTestPosition()
    {
        if (IsInsideTree())
        {
            return GlobalPosition;
        }
        else
        {
            return Position;
        }
    }
```

Helper method to get position without requiring scene tree.

**Returns:** `Vector2`

### SetTestRotation

```csharp
/// <summary>
    /// Helper method to set rotation without requiring scene tree.
    /// </summary>
    public void SetTestRotation(float rotation)
    {
        if (IsInsideTree())
        {
            GlobalRotation = rotation;
        }
        else
        {
            Rotation = rotation;
        }
    }
```

Helper method to set rotation without requiring scene tree.

**Returns:** `void`

**Parameters:**
- `float rotation`

### GetTestRotation

```csharp
/// <summary>
    /// Helper method to get rotation without requiring scene tree.
    /// </summary>
    public float GetTestRotation()
    {
        if (IsInsideTree())
        {
            return GlobalRotation;
        }
        else
        {
            return Rotation;
        }
    }
```

Helper method to get rotation without requiring scene tree.

**Returns:** `float`

