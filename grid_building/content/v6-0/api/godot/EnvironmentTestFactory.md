---
title: "EnvironmentTestFactory"
description: "Factory for creating test environments for GridBuilding testing
Provides centralized creation and management of various test environments"
weight: 20
url: "/gridbuilding/v6-0/api/godot/environmenttestfactory/"
---

# EnvironmentTestFactory

```csharp
GridBuilding.Godot.Tests.Factories
class EnvironmentTestFactory
{
    // Members...
}
```

Factory for creating test environments for GridBuilding testing
Provides centralized creation and management of various test environments

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/EnvironmentTestFactory.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Factories`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Contexts

```csharp
#region Properties
    
    /// <summary>
    /// Core contexts for test environments
    /// </summary>
    public Contexts? Contexts { get; private set; }
```

Core contexts for test environments

### Config

```csharp
/// <summary>
    /// Configuration for environment creation
    /// </summary>
    public EnvironmentFactoryConfig Config { get; set; } = new();
```

Configuration for environment creation

### TestEnvironments

```csharp
/// <summary>
    /// Registry of created environments
    /// </summary>
    public Dictionary<string, Node> TestEnvironments { get; private set; } = new();
```

Registry of created environments

### DemoSceneFactory

```csharp
/// <summary>
    /// Demo scene factory for creating test scenes
    /// </summary>
    public DemoSceneFactory? DemoSceneFactory { get; private set; }
```

Demo scene factory for creating test scenes


## Methods

### CreateAllSystemsEnvironment

```csharp
#endregion
    
    #region Factory Methods
    
    /// <summary>
    /// Creates an all-systems test environment
    /// </summary>
    /// <param name="environmentName">Name of the environment</param>
    /// <param name="config">Optional configuration override</param>
    /// <returns>Created test environment</returns>
    public AllSystemsTestEnvironment CreateAllSystemsEnvironment(
        string environmentName = "AllSystemsTest", 
        AllSystemsTestEnvironment.TestEnvironmentConfig? config = null)
    {
        var environment = new AllSystemsTestEnvironment();
        environment.Name = environmentName;
        
        // Apply configuration
        if (config != null)
        {
            environment.Config = config;
        }
        else
        {
            environment.Config = new AllSystemsTestEnvironment.TestEnvironmentConfig
            {
                GridSize = Config.DefaultGridSize,
                TileSize = Config.DefaultTileSize,
                MaxLogEntries = Config.DefaultMaxLogEntries,
                AutoScroll = Config.DefaultAutoScroll
            };
        }
        
        // Set up the environment
        var setupResult = environment.SetupEnvironment();
        if (!setupResult.IsValid)
        {
            GD.PrintErr($"Failed to setup AllSystemsTestEnvironment: {setupResult.GetCombinedMessage()}");
        }
        
        // Register environment
        TestEnvironments[environmentName] = environment;
        
        return environment;
    }
```

Creates an all-systems test environment

**Returns:** `AllSystemsTestEnvironment`

**Parameters:**
- `string environmentName`
- `AllSystemsTestEnvironment.TestEnvironmentConfig? config`

### CreateBuildingEnvironment

```csharp
/// <summary>
    /// Creates a building test environment
    /// </summary>
    /// <param name="environmentName">Name of the environment</param>
    /// <param name="config">Optional configuration override</param>
    /// <returns>Created test environment</returns>
    public BuildingTestEnvironment CreateBuildingEnvironment(
        string environmentName = "BuildingTest", 
        BuildingTestEnvironment.BuildingTestConfig? config = null)
    {
        var environment = new BuildingTestEnvironment();
        environment.Name = environmentName;
        
        // Apply configuration
        if (config != null)
        {
            environment.Config = config;
        }
        else
        {
            environment.Config = new BuildingTestEnvironment.BuildingTestConfig
            {
                GridSize = Config.DefaultGridSize,
                TileSize = Config.DefaultTileSize,
                EnableCollisionChecking = Config.DefaultCollisionChecking,
                MaxBuildings = Config.DefaultMaxBuildings
            };
        }
        
        // Set up the environment
        var setupResult = environment.SetupEnvironment();
        if (!setupResult.IsValid)
        {
            GD.PrintErr($"Failed to setup BuildingTestEnvironment: {setupResult.GetCombinedMessage()}");
        }
        
        // Register environment
        TestEnvironments[environmentName] = environment;
        
        return environment;
    }
