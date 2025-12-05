---
title: "EnvironmentValidationUtils"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/environmentvalidationutils/"
---

# EnvironmentValidationUtils

```csharp
GridBuilding.Godot.Tests.Utils
class EnvironmentValidationUtils
{
    // Members...
}
```

Utility class for validating test environments and their components
Provides comprehensive validation methods for test infrastructure

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/EnvironmentValidationUtils.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ValidateAllSystemsEnvironment

```csharp
#region Environment Validation
    
    /// <summary>
    /// Validates an AllSystemsTestEnvironment
    /// </summary>
    /// <param name="environment">Environment to validate</param>
    /// <returns>Detailed validation result</returns>
    public static EnvironmentValidationResult ValidateAllSystemsEnvironment(AllSystemsTestEnvironment environment)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        var componentStatus = new Dictionary<string, bool>();
        
        if (environment == null)
        {
            issues.Add("AllSystemsTestEnvironment is null");
            return new EnvironmentValidationResult
            {
                IsValid = false,
                Issues = issues,
                Warnings = warnings,
                ComponentStatus = componentStatus
            };
        }
        
        // Validate contexts
        var contextValidation = ValidateContexts(environment.Contexts);
        issues.AddRange(contextValidation.Issues);
        warnings.AddRange(contextValidation.Warnings);
        componentStatus["Contexts"] = contextValidation.IsValid;
        
        // Validate tile map
        var tileMapValidation = ValidateTileMap(environment.TestTileMap);
        issues.AddRange(tileMapValidation.Issues);
        warnings.AddRange(tileMapValidation.Warnings);
        componentStatus["TestTileMap"] = tileMapValidation.IsValid;
        
        // Validate placement system
        var placementValidation = ValidatePlacementSystem(environment.PlacementSystem);
        issues.AddRange(placementValidation.Issues);
        warnings.AddRange(placementValidation.Warnings);
        componentStatus["PlacementSystem"] = placementValidation.IsValid;
        
        // Validate targeting system
        var targetingValidation = ValidateTargetingSystem(environment.TargetingSystem);
        issues.AddRange(targetingValidation.Issues);
        warnings.AddRange(targetingValidation.Warnings);
        componentStatus["TargetingSystem"] = targetingValidation.IsValid;
        
        // Validate UI components
        var uiValidation = ValidateUIComponents(environment.ActionLog);
        issues.AddRange(uiValidation.Issues);
        warnings.AddRange(uiValidation.Warnings);
        componentStatus["UI"] = uiValidation.IsValid;
        
        // Validate camera
        var cameraValidation = ValidateCamera(environment.TestCamera);
        issues.AddRange(cameraValidation.Issues);
        warnings.AddRange(cameraValidation.Warnings);
        componentStatus["Camera"] = cameraValidation.IsValid;
        
        return new EnvironmentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings,
            ComponentStatus = componentStatus
        };
    }
```

Validates an AllSystemsTestEnvironment

**Returns:** `EnvironmentValidationResult`

**Parameters:**
- `AllSystemsTestEnvironment environment`

### ValidateBuildingEnvironment

```csharp
/// <summary>
    /// Validates a BuildingTestEnvironment
    /// </summary>
    /// <param name="environment">Environment to validate</param>
    /// <returns>Detailed validation result</returns>
    public static EnvironmentValidationResult ValidateBuildingEnvironment(BuildingTestEnvironment environment)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        var componentStatus = new Dictionary<string, bool>();
        
        if (environment == null)
        {
            issues.Add("BuildingTestEnvironment is null");
            return new EnvironmentValidationResult
            {
                IsValid = false,
                Issues = issues,
                Warnings = warnings,
                ComponentStatus = componentStatus
            };
        }
        
        // Validate contexts
        var contextValidation = ValidateContexts(environment.Contexts);
        issues.AddRange(contextValidation.Issues);
        warnings.AddRange(contextValidation.Warnings);
        componentStatus["Contexts"] = contextValidation.IsValid;
        
        // Validate tile map
        var tileMapValidation = ValidateTileMap(environment.TestTileMap);
        issues.AddRange(tileMapValidation.Issues);
        warnings.AddRange(tileMapValidation.Warnings);
        componentStatus["TestTileMap"] = tileMapValidation.IsValid;
        
        // Validate placement system
        var placementValidation = ValidatePlacementSystem(environment.PlacementSystem);
        issues.AddRange(placementValidation.Issues);
        warnings.AddRange(placementValidation.Warnings);
        componentStatus["PlacementSystem"] = placementValidation.IsValid;
        
        // Validate building state manager
        var stateManagerValidation = ValidateBuildingStateManager(environment.BuildingStateManager);
        issues.AddRange(stateManagerValidation.Issues);
        warnings.AddRange(stateManagerValidation.Warnings);
        componentStatus["BuildingStateManager"] = stateManagerValidation.IsValid;
        
        // Validate test building data
        var buildingDataValidation = ValidateTestBuildingData(environment.TestBuildings);
        issues.AddRange(buildingDataValidation.Issues);
        warnings.AddRange(buildingDataValidation.Warnings);
        componentStatus["TestBuildingData"] = buildingDataValidation.IsValid;
        
        return new EnvironmentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings,
            ComponentStatus = componentStatus
        };
    }
```

