---
title: "Core DLL API Reference"
description: "Complete API reference for GridBuilding Core DLL"
date: 2025-12-01T19:40:00-05:00
weight: 20
draft: false
type: "docs"
layout: "docs"
url: "/v5.1/api/core-dll-reference/"
icon: "fas fa-code"
tags: ["api", "core-dll", "reference", "csharp"]
---

# Core DLL API Reference

## BuildingService

### PlaceBuilding
```csharp
BuildingState PlaceBuilding(string buildingType, Vector2I gridPosition, string ownerId = "")
```
Places a building at specified position.

**Parameters:**
- `buildingType`: Type of building (basic, tower, wall, etc.)
- `gridPosition`: Grid coordinates
- `ownerId`: Building owner (optional)

**Returns:** `BuildingState` instance

**Exceptions:**
- `BuildingPlacementException`: Validation fails
- `ArgumentException`: Invalid parameters

### RemoveBuilding
```csharp
bool RemoveBuilding(string buildingId)
```
Removes building by ID.

**Returns:** `true` if successful

### ApplyDamage
```csharp
bool ApplyDamage(string buildingId, float damageAmount)
```
Applies damage to building.

**Effects:** Health reduction, status changes, events triggered

### RepairBuilding
```csharp
bool RepairBuilding(string buildingId, float repairAmount)
```
Repairs building health.

## BuildingState

### Properties
```csharp
string BuildingType { get; set; }
Vector2I GridPosition { get; set; }
string InstanceId { get; }
string OwnerId { get; set; }
BuildingStatus Status { get; set; }
float Health { get; set; }
float MaxHealth { get; set; }
```

### Methods
```csharp
void ApplyDamage(float damageAmount)
void UpdateState(BuildingStatus newStatus)
bool IsDestroyed { get; }
void Validate()
```

## BuildingStatus Enum
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

## Event Types

### BuildingPlacedEvent
```csharp
public class BuildingPlacedEvent : EventArgs
{
    public BuildingState Building { get; }
}
```

### BuildingRemovedEvent
```csharp
public class BuildingRemovedEvent : EventArgs
{
    public BuildingState Building { get; }
}
```

### BuildingDamagedEvent
```csharp
public class BuildingDamagedEvent : EventArgs
{
    public BuildingState Building { get; }
    public float DamageAmount { get; }
}
```

### BuildingDestroyedEvent
```csharp
public class BuildingDestroyedEvent : EventArgs
{
    public BuildingState Building { get; }
}
```

### BuildingRepairedEvent
```csharp
public class BuildingRepairedEvent : EventArgs
{
    public BuildingState Building { get; }
    public float RepairAmount { get; }
    public float NewHealth { get; }
}
```

### BuildingHealthChangedEvent
```csharp
public class BuildingHealthChangedEvent : EventArgs
{
    public BuildingState Building { get; }
    public float PreviousHealth { get; }
    public float CurrentHealth { get; }
}
```

## EventDispatcher

### Subscribe
```csharp
void Subscribe<T>(EventHandler<T> handler) where T : EventArgs
```

### Unsubscribe
```csharp
void Unsubscribe<T>(EventHandler<T> handler) where T : EventArgs
```

### Publish
```csharp
void Publish<T>(object sender, T eventArgs) where T : EventArgs
```

### PublishAsync
```csharp
void PublishAsync<T>(object sender, T eventArgs) where T : EventArgs
```

## Validation Rules

### Building Types
- `basic`: Standard building
- `tower`: Requires Y ≥ 5
- `wall`: Requires even coordinates
- `defense`, `resource`, `special`: Valid types

### Position Validation
- Non-negative coordinates
- Maximum grid size: 1000x1000
- No duplicate positions

### Error Messages
Common validation errors returned as strings.

## Thread Safety

The Core DLL uses `ReaderWriterLockSlim` for thread-safe operations:

- **Read operations**: Concurrent access allowed
- **Write operations**: Exclusive access required
- **Event publishing**: Creates handler copies to prevent deadlocks

## Usage Examples

### Basic Building Placement
```csharp
var service = new BuildingService();
var building = service.PlaceBuilding("tower", new Vector2I(5, 10), "player1");
```

### Event Handling
```csharp
service.BuildingPlaced += (sender, e) => {
    Console.WriteLine($"Building {e.Building.BuildingType} placed");
};
```

### Validation
```csharp
var errors = service.ValidateBuildingPlacement(position, buildingType);
if (errors.Count > 0) {
    // Handle validation errors
}
```

---

**Thread-safe, engine-agnostic C# implementation.**
