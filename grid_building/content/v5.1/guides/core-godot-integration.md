---
title: "Core/Godot DLL Integration Guide"
description: "Complete guide for integrating GridBuilding Core DLL with Godot projects"
date: 2025-12-01T19:35:00-05:00
weight: 15
draft: false
type: "docs"
layout: "docs"
url: "/v5.1/guides/core-godot-integration/"
icon: "fas fa-layer-group"
tags: ["integration", "core-dll", "godot", "architecture", "events"]
---

# Core/Godot DLL Integration Guide

This guide covers the new v5.1.0 architecture where GridBuilding's core logic is separated into an engine-agnostic C# DLL with a dedicated Godot integration layer.

## 🏗️ Architecture Overview

### Two-Layer Architecture

```
┌─────────────────────────────────────┐
│           Godot Layer               │
│  ┌─────────────────────────────────┐ │
│  │     StateBridge.cs              │ │ ← Event-to-Signal Bridge
│  │     Godot Systems               │ │
│  │     UI Components               │ │
│  └─────────────────────────────────┘ │
└─────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────┐
│            Core DLL                  │
│  ┌─────────────────────────────────┐ │
│  │   BuildingService               │ │ ← Engine-Agnostic Logic
│  │   EventDispatcher               │ │
│  │   BuildingState                 │ │
│  │   Validation & Error Handling   │ │
│  └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

### Key Components

#### Core DLL (`GridBuilding.Core.dll`)
- **Engine Agnostic**: No Godot dependencies
- **Business Logic**: Building placement, validation, state management
- **Event System**: C# events for all building operations
- **Thread Safe**: ReaderWriterLockSlim for concurrent access
- **Testable**: Can be unit tested independently

#### Godot Integration Layer
- **StateBridge**: Converts C# events to Godot signals
- **Godot Systems**: Engine-specific implementations
- **UI Integration**: GDScript-friendly state access
- **Resource Management**: Godot-specific asset handling

## 🚀 Quick Start

### 1. Project Setup

```bash
# Your project structure
your_project/
├── addons/
│   └── grid_building/
│       ├── plugin.cfg
│       ├── GridBuilding.csproj
│       ├── Core/
│       │   └── StateBridge.cs
│       ├── Systems/
│       │   └── [Godot systems]
│       └── addons/
│           └── grid_building/
│               └── bin/
│                   └── GridBuilding.Core.dll  ← Compiled Core DLL
```

### 2. Basic Usage

```csharp
// In your Godot C# script
using Godot;
using GridBuilding.Godot.Core;

public class BuildingController : Node
{
    private StateBridge _stateBridge;
    
    public override void _Ready()
    {
        // Initialize the state bridge
        _stateBridge = GetNode<StateBridge>("/root/StateBridge");
        
        // Connect to building events
        _stateBridge.BuildingPlaced += OnBuildingPlaced;
        _stateBridge.BuildingRemoved += OnBuildingRemoved;
    }
    
    private void OnBuildingPlaced(string buildingType, Vector2I position, string instanceId)
    {
        GD.Print($"Building {buildingType} placed at {position}");
        // Update UI, play sounds, etc.
    }
    
    public void PlaceBuilding(string type, Vector2I position)
    {
        // This uses the Core DLL through the StateBridge
        _stateBridge.PlaceBuilding(type, position);
    }
}
```

### 3. GDScript Integration

```gdscript
# In your GDScript
extends Node

@onready var state_bridge = $StateBridge

func _ready():
    # Connect to signals (converted from C# events)
    state_bridge.building_placed.connect(_on_building_placed)
    state_bridge.building_removed.connect(_on_building_removed)

func _on_building_placed(building_type, position, instance_id):
    print("Building placed: ", building_type, " at ", position)

func place_tower():
    # Place building using the bridge
    state_bridge.place_building("tower", Vector2i(5, 5))
