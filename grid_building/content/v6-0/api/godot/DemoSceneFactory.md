---
title: "DemoSceneFactory"
description: "Factory for creating demo scenes for testing GridBuilding functionality
Provides methods to create various test scenarios and demo configurations"
weight: 20
url: "/gridbuilding/v6-0/api/godot/demoscenefactory/"
---

# DemoSceneFactory

```csharp
GridBuilding.Godot.Tests.Factories
class DemoSceneFactory
{
    // Members...
}
```

Factory for creating demo scenes for testing GridBuilding functionality
Provides methods to create various test scenarios and demo configurations

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/DemoSceneFactory.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Factories`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Contexts

```csharp
#region Properties
    
    /// <summary>
    /// Core contexts for demo scenes
    /// </summary>
    public Contexts? Contexts { get; private set; }
```

Core contexts for demo scenes

### Config

```csharp
/// <summary>
    /// Configuration for demo scene creation
    /// </summary>
    public DemoSceneConfig Config { get; set; } = new();
```

Configuration for demo scene creation

### DemoScenes

```csharp
/// <summary>
    /// Created demo scenes registry
    /// </summary>
    public Dictionary<string, Node> DemoScenes { get; private set; } = new();
```

Created demo scenes registry


## Methods

### CreateBasicPlacementDemo

```csharp
#endregion
    
    #region Factory Methods
    
    /// <summary>
    /// Creates a basic placement demo scene
    /// </summary>
    /// <param name="sceneName">Name of the demo scene</param>
    /// <returns>Created demo scene</returns>
    public Node CreateBasicPlacementDemo(string sceneName = "BasicPlacementDemo")
    {
        var scene = new Node();
        scene.Name = sceneName;
        
        // Create tile map
        var tileMap = CreateBasicTileMap();
        scene.AddChild(tileMap);
        
        // Create placement system
        var placementSystem = new PlacementSystem();
        placementSystem.Name = "PlacementSystem";
        placementSystem.Contexts = Contexts;
        placementSystem.TileMap = tileMap;
        placementSystem.TileSize = Config.TileSize;
        scene.AddChild(placementSystem);
        
        // Create camera
        var camera = CreateDemoCamera();
        scene.AddChild(camera);
        
        // Create UI
        var actionLog = new GBActionLog();
        actionLog.Name = "ActionLog";
        actionLog.MaxEntries = 50;
        scene.AddChild(actionLog);
        
        // Register scene
        DemoScenes[sceneName] = scene;
        
        return scene;
    }
```

Creates a basic placement demo scene

**Returns:** `Node`

**Parameters:**
- `string sceneName`

### CreateCollisionDemo

```csharp
/// <summary>
    /// Creates a collision testing demo scene
    /// </summary>
    /// <param name="sceneName">Name of the demo scene</param>
    /// <returns>Created demo scene</returns>
    public Node CreateCollisionDemo(string sceneName = "CollisionDemo")
    {
        var scene = new Node();
        scene.Name = sceneName;
        
        // Create tile map with obstacles
        var tileMap = CreateObstacleTileMap();
        scene.AddChild(tileMap);
        
        // Create collision objects
        var collisionObjects = CreateTestCollisionObjects();
        foreach (var obj in collisionObjects)
        {
            scene.AddChild(obj);
        }
        
        // Create collision processor
        var collisionProcessor = new GridBuilding.Godot.Systems.Placement.Processors.CollisionProcessor();
        collisionProcessor.Name = "CollisionProcessor";
        collisionProcessor.Contexts = Contexts;
        collisionProcessor.TileMap = tileMap;
        collisionProcessor.TileSize = Config.TileSize;
        scene.AddChild(collisionProcessor);
        
        // Create camera
        var camera = CreateDemoCamera();
        scene.AddChild(camera);
        
        // Register scene
        DemoScenes[sceneName] = scene;
        
        return scene;
    }
