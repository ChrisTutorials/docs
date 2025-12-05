---
title: "GridBuildingSignalEmitter"
description: "GridBuilding signal emitter for testing Godot signal integration.
Uses GoDotTest framework for proper Godot integration testing."
weight: 20
url: "/gridbuilding/v6-0/api/godot/gridbuildingsignalemitter/"
---

# GridBuildingSignalEmitter

```csharp
GridBuilding.Tests.Godot
class GridBuildingSignalEmitter
{
    // Members...
}
```

GridBuilding signal emitter for testing Godot signal integration.
Uses GoDotTest framework for proper Godot integration testing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/GridBuildingSignalEmitter.cs`  
**Namespace:** `GridBuilding.Tests.Godot`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestBuildingState

```csharp
// Test data properties
    public BuildingState TestBuildingState { get; set; }
```

### TestBuildingData

```csharp
public BuildingData TestBuildingData { get; set; }
```


## Methods

### EmitBuildingStateChanged

```csharp
// Building State Signal Methods
    public void EmitBuildingStateChanged(BuildingState newState)
    {
        EmitSignal(SignalName.BuildingStateChanged, newState);
    }
```

**Returns:** `void`

**Parameters:**
- `BuildingState newState`

### EmitBuildingProgressUpdated

```csharp
public void EmitBuildingProgressUpdated(float progress)
    {
        EmitSignal(SignalName.BuildingProgressUpdated, progress);
    }
```

**Returns:** `void`

**Parameters:**
- `float progress`

### EmitBuildingCompleted

```csharp
public void EmitBuildingCompleted(BuildingData building)
    {
        EmitSignal(SignalName.BuildingCompleted, building);
    }
```

**Returns:** `void`

**Parameters:**
- `BuildingData building`

### EmitStateChanged

```csharp
// State Machine Signal Methods
    public void EmitStateChanged(string fromState, string toState)
    {
        EmitSignal(SignalName.StateChanged, fromState, toState);
    }
```

**Returns:** `void`

**Parameters:**
- `string fromState`
- `string toState`

### EmitStateEntered

```csharp
public void EmitStateEntered(string stateName)
    {
        EmitSignal(SignalName.StateEntered, stateName);
    }
```

**Returns:** `void`

**Parameters:**
- `string stateName`

### EmitStateExited

```csharp
public void EmitStateExited(string stateName)
    {
        EmitSignal(SignalName.StateExited, stateName);
    }
```

**Returns:** `void`

**Parameters:**
- `string stateName`

### EmitTransitionFailed

```csharp
public void EmitTransitionFailed(string fromState, string toState, string reason)
    {
        EmitSignal(SignalName.TransitionFailed, fromState, toState, reason);
    }
```

**Returns:** `void`

**Parameters:**
- `string fromState`
- `string toState`
- `string reason`

### EmitReadyChanged

```csharp
// Grid Targeting Signal Methods
    public void EmitReadyChanged(bool value)
    {
        EmitSignal(SignalName.ReadyChanged, value);
    }
```

**Returns:** `void`

**Parameters:**
- `bool value`

### EmitTargetChanged

```csharp
public void EmitTargetChanged(Node2D @new, Node2D old)
    {
        EmitSignal(SignalName.TargetChanged, @new, old);
    }
```

**Returns:** `void`

**Parameters:**
- `Node2D new`
- `Node2D old`

### EmitPositionerChanged

```csharp
public void EmitPositionerChanged(Node2D positioner)
    {
        EmitSignal(SignalName.PositionerChanged, positioner);
    }
```

**Returns:** `void`

**Parameters:**
- `Node2D positioner`

### EmitTargetMapChanged

```csharp
public void EmitTargetMapChanged(TileMapLayer targetMap)
    {
        EmitSignal(SignalName.TargetMapChanged, targetMap);
    }
```

**Returns:** `void`

**Parameters:**
- `TileMapLayer targetMap`

### EmitMapsChanged

```csharp
public void EmitMapsChanged(int mapCount)
    {
        EmitSignal(SignalName.MapsChanged, mapCount);
    }
```

**Returns:** `void`

**Parameters:**
- `int mapCount`

### EmitInventorySystemReady

```csharp
// Inventory Signal Methods
    public void EmitInventorySystemReady()
    {
        EmitSignal(SignalName.InventorySystemReady);
    }
```

**Returns:** `void`

### EmitInventoryItemAdded

```csharp
public void EmitInventoryItemAdded(InventoryItem item, GridBuildingVector2I gridPosition)
    {
        EmitSignal(SignalName.InventoryItemAdded, item, gridPosition);
    }
```

**Returns:** `void`

**Parameters:**
- `InventoryItem item`
- `GridBuildingVector2I gridPosition`

### EmitInventoryItemRemoved

```csharp
public void EmitInventoryItemRemoved(InventoryItem item, GridBuildingVector2I gridPosition)
    {
        EmitSignal(SignalName.InventoryItemRemoved, item, gridPosition);
    }
```

**Returns:** `void`

**Parameters:**
- `InventoryItem item`
- `GridBuildingVector2I gridPosition`

### EmitInventoryGridInteraction

```csharp
public void EmitInventoryGridInteraction(GridBuildingVector2I gridPosition, InventoryItem item)
    {
        EmitSignal(SignalName.InventoryGridInteraction, gridPosition, item);
    }
```

**Returns:** `void`

**Parameters:**
- `GridBuildingVector2I gridPosition`
- `InventoryItem item`