```

Creates a building test environment

**Returns:** `BuildingTestEnvironment`

**Parameters:**
- `string environmentName`
- `BuildingTestEnvironment.BuildingTestConfig? config`

### CreateCollisionEnvironment

```csharp
/// <summary>
    /// Creates a collision test environment
    /// </summary>
    /// <param name="environmentName">Name of the environment</param>
    /// <param name="config">Optional configuration override</param>
    /// <returns>Created test environment</returns>
    public CollisionTestEnvironment CreateCollisionEnvironment(
        string environmentName = "CollisionTest", 
        CollisionTestEnvironment.CollisionTestConfig? config = null)
    {
        var environment = new CollisionTestEnvironment();
        environment.Name = environmentName;
        
        // Apply configuration
        if (config != null)
        {
            environment.Config = config;
        }
        else
        {
            environment.Config = new CollisionTestEnvironment.CollisionTestConfig
            {
                GridSize = Config.DefaultGridSize,
                TileSize = Config.DefaultTileSize,
                EnablePerformanceTesting = Config.DefaultPerformanceTesting,
                DefaultPerformanceIterations = Config.DefaultPerformanceIterations
            };
        }
        
        // Set up the environment
        var setupResult = environment.SetupEnvironment();
        if (!setupResult.IsValid)
        {
            GD.PrintErr($"Failed to setup CollisionTestEnvironment: {setupResult.GetCombinedMessage()}");
        }
        
        // Register environment
        TestEnvironments[environmentName] = environment;
        
        return environment;
    }
```

Creates a collision test environment

**Returns:** `CollisionTestEnvironment`

**Parameters:**
- `string environmentName`
- `CollisionTestEnvironment.CollisionTestConfig? config`

### CreateComprehensiveTestSuite

```csharp
/// <summary>
    /// Creates a comprehensive test suite with all environments
    /// </summary>
    /// <param name="suiteName">Name of the test suite</param>
    /// <returns>Container node with all test environments</returns>
    public Node CreateComprehensiveTestSuite(string suiteName = "ComprehensiveTestSuite")
    {
        var suite = new Node();
        suite.Name = suiteName;
        
        // Create all environments
        var allSystemsEnv = CreateAllSystemsEnvironment($"{suiteName}_AllSystems");
        suite.AddChild(allSystemsEnv);
        
        var buildingEnv = CreateBuildingEnvironment($"{suiteName}_Building");
        suite.AddChild(buildingEnv);
        
        var collisionEnv = CreateCollisionEnvironment($"{suiteName}_Collision");
        suite.AddChild(collisionEnv);
        
        // Create demo scenes for testing
        if (DemoSceneFactory != null)
        {
            var basicDemo = DemoSceneFactory.CreateBasicPlacementDemo($"{suiteName}_BasicDemo");
            suite.AddChild(basicDemo);
            
            var collisionDemo = DemoSceneFactory.CreateCollisionDemo($"{suiteName}_CollisionDemo");
            suite.AddChild(collisionDemo);
            
            var targetingDemo = DemoSceneFactory.CreateTargetingDemo($"{suiteName}_TargetingDemo");
            suite.AddChild(targetingDemo);
            
            var pathfindingDemo = DemoSceneFactory.CreatePathfindingDemo($"{suiteName}_PathfindingDemo");
            suite.AddChild(pathfindingDemo);
        }
        
        // Register suite
        TestEnvironments[suiteName] = suite;
        
        return suite;
    }
