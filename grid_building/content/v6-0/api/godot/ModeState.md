---
title: "ModeState"
description: "Maintains the state of the Grid Builder mode and emits signals when it changes.
Ported from: godot/addons/grid_building/core/contexts/mode_state.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/modestate/"
---

# ModeState

```csharp
GridBuilding.Godot.Tests.Core.Contexts
class ModeState
{
    // Members...
}
```

Maintains the state of the Grid Builder mode and emits signals when it changes.
Ported from: godot/addons/grid_building/core/contexts/mode_state.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ModeState.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Contexts`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Current

```csharp
/// <summary>
    /// The active mode that the system is in for modifying the game world.
    /// </summary>
    public BuildingMode Current
    {
        get => _current;
        set
        {
            if (_current == value)
            {
                return;
            }

            _current = value;
            ModeChanged?.Invoke(_current);
        }
    }
```

The active mode that the system is in for modifying the game world.


## Methods

### GetEditorIssues

```csharp
/// <summary>
    /// Returns an array of issues found during editor validation
    /// </summary>
    public List<string> GetEditorIssues()
    {
        // ModeState doesn't have specific validation requirements beyond the basic Resource validation
        return new List<string>();
    }
```

Returns an array of issues found during editor validation

**Returns:** `List<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Returns an array of issues found during runtime validation
    /// </summary>
    public List<string> GetRuntimeIssues()
    {
        var issues = new List<string>();
        issues.AddRange(GetEditorIssues());
        return issues;
    }
```

Returns an array of issues found during runtime validation

**Returns:** `List<string>`

