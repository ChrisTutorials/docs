---
title: "CollisionProcessor"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/collisionprocessor/"
---

# CollisionProcessor

```csharp
GridBuilding.Core.Geometry
class CollisionProcessor
{
    // Members...
}
```

Pure C# Collision Processor for calculating tile offsets from collision geometry.
Processes collision scenarios to determine which tiles are affected by collision shapes.
Converts collision geometry to relative tile offsets for positioning.
This is the Core implementation that can be unit tested without Godot dependencies.
Implements unified resolver interface for consistency across the plugin architecture.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/CollisionProcessor.cs`  
**Namespace:** `GridBuilding.Core.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
/// <summary>
    /// Gets the name of this resolver
    /// </summary>
    public string Name
    {
        get => _name;
        set => _name = value ?? throw new ArgumentNullException(nameof(value));
    }
```

Gets the name of this resolver

### Priority

```csharp
/// <summary>
    /// Gets the priority of this resolver (higher = more priority)
    /// </summary>
    public int Priority
    {
        get => _priority;
        set => _priority = value;
    }
```

Gets the priority of this resolver (higher = more priority)

### IsEnabled

```csharp
/// <summary>
    /// Gets whether this resolver is enabled
    /// </summary>
    public bool IsEnabled
    {
        get => _isEnabled;
        set => _isEnabled = value;
    }
```

Gets whether this resolver is enabled


## Methods

### Resolve

```csharp
/// <summary>
    /// Resolves collision input to collision output using the unified resolver interface
    /// </summary>
    /// <param name="input">The collision processor input</param>
    /// <returns>The collision processor output</returns>
    public CollisionProcessorOutput Resolve(CollisionProcessorInput input)
    {
        if (!IsEnabled)
            throw new InvalidOperationException($"CollisionProcessor '{Name}' is disabled");
        
        if (!CanResolve(input))
            throw new InvalidOperationException($"CollisionProcessor cannot resolve input");

        var collisionPositions = ProcessCollisions(input.ScenarioData, input.MapData, input.CenterTile);
        
        return new CollisionProcessorOutput
        {
            Success = true,
            CollisionPositions = collisionPositions,
            ProcessedShapes = input.ScenarioData.RectCollisionTestSetups.Count,
            TotalCollisions = collisionPositions.Values.Sum(offsets => offsets.Count)
        };
    }
```

Resolves collision input to collision output using the unified resolver interface

**Returns:** `CollisionProcessorOutput`

**Parameters:**
- `CollisionProcessorInput input`

### CanResolve

```csharp
/// <summary>
    /// Checks if this resolver can handle the input
    /// </summary>
    /// <param name="input">The input to check</param>
    /// <returns>True if the resolver can handle the input</returns>
    public bool CanResolve(CollisionProcessorInput input)
    {
        return input != null && 
               input.ScenarioData != null &&
               input.MapData != null &&
               input.ScenarioData.ValidateSetup();
    }
```

Checks if this resolver can handle the input

**Returns:** `bool`

**Parameters:**
- `CollisionProcessorInput input`

### ProcessCollisions

```csharp
/// <summary>
    /// Processes collision scenarios to get tile offsets
    /// </summary>
    /// <param name="scenarioData">Collision scenario data</param>
    /// <param name="mapData">Tile map data</param>
    /// <param name="centerTile">Center tile position</param>
    /// <returns>Dictionary of tile positions to collision offsets</returns>
    public Dictionary<Vector2I, List<Vector2I>> ProcessCollisions(
        CollisionScenarioData scenarioData,
        TileMapData mapData,
        Vector2I centerTile)
    {
        var collisionPositions = new Dictionary<Vector2I, List<Vector2I>>();

        // Validate inputs
        if (scenarioData == null || mapData == null)
        {
            _logger?.LogWarning("Invalid inputs for collision processing");
            return collisionPositions;
        }

        _logger?.LogDebug($"Processing collisions for {scenarioData.RectCollisionTestSetups.Count} scenarios");

        // Process each collision scenario
        foreach (var rectTestSetup in scenarioData.RectCollisionTestSetups)
        {
            try
            {
                var shapePositions = ProcessShapeOffsets(rectTestSetup, mapData, centerTile);
                MergeCollisionPositions(collisionPositions, shapePositions);
            }
            catch (Exception ex)
            {
                _logger?.LogError($"Error processing collision scenario: {ex.Message}");
            }
        }

        _logger?.LogDebug($"Collision processing complete. Found {collisionPositions.Count} collision positions");
        return collisionPositions;
    }
```

Processes collision scenarios to get tile offsets

**Returns:** `Dictionary<Vector2I, List<Vector2I>>`

**Parameters:**
- `CollisionScenarioData scenarioData`
- `TileMapData mapData`
- `Vector2I centerTile`

### CreateDefault

```csharp
/// <summary>
    /// Creates a default collision processor
    /// </summary>
    public static CollisionProcessor CreateDefault()
    {
        return new CollisionProcessor();
    }
```

Creates a default collision processor

**Returns:** `CollisionProcessor`

### CreateWithCache

```csharp
/// <summary>
    /// Creates a collision processor with caching
    /// </summary>
    public static CollisionProcessor CreateWithCache(IGeometryCache cache)
    {
        return new CollisionProcessor(cache: cache);
    }
```

Creates a collision processor with caching

**Returns:** `CollisionProcessor`

**Parameters:**
- `IGeometryCache cache`

### Process

```csharp
#region IGeometryCollisionProcessor Implementation

    /// <summary>
    /// Processes collision scenarios to determine affected tiles.
    /// </summary>
    /// <param name="input">Collision processor input data</param>
    /// <returns>Collision processor output with tile offsets</returns>
    public CollisionProcessorOutput Process(CollisionProcessorInput input)
    {
        return Resolve(input);
    }
```

Processes collision scenarios to determine affected tiles.

**Returns:** `CollisionProcessorOutput`

**Parameters:**
- `CollisionProcessorInput input`

### ValidateConfiguration

```csharp
/// <summary>
    /// Validates collision processor configuration.
    /// </summary>
    /// <returns>Validation result indicating if configuration is valid</returns>
    public bool ValidateConfiguration()
    {
        return _logger != null && _cache != null && !string.IsNullOrEmpty(_name);
    }
```

Validates collision processor configuration.

**Returns:** `bool`

### ResolveAsync

```csharp
/// <summary>
    /// Asynchronously resolves the input to an output
    /// </summary>
    public System.Threading.Tasks.Task<CollisionProcessorOutput> ResolveAsync(
        CollisionProcessorInput input, 
        System.Threading.CancellationToken cancellationToken = default)
    {
        return System.Threading.Tasks.Task.FromResult(Resolve(input));
    }
```

Asynchronously resolves the input to an output

**Returns:** `System.Threading.Tasks.Task<CollisionProcessorOutput>`

**Parameters:**
- `CollisionProcessorInput input`
- `System.Threading.CancellationToken cancellationToken`

