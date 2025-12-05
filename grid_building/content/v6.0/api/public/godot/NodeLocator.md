---
title: "NodeLocator"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/nodelocator/"
---

# NodeLocator

```csharp
GridBuilding.Godot.Systems.Placement.Resources
class NodeLocator
{
    // Members...
}
```

Settings for locating inventory nodes during rule validation.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/resources/node_locator.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Resources/NodeLocator.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Resources`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Method

```csharp
#endregion

    #region Exported Properties

    /// <summary>
    /// Method for finding the inventory node.
    /// </summary>
    [Export]
    public SearchMethod Method { get; set; } = SearchMethod.NodeName;
```

Method for finding the inventory node.

### SearchString

```csharp
/// <summary>
    /// Search string to use with the search method.
    /// </summary>
    [Export]
    public string SearchString { get; set; } = "<Set me>";
```

Search string to use with the search method.


## Methods

### LocateContainer

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Locates a container node based on the configured search method.
    /// Searches the node tree using the specified method and search string.
    /// Uses pure logic class for composition over inheritance.
    /// </summary>
    /// <param name="searchRoot">Root node to start the search from</param>
    /// <returns>Found container node or null</returns>
    public Node? LocateContainer(Node? searchRoot)
    {
        if (searchRoot == null)
            return null;

        Node? inventoryContainer = null;
        var allNodes = new global::Godot.Collections.Array<Node> { searchRoot };

        // Collect all child nodes for search
        var childNodes = searchRoot.FindChildren("", "Node", true, false);
        foreach (var child in childNodes)
        {
            allNodes.Add(child);
        }

        switch (Method)
        {
            case SearchMethod.NodeName:
                // Use pure logic class for node search
                var foundNodesByName = NodeSearchLogic.FindNodesByName(allNodes, SearchString);
                if (foundNodesByName.Count > 0)
                {
                    inventoryContainer = foundNodesByName[0];
                }
                break;
            case SearchMethod.ScriptNameWithExtension:
                // Use pure logic class for script search
                var foundNodesByScript = NodeSearchLogic.FindNodesByScript(allNodes, SearchString);
                if (foundNodesByScript.Count > 0)
                {
                    inventoryContainer = foundNodesByScript[0];
                }
                break;
            case SearchMethod.IsInGroup:
                // Use pure logic class for group search
                var foundNodesByGroup = NodeSearchLogic.FindNodesByGroup(allNodes, SearchString);
                if (foundNodesByGroup.Count > 0)
                {
                    inventoryContainer = foundNodesByGroup[0];
                }
                break;
        }

        return inventoryContainer;
    }
```

Locates a container node based on the configured search method.
Searches the node tree using the specified method and search string.
Uses pure logic class for composition over inheritance.

**Returns:** `Node?`

**Parameters:**
- `Node? searchRoot`

### GetScriptName

```csharp
/// <summary>
    /// Extracts the script file name from an object's attached script.
    /// Uses pure logic class for composition over inheritance.
    /// Returns the script filename with extension, or empty string if no script.
    /// </summary>
    /// <param name="check">Object to get script name from</param>
    /// <returns>Script filename with extension or empty string</returns>
    public string GetScriptName(GodotObject check)
    {
        // Use pure logic class for script name extraction
        return NodeSearchLogic.GetScriptName(check);
    }
```

Extracts the script file name from an object's attached script.
Uses pure logic class for composition over inheritance.
Returns the script filename with extension, or empty string if no script.

**Returns:** `string`

**Parameters:**
- `GodotObject check`

### GetEditorIssues

```csharp
/// <summary>
    /// Returns an array of issues found during editor validation.
    /// </summary>
    /// <returns>Array of editor validation issues</returns>
    public global::Godot.Collections.Array<string> GetEditorIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();

        if (string.IsNullOrEmpty(SearchString) || SearchString == "<Set me>")
        {
            issues.Add("NodeLocator SearchString is not set");
        }

        return issues;
    }
```

Returns an array of issues found during editor validation.

**Returns:** `global::Godot.Collections.Array<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Returns an array of issues found during runtime validation.
    /// </summary>
    /// <returns>Array of runtime validation issues</returns>
    public global::Godot.Collections.Array<string> GetRuntimeIssues()
    {
        var issues = GetEditorIssues();
        return issues;
    }
```

Returns an array of issues found during runtime validation.

**Returns:** `global::Godot.Collections.Array<string>`