Validates a BuildingTestEnvironment

**Returns:** `EnvironmentValidationResult`

**Parameters:**
- `BuildingTestEnvironment environment`

### ValidateCollisionEnvironment

```csharp
/// <summary>
    /// Validates a CollisionTestEnvironment
    /// </summary>
    /// <param name="environment">Environment to validate</param>
    /// <returns>Detailed validation result</returns>
    public static EnvironmentValidationResult ValidateCollisionEnvironment(CollisionTestEnvironment environment)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        var componentStatus = new Dictionary<string, bool>();
        
        if (environment == null)
        {
            issues.Add("CollisionTestEnvironment is null");
            return new EnvironmentValidationResult
            {
                IsValid = false,
                Issues = issues,
                Warnings = warnings,
                ComponentStatus = componentStatus
            };
        }
        
        // Validate contexts
        var contextValidation = ValidateContexts(environment.Contexts);
        issues.AddRange(contextValidation.Issues);
        warnings.AddRange(contextValidation.Warnings);
        componentStatus["Contexts"] = contextValidation.IsValid;
        
        // Validate tile map
        var tileMapValidation = ValidateTileMap(environment.TestTileMap);
        issues.AddRange(tileMapValidation.Issues);
        warnings.AddRange(tileMapValidation.Warnings);
        componentStatus["TestTileMap"] = tileMapValidation.IsValid;
        
        // Validate scenario builder
        var scenarioBuilderValidation = ValidateScenarioBuilder(environment.ScenarioBuilder);
        issues.AddRange(scenarioBuilderValidation.Issues);
        warnings.AddRange(scenarioBuilderValidation.Warnings);
        componentStatus["ScenarioBuilder"] = scenarioBuilderValidation.IsValid;
        
        // Validate collision processor
        var processorValidation = ValidateCollisionProcessor(environment.CollisionProcessor);
        issues.AddRange(processorValidation.Issues);
        warnings.AddRange(processorValidation.Warnings);
        componentStatus["CollisionProcessor"] = processorValidation.IsValid;
        
        // Validate test collision objects
        var collisionObjectsValidation = ValidateTestCollisionObjects(environment.TestCollisionObjects);
        issues.AddRange(collisionObjectsValidation.Issues);
        warnings.AddRange(collisionObjectsValidation.Warnings);
        componentStatus["TestCollisionObjects"] = collisionObjectsValidation.IsValid;
        
        // Validate test scenarios
        var scenariosValidation = ValidateTestScenarios(environment.TestScenarios);
        issues.AddRange(scenariosValidation.Issues);
        warnings.AddRange(scenariosValidation.Warnings);
        componentStatus["TestScenarios"] = scenariosValidation.IsValid;
        
        return new EnvironmentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings,
            ComponentStatus = componentStatus
        };
    }
```

Validates a CollisionTestEnvironment

**Returns:** `EnvironmentValidationResult`

**Parameters:**
- `CollisionTestEnvironment environment`

### ValidateContexts

```csharp
#endregion
    
    #region Component Validation
    
    /// <summary>
    /// Validates Contexts
    /// </summary>
    public static ComponentValidationResult ValidateContexts(Contexts? contexts)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        
        if (contexts == null)
        {
            issues.Add("Contexts is null");
            return new ComponentValidationResult
            {
                IsValid = false,
                Issues = issues,
                Warnings = warnings
            };
        }
        
        // Validate runtime validation
        var runtimeValidation = contexts.GetRuntimeValidation();
        issues.AddRange(runtimeValidation.Issues);
        warnings.AddRange(runtimeValidation.Warnings);
        
        // Check for essential contexts
        if (contexts.PlacementContext == null)
            issues.Add("PlacementContext is null");
        if (contexts.TargetingContext == null)
            issues.Add("TargetingContext is null");
        if (contexts.CollisionContext == null)
            warnings.Add("CollisionContext is null (may be intentional)");
        
        return new ComponentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings
        };
    }
```

