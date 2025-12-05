---
title: "GridTargetingSettings"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/gridtargetingsettings/"
---

# GridTargetingSettings

```csharp
GridBuilding.Godot.Tests.Resources.Settings
class GridTargetingSettings
{
    // Members...
}
```

Settings related to targeting tiles and the pathing that goes between them.
Ported from: godot/addons/grid_building/systems/grid_targeting/grid_targeting_settings.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Settings/GridTargetingSettings.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Resources.Settings`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### LimitToAdjacent

```csharp
#region Core Settings

    /// <summary>
    /// When set, limits tile selection to only the character adjacent tile that is in the direction of the cursor location.
    /// </summary>
    public bool LimitToAdjacent { get; set; }
```

When set, limits tile selection to only the character adjacent tile that is in the direction of the cursor location.

### MaxTileDistance

```csharp
/// <summary>
    /// The number of tiles distance away from the limit target that the pointer tile can be.
    /// Range: 0-20+
    /// </summary>
    public int MaxTileDistance { get; set; } = 3;
```

The number of tiles distance away from the limit target that the pointer tile can be.
Range: 0-20+

### RestrictToMapArea

```csharp
/// <summary>
    /// Makes it so the cursor can only move to areas with valid tiles on the target map layer.
    /// </summary>
    public bool RestrictToMapArea { get; set; }
```

Makes it so the cursor can only move to areas with valid tiles on the target map layer.

### ShowDebug

```csharp
/// <summary>
    /// Whether to show debug information for targeting systems.
    /// </summary>
    public bool ShowDebug { get; set; }
```

Whether to show debug information for targeting systems.

### EnableMouseInput

```csharp
#endregion

    #region GridPositioner2D Settings

    /// <summary>
    /// Toggle whether the GridPositioner2D will move with mouse input or not.
    /// </summary>
    public bool EnableMouseInput { get; set; } = true;
```

Toggle whether the GridPositioner2D will move with mouse input or not.

### EnableKeyboardInput

```csharp
/// <summary>
    /// Toggle whether the GridPositioner will move with keyboard input or not.
    /// </summary>
    public bool EnableKeyboardInput { get; set; }
```

Toggle whether the GridPositioner will move with keyboard input or not.

### EnableRotationInput

```csharp
/// <summary>
    /// Toggle whether the GridPositioner2D can rotate objects with rotation input.
    /// </summary>
    public bool EnableRotationInput { get; set; }
```

Toggle whether the GridPositioner2D can rotate objects with rotation input.

### RemainActiveInOffMode

```csharp
/// <summary>
    /// Controls whether GridPositioner2D remains active during OFF mode.
    /// </summary>
    public bool RemainActiveInOffMode { get; set; }
```

Controls whether GridPositioner2D remains active during OFF mode.

### ManualRecenterMode

```csharp
/// <summary>
    /// Manual recenter mode for GridPositioner2D input actions.
    /// </summary>
    public CenteringMode ManualRecenterMode { get; set; } = CenteringMode.CenterOnScreen;
```

Manual recenter mode for GridPositioner2D input actions.

### PositionOnEnablePolicy

```csharp
/// <summary>
    /// Recenter policy on enable.
    /// </summary>
    public RecenterOnEnablePolicy PositionOnEnablePolicy { get; set; } = RecenterOnEnablePolicy.MouseCursor;
```

Recenter policy on enable.

### HideOnHandled

```csharp
/// <summary>
    /// Controls whether the grid positioner hides when mouse input is handled by UI.
    /// </summary>
    public bool HideOnHandled { get; set; } = true;
```

Controls whether the grid positioner hides when mouse input is handled by UI.

### RegionSize

```csharp
#endregion

    #region AStarGrid2D Settings

    /// <summary>
    /// Size of the AStar region.
    /// </summary>
    public (int X, int Y) RegionSize { get; set; } = (50, 50);
```

Size of the AStar region.

### CellShape

```csharp
/// <summary>
    /// Cell shape for the AStar grid.
    /// </summary>
    public CellShape CellShape { get; set; } = CellShape.Square;
```

Cell shape for the AStar grid.

### DiagonalMode

```csharp
/// <summary>
    /// What moves are allowed in a single change of grid space for grid pathing.
    /// </summary>
    public DiagonalMode DiagonalMode { get; set; } = DiagonalMode.Always;
```

What moves are allowed in a single change of grid space for grid pathing.

### DefaultComputeHeuristic

```csharp
/// <summary>
    /// Formula for calculating AStarGrid2D movement cost (compute heuristic).
    /// </summary>
    public AStarHeuristic DefaultComputeHeuristic { get; set; } = AStarHeuristic.Euclidean;
```

Formula for calculating AStarGrid2D movement cost (compute heuristic).

### DefaultEstimateHeuristic

```csharp
/// <summary>
    /// Formula for calculating AStarGrid2D movement cost (estimate heuristic).
    /// </summary>
    public AStarHeuristic DefaultEstimateHeuristic { get; set; } = AStarHeuristic.Euclidean;
```

Formula for calculating AStarGrid2D movement cost (estimate heuristic).


## Methods

### GetEditorIssues

```csharp
#endregion

    #region Validation

    /// <summary>
    /// Returns an array of issues found during editor validation.
    /// </summary>
    public List<string> GetEditorIssues()
    {
        var issues = new List<string>();

        if (MaxTileDistance < 0)
        {
            issues.Add($"Max tile distance must be a positive value on {this}");
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
    public List<string> GetRuntimeIssues()
    {
        return GetEditorIssues();
    }
```

Returns an array of issues found during runtime validation.

**Returns:** `List<string>`

