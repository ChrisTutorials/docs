---
title: "MockNode2D"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/mocknode2d/"
---

# MockNode2D

```csharp
GridBuilding.Core.Types
class MockNode2D
{
    // Members...
}
```

Mock Node2D implementation for testing purposes
Provides basic node functionality without Godot dependencies

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Common/Types/MockNode2D.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
#region Properties
    
    /// <summary>
    /// Node name
    /// </summary>
    public string Name { get; set; } = string.Empty;
```

Node name

### Parent

```csharp
/// <summary>
    /// Parent node
    /// </summary>
    public MockNode2D? Parent { get; set; }
```

Parent node

### Children

```csharp
/// <summary>
    /// Child nodes
    /// </summary>
    public List<MockNode2D> Children { get; set; } = new();
```

Child nodes

### Position

```csharp
/// <summary>
    /// Position in local space
    /// </summary>
    public Vector2 Position { get; set; }
```

Position in local space

### Rotation

```csharp
/// <summary>
    /// Rotation in degrees
    /// </summary>
    public float Rotation { get; set; }
```

Rotation in degrees

### Scale

```csharp
/// <summary>
    /// Scale factor
    /// </summary>
    public Vector2 Scale { get; set; } = Vector2.One;
```

Scale factor

### Transform

```csharp
/// <summary>
    /// Transform data
    /// </summary>
    public TransformData Transform { get; set; } = TransformData.Identity;
```

Transform data

### GlobalPosition

```csharp
/// <summary>
    /// Global position (computed)
    /// </summary>
    public Vector2 GlobalPosition
    {
        get
        {
            if (Parent == null)
                return Position;
            
            return Parent.GlobalPosition + Parent.Transform.TransformVector(Position);
        }
        set
        {
            if (Parent == null)
            {
                Position = value;
            }
            else
            {
                Position = Parent.GlobalTransform.Inverse().TransformPoint(value);
            }
        }
    }
```

Global position (computed)

### GlobalRotation

```csharp
/// <summary>
    /// Global rotation (computed)
    /// </summary>
    public float GlobalRotation
    {
        get
        {
            if (Parent == null)
                return Rotation;
            
            return Parent.GlobalRotation + Rotation;
        }
        set
        {
            if (Parent == null)
            {
                Rotation = value;
            }
            else
            {
                Rotation = value - Parent.GlobalRotation;
            }
        }
    }
```

Global rotation (computed)

### GlobalScale

```csharp
/// <summary>
    /// Global scale (computed)
    /// </summary>
    public Vector2 GlobalScale
    {
        get
        {
            if (Parent == null)
                return Scale;
            
            return Parent.GlobalScale * Scale;
        }
        set
        {
            if (Parent == null)
            {
                Scale = value;
            }
            else
            {
                Scale = value / Parent.GlobalScale;
            }
        }
    }
```

Global scale (computed)

### GlobalTransform

```csharp
/// <summary>
    /// Global transform (computed)
    /// </summary>
    public Transform2D GlobalTransform
    {
        get
        {
            if (Parent == null)
                return Transform.Transform;
            
            return Parent.GlobalTransform * Transform.Transform;
        }
    }
```

Global transform (computed)

### IsInsideTree

```csharp
/// <summary>
    /// Whether this node is inside the scene tree
    /// </summary>
    public bool IsInsideTree { get; set; } = true;
```

Whether this node is inside the scene tree

### Metadata

```csharp
/// <summary>
    /// Custom metadata
    /// </summary>
    public Dictionary<string, object> Metadata { get; set; } = new();
```

Custom metadata


## Methods

### UpdateTransform

```csharp
#endregion
    
    #region Methods
    
    /// <summary>
    /// Updates the transform based on position, rotation, and scale
    /// </summary>
    public void UpdateTransform()
    {
        Transform = new TransformData(Position, Rotation, Scale);
    }
