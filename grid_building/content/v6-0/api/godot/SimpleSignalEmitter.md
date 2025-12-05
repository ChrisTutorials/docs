---
title: "SimpleSignalEmitter"
description: "Simple signal emitter using only Godot-supported types."
weight: 20
url: "/gridbuilding/v6-0/api/godot/simplesignalemitter/"
---

# SimpleSignalEmitter

```csharp
GridBuilding.Tests.Godot
class SimpleSignalEmitter
{
    // Members...
}
```

Simple signal emitter using only Godot-supported types.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/SimpleSignalTests.cs`  
**Namespace:** `GridBuilding.Tests.Godot`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### EmitBuildingStateChanged

```csharp
// Signal emission methods
    public void EmitBuildingStateChanged(string newState)
    {
        EmitSignal(SignalName.BuildingStateChanged, newState);
    }
```

**Returns:** `void`

**Parameters:**
- `string newState`

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

### EmitReadyChanged

```csharp
public void EmitReadyChanged(bool value)
    {
        EmitSignal(SignalName.ReadyChanged, value);
    }
```

**Returns:** `void`

**Parameters:**
- `bool value`

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

### EmitTargetPositionChanged

```csharp
public void EmitTargetPositionChanged(GodotVector2I position)
    {
        EmitSignal(SignalName.TargetPositionChanged, position);
    }
```

**Returns:** `void`

**Parameters:**
- `GodotVector2I position`

### EmitTargetChanged

```csharp
public void EmitTargetChanged(Node2D target)
    {
        EmitSignal(SignalName.TargetChanged, target);
    }
```

**Returns:** `void`

**Parameters:**
- `Node2D target`