```

Creates a comprehensive test suite with all environments

**Returns:** `Node`

**Parameters:**
- `string suiteName`

### CreateMinimalEnvironment

```csharp
/// <summary>
    /// Creates a minimal test environment for quick testing
    /// </summary>
    /// <param name="environmentName">Name of the environment</param>
    /// <returns>Created minimal test environment</returns>
    public AllSystemsTestEnvironment CreateMinimalEnvironment(string environmentName = "MinimalTest")
    {
        var minimalConfig = new AllSystemsTestEnvironment.TestEnvironmentConfig
        {
            GridSize = new Vector2I(5, 5),
            TileSize = new Vector2(16, 16),
            MaxLogEntries = 10,
            AutoScroll = false
        };
        
        return CreateAllSystemsEnvironment(environmentName, minimalConfig);
    }
```

Creates a minimal test environment for quick testing

**Returns:** `AllSystemsTestEnvironment`

**Parameters:**
- `string environmentName`

### CreatePerformanceEnvironment

```csharp
/// <summary>
    /// Creates a performance-focused test environment
    /// </summary>
    /// <param name="environmentName">Name of the environment</param>
    /// <returns>Created performance test environment</returns>
    public CollisionTestEnvironment CreatePerformanceEnvironment(string environmentName = "PerformanceTest")
    {
        var performanceConfig = new CollisionTestEnvironment.CollisionTestConfig
        {
            GridSize = new Vector2I(50, 50),
            TileSize = new Vector2(32, 32),
            EnablePerformanceTesting = true,
            DefaultPerformanceIterations = 5000
        };
        
        return CreateCollisionEnvironment(environmentName, performanceConfig);
    }
```

Creates a performance-focused test environment

**Returns:** `CollisionTestEnvironment`

**Parameters:**
- `string environmentName`

### GetTestEnvironment

```csharp
#endregion
    
    #region Environment Management
    
    /// <summary>
    /// Gets a test environment by name
    /// </summary>
    /// <param name="environmentName">Name of the environment</param>
    /// <returns>Environment if found, null otherwise</returns>
    public Node? GetTestEnvironment(string environmentName)
    {
        return TestEnvironments.TryGetValue(environmentName, out var environment) ? environment : null;
    }
```

Gets a test environment by name

**Returns:** `Node?`

**Parameters:**
- `string environmentName`

### GetTestEnvironment

```csharp
/// <summary>
    /// Gets a test environment by type
    /// </summary>
    /// <typeparam name="T">Type of the environment</typeparam>
    /// <param name="environmentName">Name of the environment</param>
    /// <returns>Environment if found and of correct type, null otherwise</returns>
    public T? GetTestEnvironment<T>(string environmentName) where T : Node
    {
        var environment = GetTestEnvironment(environmentName);
        return environment as T;
    }
```

Gets a test environment by type

**Returns:** `T?`

**Parameters:**
- `string environmentName`

### RemoveTestEnvironment

```csharp
/// <summary>
    /// Removes a test environment
    /// </summary>
    /// <param name="environmentName">Name of the environment to remove</param>
    /// <returns>True if environment was removed</returns>
    public bool RemoveTestEnvironment(string environmentName)
    {
        if (TestEnvironments.TryGetValue(environmentName, out var environment))
        {
            // Cleanup specific environment
            if (environment is AllSystemsTestEnvironment allSystemsEnv)
            {
                allSystemsEnv.CleanupEnvironment();
            }
            else if (environment is BuildingTestEnvironment buildingEnv)
            {
                buildingEnv.CleanupEnvironment();
            }
            else if (environment is CollisionTestEnvironment collisionEnv)
            {
                collisionEnv.CleanupEnvironment();
            }
            
            environment.QueueFree();
            TestEnvironments.Remove(environmentName);
            return true;
        }
        return false;
    }
```

Removes a test environment

**Returns:** `bool`

**Parameters:**
- `string environmentName`

### ClearAllTestEnvironments

```csharp
/// <summary>
    /// Clears all test environments
    /// </summary>
    public void ClearAllTestEnvironments()
    {
        var environmentNames = new List<string>(TestEnvironments.Keys);
        foreach (var name in environmentNames)
        {
            RemoveTestEnvironment(name);
        }
    }
```

Clears all test environments

**Returns:** `void`

### GetTestEnvironmentNames

```csharp
/// <summary>
    /// Gets all test environment names
    /// </summary>
    /// <returns>List of test environment names</returns>
    public List<string> GetTestEnvironmentNames()
    {
        return new List<string>(TestEnvironments.Keys);
    }
