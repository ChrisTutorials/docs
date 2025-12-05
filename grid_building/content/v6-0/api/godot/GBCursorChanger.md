---
title: "GBCursorChanger"
description: "Optional component for changing the cursors when the grid builder mode state changes.
Ported from: godot/addons/grid_building/shared/components/ui_controls/cursor_changer.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gbcursorchanger/"
---

# GBCursorChanger

```csharp
GridBuilding.Godot.Shared.Components.UIControls
class GBCursorChanger
{
    // Members...
}
```

Optional component for changing the cursors when the grid builder mode state changes.
Ported from: godot/addons/grid_building/shared/components/ui_controls/cursor_changer.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/CursorChanger.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Components.UIControls`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ModeState

```csharp
/// <summary>
    /// Mode state dependency
    /// </summary>
    public ModeState? ModeState
    {
        get => _modeState;
        set
        {
            if (_modeState != null)
            {
                _modeState.ModeChanged -= OnModeChanged;
            }

            _modeState = value;

            if (_modeState != null)
            {
                _modeState.ModeChanged += OnModeChanged;
            }
        }
    }
```

Mode state dependency


## Methods

### _Ready

```csharp
#endregion

    #region Lifecycle

    public override void _Ready()
    {
        TreeExiting += OnTreeExiting;
    }
```

**Returns:** `void`

### ResolveGBDependencies

```csharp
public override void ResolveGBDependencies(CompositionContainer container)
    {
        ModeState = container.GetStates().Mode;
        _cursors = container.GetVisualSettings().Cursor;
        _logger = container.GetLogger() as ILogger ?? LoggerBridge.Create();

        if (_cursors == null)
        {
            GD.PushError("Cursor settings must be defined for cursor change to work.");
        }

        GetRuntimeIssues();
    }
```

**Returns:** `void`

**Parameters:**
- `CompositionContainer container`

### GetRuntimeIssues

```csharp
public override global::Godot.Collections.Array<string> GetRuntimeIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();

        if (_cursors == null)
        {
            issues.Add(
                "You must create the cursor settings in the CompositionContainer in the InjectorSystem for this node to work."
            );
        }

        _logger?.LogIssues(issues);
        return issues;
    }
```

**Returns:** `global::Godot.Collections.Array<string>`

