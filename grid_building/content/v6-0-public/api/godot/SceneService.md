---
title: "SceneService"
description: "Godot-specific scene service implementation for engine operations.
This service handles all Godot-specific operations that core services
cannot perform, providing a clean abstraction layer between pure C#
business logic and Godot presentation concerns.
## Features:
- Safe scene instantiation with error handling
- Robust node parenting/unparenting
- Resource cleanup and memory management
- Comprehensive error logging and validation
## Usage:
```
var sceneService = new SceneService(logger);
var node = sceneService.InstantiateScene(packedScene);
sceneService.AddChildToParent(parent, node);
```"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/sceneservice/"
---

# SceneService

```csharp
GridBuilding.Godot.Services.Placement
class SceneService
{
    // Members...
}
```

Godot-specific scene service implementation for engine operations.
This service handles all Godot-specific operations that core services
cannot perform, providing a clean abstraction layer between pure C#
business logic and Godot presentation concerns.
## Features:
- Safe scene instantiation with error handling
- Robust node parenting/unparenting
- Resource cleanup and memory management
- Comprehensive error logging and validation
## Usage:
```
var sceneService = new SceneService(logger);
var node = sceneService.InstantiateScene(packedScene);
sceneService.AddChildToParent(parent, node);
```

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Services/Placement/SceneService.cs`  
**Namespace:** `GridBuilding.Godot.Services.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### InstantiateScene

```csharp
#endregion

    #region ISceneService Implementation
    /// <summary>
    /// Instantiates a scene from a PackedScene resource.
    /// </summary>
    /// <param name="scene">The PackedScene to instantiate</param>
    /// <returns>Instantiated node or null if instantiation failed</returns>
    public Node? InstantiateScene(PackedScene scene)
    {
        if (_isDisposed)
        {
            _logger.LogError("Cannot instantiate scene: SceneService is disposed");
            return null;
        }

        if (scene == null)
        {
            _logger.LogWarning("Attempted to instantiate null PackedScene");
            return null;
        }

        try
        {
            var node = scene.Instantiate();
            if (node == null)
            {
                _logger.LogError("Scene.Instantiate() returned null");
                return null;
            }

            // Track the node for cleanup
            _trackedNodes.Add(node);
            
            _logger.LogInfo($"Successfully instantiated scene: {scene.ResourcePath} -> {node.GetType().Name}");
            return node;
        }
        catch (Exception ex)
        {
            _logger.LogError($"Failed to instantiate scene {scene.ResourcePath}: {ex.Message}");
            return null;
        }
    }
```

Instantiates a scene from a PackedScene resource.

**Returns:** `Node?`

**Parameters:**
- `PackedScene scene`

### AddChildToParent

```csharp
/// <summary>
    /// Adds a child node to a parent node with proper error handling.
    /// </summary>
    /// <param name="parent">The parent node</param>
    /// <param name="child">The child node to add</param>
    public void AddChildToParent(Node parent, Node child)
    {
        if (_isDisposed)
        {
            _logger.LogError("Cannot add child to parent: SceneService is disposed");
            return;
        }

        if (parent == null)
        {
            _logger.LogWarning("AddChildToParent: parent node is null");
            return;
        }

        if (child == null)
        {
            _logger.LogWarning("AddChildToParent: child node is null");
            return;
        }

        try
        {
            // Check if child is already in scene tree
            if (child.IsInsideTree())
            {
                _logger.LogWarning($"Child {child.Name} is already in scene tree, removing from current parent first");
                child.GetParent()?.RemoveChild(child);
            }

            // Check if parent is in scene tree
            if (!parent.IsInsideTree())
            {
                _logger.LogWarning($"Parent {parent.Name} is not in scene tree");
                // Still add the child, but log warning
            }

            parent.AddChild(child);
            _logger.LogInfo($"Added child {child.Name} to parent {parent.Name}");
        }
        catch (Exception ex)
        {
            _logger.LogError($"Failed to add child {child.Name} to parent {parent.Name}: {ex.Message}");
        }
    }
```

Adds a child node to a parent node with proper error handling.

**Returns:** `void`

**Parameters:**
- `Node parent`
- `Node child`

### RemoveChildFromParent

```csharp
/// <summary>
    /// Removes a child node from its parent with proper error handling.
    /// </summary>
    /// <param name="parent">The parent node</param>
    /// <param name="child">The child node to remove</param>
    public void RemoveChildFromParent(Node parent, Node child)
    {
        if (_isDisposed)
        {
            _logger.LogError("Cannot remove child from parent: SceneService is disposed");
            return;
        }

        if (parent == null)
        {
            _logger.LogWarning("RemoveChildFromParent: parent node is null");
            return;
        }

        if (child == null)
        {
            _logger.LogWarning("RemoveChildFromParent: child node is null");
            return;
        }

        try
        {
            // Check if child is actually a child of this parent
            if (child.GetParent() != parent)
            {
                _logger.LogWarning($"Child {child.Name} is not a child of parent {parent.Name}");
                return;
            }

            parent.RemoveChild(child);
            _logger.LogInfo($"Removed child {child.Name} from parent {parent.Name}");
        }
        catch (Exception ex)
        {
            _logger.LogError($"Failed to remove child {child.Name} from parent {parent.Name}: {ex.Message}");
        }
    }
```

Removes a child node from its parent with proper error handling.

**Returns:** `void`

**Parameters:**
- `Node parent`
- `Node child`

### FreeNode

