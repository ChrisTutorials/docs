---
title: "Manipulatable"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/manipulatable/"
---

# Manipulatable

```csharp
GridBuilding.Godot.Systems.Manipulation
class Manipulatable
{
    // Members...
}
```

Component that marks a node as manipulatable (can be moved, rotated, etc.).
Ported from: godot/addons/grid_building/shared/components/manipulatable.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/Manipulatable.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Root

```csharp
#region Properties

    /// <summary>
    /// The root node of the manipulatable object.
    /// This is typically the parent or the node itself if it's the root.
    /// </summary>
    public Node2D? Root { get; set; }
```

The root node of the manipulatable object.
This is typically the parent or the node itself if it's the root.

### CanDemolish

```csharp
/// <summary>
    /// Whether this object can be demolished.
    /// </summary>
    public bool CanDemolish { get; set; } = true;
```

Whether this object can be demolished.

### CanMove

```csharp
/// <summary>
    /// Whether this object can be moved.
    /// </summary>
    public bool CanMove { get; set; } = true;
```

Whether this object can be moved.

### CanRotate

```csharp
/// <summary>
    /// Whether this object can be rotated.
    /// </summary>
    public bool CanRotate { get; set; } = true;
```

Whether this object can be rotated.

### CanFlipHorizontal

```csharp
/// <summary>
    /// Whether this object can be flipped horizontally.
    /// </summary>
    public bool CanFlipHorizontal { get; set; } = true;
```

Whether this object can be flipped horizontally.

### CanFlipVertical

```csharp
/// <summary>
    /// Whether this object can be flipped vertically.
    /// </summary>
    public bool CanFlipVertical { get; set; } = true;
```

Whether this object can be flipped vertically.

### CustomData

```csharp
/// <summary>
    /// Custom data associated with this manipulatable object.
    /// </summary>
    public global::Godot.Collections.Dictionary CustomData { get; set; } = new();
```

Custom data associated with this manipulatable object.


## Methods

### _Ready

```csharp
#endregion

    #region Godot Lifecycle

    public override void _Ready()
    {
        // If Root is not set, assume this node or its parent is the root
        if (Root == null)
        {
            Root = this as Node2D ?? GetParent() as Node2D;
        }

        // Validate that we have a valid root
        if (Root == null)
        {
            GD.PrintErr("Manipulatable: Could not determine root node");
        }
    }
```

**Returns:** `void`

### CanPerformAction

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Checks if the specified manipulation action is allowed.
    /// </summary>
    /// <param name="action">The action to check</param>
    /// <returns>True if the action is allowed, false otherwise</returns>
    public bool CanPerformAction(ManipulationAction action)
    {
        return action switch
        {
            ManipulationAction.Move => CanMove,
            ManipulationAction.Rotate_LEFT or ManipulationAction.Rotate_RIGHT => CanRotate,
            ManipulationAction.FLIP_HORIZONTAL => CanFlipHorizontal,
            ManipulationAction.FLIP_VERTICAL => CanFlipVertical,
            ManipulationAction.Demolish => CanDemolish,
            _ => false
        };
    }
```

Checks if the specified manipulation action is allowed.

**Returns:** `bool`

**Parameters:**
- `ManipulationAction action`

### GetGlobalPosition

```csharp
/// <summary>
    /// Gets the current global position of the manipulatable object.
    /// </summary>
    /// <returns>Global position, or Vector2.Zero if no root</returns>
    public Vector2 GetGlobalPosition()
    {
        return Root?.GlobalPosition ?? Vector2.Zero;
    }
```

Gets the current global position of the manipulatable object.

**Returns:** `Vector2`

### SetGlobalPosition

```csharp
/// <summary>
    /// Sets the global position of the manipulatable object.
    /// </summary>
    /// <param name="position">New global position</param>
    public void SetGlobalPosition(Vector2 position)
    {
        if (Root != null)
        {
            Root.GlobalPosition = position;
        }
    }
```

Sets the global position of the manipulatable object.

**Returns:** `void`

**Parameters:**
- `Vector2 position`

### GetRotation

```csharp
/// <summary>
    /// Gets the current rotation of the manipulatable object.
    /// </summary>
    /// <returns>Rotation in radians, or 0 if no root</returns>
    public float GetRotation()
    {
        return Root?.Rotation ?? 0f;
    }
```

Gets the current rotation of the manipulatable object.

**Returns:** `float`

### SetRotation

```csharp
/// <summary>
    /// Sets the rotation of the manipulatable object.
    /// </summary>
    /// <param name="rotation">New rotation in radians</param>
    public void SetRotation(float rotation)
    {
        if (Root != null)
        {
            Root.Rotation = rotation;
        }
    }
```

Sets the rotation of the manipulatable object.

**Returns:** `void`

**Parameters:**
- `float rotation`

### GetScale

```csharp
/// <summary>
    /// Gets the current scale of the manipulatable object.
    /// </summary>
    /// <returns>Scale, or Vector2.One if no root</returns>
    public Vector2 GetScale()
    {
        return Root?.Scale ?? Vector2.One;
    }
```

Gets the current scale of the manipulatable object.

**Returns:** `Vector2`

### SetScale

```csharp
/// <summary>
    /// Sets the scale of the manipulatable object.
    /// </summary>
    /// <param name="scale">New scale</param>
    public void SetScale(Vector2 scale)
    {
        if (Root != null)
        {
            Root.Scale = scale;
        }
    }
```

Sets the scale of the manipulatable object.

**Returns:** `void`

**Parameters:**
- `Vector2 scale`

### GetDisplayName

```csharp
/// <summary>
    /// Gets a display name for this manipulatable object.
    /// </summary>
    /// <returns>Display name, or "Unknown" if no root</returns>
    public string GetDisplayName()
    {
        return Root?.Name ?? "Unknown";
    }
```

Gets a display name for this manipulatable object.

**Returns:** `string`

### IsValid

```csharp
/// <summary>
    /// Validates that this manipulatable object is in a valid state.
    /// </summary>
    /// <returns>True if valid, false otherwise</returns>
    public bool IsValid()
    {
        return Root != null && IsInstanceValid(Root);
    }
```

Validates that this manipulatable object is in a valid state.

**Returns:** `bool`

