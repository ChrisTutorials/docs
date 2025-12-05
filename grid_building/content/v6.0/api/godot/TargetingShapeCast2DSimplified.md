---
title: "TargetingShapeCast2DSimplified"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/targetingshapecast2dsimplified/"
---

# TargetingShapeCast2DSimplified

```csharp
GridBuilding.Godot.Systems.GridTargeting
class TargetingShapeCast2DSimplified
{
    // Members...
}
```

Simplified TargetingShapeCast2D focused on Godot-specific responsibilities.
This component handles only:
- Physics collision detection
- Grid coordinate conversion
- Signal emission for Godot events
- Core service delegation for business logic
All heavy algorithms are delegated to IGridTargetingService.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/GridTargeting/TargetingShapeCast2DSimplified.cs`  
**Namespace:** `GridBuilding.Godot.Systems.GridTargeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CurrentGridPosition

```csharp
#endregion

        #region Properties

        /// <summary>
        /// Current grid position of the shape cast
        /// </summary>
        public Vector2I CurrentGridPosition => _currentGridPosition;
```

Current grid position of the shape cast

### GridSnappingEnabled

```csharp
/// <summary>
        /// Whether grid snapping is enabled
        /// </summary>
        public bool GridSnappingEnabled { get; set; } = true;
```

Whether grid snapping is enabled

### AutoUpdateEnabled

```csharp
#endregion

        #region Public API

        /// <summary>
        /// Whether auto-update is enabled
        /// </summary>
        public bool AutoUpdateEnabled { get; set; } = true;
```

Whether auto-update is enabled


## Methods

### _Ready

```csharp
#endregion

        #region Godot Lifecycle

        public override void _Ready()
        {
            base._Ready();
            SetupAutoUpdate();
        }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
        {
            if (AutoUpdateEnabled)
            {
                UpdateTargeting();
            }
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### InjectDependencies

```csharp
/// <summary>
        /// Inject Core targeting service dependency
        /// </summary>
        /// <param name="targetingService">Core targeting service</param>
        /// <param name="gridMap">Grid map for coordinate conversion</param>
        public void InjectDependencies(IGridTargetingService targetingService, TileMapLayer gridMap)
        {
            _targetingService = targetingService ?? throw new ArgumentNullException(nameof(targetingService));
            _gridMap = gridMap ?? throw new ArgumentNullException(nameof(gridMap));
        }
```

Inject Core targeting service dependency

**Returns:** `void`

**Parameters:**
- `IGridTargetingService targetingService`
- `TileMapLayer gridMap`

### UpdateTargeting

```csharp
/// <summary>
        /// Updates targeting position and validation
        /// </summary>
        public void UpdateTargeting()
        {
            var newGridPos = ConvertToGridPosition(GlobalPosition);
            if (newGridPos != _currentGridPosition)
            {
                _currentGridPosition = newGridPos;
                EmitSignal(SignalName.GridPositionChanged, _currentGridPosition);
            }

            ValidateCurrentTarget();
        }
```

Updates targeting position and validation

**Returns:** `void`

### IsValidTarget

```csharp
/// <summary>
        /// Validates if current target is valid using Core service
        /// </summary>
        /// <returns>True if target is valid</returns>
        public bool IsValidTarget()
        {
            if (_targetingService == null || _gridMap == null)
                return false;

            return _targetingService.IsValidTargetTile(_currentGridPosition);
        }
```

Validates if current target is valid using Core service

**Returns:** `bool`

### GetValidationErrors

```csharp
/// <summary>
        /// Gets validation errors from Core service
        /// </summary>
        /// <returns>List of validation errors</returns>
        public List<string> GetValidationErrors()
        {
            if (_targetingService == null)
                return new List<string> { "Targeting service not injected" };

            return _targetingService.ValidateTilePlacement(_currentGridPosition);
        }
```

Gets validation errors from Core service

**Returns:** `List<string>`

### ValidateTarget

```csharp
#endregion

        #region ITargetingValidator Implementation

        /// <summary>
        /// Validates target at current position
        /// </summary>
        /// <param name="target">Target to validate</param>
        /// <returns>True if valid</returns>
        public bool ValidateTarget(object? target)
        {
            return IsValidTarget();
        }
```

Validates target at current position

**Returns:** `bool`

**Parameters:**
- `object? target`

