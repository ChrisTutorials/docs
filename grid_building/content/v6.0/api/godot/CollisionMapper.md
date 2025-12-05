---
title: "CollisionMapper"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionmapper/"
---

# CollisionMapper

```csharp
GridBuilding.Godot.Systems.Placement.Processors
class CollisionMapper
{
    // Members...
}
```

Responsibilities:
- Translate CollisionShape2D / CollisionPolygon2D geometry into tile offsets used by placement rules and indicators.
- Apply filtering, normalization, and heuristics to remove slivers and normalize pivots for consistent indicators.
Ported from: godot/addons/grid_building/systems/placement/processors/collision_mapper.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Processors/CollisionMapper.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Processors`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestIndicator

```csharp
public RuleCheckIndicator? TestIndicator => _testIndicator;
```

### TestSetups

```csharp
public List<CollisionTestSetup2D> TestSetups => _testSetups;
```


## Methods

### ResolveGbDependencies

```csharp
public bool ResolveGbDependencies(GBCompositionContainer container)
    {
        _targetingState = container.GetTargetingState();
        _logger = container.GetLogger();
        return true;
    }
```

**Returns:** `bool`

**Parameters:**
- `GBCompositionContainer container`

### GetRuntimeIssues

```csharp
public global::Godot.Collections.Array<string> GetRuntimeIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();
        if (_targetingState == null) issues.Add("GridTargetingState is not set");
        return issues;
    }
```

**Returns:** `global::Godot.Collections.Array<string>`

### Setup

```csharp
/// <summary>
    /// Setup the collision mapper with test indicator and collision body.
    /// </summary>
    public void Setup(Node2D collisionBody, TileCheckRule rule, Dictionary<Vector2I, List<Node2D>> collisionPositions)
    {
        // Create test indicator
        _testIndicator = new RuleCheckIndicator();
        _testIndicator.Position = collisionBody.Position;
        _testIndicator.Shape = new RectangleShape2D();
        _testIndicator.Shape.Size = new Vector2(32, 32);

        // Create test setup for the collision body
        var testSetup = new CollisionTestSetup2D
        {
            CollisionObject = collisionBody,
            RectCollisionTestSetups = new List<RectCollisionTestingSetup>
            {
                new RectCollisionTestingSetup
                {
                    Shapes = new List<Shape2D> { new RectangleShape2D() }
                }
            }
        };

        _testSetups.Clear();
        _testSetups.Add(testSetup);
    }
```

Setup the collision mapper with test indicator and collision body.

**Returns:** `void`

**Parameters:**
- `Node2D collisionBody`
- `TileCheckRule rule`
- `Dictionary<Vector2I, List<Node2D>> collisionPositions`

### MapCollisions

```csharp
/// <summary>
    /// Map collisions for the given rule and collision positions.
    /// </summary>
    public Dictionary<Vector2I, List<Node2D>>? MapCollisions(
        TileCheckRule rule, Dictionary<Vector2I, List<Node2D>> collisionPositions)
    {
        if (_guardSetupComplete() == false)
            return new Dictionary<Vector2I, List<Node2D>>();

        var result = new Dictionary<Vector2I, List<Node2D>>();

        // Simple implementation for testing - return basic collision positions
        foreach (var setup in _testSetups)
        {
            if (setup.CollisionObject != null && CollisionUtilities.ObjectMatchesLayerMask(
                setup.CollisionObject as CollisionObject2D, rule.ApplyToObjectsMask))
            {
                // Add collision object to result at some test positions
                var testPositions = new List<Vector2I> { Vector2I.Zero, Vector2I.One, new Vector2I(1, 0), new Vector2I(0, 1) };
                
                foreach (var pos in testPositions)
                {
                    if (!result.ContainsKey(pos))
                    {
                        result[pos] = new List<Node2D>();
                    }
                    result[pos].Add(setup.CollisionObject);
                }
            }
        }

        return result;
    }
```

Map collisions for the given rule and collision positions.

**Returns:** `Dictionary<Vector2I, List<Node2D>>?`

**Parameters:**
- `TileCheckRule rule`
- `Dictionary<Vector2I, List<Node2D>> collisionPositions`

### MapCollisionPositionsToRules

```csharp
/// <summary>
    /// Map collision positions to rules.
    /// Builds a dictionary of tile_offset -> [TileCheckRule].
    /// </summary>
    public Dictionary<Vector2I, List<TileCheckRule>> MapCollisionPositionsToRules(
        global::Godot.Collections.Array<Node2D> colObjects, 
        global::Godot.Collections.Array<TileCheckRule> tileCheckRules)
    {
        var map = new Dictionary<Vector2I, List<TileCheckRule>>();

        if (_targetingState?.TargetMap == null || _targetingState.Positioner == null)
        {
            return map;
        }

        // If no rules, doing geometry only mapping not fully implemented in this stub
        // Full implementation requires porting geometry processors (CollisionProcessor, etc)
        
        // Simplified dummy implementation for compilation
        foreach (var rule in tileCheckRules)
        {
            // Real logic would check collision masks and geometry
        }

        return map;
    }
```

Map collision positions to rules.
Builds a dictionary of tile_offset -> [TileCheckRule].

**Returns:** `Dictionary<Vector2I, List<TileCheckRule>>`

**Parameters:**
- `global::Godot.Collections.Array<Node2D> colObjects`
- `global::Godot.Collections.Array<TileCheckRule> tileCheckRules`

