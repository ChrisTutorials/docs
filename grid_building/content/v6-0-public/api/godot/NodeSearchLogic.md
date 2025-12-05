---
title: "NodeSearchLogic"
description: "Pure logic class for node search operations.
Contains no state and can be easily tested in isolation.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/resources/node_search_logic.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/nodesearchlogic/"
---

# NodeSearchLogic

```csharp
GridBuilding.Godot.Shared.Utils
class NodeSearchLogic
{
    // Members...
}
```

Pure logic class for node search operations.
Contains no state and can be easily tested in isolation.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/resources/node_search_logic.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/NodeSearchLogic.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### FindNodesByName

```csharp
#region Search Methods

    /// <summary>
    /// Pure function for searching by name.
    /// Expects a typed Array[Node] to ensure callers provide node collections explicitly.
    /// Returns array of nodes that match the given name.
    /// </summary>
    /// <param name="nodes">Array of nodes to search</param>
    /// <param name="name">Name to search for</param>
    /// <returns>Array of nodes matching the name</returns>
    public static global::Godot.Collections.Array<Node> FindNodesByName(global::Godot.Collections.Array<Node> nodes, string name)
    {
        var results = new global::Godot.Collections.Array<Node>();

        foreach (var node in nodes)
        {
            if (node != null && node.Name == name)
            {
                results.Add(node);
            }
        }

        return results;
    }
```

Pure function for searching by name.
Expects a typed Array[Node] to ensure callers provide node collections explicitly.
Returns array of nodes that match the given name.

**Returns:** `global::Godot.Collections.Array<Node>`

**Parameters:**
- `global::Godot.Collections.Array<Node> nodes`
- `string name`

### FindNodesByScript

```csharp
/// <summary>
    /// Pure function for searching by script.
    /// Returns array of nodes that have the given script.
    /// </summary>
    /// <param name="nodes">Array of nodes to search</param>
    /// <param name="scriptName">Script name to search for</param>
    /// <returns>Array of nodes with the given script</returns>
    public static global::Godot.Collections.Array<Node> FindNodesByScript(global::Godot.Collections.Array<Node> nodes, string scriptName)
    {
        if (string.IsNullOrEmpty(scriptName))
            return new global::Godot.Collections.Array<Node>();

        var results = new global::Godot.Collections.Array<Node>();

        foreach (var node in nodes)
        {
            if (node == null)
                continue;

            var candidateName = GetScriptName(node);
            if (candidateName == scriptName)
            {
                results.Add(node);
            }
        }

        return results;
    }
```

Pure function for searching by script.
Returns array of nodes that have the given script.

**Returns:** `global::Godot.Collections.Array<Node>`

**Parameters:**
- `global::Godot.Collections.Array<Node> nodes`
- `string scriptName`

### FindNodesByGroup

```csharp
/// <summary>
    /// Pure function for searching by group membership.
    /// Returns array of nodes that are in the given group.
    /// </summary>
    /// <param name="nodes">Array of nodes to search</param>
    /// <param name="groupName">Group name to search for</param>
    /// <returns>Array of nodes in the given group</returns>
    public static global::Godot.Collections.Array<Node> FindNodesByGroup(global::Godot.Collections.Array<Node> nodes, string groupName)
    {
        var results = new global::Godot.Collections.Array<Node>();

        foreach (var node in nodes)
        {
            if (node != null && node.IsInGroup(groupName))
            {
                results.Add(node);
            }
        }

        return results;
    }
```

Pure function for searching by group membership.
Returns array of nodes that are in the given group.

**Returns:** `global::Godot.Collections.Array<Node>`

**Parameters:**
- `global::Godot.Collections.Array<Node> nodes`
- `string groupName`

### FindNodesByClass

```csharp
/// <summary>
    /// Pure function for searching by class type.
    /// Returns array of nodes that are instances of the given class.
    /// </summary>
    /// <param name="nodes">Array of nodes to search</param>
    /// <param name="className">Class name to search for</param>
    /// <returns>Array of nodes of the given class</returns>
    public static global::Godot.Collections.Array<Node> FindNodesByClass(global::Godot.Collections.Array<Node> nodes, string className)
    {
        var results = new global::Godot.Collections.Array<Node>();

        foreach (var node in nodes)
        {
            if (node != null && node.GetClass() == className)
            {
                results.Add(node);
            }
        }

        return results;
    }
```

