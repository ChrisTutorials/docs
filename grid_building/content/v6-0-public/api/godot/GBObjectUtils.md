---
title: "GBObjectUtils"
description: "Utility class for object operations.
Ported from: godot/addons/grid_building/shared/utils/object_utils.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/gbobjectutils/"
---

# GBObjectUtils

```csharp
GridBuilding.Godot.Systems.Manipulation.Utils
class GBObjectUtils
{
    // Members...
}
```

Utility class for object operations.
Ported from: godot/addons/grid_building/shared/utils/object_utils.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Utils/ObjectUtils.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetDisplayName

```csharp
/// <summary>
    /// Gets a display name for a node.
    /// </summary>
    /// <param name="node">The node to get the display name for</param>
    /// <returns>Display name, or a default name if node is null</returns>
    public static string GetDisplayName(Node? node)
    {
        if (node == null)
            return "Null";

        // Try to get custom display name from metadata
        if (node.HasMeta("display_name"))
        {
            var displayName = node.GetMeta("display_name").AsString();
            if (!string.IsNullOrEmpty(displayName))
                return displayName;
        }

        // Use node name as fallback
        return node.Name;
    }
```

Gets a display name for a node.

**Returns:** `string`

**Parameters:**
- `Node? node`

### GetDisplayName

```csharp
/// <summary>
    /// Gets a display name for a manipulatable object.
    /// </summary>
    /// <param name="manipulatable">The manipulatable object</param>
    /// <returns>Display name, or a default name if null</returns>
    public static string GetDisplayName(Manipulatable? manipulatable)
    {
        if (manipulatable?.Root != null)
            return GetDisplayName(manipulatable.Root);

        return "Unknown Manipulatable";
    }
```

Gets a display name for a manipulatable object.

**Returns:** `string`

**Parameters:**
- `Manipulatable? manipulatable`

### IsValidAndInTree

```csharp
/// <summary>
    /// Checks if an object is valid and in the scene tree.
    /// </summary>
    /// <param name="obj">The object to check</param>
    /// <returns>True if the object is valid and in the scene tree</returns>
    public static bool IsValidAndInTree(GodotObject? obj)
    {
        return obj != null && GodotObject.IsInstanceValid(obj);
    }
```

Checks if an object is valid and in the scene tree.

**Returns:** `bool`

**Parameters:**
- `GodotObject? obj`

### IsValidAndInTree

```csharp
/// <summary>
    /// Checks if a node is valid and in the scene tree.
    /// </summary>
    /// <param name="node">The node to check</param>
    /// <returns>True if the node is valid and in the scene tree</returns>
    public static bool IsValidAndInTree(Node? node)
    {
        return node != null && GodotObject.IsInstanceValid(node) && node.IsInsideTree();
    }
```

Checks if a node is valid and in the scene tree.

**Returns:** `bool`

**Parameters:**
- `Node? node`

### GetSafeGlobalPosition

```csharp
/// <summary>
    /// Safely gets a node's global position.
    /// </summary>
    /// <param name="node">The node to get the position from</param>
    /// <returns>Global position, or Vector2.Zero if node is invalid</returns>
    public static Vector2 GetSafeGlobalPosition(Node2D? node)
    {
        if (IsValidAndInTree(node))
            return node.GlobalPosition;

        return Vector2.Zero;
    }
```

Safely gets a node's global position.

**Returns:** `Vector2`

**Parameters:**
- `Node2D? node`

### SetSafeGlobalPosition

```csharp
/// <summary>
    /// Safely sets a node's global position.
    /// </summary>
    /// <param name="node">The node to set the position on</param>
    /// <param name="position">The position to set</param>
    /// <returns>True if position was set successfully</returns>
    public static bool SetSafeGlobalPosition(Node2D? node, Vector2 position)
    {
        if (IsValidAndInTree(node))
        {
            node.GlobalPosition = position;
            return true;
        }

        return false;
    }
```

Safely sets a node's global position.

**Returns:** `bool`

**Parameters:**
- `Node2D? node`
- `Vector2 position`

### GetSafeRotation

```csharp
/// <summary>
    /// Safely gets a node's rotation.
    /// </summary>
    /// <param name="node">The node to get the rotation from</param>
    /// <returns>Rotation in radians, or 0 if node is invalid</returns>
    public static float GetSafeRotation(Node2D? node)
    {
        if (IsValidAndInTree(node))
            return node.Rotation;

        return 0f;
    }
```

Safely gets a node's rotation.

**Returns:** `float`

**Parameters:**
- `Node2D? node`

### SetSafeRotation

