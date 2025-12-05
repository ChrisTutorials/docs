---
title: "BuildingTestEnvironment"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/buildingtestenvironment/"
---

# BuildingTestEnvironment

```csharp
GridBuilding.Godot.Tests.Environments
class BuildingTestEnvironment
{
    // Members...
}
```

Test environment specifically for building system functionality
Provides setup and validation for building placement, state management, and manipulation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/BuildingTestEnvironment.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Environments`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Contexts

```csharp
#region Properties
    
    /// <summary>
    /// Core contexts for the building system
    /// </summary>
    public Contexts? Contexts { get; private set; }
```

Core contexts for the building system

### TestTileMap

```csharp
/// <summary>
    /// Test tile map layer for building placement
    /// </summary>
    public TileMapLayer? TestTileMap { get; private set; }
```

Test tile map layer for building placement

### PlacementSystem

```csharp
/// <summary>
    /// Building placement system
    /// </summary>
    public PlacementSystem? PlacementSystem { get; private set; }
```

Building placement system

### StateManager

```csharp
/// <summary>
    /// Building state manager
    /// </summary>
    public BuildingStateManager? StateManager { get; private set; }
```

Building state manager

### TestBuildings

```csharp
/// <summary>
    /// Test building data
    /// </summary>
    public List<TestBuildingData> TestBuildings { get; private set; } = new();
```

Test building data

### Config

```csharp
/// <summary>
    /// Configuration for the building test environment
    /// </summary>
    public BuildingTestConfig Config { get; set; } = new();
```

Configuration for the building test environment


## Methods

### SetupEnvironment

```csharp
#endregion
    
    #region Setup Methods
    
    /// <summary>
    /// Sets up the building test environment
    /// </summary>
    /// <returns>Validation result of the setup</returns>
    public ValidationResult SetupEnvironment()
    {
        var issues = new List<string>();
        
        try
        {
            // Create core contexts
            Contexts = new Contexts();
            
            // Setup tile map
            SetupTileMap();
            
            // Setup placement system
            SetupPlacementSystem();
            
            // Setup state manager
            SetupStateManager();
            
            // Create test building data
            CreateTestBuildingData();
            
            // Validate all systems
            issues.AddRange(ValidateSystems());
            
        }
        catch (System.Exception ex)
        {
            issues.Add($"Setup failed: {ex.Message}");
        }
        
        return ValidationResult.FromIssues(issues);
    }
```

Sets up the building test environment

**Returns:** `ValidationResult`

### ValidateBuildingPlacement

```csharp
/// <summary>
    /// Validates if a building can be placed at the specified position
    /// </summary>
    /// <param name="buildingData">Building data to validate</param>
    /// <param name="gridPosition">Grid position to validate</param>
    /// <returns>Validation result</returns>
    public ValidationResult ValidateBuildingPlacement(TestBuildingData buildingData, Vector2I gridPosition)
    {
        var issues = new List<string>();
        
        if (PlacementSystem == null)
        {
            issues.Add("PlacementSystem not available");
            return ValidationResult.FromIssues(issues);
        }
        
        // Check bounds
        if (!IsWithinGridBounds(buildingData.Size, gridPosition))
        {
            issues.Add("Building placement is outside grid bounds");
        }
        
        // Check collision if enabled
        if (Config.EnableCollisionChecking)
        {
            var collisionResult = CheckCollision(buildingData.Size, gridPosition);
            if (!collisionResult.IsValid)
            {
                issues.AddRange(collisionResult.Issues);
            }
        }
        
        // Check building limit
        if (StateManager != null && StateManager.GetBuildingCount() >= Config.MaxBuildings)
        {
            issues.Add("Maximum building limit reached");
        }
        
        return ValidationResult.FromIssues(issues);
    }