```csharp
/// <summary>
    /// Safely frees a node and its resources.
    /// </summary>
    /// <param name="node">The node to free</param>
    public void FreeNode(Node node)
    {
        if (_isDisposed)
        {
            _logger.LogError("Cannot free node: SceneService is disposed");
            return;
        }

        if (node == null)
        {
            _logger.LogWarning("Attempted to free null node");
            return;
        }

        try
        {
            // Remove from tracking
            _trackedNodes.Remove(node);

            // Remove from parent if in scene tree
            if (node.IsInsideTree())
            {
                var parent = node.GetParent();
                if (parent != null)
                {
                    parent.RemoveChild(node);
                }
            }

            // Free the node
            node.QueueFree();
            _logger.LogInfo($"Queued node {node.Name} for freeing");
        }
        catch (Exception ex)
        {
            _logger.LogError($"Failed to free node {node.Name}: {ex.Message}");
        }
    }
```

Safely frees a node and its resources.

**Returns:** `void`

**Parameters:**
- `Node node`

### SetNodePosition

```csharp
/// <summary>
    /// Sets the position of a Node2D with validation.
    /// </summary>
    /// <param name="node">The Node2D to position</param>
    /// <param name="position">The position to set</param>
    public void SetNodePosition(Node2D node, Vector2 position)
    {
        if (_isDisposed)
        {
            _logger.LogError("Cannot set node position: SceneService is disposed");
            return;
        }

        if (node == null)
        {
            _logger.LogWarning("Attempted to set position on null Node2D");
            return;
        }

        try
        {
            node.Position = position;
            _logger.LogInfo($"Set position of {node.Name} to {position}");
        }
        catch (Exception ex)
        {
            _logger.LogError($"Failed to set position of {node.Name} to {position}: {ex.Message}");
        }
    }
```

Sets the position of a Node2D with validation.

**Returns:** `void`

**Parameters:**
- `Node2D node`
- `Vector2 position`

### IsNodeInSceneTree

```csharp
/// <summary>
    /// Gets whether a node is currently in the scene tree.
    /// </summary>
    /// <param name="node">The node to check</param>
    /// <returns>True if the node is in the scene tree</returns>
    public bool IsNodeInSceneTree(Node node)
    {
        if (_isDisposed || node == null)
        {
            return false;
        }

        try
        {
            return node.IsInsideTree();
        }
        catch (Exception ex)
        {
            _logger.LogError($"Failed to check if node {node.Name} is in scene tree: {ex.Message}");
            return false;
        }
    }
```

Gets whether a node is currently in the scene tree.

**Returns:** `bool`

**Parameters:**
- `Node node`

### CreateNode

```csharp
/// <summary>
    /// Creates a new node of the specified type.
    /// </summary>
    /// <typeparam name="T">The node type to create</typeparam>
    /// <returns>New node instance or null if creation failed</returns>
    public T? CreateNode<T>() where T : Node, new()
    {
        if (_isDisposed)
        {
            _logger.LogError("Cannot create node: SceneService is disposed");
            return null;
        }

        try
        {
            var node = new T();
            _trackedNodes.Add(node);
            _logger.LogInfo($"Created new node of type {typeof(T).Name}");
            return node;
        }
        catch (Exception ex)
        {
            _logger.LogError($"Failed to create node of type {typeof(T).Name}: {ex.Message}");
            return null;
        }
    }
```

Creates a new node of the specified type.

**Returns:** `T?`

### GetValidationIssues

```csharp
/// <summary>
    /// Gets validation issues if any Godot dependencies are missing.
    /// </summary>
    /// <returns>Collection of validation issue descriptions</returns>
    public IEnumerable<string> GetValidationIssues()
    {
        var issues = new List<string>();
        
        if (_logger == null)
            issues.Add("ILogger is not available");
        if (_isDisposed)
            issues.Add("SceneService has been disposed");
            
        return issues;
    }
```

Gets validation issues if any Godot dependencies are missing.

**Returns:** `IEnumerable<string>`

### GetTrackedNodeCount

```csharp
#endregion

    #region Public Methods
    /// <summary>
    /// Gets the count of currently tracked nodes.
    /// </summary>
    /// <returns>Number of tracked nodes</returns>
    public int GetTrackedNodeCount()
    {
        return _trackedNodes.Count;
    }
```

Gets the count of currently tracked nodes.

**Returns:** `int`

### FreeAllTrackedNodes

```csharp
/// <summary>
    /// Frees all tracked nodes for cleanup.
    /// </summary>
    public void FreeAllTrackedNodes()
    {
        if (_isDisposed)
            return;

        var nodesToFree = new List<Node>(_trackedNodes);
        _trackedNodes.Clear();

        foreach (var node in nodesToFree)
        {
            FreeNode(node);
        }

        _logger.LogInfo($"Freed {nodesToFree.Count} tracked nodes");
    }
```

Frees all tracked nodes for cleanup.

**Returns:** `void`

### Dispose

```csharp
#endregion

    #region IDisposable Implementation
    /// <summary>
    /// Disposes of the scene service and its resources.
    /// </summary>
    public void Dispose()
    {
        if (_isDisposed)
            return;

        _logger.LogInfo("Disposing SceneService");
        
        // Free all tracked nodes
        FreeAllTrackedNodes();
        
        // Dispose of logger if it's disposable
        if (_logger is IDisposable disposableLogger)
            disposableLogger.Dispose();

        _isDisposed = true;
    }
```

Disposes of the scene service and its resources.

**Returns:** `void`

