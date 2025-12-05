---
title: "TargetingShapeCast2DRefactored"
description: "Refactored TargetingShapeCast2D that delegates to Core service
This component now focuses on Godot-specific responsibilities:
- Physics detection and collision handling
- Grid coordinate conversion
- Signal emission and Godot event handling
- Visual debugging and editor integration
Heavy business logic (pathfinding, validation, navigation) is delegated
to the IGridTargetingService for better testability and separation."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/targetingshapecast2drefactored/"
---

# TargetingShapeCast2DRefactored

```csharp
GridBuilding.Godot.Systems.GridTargeting
class TargetingShapeCast2DRefactored
{
    // Members...
}
```

Refactored TargetingShapeCast2D that delegates to Core service
This component now focuses on Godot-specific responsibilities:
- Physics detection and collision handling
- Grid coordinate conversion
- Signal emission and Godot event handling
- Visual debugging and editor integration
Heavy business logic (pathfinding, validation, navigation) is delegated
to the IGridTargetingService for better testability and separation.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/GridTargeting/TargetingShapeCast2DRefactored.cs`  
**Namespace:** `GridBuilding.Godot.Systems.GridTargeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsGridSnapping

```csharp
#endregion

        #region Exported Properties

        /// <summary>
        /// Whether to snap to grid positions
        /// </summary>
        [Export]
        public bool IsGridSnapping
        {
            get => _isGridSnapping;
            set => SetGridSnapping(value);
        }
```

Whether to snap to grid positions

### AutoUpdate

```csharp
/// <summary>
        /// Whether to automatically update targeting
        /// </summary>
        [Export]
        public bool AutoUpdate
        {
            get => _autoUpdate;
            set => SetAutoUpdate(value);
        }
```

Whether to automatically update targeting

### UpdateInterval

```csharp
/// <summary>
        /// Update interval in seconds
        /// </summary>
        [Export]
        public float UpdateInterval
        {
            get => _updateInterval;
            set => SetUpdateInterval(value);
        }
```

Update interval in seconds

### GridCellSize

```csharp
/// <summary>
        /// Grid cell size for snapping
        /// </summary>
        [Export]
        public Vector2 GridCellSize { get; set; } = new Vector2(32.0f, 32.0f);
```

Grid cell size for snapping

### GridOrigin

```csharp
/// <summary>
        /// Grid origin for coordinate conversion
        /// </summary>
        [Export]
        public Vector2 GridOrigin { get; set; } = Vector2.Zero;
```

Grid origin for coordinate conversion

### ValidateTargets

```csharp
/// <summary>
        /// Whether to validate targets
        /// </summary>
        [Export]
        public bool ValidateTargets { get; set; } = true;
```

Whether to validate targets

### EmitDetectionSignals

```csharp
/// <summary>
        /// Whether to emit signals on detection
        /// </summary>
        [Export]
        public bool EmitDetectionSignals { get; set; } = true;
```

Whether to emit signals on detection

### MaxTargetDistance

```csharp
/// <summary>
        /// Maximum targeting distance
        /// </summary>
        [Export]
        public float MaxTargetDistance { get; set; } = 100.0f;
```

Maximum targeting distance

### ShowDebug

```csharp
/// <summary>
        /// Whether to show debug visualization
        /// </summary>
        [Export]
        public bool ShowDebug { get; set; } = false;
```

Whether to show debug visualization

### CurrentGridPosition

```csharp
#endregion

        #region Public Properties

        /// <summary>
        /// Current grid position
        /// </summary>
        public Vector2I CurrentGridPosition => _currentGridPosition;
```

Current grid position

### HasValidTarget

```csharp
/// <summary>
        /// Whether currently has a valid target
        /// </summary>
        public bool HasValidTarget => GetColliderCount() > 0 && IsTargetValid();
```

Whether currently has a valid target

### CurrentTarget

```csharp
/// <summary>
        /// Current target node
        /// </summary>
        public Node CurrentTarget => GetCollider(0) as Node;
```

Current target node

### IsInitialized

```csharp
/// <summary>
        /// Whether the component is initialized
        /// </summary>
        public bool IsInitialized => _isInitialized;
```

Whether the component is initialized

### TargetData

```csharp
/// <summary>
        /// Target data dictionary
        /// </summary>
        public Dictionary<string, object> TargetData => new Dictionary<string, object>(_targetData);
```

Target data dictionary


## Methods

### _Ready

```csharp
#endregion

        #region Godot Methods

        public override void _Ready()
        {
            InitializeTargeting();
        }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
        {
            if (!_isInitialized || !_autoUpdate)
                return;

            UpdateTargeting();
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### _Draw

```csharp
public override void _Draw()
        {
            if (!ShowDebug)
                return;

            DrawDebugVisualization();
        }
