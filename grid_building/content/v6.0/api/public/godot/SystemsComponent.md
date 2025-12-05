---
title: "SystemsComponent"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/systemscomponent/"
---

# SystemsComponent

```csharp
GridBuilding.Godot.Core.Base
class SystemsComponent
{
    // Members...
}
```

Base component class for GridBuilding systems.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Core/Base/SystemsComponent.cs`  
**Namespace:** `GridBuilding.Godot.Core.Base`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ResolveGbDependencies

```csharp
/// <summary>
    /// Override this method to receive injected dependencies.
    /// </summary>
    /// <param name="container">The dependency container</param>
    /// <returns>True if dependencies were successfully resolved, false otherwise</returns>
    public virtual bool ResolveGbDependencies(CompositionContainer container)
    {
        return true;
    }
```

Override this method to receive injected dependencies.

**Returns:** `bool`

**Parameters:**
- `CompositionContainer container`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Gets runtime validation issues.
    /// </summary>
    /// <returns>Array of validation issue messages</returns>
    public virtual global::Godot.Collections.Array<string> GetRuntimeIssues()
    {
        return new global::Godot.Collections.Array<string>();
    }
```

Gets runtime validation issues.

**Returns:** `global::Godot.Collections.Array<string>`

