---
title: "ResourceStack"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/resourcestack/"
---

# ResourceStack

```csharp
GridBuilding.Godot.Systems.Placement.Resources
class ResourceStack
{
    // Members...
}
```

Resource stack for inventory and cost tracking.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/resources/resource_stack.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Resources/ResourceStack.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Resources`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Type

```csharp
#region Exported Properties

    /// <summary>
    /// The resource type stored in the stack.
    /// </summary>
    [Export]
    public Resource? Type { get; set; }
```

The resource type stored in the stack.

### Count

```csharp
/// <summary>
    /// The number of resources in the stack.
    /// </summary>
    [Export]
    public int Count { get; set; } = 1;
```

The number of resources in the stack.


## Methods

### GetEditorIssues

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Returns an array of issues found during editor validation.
    /// </summary>
    /// <returns>Array of editor validation issues</returns>
    public List<string> GetEditorIssues()
    {
        var issues = new List<string>();

        if (Type == null)
        {
            issues.Add("ResourceStack Type is null");
        }

        if (Count < 0)
        {
            issues.Add("ResourceStack Count cannot be negative");
        }

        return issues;
    }
```

Returns an array of issues found during editor validation.

**Returns:** `List<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Returns an array of issues found during runtime validation.
    /// </summary>
    /// <returns>Array of runtime validation issues</returns>
    public List<string> GetRuntimeIssues()
    {
        var issues = GetEditorIssues();
        return issues;
    }
```

Returns an array of issues found during runtime validation.

**Returns:** `List<string>`