```

Updates the transform based on position, rotation, and scale

**Returns:** `void`

### AddChild

```csharp
/// <summary>
    /// Adds a child node
    /// </summary>
    public void AddChild(MockNode2D child)
    {
        if (child == null) return;
        
        // Remove from current parent if any
        child.Parent?.Children.Remove(child);
        
        // Add to this node
        child.Parent = this;
        Children.Add(child);
    }
```

Adds a child node

**Returns:** `void`

**Parameters:**
- `MockNode2D child`

### RemoveChild

```csharp
/// <summary>
    /// Removes a child node
    /// </summary>
    public void RemoveChild(MockNode2D child)
    {
        if (child == null || child.Parent != this) return;
        
        child.Parent = null;
        Children.Remove(child);
    }
```

Removes a child node

**Returns:** `void`

**Parameters:**
- `MockNode2D child`

### FindChild

```csharp
/// <summary>
    /// Finds a child by name
    /// </summary>
    public MockNode2D? FindChild(string name, bool recursive = false)
    {
        var child = Children.FirstOrDefault(c => c.Name == name);
        if (child != null || !recursive) return child;
        
        foreach (var c in Children)
        {
            var found = c.FindChild(name, true);
            if (found != null) return found;
        }
        
        return null;
    }
```

Finds a child by name

**Returns:** `MockNode2D?`

**Parameters:**
- `string name`
- `bool recursive`

### GetAllChildren

```csharp
/// <summary>
    /// Gets all children recursively
    /// </summary>
    public List<MockNode2D> GetAllChildren()
    {
        var result = new List<MockNode2D>();
        
        foreach (var child in Children)
        {
            result.Add(child);
            result.AddRange(child.GetAllChildren());
        }
        
        return result;
    }
```

Gets all children recursively

**Returns:** `List<MockNode2D>`

### ToGlobal

```csharp
/// <summary>
    /// Converts local position to global position
    /// </summary>
    public Vector2 ToGlobal(Vector2 localPoint)
    {
        return GlobalTransform * localPoint;
    }
```

Converts local position to global position

**Returns:** `Vector2`

**Parameters:**
- `Vector2 localPoint`

### ToLocal

```csharp
/// <summary>
    /// Converts global position to local position
    /// </summary>
    public Vector2 ToLocal(Vector2 globalPoint)
    {
        return GlobalTransform.Inverse() * globalPoint;
    }
```

Converts global position to local position

**Returns:** `Vector2`

**Parameters:**
- `Vector2 globalPoint`

### SetMeta

```csharp
/// <summary>
    /// Sets metadata value
    /// </summary>
    public void SetMeta(string key, object value)
    {
        Metadata[key] = value;
    }
```

Sets metadata value

**Returns:** `void`

**Parameters:**
- `string key`
- `object value`

### GetMeta

```csharp
/// <summary>
    /// Gets metadata value
    /// </summary>
    public T? GetMeta<T>(string key, T? defaultValue = default)
    {
        if (Metadata.TryGetValue(key, out var value) && value is T typedValue)
        {
            return typedValue;
        }
        
        return defaultValue;
    }
```

Gets metadata value

**Returns:** `T?`

**Parameters:**
- `string key`
- `T? defaultValue`

### HasMeta

```csharp
/// <summary>
    /// Checks if metadata key exists
    /// </summary>
    public bool HasMeta(string key)
    {
        return Metadata.ContainsKey(key);
    }
```

Checks if metadata key exists

**Returns:** `bool`

**Parameters:**
- `string key`

### RemoveMeta

```csharp
/// <summary>
    /// Removes metadata key
    /// </summary>
    public void RemoveMeta(string key)
    {
        Metadata.Remove(key);
    }
```

Removes metadata key

**Returns:** `void`

**Parameters:**
- `string key`

### ToString

```csharp
/// <summary>
    /// Creates a string representation
    /// </summary>
    public override string ToString()
    {
        return $"MockNode2D({Name}) at {GlobalPosition}";
    }
```

Creates a string representation

**Returns:** `string`

