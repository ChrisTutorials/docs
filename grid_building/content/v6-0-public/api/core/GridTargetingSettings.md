---
title: "GridTargetingSettings"
description: "Configuration settings for grid targeting system
Provides centralized configuration for grid positioning, targeting behavior, and visual feedback"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/gridtargetingsettings/"
---

# GridTargetingSettings

```csharp
GridBuilding.Core.Systems.Configuration
class GridTargetingSettings
{
    // Members...
}
```

Configuration settings for grid targeting system
Provides centralized configuration for grid positioning, targeting behavior, and visual feedback

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Configuration/GridTargetingSettings.cs`  
**Namespace:** `GridBuilding.Core.Systems.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### GridSize

```csharp
#region Grid Properties

        /// <summary>
        /// Size of the grid in cells
        /// </summary>
        public Vector2I GridSize { get; set; } = new Vector2I(100, 100);
```

Size of the grid in cells

### CellSize

```csharp
/// <summary>
        /// Size of each grid cell in world units
        /// </summary>
        public float CellSize { get; set; } = 32.0f;
```

Size of each grid cell in world units

### CellSize2D

```csharp
/// <summary>
        /// Size of each grid cell in world units (Vector2 version)
        /// </summary>
        public Vector2 CellSize2D { get; set; } = new Vector2(32.0f, 32.0f);
```

Size of each grid cell in world units (Vector2 version)

### Origin

```csharp
/// <summary>
        /// Origin point of the grid in world coordinates
        /// </summary>
        public Vector2 Origin { get; set; } = Vector2.Zero;
```

Origin point of the grid in world coordinates

### IsIsometric

```csharp
/// <summary>
        /// Whether the grid uses isometric coordinates
        /// </summary>
        public bool IsIsometric { get; set; } = false;
```

Whether the grid uses isometric coordinates

### WrapsEdges

```csharp
/// <summary>
        /// Whether the grid wraps around edges
        /// </summary>
        public bool WrapsEdges { get; set; } = false;
```

Whether the grid wraps around edges

### GridRotation

```csharp
/// <summary>
        /// Grid rotation angle in degrees
        /// </summary>
        public float GridRotation { get; set; } = 0.0f;
```

Grid rotation angle in degrees

### IsEnabled

```csharp
/// <summary>
        /// Whether the grid is enabled
        /// </summary>
        public bool IsEnabled { get; set; } = true;
```

Whether the grid is enabled

### IsValid

```csharp
/// <summary>
        /// Configuration validity
        /// </summary>
        public bool IsValid => GridSize.X > 0 && GridSize.Y > 0 && CellSize > 0;
```

Configuration validity

### MaxTargetingRange

```csharp
#endregion

        #region Targeting Properties

        /// <summary>
        /// Maximum targeting range in grid units
        /// </summary>
        public int MaxTargetingRange { get; set; } = 50;
```

Maximum targeting range in grid units

### MinTargetingRange

```csharp
/// <summary>
        /// Minimum targeting range in grid units
        /// </summary>
        public int MinTargetingRange { get; set; } = 1;
```

Minimum targeting range in grid units

### RequiresLineOfSight

```csharp
/// <summary>
        /// Whether targeting requires line of sight
        /// </summary>
        public bool RequiresLineOfSight { get; set; } = false;
```

Whether targeting requires line of sight

### BlockingLayers

```csharp
/// <summary>
        /// Layers that block targeting
        /// </summary>
        public List<string> BlockingLayers { get; set; } = new List<string>();
```

Layers that block targeting

### TargetableLayers

```csharp
/// <summary>
        /// Layers that can be targeted
        /// </summary>
        public List<string> TargetableLayers { get; set; } = new List<string> { "default" };
```

Layers that can be targeted

### AllowDiagonalMovement

```csharp
/// <summary>
        /// Whether diagonal movement is allowed
        /// </summary>
        public bool AllowDiagonalMovement { get; set; } = true;
```

Whether diagonal movement is allowed

### SnapToGrid

