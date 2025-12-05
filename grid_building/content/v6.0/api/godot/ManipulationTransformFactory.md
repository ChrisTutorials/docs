---
title: "ManipulationTransformFactory"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/manipulationtransformfactory/"
---

# ManipulationTransformFactory

```csharp
GridBuilding.Godot.Tests.Manipulation
class ManipulationTransformFactory
{
    // Members...
}
```

Factory for creating manipulation-related objects - mirrors GDScript ManipulationTransformFactory
Provides convenient methods for creating test fixtures and validated objects.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ManipulationTransformFactory.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CreateMockNode

```csharp
/// <summary>
    /// Creates a mock Node2D with the specified transform properties.
    /// </summary>
    /// <param name="position">Global position</param>
    /// <param name="rotation">Rotation in radians</param>
    /// <param name="scale">Scale vector</param>
    /// <returns>A new MockNode2D instance</returns>
    public static MockNode2D CreateMockNode(Vector2TypeSafe position, float rotation, Vector2TypeSafe scale)
    {
        return new MockNode2D(position, rotation, scale);
    }
```

Creates a mock Node2D with the specified transform properties.

**Returns:** `MockNode2D`

**Parameters:**
- `Vector2TypeSafe position`
- `float rotation`
- `Vector2TypeSafe scale`

### CreateMockNode

```csharp
/// <summary>
    /// Creates a mock Node2D from raw float values (convenience method).
    /// </summary>
    public static MockNode2D CreateMockNode(float x, float y, float rotation, float scaleX, float scaleY)
    {
        return new MockNode2D(
            new Vector2TypeSafe(x, y),
            rotation,
            new Vector2TypeSafe(scaleX, scaleY)
        );
    }
```

Creates a mock Node2D from raw float values (convenience method).

**Returns:** `MockNode2D`

**Parameters:**
- `float x`
- `float y`
- `float rotation`
- `float scaleX`
- `float scaleY`

### CreateTransformData

```csharp
/// <summary>
    /// Creates transform data with the specified properties.
    /// </summary>
    /// <param name="position">Position vector</param>
    /// <param name="rotation">Rotation in radians</param>
    /// <param name="scale">Scale vector</param>
    /// <returns>A new TransformData instance</returns>
    public static TransformData CreateTransformData(Vector2TypeSafe position, float rotation, Vector2TypeSafe scale)
    {
        return new TransformData(position, rotation, scale);
    }
```

Creates transform data with the specified properties.

**Returns:** `TransformData`

**Parameters:**
- `Vector2TypeSafe position`
- `float rotation`
- `Vector2TypeSafe scale`

### CreateTransformData

```csharp
/// <summary>
    /// Creates transform data from raw float values (convenience method).
    /// </summary>
    public static TransformData CreateTransformData(float x, float y, float rotation, float scaleX, float scaleY)
    {
        return new TransformData(
            new Vector2TypeSafe(x, y),
            rotation,
            new Vector2TypeSafe(scaleX, scaleY)
        );
    }
```

Creates transform data from raw float values (convenience method).

**Returns:** `TransformData`

**Parameters:**
- `float x`
- `float y`
- `float rotation`
- `float scaleX`
- `float scaleY`

### CreateIdentityMockNode

```csharp
/// <summary>
    /// Creates a mock node with identity transform (origin, no rotation, unit scale).
    /// </summary>
    public static MockNode2D CreateIdentityMockNode() => MockNode2D.Identity();
```

Creates a mock node with identity transform (origin, no rotation, unit scale).

**Returns:** `MockNode2D`

### CreateIdentityTransformData

```csharp
/// <summary>
    /// Creates transform data with identity values (origin, no rotation, unit scale).
    /// </summary>
    public static TransformData CreateIdentityTransformData() => TransformData.Identity();
```

Creates transform data with identity values (origin, no rotation, unit scale).

**Returns:** `TransformData`

### CreateHorizontalFlipMockNode

```csharp
/// <summary>
    /// Creates a mock node with horizontal flip (negative X scale).
    /// </summary>
    public static MockNode2D CreateHorizontalFlipMockNode(Vector2TypeSafe position)
    {
        return new MockNode2D(position, 0.0f, new Vector2TypeSafe(-1.0f, 1.0f));
    }
```

Creates a mock node with horizontal flip (negative X scale).

**Returns:** `MockNode2D`

**Parameters:**
- `Vector2TypeSafe position`

### CreateVerticalFlipMockNode

```csharp
/// <summary>
    /// Creates a mock node with vertical flip (negative Y scale).
    /// </summary>
    public static MockNode2D CreateVerticalFlipMockNode(Vector2TypeSafe position)
    {
        return new MockNode2D(position, 0.0f, new Vector2TypeSafe(1.0f, -1.0f));
    }
```

Creates a mock node with vertical flip (negative Y scale).

**Returns:** `MockNode2D`

**Parameters:**
- `Vector2TypeSafe position`

### CreateBothAxesFlipMockNode

```csharp
/// <summary>
    /// Creates a mock node with both axes flipped (negative X and Y scale).
    /// </summary>
    public static MockNode2D CreateBothAxesFlipMockNode(Vector2TypeSafe position, float rotation = 0.0f)
    {
        return new MockNode2D(position, rotation, new Vector2TypeSafe(-1.0f, -1.0f));
    }
```

Creates a mock node with both axes flipped (negative X and Y scale).

**Returns:** `MockNode2D`

**Parameters:**
- `Vector2TypeSafe position`
- `float rotation`

