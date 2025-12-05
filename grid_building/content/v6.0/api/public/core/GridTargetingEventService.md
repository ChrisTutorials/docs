---
title: "GridTargetingEventService"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/gridtargetingeventservice/"
---

# GridTargetingEventService

```csharp
GridBuilding.Core.Services.Targeting
class GridTargetingEventService
{
    // Members...
}
```

Service that handles GridTargetingState events.
Separates event handling from state data to maintain SRP.
State objects contain data only, services handle events and business logic.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Targeting/GridTargetingEventService.cs`  
**Namespace:** `GridBuilding.Core.Services.Targeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### EmitReadyChanged

```csharp
#endregion

        #region Event Emission Methods

        /// <summary>
        /// Emits ReadyChanged event if value actually changed
        /// </summary>
        public void EmitReadyChanged(bool isReady)
        {
            var key = "ready";
            if (!HasValueChanged(key, isReady)) return;

            _logger.LogDebug("Targeting ready changed: {IsReady}", isReady);
            ReadyChanged?.Invoke(isReady);
            UpdateLastKnownValue(key, isReady);
        }
```

Emits ReadyChanged event if value actually changed

**Returns:** `void`

**Parameters:**
- `bool isReady`

### EmitTargetChanged

```csharp
/// <summary>
        /// Emits TargetChanged event if value actually changed
        /// </summary>
        public void EmitTargetChanged(object? newTarget, object? oldTarget)
        {
            var key = "target";
            if (!HasValueChanged(key, newTarget)) return;

            _logger.LogDebug("Target changed from {OldTarget} to {NewTarget}", oldTarget, newTarget);
            TargetChanged?.Invoke(oldTarget, newTarget);
            UpdateLastKnownValue(key, newTarget);
        }
```

Emits TargetChanged event if value actually changed

**Returns:** `void`

**Parameters:**
- `object? newTarget`
- `object? oldTarget`

### EmitPositionerChanged

```csharp
/// <summary>
        /// Emits PositionerChanged event if value actually changed
        /// </summary>
        public void EmitPositionerChanged(object? newPositioner)
        {
            var key = "positioner";
            if (!HasValueChanged(key, newPositioner)) return;

            _logger.LogDebug("Positioner changed: {Positioner}", newPositioner);
            PositionerChanged?.Invoke(newPositioner);
            UpdateLastKnownValue(key, newPositioner);
        }
```

Emits PositionerChanged event if value actually changed

**Returns:** `void`

**Parameters:**
- `object? newPositioner`

### EmitTargetMapChanged

```csharp
/// <summary>
        /// Emits TargetMapChanged event if value actually changed
        /// </summary>
        public void EmitTargetMapChanged(object? newTargetMap)
        {
            var key = "targetMap";
            if (!HasValueChanged(key, newTargetMap)) return;

            _logger.LogDebug("Target map changed: {TargetMap}", newTargetMap);
            TargetMapChanged?.Invoke(newTargetMap);
            UpdateLastKnownValue(key, newTargetMap);
        }
```

Emits TargetMapChanged event if value actually changed

**Returns:** `void`

**Parameters:**
- `object? newTargetMap`

### EmitMapsChanged

```csharp
/// <summary>
        /// Emits MapsChanged event if value actually changed
        /// </summary>
        public void EmitMapsChanged(IList<object>? newMaps)
        {
            var key = "maps";
            if (!HasValueChanged(key, newMaps)) return;

            _logger.LogDebug("Maps changed: {MapCount} maps", newMaps?.Count ?? 0);
            MapsChanged?.Invoke(newMaps);
            UpdateLastKnownValue(key, newMaps);
        }
```

Emits MapsChanged event if value actually changed

**Returns:** `void`

**Parameters:**
- `IList<object>? newMaps`

### MonitorStateChanges

```csharp
#endregion

        #region State Monitoring Methods

        /// <summary>
        /// Monitors state changes and emits appropriate events
        /// Call this after updating state properties
        /// </summary>
        public void MonitorStateChanges(GridTargetingState state)
        {
            // Monitor ready state
            EmitReadyChanged(state.IsReady);

            // Monitor target changes
            var currentTarget = state.Target;
            EmitTargetChanged(currentTarget, GetLastKnownValue<object?>("target"));

            // Monitor positioner changes
            EmitPositionerChanged(state.Positioner);

            // Monitor target map changes
            EmitTargetMapChanged(state.TargetMap);

            // Monitor maps changes
            EmitMapsChanged(state.Maps);
        }
```

Monitors state changes and emits appropriate events
Call this after updating state properties

**Returns:** `void`

**Parameters:**
- `GridTargetingState state`

### ClearCache

```csharp
/// <summary>
        /// Clears all last known values (useful for testing or reset)
        /// </summary>
        public void ClearCache()
        {
            _lastKnownValues.Clear();
            _logger.LogDebug("Targeting event service cache cleared");
        }
```

Clears all last known values (useful for testing or reset)

**Returns:** `void`