```csharp
/// <summary>
        /// Whether to snap to grid when targeting
        /// </summary>
        public bool SnapToGrid { get; set; } = true;
```

Whether to snap to grid when targeting

### SnapTolerance

```csharp
/// <summary>
        /// Grid snapping tolerance in world units
        /// </summary>
        public float SnapTolerance { get; set; } = 8.0f;
```

Grid snapping tolerance in world units

### GridLineColor

```csharp
#endregion

        #region Visual Properties

        /// <summary>
        /// Color of the grid lines
        /// </summary>
        public GridBuilding.Core.Types.Color GridLineColor { get; set; } = new GridBuilding.Core.Types.Color(1.0f, 1.0f, 1.0f, 0.3f);
```

Color of the grid lines

### ValidTargetColor

```csharp
/// <summary>
        /// Color of valid targeting indicators
        /// </summary>
        public GridBuilding.Core.Types.Color ValidTargetColor { get; set; } = new GridBuilding.Core.Types.Color(0.0f, 1.0f, 0.0f, 0.5f);
```

Color of valid targeting indicators

### InvalidTargetColor

```csharp
/// <summary>
        /// Color of invalid targeting indicators
        /// </summary>
        public GridBuilding.Core.Types.Color InvalidTargetColor { get; set; } = new GridBuilding.Core.Types.Color(1.0f, 0.0f, 0.0f, 0.5f);
```

Color of invalid targeting indicators

### CursorColor

```csharp
/// <summary>
        /// Color of the targeting cursor
        /// </summary>
        public GridBuilding.Core.Types.Color CursorColor { get; set; } = new GridBuilding.Core.Types.Color(1.0f, 1.0f, 1.0f, 0.8f);
```

Color of the targeting cursor

### GridLineWidth

```csharp
/// <summary>
        /// Width of grid lines
        /// </summary>
        public float GridLineWidth { get; set; } = 1.0f;
```

Width of grid lines

### ShowGridLines

```csharp
/// <summary>
        /// Whether to show grid lines
        /// </summary>
        public bool ShowGridLines { get; set; } = true;
```

Whether to show grid lines

### ShowCellCoordinates

```csharp
/// <summary>
        /// Whether to show cell coordinates
        /// </summary>
        public bool ShowCellCoordinates { get; set; } = false;
```

Whether to show cell coordinates

### CoordinateFontSize

```csharp
/// <summary>
        /// Font size for cell coordinates
        /// </summary>
        public int CoordinateFontSize { get; set; } = 12;
```

Font size for cell coordinates

### EnableAnimations

```csharp
#endregion

        #region Animation Properties

        /// <summary>
        /// Whether to enable targeting animations
        /// </summary>
        public bool EnableAnimations { get; set; } = true;
```

Whether to enable targeting animations

### AnimationSpeed

```csharp
/// <summary>
        /// Animation speed multiplier
        /// </summary>
        public float AnimationSpeed { get; set; } = 1.0f;
```

Animation speed multiplier

### CursorAnimationDuration

```csharp
/// <summary>
        /// Cursor animation duration in seconds
        /// </summary>
        public float CursorAnimationDuration { get; set; } = 0.2f;
```

Cursor animation duration in seconds

### TargetAnimationDuration

```csharp
/// <summary>
        /// Target indicator animation duration in seconds
        /// </summary>
        public float TargetAnimationDuration { get; set; } = 0.3f;
```

Target indicator animation duration in seconds

### UseEasing

```csharp
/// <summary>
        /// Whether to use easing for animations
        /// </summary>
        public bool UseEasing { get; set; } = true;
```

Whether to use easing for animations

### MaxCellsPerFrame

```csharp
#endregion

        #region Performance Properties

        /// <summary>
        /// Maximum number of cells to update per frame
        /// </summary>
        public int MaxCellsPerFrame { get; set; } = 100;
```

Maximum number of cells to update per frame

### UseSpatialPartitioning

```csharp
/// <summary>
        /// Whether to use spatial partitioning for performance
        /// </summary>
        public bool UseSpatialPartitioning { get; set; } = true;
```

