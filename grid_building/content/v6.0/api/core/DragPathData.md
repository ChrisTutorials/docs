---
title: "DragPathData"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/dragpathdata/"
---

# DragPathData

```csharp
GridBuilding.Core.Systems.Data
class DragPathData
{
    // Members...
}
```

Drag data for a single drag operation between a start and end position.
Ported from GDScript DragPathData class.
POCS version - no Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Data/DragPathData.cs`  
**Namespace:** `GridBuilding.Core.Systems.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### StartPosition

```csharp
#region Public Properties

        /// <summary>
        /// Starting position of the drag.
        /// </summary>
        public Vector2 StartPosition { get; set; }
```

Starting position of the drag.

### CurrentPosition

```csharp
/// <summary>
        /// Current position during the drag.
        /// </summary>
        public Vector2 CurrentPosition { get; set; }
```

Current position during the drag.

### TimeHeld

```csharp
/// <summary>
        /// Time the drag has been held (in seconds).
        /// </summary>
        public float TimeHeld { get; set; } = 0.0f;
```

Time the drag has been held (in seconds).

### DragDistance

```csharp
/// <summary>
        /// Total distance dragged.
        /// </summary>
        public float DragDistance { get; set; } = 0.0f;
```

Total distance dragged.

### LastTile

```csharp
/// <summary>
        /// Last tile position during drag.
        /// </summary>
        public Vector2I LastTile { get; set; }
```

Last tile position during drag.

### TargetTile

```csharp
/// <summary>
        /// Target tile position for drag.
        /// </summary>
        public Vector2I TargetTile { get; set; }
```

Target tile position for drag.

### NextTile

```csharp
/// <summary>
        /// Next tile position in drag path.
        /// </summary>
        public Vector2I NextTile { get; set; }
```

Next tile position in drag path.

### LastAttemptedTile

```csharp
/// <summary>
        /// Last attempted tile position (initialized to invalid coordinates).
        /// </summary>
        public Vector2I LastAttemptedTile { get; set; } = new Vector2I(999999, 999999);
```

Last attempted tile position (initialized to invalid coordinates).

### BuildRequests

```csharp
/// <summary>
        /// Number of build requests made during this drag session.
        /// Incremented each time DragManager calls BuildingSystem.try_build().
        /// Useful for monitoring drag-build behavior and verifying request throttling.
        /// </summary>
        public int BuildRequests { get; set; } = 0;
```

Number of build requests made during this drag session.
Incremented each time DragManager calls BuildingSystem.try_build().
Useful for monitoring drag-build behavior and verifying request throttling.

### Positioner

```csharp
/// <summary>
        /// Reference to positioner node (POCS - uses object reference).
        /// </summary>
        public object? Positioner { get; set; }
```

Reference to positioner node (POCS - uses object reference).

### TargetingState

```csharp
/// <summary>
        /// Reference to targeting state (POCS - uses object reference).
        /// </summary>
        public object? TargetingState { get; set; }
```

Reference to targeting state (POCS - uses object reference).

### IsDragging

```csharp
/// <summary>
        /// Whether the drag is currently active.
        /// </summary>
        public bool IsDragging { get; set; } = true;
```

Whether the drag is currently active.


## Methods

### UpdatePosition

```csharp
#endregion

        #region Public Methods

        /// <summary>
        /// Updates the current position and calculates drag metrics.
        /// </summary>
        /// <param name="newPosition">The new current position.</param>
        public void UpdatePosition(Vector2 newPosition)
        {
            CurrentPosition = newPosition;
            DragDistance = StartPosition.DistanceTo(newPosition);
            
            // Update target tile
            var newTargetTile = GetTileAtPosition(newPosition);
            if (newTargetTile != TargetTile)
            {
                NextTile = TargetTile;
                TargetTile = newTargetTile;
            }
        }
```

Updates the current position and calculates drag metrics.

**Returns:** `void`

**Parameters:**
- `Vector2 newPosition`

### IncrementBuildRequests

```csharp
/// <summary>
        /// Increments the build request counter.
        /// </summary>
        public void IncrementBuildRequests()
        {
            BuildRequests++;
        }
```

Increments the build request counter.

**Returns:** `void`

### GetTileAtPosition