```

**Returns:** `void`

### UpdateTargeting

```csharp
#endregion

        #region Targeting Management

        /// <summary>
        /// Updates targeting system using Core service delegation
        /// </summary>
        public void UpdateTargeting()
        {
            if (!_isInitialized || _targetingService == null)
                return;

            // Update grid position
            UpdateGridPosition();

            // Force collision detection
            ForceShapecastUpdate();

            // Validate current target using Core service
            if (ValidateTargets)
            {
                ValidateCurrentTarget();
            }

            // Emit detection signal if valid target found
            if (EmitDetectionSignals && HasValidTarget)
            {
                EmitSignal(SignalName.TargetDetected, CurrentTarget, _currentGridPosition);
            }
        }
```

Updates targeting system using Core service delegation

**Returns:** `void`

### SetGridPosition

```csharp
#endregion

        #region Grid Operations

        /// <summary>
        /// Sets position at grid coordinates
        /// </summary>
        public void SetGridPosition(Vector2I gridPosition)
        {
            var worldPos = GridToWorld(gridPosition);
            GlobalPosition = worldPos;
        }
```

Sets position at grid coordinates

**Returns:** `void`

**Parameters:**
- `Vector2I gridPosition`

### GridToWorld

```csharp
/// <summary>
        /// Converts grid coordinates to world coordinates
        /// </summary>
        public Vector2 GridToWorld(Vector2I gridPosition)
        {
            return GridOrigin + new Vector2(
                gridPosition.X * GridCellSize.X + GridCellSize.X * 0.5f,
                gridPosition.Y * GridCellSize.Y + GridCellSize.Y * 0.5f
            );
        }
```

Converts grid coordinates to world coordinates

**Returns:** `Vector2`

**Parameters:**
- `Vector2I gridPosition`

### WorldToGrid

```csharp
/// <summary>
        /// Converts world coordinates to grid coordinates
        /// </summary>
        public Vector2I WorldToGrid(Vector2 worldPosition)
        {
            var localPos = worldPosition - GridOrigin;
            var gridX = Mathf.FloorToInt(localPos.X / GridCellSize.X);
            var gridY = Mathf.FloorToInt(localPos.Y / GridCellSize.Y);
            return new Vector2I(gridX, gridY);
        }
```

Converts world coordinates to grid coordinates

**Returns:** `Vector2I`

**Parameters:**
- `Vector2 worldPosition`

### GetCoveredGridCells

```csharp
/// <summary>
        /// Gets grid cells covered by the shape
        /// </summary>
        public List<Vector2I> GetCoveredGridCells()
        {
            var cells = new List<Vector2I>();

            if (Shape is RectangleShape2D rectShape)
            {
                // Get rectangle bounds
                var size = rectShape.Size;
                var halfSize = size * 0.5f;
                var minPos = GlobalPosition - halfSize;
                var maxPos = GlobalPosition + halfSize;

                // Convert to grid coordinates
                var minGrid = WorldToGrid(minPos);
                var maxGrid = WorldToGrid(maxPos);

                // Add all cells in range
                for (int x = minGrid.X; x <= maxGrid.X; x++)
                {
                    for (int y = minGrid.Y; y <= maxGrid.Y; y++)
                    {
                        cells.Add(new Vector2I(x, y));
                    }
                }
            }
            else if (Shape is CircleShape2D circleShape)
            {
                // Get circle bounds
                var radius = circleShape.Radius;
                var minPos = GlobalPosition - new Vector2(radius, radius);
                var maxPos = GlobalPosition + new Vector2(radius, radius);

                // Convert to grid coordinates
                var minGrid = WorldToGrid(minPos);
                var maxGrid = WorldToGrid(maxPos);

                // Add cells within circle
                for (int x = minGrid.X; x <= maxGrid.X; x++)
                {
                    for (int y = minGrid.Y; y <= maxGrid.Y; y++)
                    {
                        var cellCenter = GridToWorld(new Vector2I(x, y));
                        var distance = cellCenter.DistanceTo(GlobalPosition);
                        if (distance <= radius)
                        {
                            cells.Add(new Vector2I(x, y));
                        }
                    }
                }
            }

            return cells;
        }
```

Gets grid cells covered by the shape

**Returns:** `List<Vector2I>`

### AddFilter

```csharp
#endregion

        #region Filter and Validator Management

        /// <summary>
        /// Adds a targeting filter
        /// </summary>
        public void AddFilter(ITargetingFilter filter)
        {
            if (filter != null && !_filters.Contains(filter))
            {
                _filters.Add(filter);
            }
        }
```

Adds a targeting filter

**Returns:** `void`

**Parameters:**
- `ITargetingFilter filter`

### RemoveFilter

```csharp
/// <summary>
        /// Removes a targeting filter
        /// </summary>
        public void RemoveFilter(ITargetingFilter filter)
        {
            _filters.Remove(filter);
        }
```

Removes a targeting filter

**Returns:** `void`

**Parameters:**
- `ITargetingFilter filter`

### ClearFilters

```csharp
/// <summary>
        /// Clears all filters
        /// </summary>
        public void ClearFilters()
        {
            _filters.Clear();
        }