Whether to use spatial partitioning for performance

### PartitionCellSize

```csharp
/// <summary>
        /// Size of spatial partition cells
        /// </summary>
        public int PartitionCellSize { get; set; } = 10;
```

Size of spatial partition cells

### EnableFrustumCulling

```csharp
/// <summary>
        /// Whether to enable frustum culling
        /// </summary>
        public bool EnableFrustumCulling { get; set; } = true;
```

Whether to enable frustum culling

### UpdateInterval

```csharp
/// <summary>
        /// Update interval in seconds for performance optimization
        /// </summary>
        public float UpdateInterval { get; set; } = 0.016f; // ~60 FPS
```

Update interval in seconds for performance optimization

### MouseSensitivity

```csharp
#endregion

        #region Input Properties

        /// <summary>
        /// Mouse sensitivity for targeting
        /// </summary>
        public float MouseSensitivity { get; set; } = 1.0f;
```

Mouse sensitivity for targeting

### InvertMouseY

```csharp
/// <summary>
        /// Whether to invert mouse Y axis
        /// </summary>
        public bool InvertMouseY { get; set; } = false;
```

Whether to invert mouse Y axis

### KeyboardSpeed

```csharp
/// <summary>
        /// Keyboard movement speed in cells per second
        /// </summary>
        public float KeyboardSpeed { get; set; } = 10.0f;
```

Keyboard movement speed in cells per second

### EnableGamepad

```csharp
/// <summary>
        /// Whether to enable gamepad targeting
        /// </summary>
        public bool EnableGamepad { get; set; } = true;
```

Whether to enable gamepad targeting

### GamepadSensitivity

```csharp
/// <summary>
        /// Gamepad stick sensitivity
        /// </summary>
        public float GamepadSensitivity { get; set; } = 1.0f;
```

Gamepad stick sensitivity

### GamepadDeadZone

```csharp
/// <summary>
        /// Dead zone for gamepad input
        /// </summary>
        public float GamepadDeadZone { get; set; } = 0.1f;
```

Dead zone for gamepad input

### ShowDebugInfo

```csharp
#endregion

        #region Debug Properties

        /// <summary>
        /// Whether to show debug information
        /// </summary>
        public bool ShowDebugInfo { get; set; } = false;
```

Whether to show debug information

### ShowPerformanceMetrics

```csharp
/// <summary>
        /// Whether to show performance metrics
        /// </summary>
        public bool ShowPerformanceMetrics { get; set; } = false;
```

Whether to show performance metrics

### ShowCellBoundaries

```csharp
/// <summary>
        /// Whether to show cell boundaries
        /// </summary>
        public bool ShowCellBoundaries { get; set; } = false;
```

Whether to show cell boundaries

### LogTargetingEvents

```csharp
/// <summary>
        /// Whether to log targeting events
        /// </summary>
        public bool LogTargetingEvents { get; set; } = false;
```

Whether to log targeting events

### DebugFontSize

```csharp
/// <summary>
        /// Debug overlay font size
        /// </summary>
        public int DebugFontSize { get; set; } = 14;
```

Debug overlay font size


## Methods

### Validate