```csharp
/// <summary>
        /// Gets the tile position at a given world position.
        /// POCS version - returns rounded position as tile coordinate.
        /// </summary>
        /// <param name="worldPosition">The world position.</param>
        /// <returns>The tile coordinates.</returns>
        public Vector2I GetTileAtPosition(Vector2 worldPosition)
        {
            // In POCS version, we'll use a simple grid conversion
            // The actual implementation would depend on the tile map configuration
            return new Vector2I((int)System.Math.Round(worldPosition.X), (int)System.Math.Round(worldPosition.Y));
        }
```

Gets the tile position at a given world position.
POCS version - returns rounded position as tile coordinate.

**Returns:** `Vector2I`

**Parameters:**
- `Vector2 worldPosition`

### HasMovedToNewTile

```csharp
/// <summary>
        /// Checks if the drag has moved to a new tile.
        /// </summary>
        /// <returns>True if the target tile has changed.</returns>
        public bool HasMovedToNewTile()
        {
            return TargetTile != LastTile;
        }
```

Checks if the drag has moved to a new tile.

**Returns:** `bool`

### UpdateLastTile

```csharp
/// <summary>
        /// Updates the last tile to the current target tile.
        /// </summary>
        public void UpdateLastTile()
        {
            LastTile = TargetTile;
        }
```

Updates the last tile to the current target tile.

**Returns:** `void`

### GetDirection

```csharp
/// <summary>
        /// Gets the direction vector of the drag.
        /// </summary>
        /// <returns>Normalized direction vector, or zero if no movement.</returns>
        public Vector2 GetDirection()
        {
            if (DragDistance == 0.0f)
                return Vector2.Zero;
                
            return (CurrentPosition - StartPosition).Normalized();
        }
```

Gets the direction vector of the drag.

**Returns:** `Vector2`

### GetAngle

```csharp
/// <summary>
        /// Gets the angle of the drag in radians.
        /// </summary>
        /// <returns>Angle in radians.</returns>
        public float GetAngle()
        {
            var direction = GetDirection();
            if (direction == Vector2.Zero)
                return 0.0f;
                
            return Mathf.Atan2(direction.Y, direction.X);
        }
```

Gets the angle of the drag in radians.

**Returns:** `float`

### Reset

```csharp
/// <summary>
        /// Resets the drag data for reuse.
        /// </summary>
        public void Reset()
        {
            StartPosition = Vector2.Zero;
            CurrentPosition = Vector2.Zero;
            TimeHeld = 0.0f;
            DragDistance = 0.0f;
            LastTile = Vector2I.Zero;
            TargetTile = Vector2I.Zero;
            NextTile = Vector2I.Zero;
            LastAttemptedTile = new Vector2I(999999, 999999);
            BuildRequests = 0;
            IsDragging = true;
        }
```

Resets the drag data for reuse.

**Returns:** `void`

### ToString

```csharp
/// <summary>
        /// Creates a string representation of the drag data.
        /// </summary>
        /// <returns>String description.</returns>
        public override string ToString()
        {
            return $"DragPathData(Start: {StartPosition}, Current: {CurrentPosition}, Distance: {DragDistance:F1}, Requests: {BuildRequests})";
        }
```

Creates a string representation of the drag data.

**Returns:** `string`

### FromPositions

```csharp
#endregion

        #region Static Methods

        /// <summary>
        /// Creates a DragPathData instance from world positions.
        /// </summary>
        /// <param name="startPosition">Starting world position.</param>
        /// <param name="currentPosition">Current world position.</param>
        /// <param name="positioner">Positioner object reference.</param>
        /// <param name="targetingState">Targeting state object reference.</param>
        /// <returns>New DragPathData instance.</returns>
        public static DragPathData FromPositions(Vector2 startPosition, Vector2 currentPosition, 
            object? positioner, object? targetingState)
        {
            var dragData = new DragPathData(positioner, targetingState);
            dragData.StartPosition = startPosition;
            dragData.CurrentPosition = currentPosition;
            dragData.DragDistance = startPosition.DistanceTo(currentPosition);
            
            return dragData;
        }
```

Creates a DragPathData instance from world positions.

**Returns:** `DragPathData`

**Parameters:**
- `Vector2 startPosition`
- `Vector2 currentPosition`
- `object? positioner`
- `object? targetingState`