Validates Contexts

**Returns:** `ComponentValidationResult`

**Parameters:**
- `Contexts? contexts`

### ValidateTileMap

```csharp
/// <summary>
    /// Validates a TileMapLayer
    /// </summary>
    public static ComponentValidationResult ValidateTileMap(TileMapLayer? tileMap)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        
        if (tileMap == null)
        {
            issues.Add("TileMap is null");
            return new ComponentValidationResult
            {
                IsValid = false,
                Issues = issues,
                Warnings = warnings
            };
        }
        
        if (tileMap.TileSet == null)
            issues.Add("TileMap has no TileSet");
        else if (tileMap.TileSet.GetSourceCount() == 0)
            warnings.Add("TileMap TileSet has no sources");
        
        // Check for tiles
        var usedCells = tileMap.GetUsedCells();
        if (usedCells.Count == 0)
            warnings.Add("TileMap has no placed tiles");
        
        return new ComponentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings
        };
    }
```

Validates a TileMapLayer

**Returns:** `ComponentValidationResult`

**Parameters:**
- `TileMapLayer? tileMap`

### ValidatePlacementSystem

```csharp
/// <summary>
    /// Validates a PlacementSystem
    /// </summary>
    public static ComponentValidationResult ValidatePlacementSystem(GridBuilding.Godot.Systems.Placement.PlacementSystem? placementSystem)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        
        if (placementSystem == null)
        {
            issues.Add("PlacementSystem is null");
            return new ComponentValidationResult
            {
                IsValid = false,
                Issues = issues,
                Warnings = warnings
            };
        }
        
        if (!placementSystem.IsConfigured())
            issues.Add("PlacementSystem is not properly configured");
        
        if (placementSystem.Contexts == null)
            issues.Add("PlacementSystem has no Contexts");
        
        if (placementSystem.TileMap == null)
            issues.Add("PlacementSystem has no TileMap");
        
        if (placementSystem.TileSize == Vector2.Zero)
            issues.Add("PlacementSystem has invalid TileSize");
        
        return new ComponentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings
        };
    }
```

Validates a PlacementSystem

**Returns:** `ComponentValidationResult`

**Parameters:**
- `GridBuilding.Godot.Systems.Placement.PlacementSystem? placementSystem`

### ValidateTargetingSystem

```csharp
/// <summary>
    /// Validates a TargetingSystem
    /// </summary>
    public static ComponentValidationResult ValidateTargetingSystem(GridBuilding.Godot.Targeting.TargetingSystem? targetingSystem)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        
        if (targetingSystem == null)
        {
            issues.Add("TargetingSystem is null");
            return new ComponentValidationResult
            {
                IsValid = false,
                Issues = issues,
                Warnings = warnings
            };
        }
        
        if (targetingSystem.Contexts == null)
            issues.Add("TargetingSystem has no Contexts");
        
        if (targetingSystem.TileMap == null)
            issues.Add("TargetingSystem has no TileMap");
        
        return new ComponentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings
        };
    }
```

Validates a TargetingSystem

**Returns:** `ComponentValidationResult`

**Parameters:**
- `GridBuilding.Godot.Targeting.TargetingSystem? targetingSystem`

### ValidateUIComponents

```csharp
/// <summary>
    /// Validates UI components
    /// </summary>
    public static ComponentValidationResult ValidateUIComponents(GridBuilding.Godot.UI.GBActionLog? actionLog)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        
        if (actionLog == null)
        {
            warnings.Add("ActionLog is null (may be intentional)");
            return new ComponentValidationResult
            {
                IsValid = true, // UI components are optional
                Issues = issues,
                Warnings = warnings
            };
        }
        
        if (actionLog.MaxEntries <= 0)
            warnings.Add("ActionLog has invalid MaxEntries");
        
        return new ComponentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings
        };
    }
```

Validates UI components

**Returns:** `ComponentValidationResult`

**Parameters:**
- `GridBuilding.Godot.UI.GBActionLog? actionLog`

### ValidateCamera

```csharp
/// <summary>
    /// Validates a Camera2D
    /// </summary>
    public static ComponentValidationResult ValidateCamera(Camera2D? camera)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        
        if (camera == null)
        {
            warnings.Add("Camera is null (may be intentional)");
            return new ComponentValidationResult
            {
                IsValid = true, // Camera is optional
                Issues = issues,
                Warnings = warnings
            };
        }
        
        if (camera.Zoom.X <= 0 || camera.Zoom.Y <= 0)
            warnings.Add("Camera has invalid zoom values");
        
        return new ComponentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings
        };
    }
```