```csharp
/// <summary>
    /// Safely sets a node's rotation.
    /// </summary>
    /// <param name="node">The node to set the rotation on</param>
    /// <param name="rotation">The rotation to set in radians</param>
    /// <returns>True if rotation was set successfully</returns>
    public static bool SetSafeRotation(Node2D? node, float rotation)
    {
        if (IsValidAndInTree(node))
        {
            node.Rotation = rotation;
            return true;
        }

        return false;
    }
```

Safely sets a node's rotation.

**Returns:** `bool`

**Parameters:**
- `Node2D? node`
- `float rotation`

### GetSafeScale

```csharp
/// <summary>
    /// Safely gets a node's scale.
    /// </summary>
    /// <param name="node">The node to get the scale from</param>
    /// <returns>Scale, or Vector2.One if node is invalid</returns>
    public static Vector2 GetSafeScale(Node2D? node)
    {
        if (IsValidAndInTree(node))
            return node.Scale;

        return Vector2.One;
    }
```

Safely gets a node's scale.

**Returns:** `Vector2`

**Parameters:**
- `Node2D? node`

### SetSafeScale

```csharp
/// <summary>
    /// Safely sets a node's scale.
    /// </summary>
    /// <param name="node">The node to set the scale on</param>
    /// <param name="scale">The scale to set</param>
    /// <returns>True if scale was set successfully</returns>
    public static bool SetSafeScale(Node2D? node, Vector2 scale)
    {
        if (IsValidAndInTree(node))
        {
            node.Scale = scale;
            return true;
        }

        return false;
    }
```

Safely sets a node's scale.

**Returns:** `bool`

**Parameters:**
- `Node2D? node`
- `Vector2 scale`

### GetObjectTypeDescription

```csharp
/// <summary>
    /// Gets a descriptive string for an object's type.
    /// </summary>
    /// <param name="obj">The object to get the type description for</param>
    /// <returns>Type description string</returns>
    public static string GetObjectTypeDescription(GodotObject? obj)
    {
        if (obj == null)
            return "Null";

        var type = obj.GetType().Name;
        
        // Add more descriptive names for common types
        return type switch
        {
            "Node2D" => "2D Node",
            "Sprite2D" => "Sprite",
            "CollisionObject2D" => "Collision Object",
            "Area2D" => "Area",
            "RigidBody2D" => "Physics Body",
            "StaticBody2D" => "Static Body",
            "CharacterBody2D" => "Character Body",
            _ => type
        };
    }
```

Gets a descriptive string for an object's type.

**Returns:** `string`

**Parameters:**
- `GodotObject? obj`

### CreateCopy

```csharp
/// <summary>
    /// Creates a copy of a node with its properties.
    /// </summary>
    /// <param name="original">The original node to copy</param>
    /// <param name="parent">The parent to add the copy to</param>
    /// <returns>The copied node, or null if failed</returns>
    public static T? CreateCopy<T>(T original, Node? parent) where T : Node
    {
        if (original == null || parent == null)
            return null;

        var copy = original.Duplicate() as T;
        if (copy != null)
        {
            parent.AddChild(copy);
            copy.Owner = parent.GetTree().EditedSceneRoot ?? parent;
        }

        return copy;
    }
```

Creates a copy of a node with its properties.

**Returns:** `T?`

**Parameters:**
- `T original`
- `Node? parent`

### ApproximatelyEqual

```csharp
/// <summary>
    /// Checks if two objects are approximately equal in position.
    /// </summary>
    /// <param name="pos1">First position</param>
    /// <param name="pos2">Second position</param>
    /// <param name="tolerance">Tolerance for comparison</param>
    /// <returns>True if positions are approximately equal</returns>
    public static bool ApproximatelyEqual(Vector2 pos1, Vector2 pos2, float tolerance = 0.001f)
    {
        return pos1.DistanceTo(pos2) <= tolerance;
    }
```

Checks if two objects are approximately equal in position.

**Returns:** `bool`

**Parameters:**
- `Vector2 pos1`
- `Vector2 pos2`
- `float tolerance`

### ApproximatelyEqual

```csharp
/// <summary>
    /// Checks if two floats are approximately equal.
    /// </summary>
    /// <param name="value1">First value</param>
    /// <param name="value2">Second value</param>
    /// <param name="tolerance">Tolerance for comparison</param>
    /// <returns>True if values are approximately equal</returns>
    public static bool ApproximatelyEqual(float value1, float value2, float tolerance = 0.001f)
    {
        return Mathf.Abs(value1 - value2) <= tolerance;
    }
```

Checks if two floats are approximately equal.

**Returns:** `bool`

**Parameters:**
- `float value1`
- `float value2`
- `float tolerance`