```csharp
#endregion

        #region Validation

        /// <summary>
        /// Validates the grid targeting settings
        /// </summary>
        /// <returns>Validation result</returns>
        public GridBuilding.Core.Results.ValidationResult Validate()
        {
            var errors = new List<string>();
            var warnings = new List<string>();

            // Validate grid size
            if (GridSize.X <= 0 || GridSize.Y <= 0)
                errors.Add("Grid size must have positive dimensions");

            if (GridSize.X > 1000 || GridSize.Y > 1000)
                warnings.Add("Very large grid size may impact performance");

            // Validate cell size
            if (CellSize.X <= 0 || CellSize.Y <= 0)
                errors.Add("Cell size must have positive dimensions");

            if (CellSize.X > 256 || CellSize.Y > 256)
                warnings.Add("Very large cell size may cause precision issues");

            // Validate targeting range
            if (MaxTargetingRange < MinTargetingRange)
                errors.Add("Max targeting range cannot be less than min targeting range");

            if (MaxTargetingRange < 0 || MinTargetingRange < 0)
                errors.Add("Targeting ranges cannot be negative");

            // Validate performance settings
            if (MaxCellsPerFrame <= 0)
                errors.Add("Max cells per frame must be positive");

            if (PartitionCellSize <= 0)
                errors.Add("Partition cell size must be positive");

            // Validate input settings
            if (MouseSensitivity <= 0)
                errors.Add("Mouse sensitivity must be positive");

            if (KeyboardSpeed <= 0)
                errors.Add("Keyboard speed must be positive");

            if (GamepadSensitivity <= 0)
                errors.Add("Gamepad sensitivity must be positive");

            if (GamepadDeadZone < 0 || GamepadDeadZone >= 1.0f)
                errors.Add("Gamepad dead zone must be between 0 and 1");

            // Validate animation settings
            if (AnimationSpeed <= 0)
                errors.Add("Animation speed must be positive");

            if (CursorAnimationDuration < 0)
                errors.Add("Cursor animation duration cannot be negative");

            if (TargetAnimationDuration < 0)
                errors.Add("Target animation duration cannot be negative");

            // Validate update interval
            if (UpdateInterval <= 0)
                errors.Add("Update interval must be positive");

            // Validate font sizes
            if (CoordinateFontSize <= 0)
                errors.Add("Coordinate font size must be positive");

            if (DebugFontSize <= 0)
                errors.Add("Debug font size must be positive");

            // Calculate score
            var score = CalculateValidationScore(errors, warnings);

            return new ValidationResult
            {
                IsValid = errors.Count == 0,
                Errors = errors,
                Warnings = warnings,
                Score = score
            };
        }
```

Validates the grid targeting settings

**Returns:** `GridBuilding.Core.Results.ValidationResult`

### Clone

```csharp
#endregion

        #region Utility Methods

        /// <summary>
        /// Creates a copy of these settings
        /// </summary>
        /// <returns>Copy of the settings</returns>
        public GridTargetingSettings Clone()
        {
            return new GridTargetingSettings
            {
                GridSize = GridSize,
                CellSize = CellSize,
                Origin = Origin,
                IsIsometric = IsIsometric,
                WrapsEdges = WrapsEdges,
                GridRotation = GridRotation,
                MaxTargetingRange = MaxTargetingRange,
                MinTargetingRange = MinTargetingRange,
                RequiresLineOfSight = RequiresLineOfSight,
                BlockingLayers = new List<string>(BlockingLayers),
                TargetableLayers = new List<string>(TargetableLayers),
                AllowDiagonalMovement = AllowDiagonalMovement,
                SnapToGrid = SnapToGrid,
                SnapTolerance = SnapTolerance,
                GridLineColor = GridLineColor,
                ValidTargetColor = ValidTargetColor,
                InvalidTargetColor = InvalidTargetColor,
                CursorColor = CursorColor,
                GridLineWidth = GridLineWidth,
                ShowGridLines = ShowGridLines,
                ShowCellCoordinates = ShowCellCoordinates,
                CoordinateFontSize = CoordinateFontSize,
                EnableAnimations = EnableAnimations,
                AnimationSpeed = AnimationSpeed,
                CursorAnimationDuration = CursorAnimationDuration,
                TargetAnimationDuration = TargetAnimationDuration,
                UseEasing = UseEasing,
                MaxCellsPerFrame = MaxCellsPerFrame,
                UseSpatialPartitioning = UseSpatialPartitioning,
                PartitionCellSize = PartitionCellSize,
                EnableFrustumCulling = EnableFrustumCulling,
                UpdateInterval = UpdateInterval,
                MouseSensitivity = MouseSensitivity,
                InvertMouseY = InvertMouseY,
                KeyboardSpeed = KeyboardSpeed,
                EnableGamepad = EnableGamepad,
                GamepadSensitivity = GamepadSensitivity,
                GamepadDeadZone = GamepadDeadZone,
                ShowDebugInfo = ShowDebugInfo,
                ShowPerformanceMetrics = ShowPerformanceMetrics,
                ShowCellBoundaries = ShowCellBoundaries,
                LogTargetingEvents = LogTargetingEvents,
                DebugFontSize = DebugFontSize
            };
        }
```