Validates a Camera2D

**Returns:** `ComponentValidationResult`

**Parameters:**
- `Camera2D? camera`

### ValidateBuildingStateManager

```csharp
/// <summary>
    /// Validates a BuildingStateManager
    /// </summary>
    public static ComponentValidationResult ValidateBuildingStateManager(GridBuilding.Godot.Systems.Building.BuildingStateManager? stateManager)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        
        if (stateManager == null)
        {
            issues.Add("BuildingStateManager is null");
            return new ComponentValidationResult
            {
                IsValid = false,
                Issues = issues,
                Warnings = warnings
            };
        }
        
        if (stateManager.Contexts == null)
            issues.Add("BuildingStateManager has no Contexts");
        
        return new ComponentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings
        };
    }
```

Validates a BuildingStateManager

**Returns:** `ComponentValidationResult`

**Parameters:**
- `GridBuilding.Godot.Systems.Building.BuildingStateManager? stateManager`

### ValidateTestBuildingData

```csharp
/// <summary>
    /// Validates test building data
    /// </summary>
    public static ComponentValidationResult ValidateTestBuildingData(List<BuildingTestEnvironment.TestBuildingData> testBuildings)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        
        if (testBuildings == null || testBuildings.Count == 0)
        {
            warnings.Add("No test building data available");
            return new ComponentValidationResult
            {
                IsValid = true, // Test data is optional
                Issues = issues,
                Warnings = warnings
            };
        }
        
        foreach (var building in testBuildings)
        {
            if (string.IsNullOrEmpty(building.BuildingId))
                issues.Add("Test building has no BuildingId");
            
            if (building.Size == Vector2I.Zero)
                issues.Add($"Test building {building.BuildingId} has invalid Size");
            
            if (building.BuildingType == null)
                warnings.Add($"Test building {building.BuildingId} has no BuildingType");
        }
        
        return new ComponentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings
        };
    }
```

Validates test building data

**Returns:** `ComponentValidationResult`

**Parameters:**
- `List<BuildingTestEnvironment.TestBuildingData> testBuildings`

### ValidateScenarioBuilder

```csharp
/// <summary>
    /// Validates a CollisionScenarioBuilder
    /// </summary>
    public static ComponentValidationResult ValidateScenarioBuilder(GridBuilding.Godot.Systems.Placement.Utilities.CollisionScenarioBuilder2D? scenarioBuilder)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        
        if (scenarioBuilder == null)
        {
            issues.Add("ScenarioBuilder is null");
            return new ComponentValidationResult
            {
                IsValid = false,
                Issues = issues,
                Warnings = warnings
            };
        }
        
        if (scenarioBuilder.ShapeStretchSize == Vector2.Zero)
            warnings.Add("ScenarioBuilder has invalid ShapeStretchSize");
        
        return new ComponentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings
        };
    }
```

Validates a CollisionScenarioBuilder

**Returns:** `ComponentValidationResult`

**Parameters:**
- `GridBuilding.Godot.Systems.Placement.Utilities.CollisionScenarioBuilder2D? scenarioBuilder`

### ValidateCollisionProcessor

```csharp
/// <summary>
    /// Validates a CollisionProcessor
    /// </summary>
    public static ComponentValidationResult ValidateCollisionProcessor(GridBuilding.Godot.Systems.Placement.Processors.CollisionProcessor? collisionProcessor)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        
        if (collisionProcessor == null)
        {
            issues.Add("CollisionProcessor is null");
            return new ComponentValidationResult
            {
                IsValid = false,
                Issues = issues,
                Warnings = warnings
            };
        }
        
        if (!collisionProcessor.IsConfigured())
            issues.Add("CollisionProcessor is not properly configured");
        
        if (collisionProcessor.Contexts == null)
            issues.Add("CollisionProcessor has no Contexts");
        
        if (collisionProcessor.TileMap == null)
            issues.Add("CollisionProcessor has no TileMap");
        
        return new ComponentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings
        };
    }
```

Validates a CollisionProcessor

**Returns:** `ComponentValidationResult`

**Parameters:**
- `GridBuilding.Godot.Systems.Placement.Processors.CollisionProcessor? collisionProcessor`

### ValidateTestCollisionObjects