```

Creates a collision testing demo scene

**Returns:** `Node`

**Parameters:**
- `string sceneName`

### CreateTargetingDemo

```csharp
/// <summary>
    /// Creates a targeting demo scene
    /// </summary>
    /// <param name="sceneName">Name of the demo scene</param>
    /// <returns>Created demo scene</returns>
    public Node CreateTargetingDemo(string sceneName = "TargetingDemo")
    {
        var scene = new Node();
        scene.Name = sceneName;
        
        // Create tile map
        var tileMap = CreateBasicTileMap();
        scene.AddChild(tileMap);
        
        // Create targeting area
        var targetingArea = new TargetingArea2D();
        targetingArea.Name = "TargetingArea";
        targetingArea.GridSize = Config.GridSize;
        targetingArea.TileSize = Config.TileSize;
        targetingArea.Position = new Vector2(Config.GridSize.X * Config.TileSize.X * 0.5f,
                                             Config.GridSize.Y * Config.TileSize.Y * 0.5f);
        scene.AddChild(targetingArea);
        
        // Create camera
        var camera = CreateDemoCamera();
        scene.AddChild(camera);
        
        // Create UI for targeting feedback
        var actionLog = new GBActionLog();
        actionLog.Name = "TargetingLog";
        actionLog.MaxEntries = 30;
        scene.AddChild(actionLog);
        
        // Register scene
        DemoScenes[sceneName] = scene;
        
        return scene;
    }
```

Creates a targeting demo scene

**Returns:** `Node`

**Parameters:**
- `string sceneName`

### CreatePathfindingDemo

```csharp
/// <summary>
    /// Creates a pathfinding demo scene
    /// </summary>
    /// <param name="sceneName">Name of the demo scene</param>
    /// <returns>Created demo scene</returns>
    public Node CreatePathfindingDemo(string sceneName = "PathfindingDemo")
    {
        var scene = new Node();
        scene.Name = sceneName;
        
        // Create tile map with pathfinding obstacles
        var tileMap = CreatePathfindingTileMap();
        scene.AddChild(tileMap);
        
        // Create pathfinding manager
        var pathManager = new GBAStarPathManager();
        pathManager.Name = "PathManager";
        pathManager.TileMap = tileMap;
        pathManager.GridSize = Config.GridSize;
        pathManager.TileSize = Config.TileSize;
        scene.AddChild(pathManager);
        
        // Create camera
        var camera = CreateDemoCamera();
        scene.AddChild(camera);
        
        // Create UI for pathfinding feedback
        var actionLog = new GBActionLog();
        actionLog.Name = "PathfindingLog";
        actionLog.MaxEntries = 30;
        scene.AddChild(actionLog);
        
        // Register scene
        DemoScenes[sceneName] = scene;
        
        return scene;
    }
```

Creates a pathfinding demo scene

**Returns:** `Node`

**Parameters:**
- `string sceneName`

### CreateComprehensiveDemo

```csharp
/// <summary>
    /// Creates a comprehensive demo scene with all systems
    /// </summary>
    /// <param name="sceneName">Name of the demo scene</param>
    /// <returns>Created demo scene</returns>
    public Node CreateComprehensiveDemo(string sceneName = "ComprehensiveDemo")
    {
        var scene = new Node();
        scene.Name = sceneName;
        
        // Create tile map
        var tileMap = CreateComplexTileMap();
        scene.AddChild(tileMap);
        
        // Create placement system
        var placementSystem = new PlacementSystem();
        placementSystem.Name = "PlacementSystem";
        placementSystem.Contexts = Contexts;
        placementSystem.TileMap = tileMap;
        placementSystem.TileSize = Config.TileSize;
        scene.AddChild(placementSystem);
        
        // Create collision processor
        var collisionProcessor = new GridBuilding.Godot.Systems.Placement.Processors.CollisionProcessor();
        collisionProcessor.Name = "CollisionProcessor";
        collisionProcessor.Contexts = Contexts;
        collisionProcessor.TileMap = tileMap;
        collisionProcessor.TileSize = Config.TileSize;
        scene.AddChild(collisionProcessor);
        
        // Create pathfinding manager
        var pathManager = new GBAStarPathManager();
        pathManager.Name = "PathManager";
        pathManager.TileMap = tileMap;
        pathManager.GridSize = Config.GridSize;
        pathManager.TileSize = Config.TileSize;
        scene.AddChild(pathManager);
        
        // Create targeting area
        var targetingArea = new TargetingArea2D();
        targetingArea.Name = "TargetingArea";
        targetingArea.GridSize = Config.GridSize;
        targetingArea.TileSize = Config.TileSize;
        scene.AddChild(targetingArea);
        
        // Create camera
        var camera = CreateDemoCamera();
        scene.AddChild(camera);
        
        // Create UI
        var actionLog = new GBActionLog();
        actionLog.Name = "ActionLog";
        actionLog.MaxEntries = 100;
        scene.AddChild(actionLog);
        
        // Register scene
        DemoScenes[sceneName] = scene;
        
        return scene;
    }
