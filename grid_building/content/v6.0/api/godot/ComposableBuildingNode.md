---
title: "ComposableBuildingNode"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/composablebuildingnode/"
---

# ComposableBuildingNode

```csharp
GridBuilding.Godot.Examples
class ComposableBuildingNode
{
    // Members...
}
```

Example of a node that uses composition instead of inheritance.
This node can have building functionality without inheriting from a base class.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Examples/ComposableBuildingNode.cs`  
**Namespace:** `GridBuilding.Godot.Examples`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### BuildingBehavior

```csharp
#endregion

    #region Public API
    /// <summary>
    /// Gets the building behavior if available.
    /// </summary>
    public BuildingBehavior? BuildingBehavior => _behaviorManager?.GetBehavior<BuildingBehavior>();
```

Gets the building behavior if available.


## Methods

### _Ready

```csharp
#endregion

    #region Node Lifecycle
    public override void _Ready()
    {
        base._Ready();
        
        // Initialize behavior manager
        _behaviorManager = new BehaviorManager();
        AddChild(_behaviorManager);
        
        // Get services from service locator
        _buildingService = GodotServiceLocator.Instance.GetService<IBuildingService>();
        
        // Add building behavior
        if (_buildingService != null)
        {
            var buildingBehavior = new BuildingBehavior(_buildingService);
            _behaviorManager.AddBehavior<BuildingBehavior>(buildingBehavior);
        }
        
        // Can add other behaviors as needed
        // _behaviorManager.AddBehavior<InputBehavior>(new InputBehavior());
        // _behaviorManager.AddBehavior<SelectionBehavior>(new SelectionBehavior());
    }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
    {
        base._Process(delta);
        
        // Handle input or other logic
        HandleBuildingInput();
    }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### AddBehavior

```csharp
/// <summary>
    /// Adds a custom behavior to this node.
    /// </summary>
    /// <typeparam name="T">Behavior type</typeparam>
    /// <param name="behavior">Behavior instance</param>
    public void AddBehavior<T>(T behavior) where T : INodeBehavior
    {
        _behaviorManager?.AddBehavior(behavior);
    }
```

Adds a custom behavior to this node.

**Returns:** `void`

**Parameters:**
- `T behavior`

### RemoveBehavior

```csharp
/// <summary>
    /// Removes a behavior from this node.
    /// </summary>
    /// <typeparam name="T">Behavior type</typeparam>
    public void RemoveBehavior<T>() where T : INodeBehavior
    {
        _behaviorManager?.RemoveBehavior<T>();
    }
```

Removes a behavior from this node.

**Returns:** `void`