```

Validates if a building can be placed at the specified position

**Returns:** `ValidationResult`

**Parameters:**
- `TestBuildingData buildingData`
- `Vector2I gridPosition`

### PlaceBuilding

```csharp
#endregion
    
    #region Test Helper Methods
    
    /// <summary>
    /// Places a building for testing
    /// </summary>
    /// <param name="buildingId">ID of the building to place</param>
    /// <param name="gridPosition">Grid position to place at</param>
    /// <returns>Result of the placement operation</returns>
    public BuildingPlacementResult PlaceBuilding(string buildingId, Vector2I gridPosition)
    {
        var buildingData = TestBuildings.Find(b => b.Id == buildingId);
        if (buildingData == null)
            return BuildingPlacementResult.Failure($"Building with ID '{buildingId}' not found");
        
        // Validate placement
        var validation = ValidateBuildingPlacement(buildingData, gridPosition);
        if (!validation.IsValid)
            return BuildingPlacementResult.Failure(validation.GetCombinedMessage());
        
        // Place the building
        var placementResult = PlacementSystem?.TryPlaceAt(gridPosition);
        if (placementResult == null || !placementResult.IsValid)
            return BuildingPlacementResult.Failure("Placement system failed");
        
        // Update state manager
        if (StateManager != null)
        {
            StateManager.AddBuilding(new BuildingInstance
            {
                Id = buildingData.Id,
                Name = buildingData.Name,
                GridPosition = gridPosition,
                Size = buildingData.Size,
                BuildTime = buildingData.BuildTime
            });
        }
        
        return BuildingPlacementResult.Success(buildingData, gridPosition);
    }
```

Places a building for testing

**Returns:** `BuildingPlacementResult`

**Parameters:**
- `string buildingId`
- `Vector2I gridPosition`

### RemoveBuilding

```csharp
/// <summary>
    /// Removes a building for testing
    /// </summary>
    /// <param name="gridPosition">Grid position of the building to remove</param>
    /// <returns>True if building was removed</returns>
    public bool RemoveBuilding(Vector2I gridPosition)
    {
        if (StateManager == null)
            return false;
        
        var building = StateManager.GetBuildingAt(gridPosition);
        if (building == null)
            return false;
        
        StateManager.RemoveBuilding(building.Id);
        return true;
    }
```

Removes a building for testing

**Returns:** `bool`

**Parameters:**
- `Vector2I gridPosition`

### GetPlacedBuildings

```csharp
/// <summary>
    /// Gets all placed buildings
    /// </summary>
    /// <returns>List of placed buildings</returns>
    public List<BuildingInstance> GetPlacedBuildings()
    {
        if (StateManager == null)
            return new List<BuildingInstance>();
        
        return StateManager.GetAllBuildings();
    }
```

Gets all placed buildings

**Returns:** `List<BuildingInstance>`

### GetBuildingData

```csharp
/// <summary>
    /// Gets building data by ID
    /// </summary>
    /// <param name="buildingId">Building ID</param>
    /// <returns>Building data if found</returns>
    public TestBuildingData? GetBuildingData(string buildingId)
    {
        return TestBuildings.Find(b => b.Id == buildingId);
    }
```

Gets building data by ID

**Returns:** `TestBuildingData?`

**Parameters:**
- `string buildingId`

### SimulateConstruction

```csharp
/// <summary>
    /// Simulates building construction progress
    /// </summary>
    /// <param name="buildingId">Building ID</param>
    /// <param name="deltaTime">Time delta</param>
    public void SimulateConstruction(string buildingId, float deltaTime)
    {
        if (StateManager == null)
            return;
        
        StateManager.UpdateConstruction(buildingId, deltaTime);
    }
```

Simulates building construction progress

**Returns:** `void`

**Parameters:**
- `string buildingId`
- `float deltaTime`

### CleanupEnvironment

```csharp
#endregion
    
    #region Cleanup Methods
    
    /// <summary>
    /// Cleans up the building test environment
    /// </summary>
    public void CleanupEnvironment()
    {
        // Dispose contexts
        Contexts?.Dispose();
        Contexts = null;
        
        // Remove all children
        foreach (Node child in GetChildren())
        {
            child.QueueFree();
        }
        
        // Clear references
        TestTileMap = null;
        PlacementSystem = null;
        StateManager = null;
        TestBuildings.Clear();
    }
```

Cleans up the building test environment

**Returns:** `void`

