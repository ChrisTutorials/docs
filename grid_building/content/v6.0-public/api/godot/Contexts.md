---
title: "Contexts"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/contexts/"
---

# Contexts

```csharp
GridBuilding.Godot.Core.Contexts
class Contexts
{
    // Members...
}
```

Contains contexts for resolving references to current objects within the grid building system instance

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Core/Contexts/Contexts.cs`  
**Namespace:** `GridBuilding.Godot.Core.Contexts`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Indicator

```csharp
/// <summary>
    /// Holds reference to current indicator manager object
    /// </summary>
    public IndicatorContext Indicator { get; private set; }
```

Holds reference to current indicator manager object

### Owner

```csharp
/// <summary>
    /// Holds reference to the currently owning game node for the instance of the grid building system and related modules
    /// </summary>
    public OwnerContext Owner { get; private set; }
```

Holds reference to the currently owning game node for the instance of the grid building system and related modules

### Systems

```csharp
/// <summary>
    /// Holds references to the systems used in grid building operations.
    /// This context allows for easy access to the systems without needing to
    /// pass them around manually.
    /// </summary>
    public SystemsContext Systems { get; private set; }
```

Holds references to the systems used in grid building operations.
This context allows for easy access to the systems without needing to
pass them around manually.


## Methods

### GetRuntimeIssues

```csharp
/// <summary>
    /// Ensures all runtime contexts are properly initialized.
    /// Contexts may need to have their properties defined by game objects like LevelContext and GBOwner
    /// </summary>
    /// <param name="checks">Runtime checks instance</param>
    /// <returns>Array of runtime validation issue messages</returns>
    public global::Godot.Collections.Array<string> GetRuntimeIssues(GBRuntimeChecks checks)
    {
        var issues = new global::Godot.Collections.Array<string>();

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
Contexts may need to have their properties defined by game objects like LevelContext and GBOwner

**Returns:** `global::Godot.Collections.Array<string>`

**Parameters:**
- `GBRuntimeChecks checks`

### GetEditorIssues

```csharp
/// <summary>
    /// Validates editor configuration before nodes are set up.
    /// This should be called during the editor setup phase.
    /// </summary>
    /// <returns>List of editor configuration issues (empty if valid)</returns>
    public global::Godot.Collections.Array<string> GetEditorIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();
        
        if (Indicator != null)
        {
            issues.AddRange(Indicator.GetEditorIssues());
        }
        
        if (Owner != null)
        {
            issues.AddRange(Owner.GetEditorIssues());
        }
        
        if (Systems != null)
        {
            issues.AddRange(Systems.GetEditorIssues());
        }

        return issues;
    }
```

Validates editor configuration before nodes are set up.
This should be called during the editor setup phase.

**Returns:** `global::Godot.Collections.Array<string>`