```

## 🔄 Event System Integration

### C# Events → Godot Signals

The StateBridge automatically converts Core C# events to Godot signals:

| C# Event (Core DLL) | Godot Signal (StateBridge) | Parameters |
|---------------------|----------------------------|------------|
| `BuildingPlacedEvent` | `building_placed` | `building_type: String`, `position: Vector2i`, `instance_id: String` |
| `BuildingRemovedEvent` | `building_removed` | `building_type: String`, `position: Vector2i`, `instance_id: String` |
| `BuildingDamagedEvent` | `building_damaged` | `instance_id: String`, `damage: float`, `current_health: float` |
| `BuildingDestroyedEvent` | `building_destroyed` | `instance_id: String` |
| `BuildingRepairedEvent` | `building_repaired` | `instance_id: String`, `repair_amount: float`, `new_health: float` |
| `BuildingHealthChangedEvent` | `building_health_changed` | `instance_id: String`, `previous_health: float`, `current_health: float` |

### Event Flow Example

```
User Action → StateBridge.PlaceBuilding()
         ↓
Core DLL BuildingService.PlaceBuilding()
         ↓
Core DLL EventDispatcher.Publish(BuildingPlacedEvent)
         ↓
StateBridge.OnBuildingPlaced() (event handler)
         ↓
StateBridge.EmitSignal(Signal.BuildingPlaced)
         ↓
Godot Signal System → Connected GDScript/C# handlers
```

## 🛠️ Core DLL API Reference

### BuildingService

#### Place Building
```csharp
public BuildingState PlaceBuilding(string buildingType, Vector2I gridPosition, string ownerId = "")
```

**Validation Rules:**
- Position coordinates must be non-negative
- Position must not be occupied
- Building type must be valid
- Special rules (towers: Y ≥ 5, walls: even coordinates)

**Returns:** `BuildingState` with generated InstanceId

#### Remove Building
```csharp
public bool RemoveBuilding(string buildingId)
```

**Returns:** `true` if building was found and removed

#### Apply Damage
```csharp
public bool ApplyDamage(string buildingId, float damageAmount)
```

**Effects:**
- Reduces building health
- Changes status to Damaged if health < max
- Triggers BuildingDamagedEvent
- Triggers BuildingDestroyedEvent if health ≤ 0

#### Repair Building
```csharp
public bool RepairBuilding(string buildingId, float repairAmount)
```

**Effects:**
- Increases building health (up to max)
- Changes status from Damaged to Operational
- Triggers BuildingRepairedEvent

### BuildingState Properties

| Property | Type | Description |
|----------|------|-------------|
| `BuildingType` | `string` | Type of building (basic, tower, wall, etc.) |
| `GridPosition` | `Vector2I` | Position on the grid |
| `InstanceId` | `string` | Unique identifier (GUID) |
| `OwnerId` | `string` | Owner of the building |
| `Status` | `BuildingStatus` | Current state (Placed, Damaged, Destroyed, etc.) |
| `Health` | `float` | Current health points |
| `MaxHealth` | `float` | Maximum health points |

### BuildingStatus Enum

```csharp
public enum BuildingStatus
{
    Placed,
    UnderConstruction,
    Operational,
    Damaged,
    Destroyed,
    Repairing
}
```

## 🧪 Testing Integration

### Unit Testing Core DLL

```csharp
[Test]
public void BuildingService_CanPlaceAndRemoveBuilding()
{
    var service = new BuildingService();
    var building = service.PlaceBuilding("basic", new Vector2I(5, 10));
    
    Assert.NotNull(building);
    Assert.Equal("basic", building.BuildingType);
    Assert.Equal(1, service.GetAllBuildings().Count());
    
    var removed = service.RemoveBuilding(building.InstanceId);
    Assert.True(removed);
    Assert.Equal(0, service.GetAllBuildings().Count());
}
```

### Integration Testing with Godot

```csharp
[Test]
public void StateBridge_ConvertsEventsToSignals()
{
    // This requires Godot test environment
    var stateBridge = new StateBridge();
    var signalReceived = false;
    
    stateBridge.BuildingPlaced += () => signalReceived = true;
    
    // Trigger Core DLL event
    var building = service.PlaceBuilding("tower", new Vector2I(3, 7));
    
    Assert.True(signalReceived);
}
```

## 🔧 Advanced Configuration

### Custom Validation Rules

```csharp
// Extend BuildingService validation
public class CustomBuildingService : BuildingService
{
    protected override List<string> ValidateBuildingPlacement(Vector2I position, string buildingType)
    {
        var errors = base.ValidateBuildingPlacement(position, buildingType);
        
        // Add custom rules
        if (buildingType == "special" && position.X < 10)
        {
            errors.Add("Special buildings must be placed at X ≥ 10");
        }
        
        return errors;
    }
}
```

### Custom Event Handlers

```csharp
// In StateBridge
protected override void OnBuildingPlaced(object? sender, BuildingPlacedEvent e)
{
    base.OnBuildingPlaced(sender, e);
    
    // Add custom logic
    LogBuildingPlacement(e.Building);
    UpdateStatistics(e.Building);
}
```

### Thread Safety Considerations

The Core DLL uses `ReaderWriterLockSlim` for thread safety:

```csharp
// Thread-safe operations are automatic
Parallel.ForEach(positions, pos => {
    var building = service.PlaceBuilding("basic", pos);
    // No additional synchronization needed
});
```

## 🚨 Error Handling

### Exception Types

| Exception | When Thrown | How to Handle |
|-----------|-------------|---------------|
| `BuildingPlacementException` | Validation fails | Show error message to user |
| `ArgumentException` | Invalid parameters | Validate user input |
| `InvalidOperationException` | Duplicate placement | Check position first |

### Error Handling Pattern

```csharp
try
{
    var building = _stateBridge.PlaceBuilding(buildingType, position);
    // Success - update UI
}
catch (BuildingPlacementException ex)
{
    // Show validation error to user
    ShowError($"Cannot place building: {ex.Message}");
}
catch (Exception ex)
{
    // Log unexpected errors
    GD.PrintErr($"Unexpected error: {ex.Message}");
    ShowError("An unexpected error occurred");
}
```

## 📊 Performance Considerations

### Memory Management

- Core DLL uses efficient Dictionary-based lookup
- Event subscriptions are automatically cleaned up
- Building states are lightweight structs

### Thread Performance

- Read operations use read locks (concurrent access)
- Write operations use write locks (exclusive access)
- Event publishing creates handler copies to avoid deadlocks

### Optimization Tips

```csharp
// Good: Batch operations
var buildings = new List<BuildingState>();
foreach (var pos in positions)
{
    buildings.Add(service.PlaceBuilding("basic", pos));
}

