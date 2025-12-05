---
title: "GridTargetingState"
description: "Pure C# state data for grid targeting operations.
Contains only data properties - NO events or service locator concerns.
Events are handled by GridTargetingService to maintain SRP."
weight: 10
url: "/gridbuilding/v6-0/api/core/gridtargetingstate/"
---

# GridTargetingState

```csharp
GridBuilding.Core.State.Targeting
class GridTargetingState
{
    // Members...
}
```

Pure C# state data for grid targeting operations.
Contains only data properties - NO events or service locator concerns.
Events are handled by GridTargetingService to maintain SRP.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/State/Targeting/GridTargetingState.cs`  
**Namespace:** `GridBuilding.Core.State.Targeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Collider

```csharp
#endregion

        #region Public Properties (Data Only)

        /// <summary>
        /// Raw collision detected object
        /// </summary>
        public object? Collider
        {
            get => _collider;
            set => _collider = value;
        }
```

Raw collision detected object

### Target

```csharp
/// <summary>
        /// Resolved target (logical root for display/manipulation)
        /// </summary>
        public object? Target
        {
            get => _target;
            set => _target = value;
        }
```

Resolved target (logical root for display/manipulation)

### Positioner

```csharp
/// <summary>
        /// Parent node for positioning grid building objects
        /// </summary>
        public object? Positioner
        {
            get => _positioner;
            set => _positioner = value;
        }
```

Parent node for positioning grid building objects

### TargetMap

```csharp
/// <summary>
        /// TileMap or TileMap node for grid distance calculations
        /// </summary>
        public object? TargetMap
        {
            get => _targetMap;
            set => _targetMap = value;
        }
```

TileMap or TileMap node for grid distance calculations

### Maps

```csharp
/// <summary>
        /// All maps known by the targeting state for collision testing
        /// </summary>
        public IList<object> Maps
        {
            get => _maps;
            set => _maps = value ?? new List<object>();
        }
```

All maps known by the targeting state for collision testing

### CollisionExclusions

```csharp
/// <summary>
        /// Objects excluded from collision detection
        /// </summary>
        public IList<object> CollisionExclusions
        {
            get => _collisionExclusions;
            set => _collisionExclusions = value ?? new List<object>();
        }
```

Objects excluded from collision detection

### IsManualTargetingActive

```csharp
/// <summary>
        /// Whether manual targeting is currently active
        /// </summary>
        public bool IsManualTargetingActive
        {
            get => _isManualTargetingActive;
            set => _isManualTargetingActive = value;
        }
```

Whether manual targeting is currently active

### TileSize

```csharp
/// <summary>
        /// Tile size for grid calculations
        /// </summary>
        public Vector2I TileSize { get; set; } = Vector2I.One;
```

Tile size for grid calculations

### LastUpdated

```csharp
/// <summary>
        /// Last update timestamp
        /// </summary>
        public double LastUpdated
        {
            get => _lastUpdated;
            private set => _lastUpdated = value;
        }
```

Last update timestamp

### IsInitialized

```csharp
#endregion

        #region IRuntimeState Implementation

        public bool IsInitialized => _targetMap != null;
```

### IsReady

```csharp
public bool IsReady => _isReady;
```

### HasError

```csharp
public bool HasError => false;
```

### LastError

```csharp
public string? LastError => null;
```


## Methods

### UpdateTimestamp

```csharp
#endregion

        #region Data Methods (Pure Data Operations Only)

        /// <summary>
        /// Updates the last updated timestamp
        /// </summary>
        public void UpdateTimestamp()
        {
            _lastUpdated = DateTimeOffset.UtcNow.ToUnixTimeSeconds();
        }
```

Updates the last updated timestamp

**Returns:** `void`

### SetReady

```csharp
/// <summary>
        /// Sets the ready state (data operation only)
        /// Note: Event emission is handled by GridTargetingService
        /// </summary>
        public void SetReady(bool ready)
        {
            _isReady = ready;
            UpdateTimestamp();
        }
```

Sets the ready state (data operation only)
Note: Event emission is handled by GridTargetingService

**Returns:** `void`

**Parameters:**
- `bool ready`

### UpdateTarget