```

Creates a comprehensive demo scene with all systems

**Returns:** `Node`

**Parameters:**
- `string sceneName`

### GetDemoScene

```csharp
#endregion
    
    #region Scene Management
    
    /// <summary>
    /// Gets a demo scene by name
    /// </summary>
    /// <param name="sceneName">Name of the scene</param>
    /// <returns>Scene if found, null otherwise</returns>
    public Node? GetDemoScene(string sceneName)
    {
        return DemoScenes.TryGetValue(sceneName, out var scene) ? scene : null;
    }
```

Gets a demo scene by name

**Returns:** `Node?`

**Parameters:**
- `string sceneName`

### RemoveDemoScene

```csharp
/// <summary>
    /// Removes a demo scene
    /// </summary>
    /// <param name="sceneName">Name of the scene to remove</param>
    /// <returns>True if scene was removed</returns>
    public bool RemoveDemoScene(string sceneName)
    {
        if (DemoScenes.TryGetValue(sceneName, out var scene))
        {
            scene.QueueFree();
            DemoScenes.Remove(sceneName);
            return true;
        }
        return false;
    }
```

Removes a demo scene

**Returns:** `bool`

**Parameters:**
- `string sceneName`

### ClearAllDemoScenes

```csharp
/// <summary>
    /// Clears all demo scenes
    /// </summary>
    public void ClearAllDemoScenes()
    {
        foreach (var scene in DemoScenes.Values)
        {
            scene.QueueFree();
        }
        DemoScenes.Clear();
    }
```

Clears all demo scenes

**Returns:** `void`

### GetDemoSceneNames

```csharp
/// <summary>
    /// Gets all demo scene names
    /// </summary>
    /// <returns>List of demo scene names</returns>
    public List<string> GetDemoSceneNames()
    {
        return new List<string>(DemoScenes.Keys);
    }
```

Gets all demo scene names

**Returns:** `List<string>`

### ValidateDemoScene

```csharp
#endregion
    
    #region Validation Methods
    
    /// <summary>
    /// Validates a demo scene
    /// </summary>
    /// <param name="scene">Scene to validate</param>
    /// <returns>Validation result</returns>
    public ValidationResult ValidateDemoScene(Node scene)
    {
        var issues = new List<string>();
        
        if (scene == null)
        {
            issues.Add("Scene is null");
            return ValidationResult.FromIssues(issues);
        }
        
        // Check for tile map
        var tileMap = scene.GetNode<TileMapLayer>("TileMap");
        if (tileMap == null)
            issues.Add("Missing TileMap node");
        else if (tileMap.TileSet == null)
            issues.Add("TileMap has no TileSet");
        
        // Check for camera
        var camera = scene.GetNode<Camera2D>("DemoCamera");
        if (camera == null)
            issues.Add("Missing DemoCamera node");
        
        // Check for placement system (if expected)
        var placementSystem = scene.GetNode<PlacementSystem>("PlacementSystem");
        if (placementSystem != null && !placementSystem.IsConfigured())
            issues.Add("PlacementSystem is not properly configured");
        
        return ValidationResult.FromIssues(issues);
    }
```

Validates a demo scene

**Returns:** `ValidationResult`

**Parameters:**
- `Node scene`

### ValidateAllDemoScenes

```csharp
/// <summary>
    /// Validates all demo scenes
    /// </summary>
    /// <returns>Dictionary of validation results by scene name</returns>
    public Dictionary<string, ValidationResult> ValidateAllDemoScenes()
    {
        var results = new Dictionary<string, ValidationResult>();
        
        foreach (var kvp in DemoScenes)
        {
            var validation = ValidateDemoScene(kvp.Value);
            results[kvp.Key] = validation;
        }
        
        return results;
    }
```

Validates all demo scenes

**Returns:** `Dictionary<string, ValidationResult>`

### Initialize

```csharp
#endregion
    
    #region Initialization
    
    /// <summary>
    /// Initializes the factory
    /// </summary>
    public void Initialize()
    {
        Contexts = new Contexts();
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
        ClearAllDemoScenes();
        Contexts?.Dispose();
        Contexts = null;
    }
```

Cleanup factory resources

**Returns:** `void`

