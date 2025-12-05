---
title: "GBOwner"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/gbowner/"
---

# GBOwner

```csharp
GridBuilding.Godot.Tests.Base
class GBOwner
{
    // Members...
}
```

Component that assigns an entity as the active owner on a user state resource.
This node can automatically or manually designate an owner_root (such as a CharacterBody2D, NPC, or other)
as the active entity within the system, enabling participation in grid-based logic.
Ported from: godot/addons/grid_building/core/contexts/gb_owner.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Base/GBOwner.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Base`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### OwnerRoot

```csharp
/// <summary>
    /// The root node representing the entity that owns this component.
    /// 
    /// This can be a player character, AI agent, NPC, or any other node that acts as the owning entity.
    /// This node will be assigned as the active entity in the user state.
    /// </summary>
    public object? OwnerRoot
    {
        get => _ownerRoot;
        set
        {
            if (ReferenceEquals(_ownerRoot, value))
            {
                return;
            }
            
            _ownerRoot = value;
            RootChanged?.Invoke(_ownerRoot);
        }
    }
```

The root node representing the entity that owns this component.
/// This can be a player character, AI agent, NPC, or any other node that acts as the owning entity.
This node will be assigned as the active entity in the user state.


## Methods

### ResolveDependencies

```csharp
/// <summary>
    /// Resolve dependencies from the composition container.
    /// In the C# version, we pass the context directly rather than using a container.
    /// </summary>
    /// <param name="context">The owner context to register with</param>
    public void ResolveDependencies(GBOwnerContext context)
    {
        _context = context;
        _context.SetOwner(this);

        var validationIssues = GetRuntimeIssues();
        foreach (var issue in validationIssues)
        {
            // In production, this would use the logging system
            Console.WriteLine($"GBOwner validation: {issue}");
        }
    }
```

Resolve dependencies from the composition container.
In the C# version, we pass the context directly rather than using a container.

**Returns:** `void`

**Parameters:**
- `GBOwnerContext context`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Validates that all required dependencies and properties are properly set.
    /// Returns validation issues if dependencies are missing, empty list if valid.
    /// </summary>
    /// <returns>List of validation issues (empty if valid)</returns>
    public List<string> GetRuntimeIssues()
    {
        var issues = new List<string>();

        if (_context == null)
        {
            issues.Add("GBOwner._context is null");
        }
        if (OwnerRoot == null)
        {
            issues.Add("GBOwner.owner_root is null");
        }

        return issues;
    }
```

Validates that all required dependencies and properties are properly set.
Returns validation issues if dependencies are missing, empty list if valid.

**Returns:** `List<string>`