```csharp
/// <summary>
        /// Updates target (data operation only)
        /// Note: Event emission is handled by GridTargetingService
        /// </summary>
        public void UpdateTarget(object? newTarget, object? oldTarget)
        {
            _target = newTarget;
            UpdateTimestamp();
        }
```

Updates target (data operation only)
Note: Event emission is handled by GridTargetingService

**Returns:** `void`

**Parameters:**
- `object? newTarget`
- `object? oldTarget`

### UpdatePositioner

```csharp
/// <summary>
        /// Updates positioner (data operation only)
        /// Note: Event emission is handled by GridTargetingService
        /// </summary>
        public void UpdatePositioner(object? newPositioner)
        {
            _positioner = newPositioner;
            UpdateTimestamp();
        }
```

Updates positioner (data operation only)
Note: Event emission is handled by GridTargetingService

**Returns:** `void`

**Parameters:**
- `object? newPositioner`

### UpdateTargetMap

```csharp
/// <summary>
        /// Updates target map (data operation only)
        /// Note: Event emission is handled by GridTargetingService
        /// </summary>
        public void UpdateTargetMap(object? newTargetMap)
        {
            _targetMap = newTargetMap;
            UpdateTimestamp();
        }
```

Updates target map (data operation only)
Note: Event emission is handled by GridTargetingService

**Returns:** `void`

**Parameters:**
- `object? newTargetMap`

### UpdateMaps

```csharp
/// <summary>
        /// Updates maps list (data operation only)
        /// Note: Event emission is handled by GridTargetingService
        /// </summary>
        public void UpdateMaps(IList<object> newMaps)
        {
            _maps = newMaps ?? new List<object>();
            UpdateTimestamp();
        }
```

Updates maps list (data operation only)
Note: Event emission is handled by GridTargetingService

**Returns:** `void`

**Parameters:**
- `IList<object> newMaps`

### ValidateState

```csharp
#endregion

        #region Validation Methods

        /// <summary>
        /// Validates the current state configuration
        /// </summary>
        public bool ValidateState()
        {
            return _targetMap != null;
        }
```

Validates the current state configuration

**Returns:** `bool`

### GetTarget

```csharp
public object? GetTarget() => _target;
```

**Returns:** `object?`

### GetCollider

```csharp
public object? GetCollider() => _collider;
```

**Returns:** `object?`

### SetManualTarget

```csharp
public void SetManualTarget(object? target)
        {
            _target = target;
            _isManualTargetingActive = target != null;
            UpdateTimestamp();
        }
```

**Returns:** `void`

**Parameters:**
- `object? target`

### Clear

```csharp
public void Clear()
        {
            _target = null;
            _collider = null;
            _isManualTargetingActive = false;
            UpdateTimestamp();
        }
```

**Returns:** `void`

### ClearCollisionExclusions

```csharp
public void ClearCollisionExclusions()
        {
            _collisionExclusions.Clear();
            UpdateTimestamp();
        }
```

**Returns:** `void`

### SetCollider

```csharp
public void SetCollider(object? collider)
        {
            _collider = collider;
            UpdateTimestamp();
        }
```

**Returns:** `void`

**Parameters:**
- `object? collider`

### SetMapObjects

```csharp
public void SetMapObjects(object? targetMap, IList<object>? maps)
        {
            _targetMap = targetMap;
            _maps = maps ?? new List<object>();
            UpdateTimestamp();
        }
```

**Returns:** `void`

**Parameters:**
- `object? targetMap`
- `IList<object>? maps`

### GetEditorIssues

```csharp
public List<string> GetEditorIssues()
        {
            var issues = new List<string>();
            if (_targetMap == null)
                issues.Add("Target map is required");
            return issues;
        }
```

**Returns:** `List<string>`

### GetRuntimeIssues

```csharp
public List<string> GetRuntimeIssues()
        {
            var issues = new List<string>();
            if (!_isReady)
                issues.Add("Targeting state is not ready");
            return issues;
        }
```

**Returns:** `List<string>`

### CreateDefault

```csharp
#endregion

        #region Static Factory Methods

        /// <summary>
        /// Creates a new targeting state with default values
        /// </summary>
        public static GridTargetingState CreateDefault()
        {
            return new GridTargetingState();
        }
```

Creates a new targeting state with default values

**Returns:** `GridTargetingState`