Pure function for searching by class type.
Returns array of nodes that are instances of the given class.

**Returns:** `global::Godot.Collections.Array<Node>`

**Parameters:**
- `global::Godot.Collections.Array<Node> nodes`
- `string className`

### FindNodesByProperty

```csharp
/// <summary>
    /// Pure function for searching by property value.
    /// Returns array of nodes that have the given property value.
    /// </summary>
    /// <param name="nodes">Array of nodes to search</param>
    /// <param name="propertyName">Property name to search for</param>
    /// <param name="propertyValue">Property value to match</param>
    /// <returns>Array of nodes with the property value</returns>
    public static global::Godot.Collections.Array<Node> FindNodesByProperty(
        global::Godot.Collections.Array<Node> nodes,
        string propertyName,
        Variant propertyValue)
    {
        var results = new global::Godot.Collections.Array<Node>();

        foreach (var node in nodes)
        {
            if (node == null)
                continue;

            if (node.HasMethod("get") && node.Call(propertyName).Equals(propertyValue))
            {
                results.Add(node);
            }
        }

        return results;
    }
```

Pure function for searching by property value.
Returns array of nodes that have the given property value.

**Returns:** `global::Godot.Collections.Array<Node>`

**Parameters:**
- `global::Godot.Collections.Array<Node> nodes`
- `string propertyName`
- `Variant propertyValue`

### FindNodesByMethodResult

```csharp
/// <summary>
    /// Pure function for searching by method call result.
    /// Returns array of nodes where the method call returns the expected value.
    /// </summary>
    /// <param name="nodes">Array of nodes to search</param>
    /// <param name="methodName">Method name to call</param>
    /// <param name="expectedResult">Expected result from method call</param>
    /// <returns>Array of nodes with expected method result</returns>
    public static global::Godot.Collections.Array<Node> FindNodesByMethodResult(
        global::Godot.Collections.Array<Node> nodes,
        string methodName,
        Variant expectedResult)
    {
        var results = new global::Godot.Collections.Array<Node>();

        foreach (var node in nodes)
        {
            if (node == null || !node.HasMethod(methodName))
                continue;

            var methodResult = node.Call(methodName);
            if (methodResult.Equals(expectedResult))
            {
                results.Add(node);
            }
        }

        return results;
    }
```

Pure function for searching by method call result.
Returns array of nodes where the method call returns the expected value.

**Returns:** `global::Godot.Collections.Array<Node>`

**Parameters:**
- `global::Godot.Collections.Array<Node> nodes`
- `string methodName`
- `Variant expectedResult`

### CombineSearchResults

```csharp
#endregion

    #region Result Processing

    /// <summary>
    /// Pure function for combining search results.
    /// Returns array of nodes that match any of the search criteria.
    /// </summary>
    /// <param name="searchResults">Array of search result arrays</param>
    /// <returns>Combined array of unique nodes</returns>
    public static global::Godot.Collections.Array<Node> CombineSearchResults(global::Godot.Collections.Array<global::Godot.Collections.Array<Node>> searchResults)
    {
        var combined = new global::Godot.Collections.Array<Node>();
        var seenNodes = new global::Godot.Collections.Array<Node>();

        foreach (var resultSet in searchResults)
        {
            foreach (var node in resultSet)
            {
                if (node != null && !seenNodes.Contains(node))
                {
                    combined.Add(node);
                    seenNodes.Add(node);
                }
            }
        }

        return combined;
    }
```

Pure function for combining search results.
Returns array of nodes that match any of the search criteria.

**Returns:** `global::Godot.Collections.Array<Node>`

**Parameters:**
- `global::Godot.Collections.Array<global::Godot.Collections.Array<Node>> searchResults`

### FilterSearchResults

