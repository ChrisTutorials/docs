---
title: "BehaviorManager"
description: "Manages multiple behaviors for a node.
Provides composition-based functionality without inheritance."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/behaviormanager/"
---

# BehaviorManager

```csharp
GridBuilding.Godot.Behaviors
class BehaviorManager
{
    // Members...
}
```

Manages multiple behaviors for a node.
Provides composition-based functionality without inheritance.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Behaviors/BehaviorManager.cs`  
**Namespace:** `GridBuilding.Godot.Behaviors`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### AddBehavior

```csharp
#endregion

    #region Public Methods
    /// <summary>
    /// Adds a behavior to this manager.
    /// </summary>
    /// <typeparam name="T">Behavior type</typeparam>
    /// <param name="behavior">Behavior instance</param>
    public void AddBehavior<T>(T behavior) where T : INodeBehavior
    {
        var behaviorType = typeof(T);
        
        if (_behaviors.ContainsKey(behaviorType))
        {
            GD.PrintErr($"Behavior {behaviorType.Name} already exists on this node");
            return;
        }

        _behaviors[behaviorType] = behavior;
        behavior.Attach(this);
        _activeBehaviors.Add(behavior);
    }
```

Adds a behavior to this manager.

**Returns:** `void`

**Parameters:**
- `T behavior`

### RemoveBehavior

```csharp
/// <summary>
    /// Removes a behavior from this manager.
    /// </summary>
    /// <typeparam name="T">Behavior type</typeparam>
    public void RemoveBehavior<T>() where T : INodeBehavior
    {
        var behaviorType = typeof(T);
        
        if (_behaviors.TryGetValue(behaviorType, out var behavior))
        {
            behavior.Detach();
            _behaviors.Remove(behaviorType);
            _activeBehaviors.Remove(behavior);
        }
    }
```

Removes a behavior from this manager.

**Returns:** `void`

### GetBehavior

```csharp
/// <summary>
    /// Gets a behavior of the specified type.
    /// </summary>
    /// <typeparam name="T">Behavior type</typeparam>
    /// <returns>Behavior instance or null</returns>
    public T? GetBehavior<T>() where T : INodeBehavior
    {
        var behaviorType = typeof(T);
        return _behaviors.TryGetValue(behaviorType, out var behavior) ? (T)behavior : null;
    }
```

Gets a behavior of the specified type.

**Returns:** `T?`

### HasBehavior

```csharp
/// <summary>
    /// Checks if a behavior of the specified type exists.
    /// </summary>
    /// <typeparam name="T">Behavior type</typeparam>
    /// <returns>True if behavior exists</returns>
    public bool HasBehavior<T>() where T : INodeBehavior
    {
        return _behaviors.ContainsKey(typeof(T));
    }
```

Checks if a behavior of the specified type exists.

**Returns:** `bool`

### _Ready

```csharp
#endregion

    #region Node Lifecycle
    public override void _Ready()
    {
        base._Ready();
    }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
    {
        base._Process(delta);
        
        foreach (var behavior in _activeBehaviors)
        {
            if (behavior.IsEnabled)
            {
                behavior.Process(delta);
            }
        }
    }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### _PhysicsProcess

```csharp
public override void _PhysicsProcess(double delta)
    {
        base._PhysicsProcess(delta);
        
        foreach (var behavior in _activeBehaviors)
        {
            if (behavior.IsEnabled)
            {
                behavior.PhysicsProcess(delta);
            }
        }
    }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### _ExitTree

```csharp
#endregion

    #region Cleanup
    public override void _ExitTree()
    {
        base._ExitTree();
        
        // Detach all behaviors
        foreach (var behavior in _behaviors.Values)
        {
            behavior.Detach();
        }
        
        _behaviors.Clear();
        _activeBehaviors.Clear();
    }
```

**Returns:** `void`