```csharp
/// <summary>
    /// Validates test collision objects
    /// </summary>
    public static ComponentValidationResult ValidateTestCollisionObjects(List<CollisionObject2D> testCollisionObjects)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        
        if (testCollisionObjects == null || testCollisionObjects.Count == 0)
        {
            warnings.Add("No test collision objects available");
            return new ComponentValidationResult
            {
                IsValid = true, // Test objects are optional
                Issues = issues,
                Warnings = warnings
            };
        }
        
        foreach (var collisionObj in testCollisionObjects)
        {
            if (collisionObj == null)
            {
                issues.Add("Test collision object is null");
                continue;
            }
            
            var shapes = collisionObj.GetChildren();
            bool hasValidShape = false;
            
            foreach (var child in shapes)
            {
                if (child is CollisionShape2D collisionShape)
                {
                    if (collisionShape.Shape != null)
                    {
                        hasValidShape = true;
                    }
                    else
                    {
                        warnings.Add($"CollisionShape2D in {collisionObj.Name} has no Shape");
                    }
                }
            }
            
            if (!hasValidShape)
            {
                issues.Add($"CollisionObject2D {collisionObj.Name} has no valid shapes");
            }
        }
        
        return new ComponentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings
        };
    }
```

Validates test collision objects

**Returns:** `ComponentValidationResult`

**Parameters:**
- `List<CollisionObject2D> testCollisionObjects`

### ValidateTestScenarios

```csharp
/// <summary>
    /// Validates test scenarios
    /// </summary>
    public static ComponentValidationResult ValidateTestScenarios(List<CollisionTestEnvironment.TestCollisionScenario> testScenarios)
    {
        var issues = new List<string>();
        var warnings = new List<string>();
        
        if (testScenarios == null || testScenarios.Count == 0)
        {
            warnings.Add("No test scenarios available");
            return new ComponentValidationResult
            {
                IsValid = true, // Test scenarios are optional
                Issues = issues,
                Warnings = warnings
            };
        }
        
        foreach (var scenario in testScenarios)
        {
            if (string.IsNullOrEmpty(scenario.Name))
                issues.Add("Test scenario has no Name");
            
            if (scenario.TestObjects == null || scenario.TestObjects.Length == 0)
                issues.Add($"Test scenario {scenario.Name} has no TestObjects");
            
            if (scenario.ExpectedCollisionCount < 0)
                issues.Add($"Test scenario {scenario.Name} has invalid ExpectedCollisionCount");
        }
        
        return new ComponentValidationResult
        {
            IsValid = issues.Count == 0,
            Issues = issues,
            Warnings = warnings
        };
    }
```

Validates test scenarios

**Returns:** `ComponentValidationResult`

**Parameters:**
- `List<CollisionTestEnvironment.TestCollisionScenario> testScenarios`

### ValidateMultipleEnvironments

```csharp
#endregion
    
    #region Batch Validation
    
    /// <summary>
    /// Validates multiple environments
    /// </summary>
    /// <param name="environments">Dictionary of environments to validate</param>
    /// <returns>Dictionary of validation results by environment name</returns>
    public static Dictionary<string, EnvironmentValidationResult> ValidateMultipleEnvironments(
        Dictionary<string, Node> environments)
    {
        var results = new Dictionary<string, EnvironmentValidationResult>();
        
        foreach (var kvp in environments)
        {
            var validation = ValidateEnvironment(kvp.Value);
            results[kvp.Key] = validation;
        }
        
        return results;
    }
```

Validates multiple environments

**Returns:** `Dictionary<string, EnvironmentValidationResult>`

**Parameters:**
- `Dictionary<string, Node> environments`

### ValidateEnvironment

```csharp
/// <summary>
    /// Validates any environment type
    /// </summary>
    /// <param name="environment">Environment to validate</param>
    /// <returns>Validation result</returns>
    public static EnvironmentValidationResult ValidateEnvironment(Node? environment)
    {
        if (environment is AllSystemsTestEnvironment allSystemsEnv)
            return ValidateAllSystemsEnvironment(allSystemsEnv);
        else if (environment is BuildingTestEnvironment buildingEnv)
            return ValidateBuildingEnvironment(buildingEnv);
        else if (environment is CollisionTestEnvironment collisionEnv)
            return ValidateCollisionEnvironment(collisionEnv);
        else
        {
            return new EnvironmentValidationResult
            {
                IsValid = false,
                Issues = new List<string> { $"Unknown environment type: {environment?.GetType().Name}" },
                Warnings = new List<string>(),
                ComponentStatus = new Dictionary<string, bool>()
            };
        }
    }
```

Validates any environment type

**Returns:** `EnvironmentValidationResult`

**Parameters:**
- `Node? environment`