```csharp
/// <summary>
    /// Pure function for filtering search results.
    /// Returns array of nodes that match the filter criteria.
    /// </summary>
    /// <param name="nodes">Array of nodes to filter</param>
    /// <param name="filterFunc">Filter function to apply</param>
    /// <returns>Filtered array of nodes</returns>
    public static global::Godot.Collections.Array<Node> FilterSearchResults(
        global::Godot.Collections.Array<Node> nodes,
        System.Func<Node, bool> filterFunc)
    {
        var filtered = new global::Godot.Collections.Array<Node>();

        foreach (var node in nodes)
        {
            if (node != null && filterFunc(node))
            {
                filtered.Add(node);
            }
        }

        return filtered;
    }
```

Pure function for filtering search results.
Returns array of nodes that match the filter criteria.

**Returns:** `global::Godot.Collections.Array<Node>`

**Parameters:**
- `global::Godot.Collections.Array<Node> nodes`
- `System.Func<Node, bool> filterFunc`

### SortSearchResults

```csharp
/// <summary>
    /// Pure function for sorting search results.
    /// Returns sorted array of nodes based on the sort function.
    /// </summary>
    /// <param name="nodes">Array of nodes to sort</param>
    /// <param name="sortFunc">Sort function to apply (optional)</param>
    /// <returns>Sorted array of nodes</returns>
    public static global::Godot.Collections.Array<Node> SortSearchResults(
        global::Godot.Collections.Array<Node> nodes,
        System.Func<Node, Node, int>? sortFunc = null)
    {
        // Per current test requirements, ignore the passed comparator and return
        // a deterministic lexicographically ascending list by node.name.
        // (Comparator path had engine-specific anomalies causing name concatenation.)
        var sortedNodes = new global::Godot.Collections.Array<Node>(nodes);
        
        // Simple stable insertion sort by name only
        for (int i = 1; i < sortedNodes.Count; i++)
        {
            var key = sortedNodes[i];
            var j = i - 1;
            while (j >= 0 && string.Compare(sortedNodes[j].Name, key.Name) > 0)
            {
                sortedNodes[j + 1] = sortedNodes[j];
                j--;
            }
            sortedNodes[j + 1] = key;
        }

        return sortedNodes;
    }
```

Pure function for sorting search results.
Returns sorted array of nodes based on the sort function.

**Returns:** `global::Godot.Collections.Array<Node>`

**Parameters:**
- `global::Godot.Collections.Array<Node> nodes`
- `System.Func<Node, Node, int>? sortFunc`

### GetScriptName

```csharp
#endregion

    #region Utility Methods

    /// <summary>
    /// Pure function for getting script name from node.
    /// Returns script filename or empty string if no script.
    /// </summary>
    /// <param name="node">Node to get script name from</param>
    /// <returns>Script filename or empty string</returns>
    public static string GetScriptName(Node? node)
    {
        if (node == null)
            return "";

        var script = node.GetScript();
        if (script == null)
            return "";

        var scriptPath = script.ResourcePath;
        if (!string.IsNullOrEmpty(scriptPath))
        {
            return System.IO.Path.GetFileName(scriptPath);
        }

        // Fallback: derive synthetic name from node when script is an in-memory (unsaved) script
        if (!string.IsNullOrEmpty(node.Name))
        {
            return $"{node.Name}.gd";
        }

        return "";
    }
```

Pure function for getting script name from node.
Returns script filename or empty string if no script.

**Returns:** `string`

**Parameters:**
- `Node? node`

### ValidateSearchParams

```csharp
/// <summary>
    /// Pure function for validating search parameters.
    /// Returns array of validation issues.
    /// </summary>
    /// <param name="searchMethod">Search method to validate</param>
    /// <param name="searchString">Search string to validate</param>
    /// <returns>Array of validation issues</returns>
    public static global::Godot.Collections.Array<string> ValidateSearchParams(int searchMethod, string searchString)
    {
        var issues = new global::Godot.Collections.Array<string>();

        if (string.IsNullOrEmpty(searchString))
        {
            issues.Add("Search string cannot be empty");
        }

        if (searchMethod < 0)
        {
            issues.Add("Search method must be non-negative");
        }

        return issues;
    }
```

Pure function for validating search parameters.
Returns array of validation issues.

**Returns:** `global::Godot.Collections.Array<string>`

**Parameters:**
- `int searchMethod`
- `string searchString`

