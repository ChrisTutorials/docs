---
title: "AllSystemsTestEnvironment"
description: "Comprehensive test environment for all GridBuilding systems
Provides integration testing setup for collision, placement, targeting, and UI systems"
weight: 20
url: "/gridbuilding/v6-0/api/godot/allsystemstestenvironment/"
---

# AllSystemsTestEnvironment

```csharp
GridBuilding.Godot.Tests.Environments
class AllSystemsTestEnvironment
{
    // Members...
}
```

Comprehensive test environment for all GridBuilding systems
Provides integration testing setup for collision, placement, targeting, and UI systems

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/AllSystemsTestEnvironment.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Environments`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Contexts

```csharp
#region Properties
    
    /// <summary>
    /// Core contexts for the grid building system
    /// </summary>
    public Contexts? Contexts { get; private set; }
```

Core contexts for the grid building system

### TestTileMap

```csharp
/// <summary>
    /// Test tile map layer for collision testing
    /// </summary>
    public TileMapLayer? TestTileMap { get; private set; }
```

Test tile map layer for collision testing

### PlacementSystem

```csharp
/// <summary>
    /// Test placement system
    /// </summary>
    public PlacementSystem? PlacementSystem { get; private set; }
```

Test placement system

### TargetingArea

```csharp
/// <summary>
    /// Test targeting area
    /// </summary>
    public TargetingArea2D? TargetingArea { get; private set; }
```

Test targeting area

### ActionLog

```csharp
/// <summary>
    /// Test action log for UI testing
    /// </summary>
    public GBActionLog? ActionLog { get; private set; }
```

Test action log for UI testing

### TestCamera

```csharp
/// <summary>
    /// Test camera for camera utilities testing
    /// </summary>
    public Camera2D? TestCamera { get; private set; }
```

Test camera for camera utilities testing

### Config

```csharp
/// <summary>
    /// Configuration for the test environment
    /// </summary>
    public TestEnvironmentConfig Config { get; set; } = new();
```

Configuration for the test environment


## Methods

### SetupEnvironment

```csharp
#endregion
    
    #region Setup Methods
    
    /// <summary>
    /// Sets up the complete test environment
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
            
            // Setup targeting system
            SetupTargetingSystem();
            
            // Setup UI components
            SetupUIComponents();
            
            // Setup camera
            SetupCamera();
            
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

Sets up the complete test environment

**Returns:** `ValidationResult`

### GetSystemStates

```csharp
/// <summary>
    /// Gets the current state of all systems for testing
    /// </summary>
    /// <returns>Dictionary containing system states</returns>
    public Dictionary<string, object> GetSystemStates()
    {
        var states = new Dictionary<string, object>();
        
        if (Contexts != null)
            states["ContextsValid"] = Contexts.GetRuntimeValidation().IsValid;
        
        if (TestTileMap != null)
            states["TileMapReady"] = TestTileMap.TileSet != null;
        
        if (PlacementSystem != null)
            states["PlacementSystemConfigured"] = PlacementSystem.IsConfigured();
        
        if (TargetingArea != null)
            states["TargetingAreaReady"] = true;
        
        if (ActionLog != null)
            states["ActionLogReady"] = true;
        
        if (TestCamera != null)
            states["CameraReady"] = true;
        
        return states;
    }
```

Gets the current state of all systems for testing

**Returns:** `Dictionary<string, object>`

### SimulatePlacement

```csharp
#endregion
    
    #region Test Helper Methods
    
    /// <summary>
    /// Simulates a placement operation for testing
    /// </summary>
    /// <param name="gridPosition">Grid position to place at</param>
    /// <returns>Result of the placement operation</returns>
    public PlacementResult SimulatePlacement(Vector2I gridPosition)
    {
        if (PlacementSystem == null)
            return PlacementResult.Failure("PlacementSystem not available");
        
        return PlacementSystem.TryPlaceAt(gridPosition);
    }
```

Simulates a placement operation for testing

**Returns:** `PlacementResult`

**Parameters:**
- `Vector2I gridPosition`

### SimulateTargeting

```csharp
/// <summary>
    /// Simulates a targeting operation for testing
    /// </summary>
    /// <param name="targetPosition">Target position</param>
    /// <returns>True if targeting succeeded</returns>
    public bool SimulateTargeting(Vector2 targetPosition)
    {
        if (TargetingArea == null)
            return false;
        
        TargetingArea.GlobalPosition = targetPosition;
        return TargetingArea.IsTargeting;
    }
```

Simulates a targeting operation for testing

**Returns:** `bool`

**Parameters:**
- `Vector2 targetPosition`

### LogTestAction

```csharp
/// <summary>
    /// Logs a test action for UI testing
    /// </summary>
    /// <param name="action">Action description</param>
    /// <param name="position">Action position</param>
    public void LogTestAction(string action, Vector2 position)
    {
        if (ActionLog != null)
        {
            ActionLog.LogAction(action, position);
        }
    }
```

Logs a test action for UI testing

**Returns:** `void`

**Parameters:**
- `string action`
- `Vector2 position`

### GetCameraUtilities

```csharp
/// <summary>
    /// Gets camera utilities for testing
    /// </summary>
    /// <returns>Camera utilities instance</returns>
    public GBCameraUtils GetCameraUtilities()
    {
        return new GBCameraUtils();
    }
```

Gets camera utilities for testing

**Returns:** `GBCameraUtils`

### CleanupEnvironment

```csharp
#endregion
    
    #region Cleanup Methods
    
    /// <summary>
    /// Cleans up the test environment
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
        TargetingArea = null;
        ActionLog = null;
        TestCamera = null;
    }
```

Cleans up the test environment

**Returns:** `void`

