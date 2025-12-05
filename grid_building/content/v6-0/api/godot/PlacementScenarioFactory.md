---
title: "PlacementScenarioFactory"
description: "Factory for creating placement scenario builders for collision testing.
Ported from: godot/addons/grid_building/systems/placement/managers/placement_scenario_factory.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/placementscenariofactory/"
---

# PlacementScenarioFactory

```csharp
GridBuilding.Godot.Systems.Placement.Managers
class PlacementScenarioFactory
{
    // Members...
}
```

Factory for creating placement scenario builders for collision testing.
Ported from: godot/addons/grid_building/systems/placement/managers/placement_scenario_factory.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Managers/PlacementScenarioFactory.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Managers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CreateWithInjection

```csharp
#endregion

    #region Static Factory Methods

    /// <summary>
    /// Creates a PlacementScenarioFactory with dependency injection from container.
    /// </summary>
    /// <param name="container">The dependency container</param>
    /// <returns>Fully configured placement scenario factory with validated dependencies</returns>
    public static PlacementScenarioFactory CreateWithInjection(CompositionContainer container)
    {
        var targetingState = container.GetTargetingState();
        var logger = container.GetLogger();
        var factory = new PlacementScenarioFactory(targetingState, logger);

        // Validate dependencies were properly injected
        var issues = factory.GetRuntimeIssues();
        if (issues.Count > 0)
        {
            logger?.LogWarnings(issues);
        }

        return factory;
    }
```

Creates a PlacementScenarioFactory with dependency injection from container.

**Returns:** `PlacementScenarioFactory`

**Parameters:**
- `CompositionContainer container`

### ResolveGbDependencies

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Resolves dependencies from the composition container.
    /// </summary>
    /// <param name="container">The dependency container</param>
    /// <returns>True if dependencies were successfully resolved, false otherwise</returns>
    public bool ResolveGbDependencies(CompositionContainer container)
    {
        if (container == null)
            return false;

        _targetingState = container.GetTargetingState();
        _logger = container.GetLogger();
        return true;
    }
```

Resolves dependencies from the composition container.

**Returns:** `bool`

**Parameters:**
- `CompositionContainer container`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Validates that all required dependencies are properly set.
    /// </summary>
    /// <returns>List of validation issues (empty if valid)</returns>
    public GDCollections.Array<string> GetRuntimeIssues()
    {
        var issues = new GDCollections.Array<string>();

        if (_targetingState == null)
            issues.Add("GridTargetingState is not set");

        if (_logger == null)
            issues.Add("Logger is not set");

        return issues;
    }
```

Validates that all required dependencies are properly set.

**Returns:** `GDCollections.Array<string>`

### GetOrCreateTestParams

```csharp
/// <summary>
    /// Gets or creates test parameters for a collision object.
    /// </summary>
    /// <param name="colObject">The collision object to get parameters for</param>
    /// <returns>Collision scenario builder for the object</returns>
    public CollisionScenarioBuilder2D GetOrCreateTestParams(CollisionObject2D colObject)
    {
        foreach (var existingParams in _testSetup)
        {
            if (existingParams.CollisionObject == colObject)
                return existingParams;
        }

        var collisionShapeStretchAmount = Vector2.Zero;
        if (_targetingState?.GetTargetMap()?.TileSet?.TileSize != null)
        {
            collisionShapeStretchAmount = _targetingState.GetTargetMap().TileSet.TileSize * 2.0f;
        }

        var newTest = new CollisionScenarioBuilder2D(colObject, collisionShapeStretchAmount);
        _testSetup.Add(newTest);
        return newTest;
    }
```

Gets or creates test parameters for a collision object.

**Returns:** `CollisionScenarioBuilder2D`

**Parameters:**
- `CollisionObject2D colObject`

### Clear

```csharp
/// <summary>
    /// Clears all test setup data.
    /// </summary>
    public void Clear()
    {
        foreach (var data in _testSetup)
        {
            data.FreeTestingNodes();
        }
        _testSetup.Clear();
    }
```

Clears all test setup data.

**Returns:** `void`

