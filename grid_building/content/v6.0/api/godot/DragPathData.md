---
title: "DragPathData"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/dragpathdata/"
---

# DragPathData

```csharp
GridBuilding.Godot.Systems.Building.Data
class DragPathData
{
    // Members...
}
```

Drag data for a single drag operation between a start and end position.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Data/DragPathData.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Building.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### StartPosition

```csharp
#region Public Properties

    /// <summary>
    /// Starting position of the drag operation.
    /// </summary>
    public Vector2 StartPosition { get; private set; }
```

Starting position of the drag operation.

### CurrentPosition

```csharp
/// <summary>
    /// Current position during the drag operation.
    /// </summary>
    public Vector2 CurrentPosition { get; private set; }
```

Current position during the drag operation.

### TimeHeld

```csharp
/// <summary>
    /// Total time the drag has been held.
    /// </summary>
    public float TimeHeld { get; private set; }
```

Total time the drag has been held.

### DragDistance

```csharp
/// <summary>
    /// Total distance dragged from start position.
    /// </summary>
    public float DragDistance { get; private set; }
```

Total distance dragged from start position.

### LastTile

```csharp
/// <summary>
    /// Last tile position during drag.
    /// </summary>
    public Vector2I LastTile { get; private set; }
```

Last tile position during drag.

### TargetTile

```csharp
/// <summary>
    /// Current target tile position.
    /// </summary>
    public Vector2I TargetTile { get; private set; }
```

Current target tile position.

### NextTile

```csharp
/// <summary>
    /// Next tile position (if set, overrides calculated position).
    /// </summary>
    public Vector2I NextTile { get; set; }
```

Next tile position (if set, overrides calculated position).

### LastAttemptedTile

```csharp
/// <summary>
    /// Last attempted tile position for tracking failed attempts.
    /// </summary>
    public Vector2I LastAttemptedTile { get; private set; }
```

Last attempted tile position for tracking failed attempts.

### BuildRequests

```csharp
/// <summary>
    /// Number of build requests made during this drag session.
    /// Incremented each time DragManager calls BuildingSystem.try_build().
    /// Useful for monitoring drag-build behavior and verifying request throttling.
    /// </summary>
    public int BuildRequests { get; set; }
```

Number of build requests made during this drag session.
Incremented each time DragManager calls BuildingSystem.try_build().
Useful for monitoring drag-build behavior and verifying request throttling.

### Positioner

```csharp
/// <summary>
    /// The positioner node for this drag operation.
    /// </summary>
    public Node2D Positioner { get; private set; }
```

The positioner node for this drag operation.

### TargetingState

```csharp
/// <summary>
    /// The targeting state for this drag operation.
    /// </summary>
    public GridTargetingState TargetingState { get; private set; }
```

The targeting state for this drag operation.

### IsDragging

```csharp
/// <summary>
    /// Whether the drag operation is currently active.
    /// </summary>
    public bool IsDragging { get; private set; }
```

Whether the drag operation is currently active.


## Methods

### Update

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Updates the drag data with current frame delta time.
    /// Recalculates distance, time held, and target tile position for this drag operation.
    /// </summary>
    /// <param name="delta">Time elapsed since last frame in seconds</param>
    public void Update(float delta)
    {
        CurrentPosition = Positioner.GlobalPosition;
        DragDistance = StartPosition.DistanceTo(CurrentPosition);
        TimeHeld += delta;

        // Use next_tile if set, otherwise calculate from current position
        if (NextTile != Vector2I.Zero)
        {
            TargetTile = NextTile;
        }
        else
        {
            TargetTile = GetTileAtNode2D(TargetingState.TargetMap, CurrentPosition);
        }
    }
```

Updates the drag data with current frame delta time.
Recalculates distance, time held, and target tile position for this drag operation.

**Returns:** `void`

**Parameters:**
- `float delta`

### GetTileAtNode2D

```csharp
/// <summary>
    /// Converts global position to tile coordinates on the specified map.
    /// Helper function for converting world positions to tilemap coordinates.
    /// </summary>
    /// <param name="map">The tilemap layer to convert coordinates for</param>
    /// <param name="globalPosition">Global position to convert to tile coordinates</param>
    /// <returns>Tile coordinates corresponding to the global position</returns>
    public Vector2I GetTileAtNode2D(TileMapLayer map, Vector2 globalPosition)
    {
        return map.LocalToMap(map.ToLocal(globalPosition));
    }
```

Converts global position to tile coordinates on the specified map.
Helper function for converting world positions to tilemap coordinates.

**Returns:** `Vector2I`

**Parameters:**
- `TileMapLayer map`
- `Vector2 globalPosition`

### Stop

```csharp
/// <summary>
    /// Stops the drag operation.
    /// </summary>
    public void Stop()
    {
        IsDragging = false;
    }
```

Stops the drag operation.

**Returns:** `void`

### ToString

```csharp
/// <summary>
    /// Gets a string representation of the drag data.
    /// </summary>
    /// <returns>String with drag statistics</returns>
    public override string ToString()
    {
        return $"DragPathData: Distance={DragDistance:F2}, Time={TimeHeld:F2}, Requests={BuildRequests}";
    }
```

Gets a string representation of the drag data.

**Returns:** `string`

