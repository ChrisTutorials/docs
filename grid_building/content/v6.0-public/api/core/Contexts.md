---
title: "Contexts"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/contexts/"
---

# Contexts

```csharp
GridBuilding.Core.Domain.State
class Contexts
{
    // Members...
}
```

Contains contexts for resolving references to current objects within the grid building system instance.
Ported from: godot/addons/grid_building/core/contexts/gb_contexts.gd

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Common/Contexts.cs`  
**Namespace:** `GridBuilding.Core.Domain.State`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Indicator

```csharp
/// <summary>
    /// Holds reference to current indicator manager object
    /// </summary>
    public IndicatorContext Indicator { get; }
```

Holds reference to current indicator manager object

### Owner

```csharp
/// <summary>
    /// Holds reference to the currently owning game node for the instance of the grid building system and related modules
    /// </summary>
    public OwnerContext Owner { get; }
```

Holds reference to the currently owning game node for the instance of the grid building system and related modules

### Systems

```csharp
/// <summary>
    /// Holds references to the systems used in grid building operations.
    /// This context allows for easy access to the systems without needing to
    /// pass them around manually.
    /// </summary>
    public SystemsContext Systems { get; }
```

Holds references to the systems used in grid building operations.
This context allows for easy access to the systems without needing to
pass them around manually.


## Methods

### GetRuntimeIssues

```csharp
/// <summary>
    /// Ensures all runtime contexts are properly initialized.
    /// Contexts may need to have their properties defined by game objects like LevelContext and Owner
    /// </summary>
    public List<string> GetRuntimeIssues(IRuntimeChecks? checks = null)
    {
        var issues = new List<string>();

        if (Indicator != null)
        {
            issues.AddRange(Indicator.GetRuntimeIssues());
        }
        else
        {
            issues.Add("IndicatorContext is null");
        }

        if (Owner != null)
        {
            issues.AddRange(Owner.GetRuntimeIssues());
        }
        else
        {
            issues.Add("OwnerContext is null");
        }

        if (Systems != null)
        {
            issues.AddRange(Systems.GetRuntimeIssues(checks));
        }
        else
        {
            issues.Add("SystemsContext is null");
        }

        return issues;
    }
```

Ensures all runtime contexts are properly initialized.
Contexts may need to have their properties defined by game objects like LevelContext and Owner

**Returns:** `List<string>`

**Parameters:**
- `IRuntimeChecks? checks`

### GetEditorIssues

```csharp
/// <summary>
    /// Validates editor configuration before nodes are set up.
    /// This should be called during the editor setup phase.
    /// </summary>
    /// <returns>List of editor configuration issues (empty if valid)</returns>
    public List<string> GetEditorIssues()
    {
        var issues = new List<string>();
        issues.AddRange(Indicator.GetEditorIssues());
        issues.AddRange(Owner.GetEditorIssues());
        issues.AddRange(Systems.GetEditorIssues());
        return issues;
    }
```

Validates editor configuration before nodes are set up.
This should be called during the editor setup phase.

**Returns:** `List<string>`

