---
title: "BuildingBehavior"
description: "Node behavior that provides building functionality.
Can be attached to any Node to make it building-capable."
weight: 20
url: "/gridbuilding/v6-0/api/godot/buildingbehavior/"
---

# BuildingBehavior

```csharp
GridBuilding.Godot.Behaviors
class BuildingBehavior
{
    // Members...
}
```

Node behavior that provides building functionality.
Can be attached to any Node to make it building-capable.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Behaviors/BuildingBehavior.cs`  
**Namespace:** `GridBuilding.Godot.Behaviors`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsEnabled

```csharp
#endregion

    #region Properties
    public bool IsEnabled { get; set; } = true;
```

### AttachedNode

```csharp
public Node? AttachedNode { get; private set; }
```


## Methods

### Attach

```csharp
#endregion

    #region INodeBehavior Implementation
    public void Attach(Node node)
    {
        AttachedNode = node;
        // Set up any node-specific building functionality
    }
```

**Returns:** `void`

**Parameters:**
- `Node node`

### Detach

```csharp
public void Detach()
    {
        AttachedNode = null;
    }
```

**Returns:** `void`

### Process

```csharp
public void Process(double delta)
    {
        if (!IsEnabled || AttachedNode == null) return;
        
        // Handle building-related processing
        HandleBuildingInput(delta);
    }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### PhysicsProcess

```csharp
public void PhysicsProcess(double delta)
    {
        if (!IsEnabled || AttachedNode == null) return;
        
        // Handle physics-related building interactions
        HandleBuildingPhysics(delta);
    }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### TryPlaceBuilding

```csharp
#endregion

    #region Building Methods
    /// <summary>
    /// Attempts to place a building at the current mouse position.
    /// </summary>
    /// <param name="placeable">The placeable to build</param>
    /// <returns>True if placement succeeded</returns>
    public bool TryPlaceBuilding(object placeable)
    {
        if (!IsEnabled || AttachedNode == null) return false;
        
        var globalMousePos = AttachedNode.GetGlobalMousePosition();
        var gridPos = Vector2I.FromVector2(globalMousePos);
        
        var result = _buildingService.PlaceBuilding(gridPos, placeable);
        return result != null;
    }
```

Attempts to place a building at the current mouse position.

**Returns:** `bool`

**Parameters:**
- `object placeable`

### CreatePreview

```csharp
/// <summary>
    /// Creates a preview for the given placeable.
    /// </summary>
    /// <param name="placeable">The placeable to preview</param>
    /// <returns>Preview node or null</returns>
    public Node? CreatePreview(object placeable)
    {
        if (!IsEnabled) return null;
        
        return _buildingService.CreatePreview(placeable);
    }
```

Creates a preview for the given placeable.

**Returns:** `Node?`

**Parameters:**
- `object placeable`