// Avoid: Excessive individual calls
// foreach (var pos in positions)
// {
//     service.PlaceBuilding("basic", pos); // Creates many events
// }
```

## 🔍 Debugging

### Core DLL Debugging

```csharp
// Enable console logging
Console.WriteLine($"[BuildingService] Placed {buildingType} at {position}");

// Check event subscriptions
var subscriberCount = EventDispatcher.Instance.GetSubscriberCount<BuildingPlacedEvent>();
GD.Print($"BuildingPlacedEvent subscribers: {subscriberCount}");
```

### Godot Integration Debugging

```csharp
// Check signal connections
if (!stateBridge.IsConnected("building_placed", Callable(OnBuildingPlaced)))
{
    GD.PrintErr("Building placed signal not connected!");
}

// Verify Core DLL is loaded
if (!File.Exists("res://addons/grid_building/bin/GridBuilding.Core.dll"))
{
    GD.PrintErr("Core DLL not found!");
}
```

## ✅ Integration Checklist

### Setup
- [ ] Core DLL copied to `addons/grid_building/bin/`
- [ ] Godot project references Core DLL
- [ ] StateBridge added to scene tree
- [ ] Plugin configuration updated

### Testing
- [ ] Core DLL builds successfully
- [ ] Building placement works
- [ ] Events convert to signals
- [ ] Error handling works
- [ ] Thread safety verified

### Performance
- [ ] No memory leaks in event system
- [ ] Acceptable placement performance
- [ ] UI remains responsive during operations

### Documentation
- [ ] API documentation updated
- [ ] Integration examples provided
- [ ] Troubleshooting guide created

## 🎉 Success!

Your GridBuilding plugin is now using the new Core/Godot DLL architecture! You have:

- ✅ **Engine-agnostic core logic** that can be tested independently
- ✅ **Robust event system** with automatic signal conversion
- ✅ **Thread-safe operations** for concurrent access
- ✅ **Comprehensive error handling** with detailed validation
- ✅ **Better performance** with optimized C# implementation

### Next Steps
1. **Explore the Core DLL** - Try unit testing your building logic
2. **Custom validation** - Add game-specific building rules
3. **Performance optimization** - Profile and optimize for your use case
4. **Contribute back** - Share improvements with the community

---

**Need help?** Check the troubleshooting section or create an issue on GitHub.
