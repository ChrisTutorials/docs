---
title: BuildingSystem Deprecation
description: Migration guide for BuildingSystem → PlacementService/ManipulationService
---

# BuildingSystem Deprecation Migration Guide

> **Status**: BuildingSystem has been marked `[Obsolete]` and will be removed in a future major version.

## Overview

The `BuildingSystem` class has been deprecated in favor of a cleaner separation of concerns:

| Old System | New System | Responsibility |
|------------|------------|----------------|
| `BuildingSystem` | `PlacementService` | Object placement |
| `BuildingSystem` | `ManipulationService` | Object removal, movement |

## Why This Change?

1. **Single Responsibility**: BuildingSystem was doing too much - placement AND manipulation
2. **Better Testability**: Pure C# services without Godot Node dependencies
3. **AOT Compatibility**: Services work properly on iOS/Android
4. **Clear Separation**: Placement logic separate from manipulation logic

## Migration Steps

### Step 1: Update Service References

**Before:**
```csharp
// OLD - Using BuildingSystem
private BuildingSystem _buildingSystem;

public void PlaceHouse(Vector2I position)
{
    _buildingSystem.TryBuild(position);
}
```

**After:**
```csharp
// NEW - Using PlacementService
private IPlacementService _placementService;

public void PlaceHouse(Vector2I position)
{
    var result = _placementService.ExecutePlacement(placeable, position, owner);
}
```

### Step 2: Update Removal Operations

**Before:**
```csharp
// OLD - Using BuildingSystem for removal
public void RemoveBuilding(Node building)
{
    _buildingSystem.RemoveBuilding(building);
}
```

**After:**
```csharp
// NEW - Using ManipulationService
public void RemoveBuilding(string buildingId, Vector2I position)
{
    _manipulationService.RemoveObject(buildingId, position);
}
```

### Step 3: Update Mode Handling

**Before:**
```gdscript
# OLD - BuildingSystem mode
building_system.enter_build_mode(placeable)
```

**After:**
```gdscript
# NEW - PlacementService mode
placement_service.enter_build_mode(placeable)
```

## Service Registration Changes

**Before:**
```csharp
// OLD - Registering BuildingSystem
services.AddSingleton<BuildingSystem>();
```

**After:**
```csharp
// NEW - Register both services
services.AddSingleton<IPlacementService, PlacementService>();
services.AddSingleton<ManipulationService>();
```

## API Mapping

| BuildingSystem Method | New Service | New Method |
|----------------------|-------------|------------|
| `TryBuild()` | PlacementService | `ExecutePlacement()` |
| `EnterBuildMode()` | PlacementService | `EnterBuildMode()` |
| `ExitBuildMode()` | PlacementService | `ExitBuildMode()` |
| `RemoveBuilding()` | ManipulationService | `RemoveObject()` |
| `MoveBuilding()` | ManipulationService | `MoveObject()` |
| `ClearPreview()` | PlacementService | `ClearPreview()` |

## Signals

Signals are now available on the respective services:

### PlacementService
- `PlacementStarted`
- `PlacementCompleted`
- `PlacementFailed`

### ManipulationService
- `ManipulationStarted`
- `ManipulationCompleted`
- `ManipulationCancelled`
- `ObjectRemoved`
- `ObjectMoved`

## Timeline

- **Current**: BuildingSystem marked `[Obsolete]` with compiler warnings
- **Next Minor**: Documentation fully updated
- **Next Major**: BuildingSystem removed from codebase

## Need Help?

See the full [BUILDING_SYSTEM_DEPRECATION_MIGRATION.md](/plugins/domains/gameplay/GridBuilding/docs/BUILDING_SYSTEM_DEPRECATION_MIGRATION.md) in the plugin docs for detailed examples and compatibility layers.