Creates a copy of these settings

**Returns:** `GridTargetingSettings`

### WorldToGrid

```csharp
/// <summary>
        /// Converts world coordinates to grid coordinates
        /// </summary>
        /// <param name="worldPosition">World position</param>
        /// <returns>Grid coordinates</returns>
        public Vector2I WorldToGrid(Vector2 worldPosition)
        {
            var adjustedPosition = worldPosition - Origin;
            
            // Apply grid rotation if needed
            if (System.Math.Abs(GridRotation) > 0.001f)
            {
                var angle = -GridRotation * (System.Math.PI / 180.0);
                var cos = (float)System.Math.Cos(angle);
                var sin = (float)System.Math.Sin(angle);
                adjustedPosition = new Vector2(
                    adjustedPosition.X * cos - adjustedPosition.Y * sin,
                    adjustedPosition.X * sin + adjustedPosition.Y * cos
                );
            }

            var gridX = (int)System.Math.Floor(adjustedPosition.X / CellSize.X);
            var gridY = (int)System.Math.Floor(adjustedPosition.Y / CellSize.Y);

            return new Vector2I(gridX, gridY);
        }
```

Converts world coordinates to grid coordinates

**Returns:** `Vector2I`

**Parameters:**
- `Vector2 worldPosition`

### GridToWorld

```csharp
/// <summary>
        /// Converts grid coordinates to world coordinates
        /// </summary>
        /// <param name="gridPosition">Grid position</param>
        /// <returns>World coordinates</returns>
        public Vector2 GridToWorld(Vector2I gridPosition)
        {
            var worldPosition = new Vector2(
                gridPosition.X * CellSize.X + CellSize.X * 0.5f,
                gridPosition.Y * CellSize.Y + CellSize.Y * 0.5f
            );

            // Apply grid rotation if needed
            if (System.Math.Abs(GridRotation) > 0.001f)
            {
                var angle = GridRotation * (System.Math.PI / 180.0);
                var cos = (float)System.Math.Cos(angle);
                var sin = (float)System.Math.Sin(angle);
                worldPosition = new Vector2(
                    worldPosition.X * cos - worldPosition.Y * sin,
                    worldPosition.X * sin + worldPosition.Y * cos
                );
            }

            return worldPosition + Origin;
        }
```

Converts grid coordinates to world coordinates

**Returns:** `Vector2`

**Parameters:**
- `Vector2I gridPosition`

### IsValidGridPosition

```csharp
/// <summary>
        /// Checks if a grid position is valid
        /// </summary>
        /// <param name="gridPosition">Grid position to check</param>
        /// <returns>True if position is valid</returns>
        public bool IsValidGridPosition(Vector2I gridPosition)
        {
            if (WrapsEdges)
                return true;

            return gridPosition.X >= 0 && gridPosition.X < GridSize.X &&
                   gridPosition.Y >= 0 && gridPosition.Y < GridSize.Y;
        }
```

Checks if a grid position is valid

**Returns:** `bool`

**Parameters:**
- `Vector2I gridPosition`

### GetNeighbors