```

Clears all filters

**Returns:** `void`

### AddValidator

```csharp
/// <summary>
        /// Adds a targeting validator
        /// </summary>
        public void AddValidator(ITargetingValidator validator)
        {
            if (validator != null && !_validators.Contains(validator))
            {
                _validators.Add(validator);
            }
        }
```

Adds a targeting validator

**Returns:** `void`

**Parameters:**
- `ITargetingValidator validator`

### RemoveValidator

```csharp
/// <summary>
        /// Removes a targeting validator
        /// </summary>
        public void RemoveValidator(ITargetingValidator validator)
        {
            _validators.Remove(validator);
        }
```

Removes a targeting validator

**Returns:** `void`

**Parameters:**
- `ITargetingValidator validator`

### ClearValidators

```csharp
/// <summary>
        /// Clears all validators
        /// </summary>
        public void ClearValidators()
        {
            _validators.Clear();
        }
```

Clears all validators

**Returns:** `void`

### ValidateTarget

```csharp
#endregion

        #region ITargetingValidator Implementation

        /// <summary>
        /// Validates a target for the given grid position
        /// </summary>
        public bool ValidateTarget(Node target, Vector2I gridPosition)
        {
            if (target == null || _targetingService == null)
                return false;

            // Delegate to Core service
            return _targetingService.ValidateTargetAtPosition(gridPosition, target);
        }
```

Validates a target for the given grid position

**Returns:** `bool`

**Parameters:**
- `Node target`
- `Vector2I gridPosition`

### GetInvalidReason

```csharp
/// <summary>
        /// Gets validation reason for invalid target
        /// </summary>
        public string GetInvalidReason(Node target, Vector2I gridPosition)
        {
            if (target == null)
                return "Target is null";

            if (_targetingService == null)
                return "Core service not available";

            // Check distance
            var distance = GlobalPosition.DistanceTo(target.GetGlobalPosition());
            if (distance > MaxTargetDistance)
                return $"Target too far: {distance:F1} > {MaxTargetDistance}";

            // Check Core service validation
            if (!_targetingService.ValidateTargetAtPosition(gridPosition, target))
            {
                return "Target position is not valid according to Core service";
            }

            return "Target is valid";
        }
```

Gets validation reason for invalid target

**Returns:** `string`

**Parameters:**
- `Node target`
- `Vector2I gridPosition`

### GetDebugInfo

```csharp
#endregion

        #region Debug and Diagnostics

        /// <summary>
        /// Gets debug information
        /// </summary>
        public string GetDebugInfo()
        {
            var info = $"TargetingShapeCast2DRefactored Debug Info:\n";
            info += $"Initialized: {_isInitialized}\n";
            info += $"Grid Position: {_currentGridPosition}\n";
            info += $"World Position: {GlobalPosition}\n";
            info += $"Has Valid Target: {HasValidTarget}\n";
            info += $"Target Count: {GetColliderCount()}\n";
            info += $"Grid Snapping: {_isGridSnapping}\n";
            info += $"Auto Update: {_autoUpdate}\n";
            info += $"Update Interval: {_updateInterval}\n";
            info += $"Grid Cell Size: {GridCellSize}\n";
            info += $"Max Target Distance: {MaxTargetDistance}\n";
            info += $"Filters: {_filters.Count}\n";
            info += $"Validators: {_validators.Count}\n";
            info += $"Core Service Available: {_targetingService != null}\n";

            if (CurrentTarget != null)
            {
                info += $"Current Target: {CurrentTarget.Name}\n";
                info += $"Target Distance: {GlobalPosition.DistanceTo(CurrentTarget.GetGlobalPosition()):F1}\n";
            }

            if (_targetingService != null)
            {
                info += $"Core Service Target: {_targetingService.CurrentTargetTile}\n";
                info += $"Core Service Active: {_targetingService.IsTargetingActive}\n";
            }

            return info;
        }
```

Gets debug information

**Returns:** `string`

### PrintDebugInfo

```csharp
/// <summary>
        /// Prints debug information
        /// </summary>
        public void PrintDebugInfo()
        {
            GD.Print(GetDebugInfo());
        }
```

Prints debug information

**Returns:** `void`

### _ExitTree

```csharp
#endregion

        #region Cleanup

        /// <summary>
        /// Cleanup when destroyed
        /// </summary>
        public override void _ExitTree()
        {
            if (_updateTimer != null)
            {
                _updateTimer.Timeout -= OnUpdateTimer;
                _updateTimer.QueueFree();
            }

            // Unsubscribe from Core service events
            if (_targetingService != null)
            {
                _targetingService.TargetingStateChanged -= OnTargetingStateChanged;
                _targetingService.PathCalculated -= OnPathCalculated;
                _targetingService.PathCalculationFailed -= OnPathCalculationFailed;
            }

            _filters.Clear();
            _validators.Clear();
            _targetData.Clear();

            _isInitialized = false;
        }
```

Cleanup when destroyed

**Returns:** `void`

