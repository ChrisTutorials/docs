---
title: "API Reference"
description: "Comprehensive API documentation for GridBuilding plugin core classes and services"
date: 2025-12-01T00:00:00Z
draft: false
weight: 20
categories:
  - "gridbuilding"
  - "documentation"
tags:
  - "godot"
  - "grid"
  - "api"
  - "reference"
  - "csharp"
---


This document provides comprehensive API documentation for the GridBuilding plugin's core classes and services.

## 📚 Table of Contents

- [Core Services](#core-services)
  - [Building Service](#building-service)
  - [Manipulation Service](#manipulation-service)
  - [Placement Service](#placement-service)
  - [Targeting Service](#targeting-service)
- [Core Classes](#core-classes)
  - [GridPosition](#gridposition)
  - [BuildingData](#buildingdata)
  - [PlacementResult](#placementresult)
- [State Management](#state-management)
- [Grid Utilities](#grid-utilities)

---

## Core Services

### Building Service

**Namespace**: `GridBuilding.Core.Services.Building`  
**Primary Class**: `BuildingService`

The Building Service handles all building-related operations including placement, validation, and management.

#### Main Methods

```csharp
public class BuildingService : IBuildingService
{
    // Place a building at the specified position
    public async Task<PlacementResult> PlaceBuildingAsync(BuildingData buildingData)
    
    // Remove a building from the grid
    public async Task<bool> RemoveBuildingAsync(GridPosition position)
    
    // Check if a building can be placed at the specified position
    public PlacementValidation CanPlaceBuilding(BuildingData buildingData, GridPosition position)
    
    // Get all buildings in the specified area
    public IEnumerable<BuildingData> GetBuildingsInArea(GridRect area)
    
    // Get building at specific position
    public BuildingData GetBuildingAt(GridPosition position)
}
```

#### Events

```csharp
// Fired when a building is successfully placed
public event EventHandler<BuildingPlacedEventArgs> BuildingPlaced;

// Fired when a building is removed
public event EventHandler<BuildingRemovedEventArgs> BuildingRemoved;

// Fired when building placement fails
public event EventHandler<BuildingFailedEventArgs> BuildingPlacementFailed;
```

#### Usage Example

```csharp
// Create building service
var buildingService = new BuildingService(gridMap);

// Subscribe to events
buildingService.BuildingPlaced += (sender, e) => 
{
    Console.WriteLine($"Building placed at {e.Position}");
};

// Create building data
var buildingData = new BuildingData
{
    Name = "House",
    Size = new Vector2I(2, 2),
    BuildingType = "Residential",
    GridPosition = new GridPosition(5, 3, new Vector2(64, 64))
};

// Place the building
var result = await buildingService.PlaceBuildingAsync(buildingData);
if (result.Success)
{
    Console.WriteLine("Building placed successfully!");
}
else
{
    Console.WriteLine($"Placement failed: {result.ErrorMessage}");
}
```

---

### Manipulation Service

**Namespace**: `GridBuilding.Core.Services.Manipulation`  
**Primary Class**: `ManipulationService`

The Manipulation Service handles building manipulation operations like moving, rotating, and deleting buildings.

#### Main Methods

```csharp
public class ManipulationService : IManipulationService
{
    // Start a manipulation operation
    public async Task<ManipulationResult> StartManipulationAsync(
        BuildingData building, 
        ManipulationAction action)
    
    // Update the current manipulation
    public async Task<ManipulationResult> UpdateManipulationAsync(GridPosition newPosition)
    
    // Complete the current manipulation
    public async Task<ManipulationResult> CompleteManipulationAsync()
    
    // Cancel the current manipulation
    public void CancelManipulation()
    
    // Check if manipulation is active
    public bool IsManipulationActive { get; }
}
```

#### Manipulation Actions

```csharp
public enum ManipulationAction
{
    Move,       // Move building to new position
    Rotate,     // Rotate building
    Delete,     // Delete building
    Scale       // Scale building size
}
```

#### Events

```csharp
// Fired when manipulation starts
public event EventHandler<ManipulationStartedEventArgs> ManipulationStarted;

// Fired when manipulation updates
public event EventHandler<ManipulationUpdatedEventArgs> ManipulationUpdated;

// Fired when manipulation completes
public event EventHandler<ManipulationCompletedEventArgs> ManipulationCompleted;

// Fired when manipulation is cancelled
public event EventHandler<ManipulationCancelledEventArgs> ManipulationCancelled;
```

#### Usage Example

```csharp
var manipulationService = new ManipulationService(buildingService);

// Start moving a building
var building = buildingService.GetBuildingAt(new GridPosition(5, 3));
var result = await manipulationService.StartManipulationAsync(building, ManipulationAction.Move);

if (result.Success)
{
    // Subscribe to updates
    manipulationService.ManipulationUpdated += (sender, e) =>
    {
        Console.WriteLine($"Building moved to {e.NewPosition}");
    };
    
    // Update position (e.g., from mouse input)
    await manipulationService.UpdateManipulationAsync(new GridPosition(7, 4));
    
    // Complete the manipulation
    await manipulationService.CompleteManipulationAsync();
}
```

---

### Placement Service

**Namespace**: `GridBuilding.Core.Services.Placement`  
**Primary Class**: `PlacementService`

The Placement Service handles the logic and validation for placing objects on the grid.

#### Main Methods

```csharp
public class PlacementService : IPlacementService
{
    // Validate placement at the specified position
    public PlacementValidation ValidatePlacement(BuildingData building, GridPosition position)
    
    // Get valid placement positions for a building
    public IEnumerable<GridPosition> GetValidPositions(BuildingData building)
    
    // Check if position is occupied
    public bool IsPositionOccupied(GridPosition position)
    
    // Get placement preview (visual feedback)
    public PlacementPreview GetPlacementPreview(BuildingData building, GridPosition position)
}
```

#### Usage Example

```csharp
var placementService = new PlacementService(gridMap);

// Check if we can place a building
var building = new BuildingData { Size = new Vector2I(2, 2) };
var position = new GridPosition(5, 3);
var validation = placementService.ValidatePlacement(building, position);

if (validation.IsValid)
{
    Console.WriteLine("Can place building here");
}
else
{
    Console.WriteLine($"Cannot place: {validation.Reason}");
}
```

---

### Targeting Service

**Namespace**: `GridBuilding.Core.Services.Targeting`  
**Primary Class**: `TargetingService`

The Targeting Service handles targeting and selection logic for buildings and grid positions.

#### Main Methods

```csharp
public class TargetingService : ITargetingService
{
    // Get building under the specified screen position
    public BuildingData GetBuildingUnderPosition(Vector2 screenPosition)
    
    // Get grid position from screen coordinates
    public GridPosition GetGridPositionFromScreen(Vector2 screenPosition)
    
    // Set targeting mode
    public void SetTargetingMode(TargetingMode mode)
    
    // Get all buildings in targeting range
    public IEnumerable<BuildingData> GetBuildingsInRange(GridPosition center, float range)
}
```

#### Targeting Modes

```csharp
public enum TargetingMode
{
    None,       // No targeting
    Building,   // Target buildings
    Grid,       // Target grid positions
    Area        // Target area selection
}
```

---

## Core Classes

### GridPosition

**Namespace**: `GridBuilding.Core.Grid`

Represents a position on the grid with tile-based coordinates.

#### Properties

```csharp
public struct GridPosition
{
    public int X { get; }           // Grid X coordinate
    public int Y { get; }           // Grid Y coordinate
    public Vector2 TileSize { get; } // Size of each tile in world units
    public Vector2 WorldPosition { get; } // World position of this grid position
}
```

#### Constructors

```csharp
// Create grid position
var gridPos = new GridPosition(x: 5, y: 3, tileSize: new Vector2(64, 64));

// Create from world position
var worldPos = new Vector2(320, 192);
var gridPos = GridPosition.FromWorldPosition(worldPos, new Vector2(64, 64));
```

#### Methods

```csharp
// Convert to world position
public Vector2 ToWorldPosition()

// Get distance to another grid position
public float DistanceTo(GridPosition other)

// Check if positions are adjacent
public bool IsAdjacentTo(GridPosition other)

// Get neighboring positions
public IEnumerable<GridPosition> GetNeighbors()

// Convert to string
public override string ToString()
```

#### Usage Example

```csharp
// Create grid position
var pos = new GridPosition(5, 3, new Vector2(64, 64));

// Convert to world coordinates
var worldPos = pos.ToWorldPosition(); // (320, 192)

// Get neighbors
foreach (var neighbor in pos.GetNeighbors())
{
    Console.WriteLine($"Neighbor at {neighbor}");
}
```

---

### BuildingData

**Namespace**: `GridBuilding.Core.Services.Building`

Contains all data about a building including its properties, position, and state.

#### Properties

```csharp
public class BuildingData
{
    public string Id { get; set; }                    // Unique identifier
    public string Name { get; set; }                  // Display name
    public string BuildingType { get; set; }           // Type/category
    public Vector2I Size { get; set; }                 // Size in grid tiles
    public GridPosition GridPosition { get; set; }     // Position on grid
    public BuildingState State { get; set; }           // Current state
    public Dictionary<string, object> Properties { get; set; } // Custom properties
    public DateTime PlacedAt { get; set; }             // When building was placed
}
```

#### Building States

```csharp
public enum BuildingState
{
    Placing,    // Being placed by user
    Placed,     // Successfully placed
    Constructing, // Under construction
    Active,     // Fully active and functional
    Damaged,    // Damaged state
    Destroyed   // Destroyed/removed
}
```

#### Usage Example

```csharp
var building = new BuildingData
{
    Id = Guid.NewGuid().ToString(),
    Name = "Small House",
    BuildingType = "Residential",
    Size = new Vector2I(2, 2),
    GridPosition = new GridPosition(5, 3, new Vector2(64, 64)),
    State = BuildingState.Placed,
    Properties = new Dictionary<string, object>
    {
        ["Capacity"] = 4,
        ["Comfort"] = 75
    }
};
```

---

### PlacementResult

**Namespace**: `GridBuilding.Core.Services.Placement`

Represents the result of a placement operation.

#### Properties

```csharp
public class PlacementResult
{
    public bool Success { get; set; }                 // Was placement successful?
    public string ErrorMessage { get; set; }           // Error message if failed
    public GridPosition Position { get; set; }         // Final position
    public BuildingData Building { get; set; }         // Placed building data
    public TimeSpan PlacementTime { get; set; }        // Time taken to place
}
```

#### Usage Example

```csharp
var result = await buildingService.PlaceBuildingAsync(buildingData);

if (result.Success)
{
    Console.WriteLine($"Building placed at {result.Position} in {result.PlacementTime.TotalMilliseconds}ms");
}
else
{
    Console.WriteLine($"Failed to place: {result.ErrorMessage}");
}
```

---

## State Management

### State Classes

**Namespace**: `GridBuilding.Core.State`

State classes contain pure data without business logic, making them easily serializable and testable.

#### Key State Classes

```csharp
// Building state
public class BuildingState
{
    public string BuildingId { get; set; }
    public BuildingStatus Status { get; set; }
    public float Health { get; set; }
    public DateTime LastUpdated { get; set; }
}

// Manipulation state
public class ManipulationState
{
    public string ActiveBuildingId { get; set; }
    public ManipulationAction CurrentAction { get; set; }
    public GridPosition StartPosition { get; set; }
    public GridPosition CurrentPosition { get; set; }
}

// Grid state
public class GridState
{
    public Dictionary<Vector2I, string> OccupiedTiles { get; set; }
    public List<BuildingState> Buildings { get; set; }
    public GridConfiguration Configuration { get; set; }
}
```

---

## Grid Utilities

### GridMath

**Namespace**: `GridBuilding.Core.Grid`

Utility class for grid-related mathematical operations.

#### Methods

```csharp
public static class GridMath
{
    // Convert world position to grid position
    public static GridPosition WorldToGrid(Vector2 worldPos, Vector2 tileSize)
    
    // Convert grid position to world position
    public static Vector2 GridToWorld(GridPosition gridPos)
    
    // Check if two grid positions overlap
    public static bool DoOverlap(GridPosition pos1, Vector2I size1, GridPosition pos2, Vector2I size2)
    
    // Get all tiles occupied by a building
    public static IEnumerable<GridPosition> GetOccupiedTiles(GridPosition position, Vector2I size)
    
    // Calculate distance between grid positions
    public static float CalculateDistance(GridPosition pos1, GridPosition pos2)
    
    // Find path between positions (basic A*)
    public static IEnumerable<GridPosition> FindPath(GridPosition start, GridPosition end, IGridMap gridMap)
}
```

#### Usage Example

```csharp
// Convert coordinates
var worldPos = new Vector2(320, 192);
var gridPos = GridMath.WorldToGrid(worldPos, new Vector2(64, 64));

// Check overlap
var overlap = GridMath.DoOverlap(
    new GridPosition(5, 3), new Vector2I(2, 2),
    new GridPosition(6, 4), new Vector2I(1, 1)
);

// Get occupied tiles
var tiles = GridMath.GetOccupiedTiles(new GridPosition(5, 3), new Vector2I(2, 2));
```

---

## Interfaces

All services implement corresponding interfaces for dependency injection and testing:

- `IBuildingService` - Building operations interface
- `IManipulationService` - Manipulation operations interface  
- `IPlacementService` - Placement validation interface
- `ITargetingService` - Targeting operations interface

---

## Error Handling

Most methods return result objects or use exceptions for critical errors:

```csharp
// Result objects (preferred)
var result = await buildingService.PlaceBuildingAsync(buildingData);
if (!result.Success)
{
    // Handle error
    Console.WriteLine(result.ErrorMessage);
}

// Exceptions (for critical errors)
try
{
    var service = new BuildingService(null); // null gridMap
}
catch (ArgumentException ex)
{
    // Handle critical error
    Console.WriteLine($"Configuration error: {ex.Message}");
}
```

---

## Thread Safety

- All service methods are thread-safe
- State objects should be treated as immutable when possible
- Use async methods for all operations that may take time

---

## Extensibility

The plugin is designed for extensibility:

```csharp
// Custom building service
public class CustomBuildingService : BuildingService
{
    public CustomBuildingService(IGridMap gridMap) : base(gridMap) { }
    
    // Add custom functionality
    public async Task<bool> UpgradeBuildingAsync(string buildingId)
    {
        // Custom upgrade logic
        return true;
    }
}

// Custom building data
public class CustomBuildingData : BuildingData
{
    public int Level { get; set; }
    public List<string> Upgrades { get; set; } = new();
}
```

---

**Need more details?** Check the [source code](../Core/) for full implementation details or see the [examples](../examples/) directory for complete usage examples.