```csharp
/// <summary>
        /// Gets neighboring grid positions
        /// </summary>
        /// <param name="gridPosition">Center position</param>
        /// <param name="includeDiagonal">Whether to include diagonal neighbors</param>
        /// <returns>List of neighboring positions</returns>
        public List<Vector2I> GetNeighbors(Vector2I gridPosition, bool includeDiagonal = true)
        {
            var neighbors = new List<Vector2I>();

            // Cardinal directions
            var cardinalDirections = new[]
            {
                new Vector2I(0, -1), // Up
                new Vector2I(1, 0),  // Right
                new Vector2I(0, 1),  // Down
                new Vector2I(-1, 0)  // Left
            };

            foreach (var dir in cardinalDirections)
            {
                var neighbor = gridPosition + dir;
                if (IsValidGridPosition(neighbor))
                    neighbors.Add(neighbor);
            }

            // Diagonal directions
            if (includeDiagonal && AllowDiagonalMovement)
            {
                var diagonalDirections = new[]
                {
                    new Vector2I(-1, -1), // Up-Left
                    new Vector2I(1, -1),  // Up-Right
                    new Vector2I(1, 1),   // Down-Right
                    new Vector2I(-1, 1)   // Down-Left
                };

                foreach (var dir in diagonalDirections)
                {
                    var neighbor = gridPosition + dir;
                    if (IsValidGridPosition(neighbor))
                        neighbors.Add(neighbor);
                }
            }

            return neighbors;
        }
```

Gets neighboring grid positions

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I gridPosition`
- `bool includeDiagonal`

### GetDistance

```csharp
/// <summary>
        /// Gets the distance between two grid positions
        /// </summary>
        /// <param name="from">Start position</param>
        /// <param name="to">End position</param>
        /// <param name="useManhattan">Whether to use Manhattan distance</param>
        /// <returns>Distance between positions</returns>
        public float GetDistance(Vector2I from, Vector2I to, bool useManhattan = false)
        {
            if (useManhattan)
            {
                return System.Math.Abs(from.X - to.X) + System.Math.Abs(from.Y - to.Y);
            }
            else
            {
                var dx = from.X - to.X;
                var dy = from.Y - to.Y;
                return (float)System.Math.Sqrt(dx * dx + dy * dy);
            }
        }
```

Gets the distance between two grid positions

**Returns:** `float`

**Parameters:**
- `Vector2I from`
- `Vector2I to`
- `bool useManhattan`

### CreateDefault

```csharp
#endregion

        #region Static Factory Methods

        /// <summary>
        /// Creates default settings for a standard grid
        /// </summary>
        /// <returns>Default settings</returns>
        public static GridTargetingSettings CreateDefault()
        {
            return new GridTargetingSettings();
        }
```

Creates default settings for a standard grid

**Returns:** `GridTargetingSettings`

### CreateSmallGrid

```csharp
/// <summary>
        /// Creates settings optimized for small grids
        /// </summary>
        /// <returns>Small grid settings</returns>
        public static GridTargetingSettings CreateSmallGrid()
        {
            return new GridTargetingSettings
            {
                GridSize = new Vector2I(50, 50),
                CellSize = new Vector2(16.0f, 16.0f),
                MaxTargetingRange = 25,
                MaxCellsPerFrame = 200,
                ShowGridLines = true,
                ShowCellCoordinates = true
            };
        }
```

Creates settings optimized for small grids

**Returns:** `GridTargetingSettings`

### CreateLargeGrid

```csharp
/// <summary>
        /// Creates settings optimized for large grids
        /// </summary>
        /// <returns>Large grid settings</returns>
        public static GridTargetingSettings CreateLargeGrid()
        {
            return new GridTargetingSettings
            {
                GridSize = new Vector2I(500, 500),
                CellSize = new Vector2(64.0f, 64.0f),
                MaxTargetingRange = 100,
                MaxCellsPerFrame = 50,
                UseSpatialPartitioning = true,
                PartitionCellSize = 20,
                EnableFrustumCulling = true,
                ShowGridLines = false,
                ShowCellCoordinates = false
            };
        }
```

Creates settings optimized for large grids

**Returns:** `GridTargetingSettings`

### CreateIsometric

```csharp
/// <summary>
        /// Creates settings for isometric grids
        /// </summary>
        /// <returns>Isometric grid settings</returns>
        public static GridTargetingSettings CreateIsometric()
        {
            return new GridTargetingSettings
            {
                IsIsometric = true,
                GridRotation = 45.0f,
                CellSize = new Vector2(32.0f, 16.0f),
                AllowDiagonalMovement = false,
                SnapToGrid = true,
                SnapTolerance = 12.0f
            };
        }
```

Creates settings for isometric grids

**Returns:** `GridTargetingSettings`