```

Gets all test environment names

**Returns:** `List<string>`

### GetTestEnvironmentsByType

```csharp
/// <summary>
    /// Gets test environments by type
    /// </summary>
    /// <typeparam name="T">Type of environments to get</typeparam>
    /// <returns>List of environments of the specified type</returns>
    public List<T> GetTestEnvironmentsByType<T>() where T : Node
    {
        var environments = new List<T>();
        foreach (var environment in TestEnvironments.Values)
        {
            if (environment is T typedEnvironment)
            {
                environments.Add(typedEnvironment);
            }
        }
        return environments;
    }
```

Gets test environments by type

**Returns:** `List<T>`

### CreateMultipleEnvironments

```csharp
#endregion
    
    #region Batch Operations
    
    /// <summary>
    /// Creates multiple test environments based on configuration
    /// </summary>
    /// <param name="configurations">List of environment configurations</param>
    /// <returns>Dictionary of created environments</returns>
    public Dictionary<string, Node> CreateMultipleEnvironments(List<EnvironmentConfiguration> configurations)
    {
        var results = new Dictionary<string, Node>();
        
        foreach (var config in configurations)
        {
            Node? environment = null;
            
            switch (config.Type)
            {
                case EnvironmentType.AllSystems:
                    environment = CreateAllSystemsEnvironment(config.Name, config.AllSystemsConfig);
                    break;
                case EnvironmentType.Building:
                    environment = CreateBuildingEnvironment(config.Name, config.BuildingConfig);
                    break;
                case EnvironmentType.Collision:
                    environment = CreateCollisionEnvironment(config.Name, config.CollisionConfig);
                    break;
                case EnvironmentType.Minimal:
                    environment = CreateMinimalEnvironment(config.Name);
                    break;
                case EnvironmentType.Performance:
                    environment = CreatePerformanceEnvironment(config.Name);
                    break;
            }
            
            if (environment != null)
            {
                results[config.Name] = environment;
            }
        }
        
        return results;
    }
```

Creates multiple test environments based on configuration

**Returns:** `Dictionary<string, Node>`

**Parameters:**
- `List<EnvironmentConfiguration> configurations`

### ValidateAllEnvironments

```csharp
/// <summary>
    /// Runs validation on all test environments
    /// </summary>
    /// <returns>Dictionary of validation results by environment name</returns>
    public Dictionary<string, ValidationResult> ValidateAllEnvironments()
    {
        var results = new Dictionary<string, ValidationResult>();
        
        foreach (var kvp in TestEnvironments)
        {
            var validation = ValidateEnvironment(kvp.Value);
            results[kvp.Key] = validation;
        }
        
        return results;
    }
```

Runs validation on all test environments

**Returns:** `Dictionary<string, ValidationResult>`

### ValidateEnvironment

```csharp
/// <summary>
    /// Validates a specific test environment
    /// </summary>
    /// <param name="environment">Environment to validate</param>
    /// <returns>Validation result</returns>
    public ValidationResult ValidateEnvironment(Node environment)
    {
        var issues = new List<string>();
        
        if (environment == null)
        {
            issues.Add("Environment is null");
            return ValidationResult.FromIssues(issues);
        }
        
        // Type-specific validation
        if (environment is AllSystemsTestEnvironment allSystemsEnv)
        {
            if (allSystemsEnv.Contexts == null)
                issues.Add("AllSystemsTestEnvironment: Contexts is null");
            if (allSystemsEnv.TestTileMap == null)
                issues.Add("AllSystemsTestEnvironment: TestTileMap is null");
            if (allSystemsEnv.PlacementSystem == null)
                issues.Add("AllSystemsTestEnvironment: PlacementSystem is null");
        }
        else if (environment is BuildingTestEnvironment buildingEnv)
        {
            if (buildingEnv.Contexts == null)
                issues.Add("BuildingTestEnvironment: Contexts is null");
            if (buildingEnv.TestTileMap == null)
                issues.Add("BuildingTestEnvironment: TestTileMap is null");
            if (buildingEnv.PlacementSystem == null)
                issues.Add("BuildingTestEnvironment: PlacementSystem is null");
            if (buildingEnv.TestBuildings.Count == 0)
                issues.Add("BuildingTestEnvironment: No test building data");
        }
        else if (environment is CollisionTestEnvironment collisionEnv)
        {
            if (collisionEnv.Contexts == null)
                issues.Add("CollisionTestEnvironment: Contexts is null");
            if (collisionEnv.TestTileMap == null)
                issues.Add("CollisionTestEnvironment: TestTileMap is null");
            if (collisionEnv.ScenarioBuilder == null)
                issues.Add("CollisionTestEnvironment: ScenarioBuilder is null");
            if (collisionEnv.TestCollisionObjects.Count == 0)
                issues.Add("CollisionTestEnvironment: No test collision objects");
        }
        else
        {
            issues.Add($"Unknown environment type: {environment.GetType().Name}");
        }
        
        return ValidationResult.FromIssues(issues);
    }
