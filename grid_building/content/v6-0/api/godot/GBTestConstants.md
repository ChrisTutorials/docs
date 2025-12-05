---
title: "GBTestConstants"
description: "C# implementation of GBTestConstants for test configuration and constants
Provides centralized test paths, scene paths, and test configuration values
Ported from: godot/addons/grid_building/test/grid_building/helpers/gb_test_constants.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gbtestconstants/"
---

# GBTestConstants

```csharp
GridBuilding.Godot.Test.Utils
class GBTestConstants
{
    // Members...
}
```

C# implementation of GBTestConstants for test configuration and constants
Provides centralized test paths, scene paths, and test configuration values
Ported from: godot/addons/grid_building/test/grid_building/helpers/gb_test_constants.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GBTestConstants.cs`  
**Namespace:** `GridBuilding.Godot.Test.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetTestScenePath

```csharp
#endregion

    #region Utility Methods

    /// <summary>
    /// Gets the full path to a test scene
    /// </summary>
    /// <param name="sceneName">Name of the scene</param>
    /// <returns>Full resource path</returns>
    public static string GetTestScenePath(string sceneName)
    {
        return $"res://addons/grid_building/test/environments/{sceneName}.tscn";
    }
```

Gets the full path to a test scene

**Returns:** `string`

**Parameters:**
- `string sceneName`

### GetTestDataPath

```csharp
/// <summary>
    /// Gets the full path to test data
    /// </summary>
    /// <param name="fileName">Name of the data file</param>
    /// <returns>Full resource path</returns>
    public static string GetTestDataPath(string fileName)
    {
        return $"res://addons/grid_building/test/data/{fileName}";
    }
```

Gets the full path to test data

**Returns:** `string`

**Parameters:**
- `string fileName`

### GetTestCollisionShapePath

```csharp
/// <summary>
    /// Gets the full path to a test collision shape
    /// </summary>
    /// <param name="shapeName">Name of the collision shape</param>
    /// <returns>Full resource path</returns>
    public static string GetTestCollisionShapePath(string shapeName)
    {
        return $"{TestCollisionShapesDir}{shapeName}.tres";
    }
```

Gets the full path to a test collision shape

**Returns:** `string`

**Parameters:**
- `string shapeName`

### GetTestBuildingPath

```csharp
/// <summary>
    /// Gets the full path to a test building definition
    /// </summary>
    /// <param name="buildingName">Name of the building</param>
    /// <returns>Full resource path</returns>
    public static string GetTestBuildingPath(string buildingName)
    {
        return $"{TestBuildingsDir}{buildingName}.tres";
    }
```

Gets the full path to a test building definition

**Returns:** `string`

**Parameters:**
- `string buildingName`

### ValidateTestEnvironment

```csharp
/// <summary>
    /// Validates that a test environment is properly set up
    /// </summary>
    /// <param name="environment">Test environment to validate</param>
    /// <returns>List of validation issues</returns>
    public static List<string> ValidateTestEnvironment(Node environment)
    {
        var issues = new List<string>();

        if (environment == null)
        {
            issues.Add("Test environment is null");
            return issues;
        }

        // Check for critical nodes
        var criticalPaths = new[]
        {
            NodePaths.World,
            NodePaths.Level,
            NodePaths.GroundLayer,
            NodePaths.ObjectsLayer,
            NodePaths.InjectorSystem
        };

        foreach (var path in criticalPaths)
        {
            var node = environment.GetNodeOrNull(path);
            if (node == null)
            {
                issues.Add($"Critical node not found: {path}");
            }
        }

        return issues;
    }
```

Validates that a test environment is properly set up

**Returns:** `List<string>`

**Parameters:**
- `Node environment`

### CreateStandardTestConfig

```csharp
/// <summary>
    /// Creates a standard test configuration
    /// </summary>
    /// <returns>Dictionary with standard test settings</returns>
    public static Dictionary<string, Variant> CreateStandardTestConfig()
    {
        return new Dictionary<string, Variant>
        {
            ["tile_size"] = DefaultTileSize,
            ["grid_size"] = Variant.From(Vector2I.One * 10),
            ["test_timeout"] = DefaultTestTimeout,
            ["frame_simulation_count"] = DefaultFrameSimulationCount,
            ["verbose_output"] = VerboseOutput,
            ["enable_debug_drawing"] = EnableDebugDrawing
        };
    }
```

Creates a standard test configuration

**Returns:** `Dictionary<string, Variant>`

