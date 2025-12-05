---
title: "GBSearchUtils"
description: "Utility class for searching nodes and components.
Ported from: godot/addons/grid_building/shared/utils/search_utils.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gbsearchutils/"
---

# GBSearchUtils

```csharp
GridBuilding.Godot.Systems.Manipulation.Utils
class GBSearchUtils
{
    // Members...
}
```

Utility class for searching nodes and components.
Ported from: godot/addons/grid_building/shared/utils/search_utils.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Utils/SearchUtils.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### FindFirst

```csharp
/// <summary>
    /// Finds the first component of type T in the node hierarchy.
    /// </summary>
    /// <typeparam name="T">The component type to search for</typeparam>
    /// <param name="root">The root node to search from</param>
    /// <returns>The first component of type T found, or null if not found</returns>
    public static T? FindFirst<T>(Node? root) where T : Node
    {
        if (root == null)
            return null;

        // Check if the root itself is of type T
        if (root is T result)
            return result;

        // Search children recursively
        foreach (Node child in root.GetChildren())
        {
            var found = FindFirst<T>(child);
            if (found != null)
                return found;
        }

        return null;
    }
```

Finds the first component of type T in the node hierarchy.

**Returns:** `T?`

**Parameters:**
- `Node? root`

### FindAll

```csharp
/// <summary>
    /// Finds all components of type T in the node hierarchy.
    /// </summary>
    /// <typeparam name="T">The component type to search for</typeparam>
    /// <param name="root">The root node to search from</param>
    /// <returns>Array of all components of type T found</returns>
    public static GDCollections.Array<T> FindAll<T>(Node? root) where T : Node
    {
        var results = new GDCollections.Array<T>();
        FindAllRecursive(root, results);
        return results;
    }
```

Finds all components of type T in the node hierarchy.

**Returns:** `GDCollections.Array<T>`

**Parameters:**
- `Node? root`

### FindFirstParent

```csharp
/// <summary>
    /// Finds the first parent of type T.
    /// </summary>
    /// <typeparam name="T">The parent type to search for</typeparam>
    /// <param name="node">The node to search from</param>
    /// <returns>The first parent of type T found, or null if not found</returns>
    public static T? FindFirstParent<T>(Node? node) where T : Node
    {
        if (node == null)
            return null;

        var current = node.GetParent();
        while (current != null)
        {
            if (current is T result)
                return result;

            current = current.GetParent();
        }

        return null;
    }
```

Finds the first parent of type T.

**Returns:** `T?`

**Parameters:**
- `Node? node`

### FindByName

```csharp
/// <summary>
    /// Finds a node by name in the hierarchy.
    /// </summary>
    /// <param name="root">The root node to search from</param>
    /// <param name="name">The name to search for</param>
    /// <param name="recursive">Whether to search recursively</param>
    /// <returns>The first node with the specified name, or null if not found</returns>
    public static Node? FindByName(Node? root, string name, bool recursive = true)
    {
        if (root == null || string.IsNullOrEmpty(name))
            return null;

        // Check direct children first
        foreach (Node child in root.GetChildren())
        {
            if (child.Name == name)
                return child;

            if (recursive)
            {
                var found = FindByName(child, name, true);
                if (found != null)
                    return found;
            }
        }

        return null;
    }
```

Finds a node by name in the hierarchy.

**Returns:** `Node?`

**Parameters:**
- `Node? root`
- `string name`
- `bool recursive`

### FindAllByName

```csharp
/// <summary>
    /// Finds all nodes with the specified name in the hierarchy.
    /// </summary>
    /// <param name="root">The root node to search from</param>
    /// <param name="name">The name to search for</param>
    /// <returns>Array of all nodes with the specified name</returns>
    public static GDCollections.Array<Node> FindAllByName(Node? root, string name)
    {
        var results = new GDCollections.Array<Node>();
        FindAllByNameRecursive(root, name, results);
        return results;
    }
```

Finds all nodes with the specified name in the hierarchy.

**Returns:** `GDCollections.Array<Node>`

**Parameters:**
- `Node? root`
- `string name`

### HasComponent

```csharp
/// <summary>
    /// Checks if a node has a component of type T.
    /// </summary>
    /// <typeparam name="T">The component type to check for</typeparam>
    /// <param name="node">The node to check</param>
    /// <returns>True if the node has a component of type T</returns>
    public static bool HasComponent<T>(Node? node) where T : Node
    {
        return FindFirst<T>(node) != null;
    }
```

Checks if a node has a component of type T.

**Returns:** `bool`

**Parameters:**
- `Node? node`

### GetRelativePath

```csharp
/// <summary>
    /// Gets the path to a node relative to a root node.
    /// </summary>
    /// <param name="root">The root node</param>
    /// <param name="target">The target node</param>
    /// <returns>Relative path from root to target, or empty string if not found</returns>
    public static string GetRelativePath(Node? root, Node? target)
    {
        if (root == null || target == null)
            return string.Empty;

        var path = target.GetPath();
        var rootPath = root.GetPath();

        if (path.ToString().StartsWith(rootPath.ToString()))
        {
            var relativePath = path.ToString().Substring(rootPath.ToString().Length);
            if (relativePath.StartsWith("/"))
                relativePath = relativePath.Substring(1);
            return relativePath;
        }

        return path; // Return full path if not under root
    }
```

Gets the path to a node relative to a root node.

**Returns:** `string`

**Parameters:**
- `Node? root`
- `Node? target`

### FindClosest

```csharp
/// <summary>
    /// Finds the closest node of type T to a given position.
    /// </summary>
    /// <typeparam name="T">The node type to search for</typeparam>
    /// <param name="root">The root node to search from</param>
    /// <param name="position">The position to measure distance from</param>
    /// <param name="maxDistance">Maximum distance to consider</param>
    /// <returns>The closest node of type T, or null if none found within maxDistance</returns>
    public static T? FindClosest<T>(Node? root, Vector2 position, float maxDistance = float.MaxValue) where T : Node2D
    {
        if (root == null)
            return null;

        T? closest = null;
        var closestDistance = maxDistance;

        var allNodes = FindAll<T>(root);
        foreach (var node in allNodes)
        {
            var distance = node.GlobalPosition.DistanceTo(position);
            if (distance < closestDistance)
            {
                closestDistance = distance;
                closest = node;
            }
        }

        return closest;
    }
```

Finds the closest node of type T to a given position.

**Returns:** `T?`

**Parameters:**
- `Node? root`
- `Vector2 position`
- `float maxDistance`