```

Validates a specific test environment

**Returns:** `ValidationResult`

**Parameters:**
- `Node environment`

### GetEnvironmentStatistics

```csharp
#endregion
    
    #region Statistics and Reporting
    
    /// <summary>
    /// Gets statistics about all test environments
    /// </summary>
    /// <returns>Environment statistics</returns>
    public EnvironmentStatistics GetEnvironmentStatistics()
    {
        var stats = new EnvironmentStatistics();
        
        foreach (var environment in TestEnvironments.Values)
        {
            stats.TotalEnvironments++;
            
            if (environment is AllSystemsTestEnvironment)
                stats.AllSystemsEnvironments++;
            else if (environment is BuildingTestEnvironment)
                stats.BuildingEnvironments++;
            else if (environment is CollisionTestEnvironment)
                stats.CollisionEnvironments++;
        }
        
        return stats;
    }
```

Gets statistics about all test environments

**Returns:** `EnvironmentStatistics`

### GenerateEnvironmentReport

```csharp
/// <summary>
    /// Generates a report of all test environments
    /// </summary>
    /// <returns>Environment report</returns>
    public string GenerateEnvironmentReport()
    {
        var stats = GetEnvironmentStatistics();
        var validations = ValidateAllEnvironments();
        
        var report = $"=== Test Environment Report ===\n";
        report += $"Total Environments: {stats.TotalEnvironments}\n";
        report += $"All Systems: {stats.AllSystemsEnvironments}\n";
        report += $"Building: {stats.BuildingEnvironments}\n";
        report += $"Collision: {stats.CollisionEnvironments}\n\n";
        
        report += "=== Environment Status ===\n";
        foreach (var kvp in validations)
        {
            var status = kvp.Value.IsValid ? "✅ VALID" : "❌ INVALID";
            report += $"{kvp.Key}: {status}\n";
            if (!kvp.Value.IsValid)
            {
                foreach (var issue in kvp.Value.Issues)
                {
                    report += $"  - {issue}\n";
                }
            }
        }
        
        return report;
    }
```

Generates a report of all test environments

**Returns:** `string`

### Initialize

```csharp
#endregion
    
    #region Initialization and Cleanup
    
    /// <summary>
    /// Initializes the factory
    /// </summary>
    public void Initialize()
    {
        Contexts = new Contexts();
        
        // Initialize demo scene factory
        DemoSceneFactory = new DemoSceneFactory();
        DemoSceneFactory.Name = "DemoSceneFactory";
        DemoSceneFactory.Initialize();
        AddChild(DemoSceneFactory);
    }
```

Initializes the factory

**Returns:** `void`

### Cleanup

```csharp
/// <summary>
    /// Cleanup factory resources
    /// </summary>
    public void Cleanup()
    {
        ClearAllTestEnvironments();
        
        DemoSceneFactory?.Cleanup();
        DemoSceneFactory = null;
        
        Contexts?.Dispose();
        Contexts = null;
    }
```

Cleanup factory resources

**Returns:** `void`

