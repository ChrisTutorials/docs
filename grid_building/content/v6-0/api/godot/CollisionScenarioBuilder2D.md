---
title: "CollisionScenarioBuilder2D"
description: "CollisionScenarioBuilder2D
Builds collision test parameters for a CollisionObject2D to enable placement indicators
to perform accurate collision checks against object geometry.
Ported from: godot/addons/grid_building/systems/placement/utilities/collision_scenario_builder_2d.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/collisionscenariobuilder2d/"
---

# CollisionScenarioBuilder2D

```csharp
GridBuilding.Godot.Systems.Placement.Utilities
class CollisionScenarioBuilder2D
{
    // Members...
}
```

CollisionScenarioBuilder2D
Builds collision test parameters for a CollisionObject2D to enable placement indicators
to perform accurate collision checks against object geometry.
Ported from: godot/addons/grid_building/systems/placement/utilities/collision_scenario_builder_2d.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Utilities/CollisionScenarioBuilder2D.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Utilities`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CollisionObject

```csharp
#region Properties

    /// <summary>
    /// The CollisionObject2D being analyzed for collision testing.
    /// </summary>
    public CollisionObject2D? CollisionObject 
    { 
        get => _collisionObject;
        set
        {
            _collisionObject = value;
            
            if (!IsInstanceValid(_collisionObject))
            {
                AddIssue("Collision object is not valid.");
            }
        }
    }
```

The CollisionObject2D being analyzed for collision testing.

### ShapeStretchSize

```csharp
/// <summary>
    /// Size to stretch collision shapes for comprehensive tile coverage.
    /// Recommended: Use your tile size (e.g., Vector2(16, 16) for 16x16 tiles).
    /// </summary>
    public Vector2 ShapeStretchSize { get; set; }
```

Size to stretch collision shapes for comprehensive tile coverage.
Recommended: Use your tile size (e.g., Vector2(16, 16) for 16x16 tiles).

### RectCollisionTestSetups

```csharp
/// <summary>
    /// Array of RectCollisionTestingSetup instances, one per shape owner.
    /// Use these setups to perform collision tests for placement indicators.
    /// </summary>
    public List<RectCollisionTestingSetup> RectCollisionTestSetups { get; private set; } = new();
```

Array of RectCollisionTestingSetup instances, one per shape owner.
Use these setups to perform collision tests for placement indicators.

### Issues

```csharp
/// <summary>
    /// Issues discovered during collision test setup.
    /// Check this array after initialization to identify configuration problems.
    /// </summary>
    public List<string> Issues { get; private set; } = new();
```

Issues discovered during collision test setup.
Check this array after initialization to identify configuration problems.


## Methods

### AddIssue

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Records an issue encountered during setup.
    /// </summary>
    public void AddIssue(string issue)
    {
        Issues.Add(issue);
    }
```

Records an issue encountered during setup.

**Returns:** `void`

**Parameters:**
- `string issue`

### FreeTestingNodes

```csharp
/// <summary>
    /// Frees all testing nodes created during setup.
    /// Call this when the setup is no longer needed to prevent memory leaks.
    /// </summary>
    public void FreeTestingNodes()
    {
        foreach (var testSetup in RectCollisionTestSetups)
        {
            testSetup.FreeTestingNodes();
        }
    }
```

Frees all testing nodes created during setup.
Call this when the setup is no longer needed to prevent memory leaks.

**Returns:** `void`

### ValidateSetup

```csharp
/// <summary>
    /// Validates the collision test setup and reports any issues.
    /// Returns true if setup is valid and ready for use, false otherwise.
    /// </summary>
    public bool ValidateSetup()
    {
        var noIssues = true;

        if (RectCollisionTestSetups == null || RectCollisionTestSetups.Count == 0)
        {
            AddIssue(
                "Test params have no RectCollisionTestingSetups. Collision object probably has no CollisionShape2D or CollisionPolygon2D children. Check scene for those."
            );
            noIssues = false;
        }

        return noIssues;
    }
```

Validates the collision test setup and reports any issues.
Returns true if setup is valid and ready for use, false otherwise.

**Returns:** `bool`

### CreateTestSetupsForCollisionOwners

```csharp
/// <summary>
    /// Creates collision test setups for multiple collision owners.
    /// 
    /// Purpose: Batch creation of collision test setups when you already have a mapping
    /// of collision owners to their shapes. This is the lower-level method that gives you
    /// fine-grained control over which collision owners to process.
    /// 
    /// Parameters:
    ///   ownerShapes: Pre-mapped collision owners to their shapes
    ///   targetingState: Provides tile set for size calculations
    /// 
    /// Returns:
    ///   Dictionary of test setups keyed by collision owner
    /// </summary>
    public static Dictionary<Node2D, CollisionScenarioBuilder2D> CreateTestSetupsForCollisionOwners(
        Dictionary<Node2D, List<Shape2D>> ownerShapes, GridTargetingState targetingState
    )
    {
        var setups = new Dictionary<Node2D, CollisionScenarioBuilder2D>();

        foreach (var owner in ownerShapes.Keys)
        {
            if (owner is CollisionObject2D collisionObj)
            {
                var tileSet = targetingState.TargetMap?.TileSet;
                if (tileSet == null)
                {
                    GD.PushError("CollisionScenarioBuilder2D: Invalid tile set in targeting state");
                    continue;
                }
                
                var collisionShapeStretchAmount = tileSet.TileSize * 2.0f;
                setups[owner] = new CollisionScenarioBuilder2D(collisionObj, collisionShapeStretchAmount);
            }
            else if (owner is CollisionPolygon2D)
            {
                setups[owner] = null; // Not supported for collision testing
            }
        }

        return setups;
    }
```

Creates collision test setups for multiple collision owners.
/// Purpose: Batch creation of collision test setups when you already have a mapping
of collision owners to their shapes. This is the lower-level method that gives you
fine-grained control over which collision owners to process.
/// Parameters:
ownerShapes: Pre-mapped collision owners to their shapes
targetingState: Provides tile set for size calculations
/// Returns:
Dictionary of test setups keyed by collision owner

**Returns:** `Dictionary<Node2D, CollisionScenarioBuilder2D>`

**Parameters:**
- `Dictionary<Node2D, List<Shape2D>> ownerShapes`
- `GridTargetingState targetingState`

### CreateTestSetupsFromTestNode

```csharp
/// <summary>
    /// Creates collision test setups starting from a test node.
    /// 
    /// Purpose: One-step collision test setup creation from any scene node.
    /// This is the higher-level convenience method that handles the complete workflow
    /// of finding collision owners and creating test setups.
    /// 
    /// Parameters:
    ///   testNode: Any node to scan for collision objects (usually a placeable root)
    ///   targetingState: Provides tile set for size calculations
    /// 
    /// Returns:
    ///   Array of ready-to-use collision test setups (null entries filtered out)
    /// </summary>
    public static List<CollisionScenarioBuilder2D> CreateTestSetupsFromTestNode(
        Node2D testNode, GridTargetingState targetingState
    )
    {
        var shapesByOwner = GetAllCollisionShapesByOwner(testNode);
        var setupsDict = CreateTestSetupsForCollisionOwners(shapesByOwner, targetingState);

        // Convert Dictionary to List, filtering out null entries
        var result = new List<CollisionScenarioBuilder2D>();
        foreach (var setup in setupsDict.Values)
        {
            if (setup != null) // Skip null entries
            {
                result.Add(setup);
            }
        }
        return result;
    }
```

Creates collision test setups starting from a test node.
/// Purpose: One-step collision test setup creation from any scene node.
This is the higher-level convenience method that handles the complete workflow
of finding collision owners and creating test setups.
/// Parameters:
testNode: Any node to scan for collision objects (usually a placeable root)
targetingState: Provides tile set for size calculations
/// Returns:
Array of ready-to-use collision test setups (null entries filtered out)

**Returns:** `List<CollisionScenarioBuilder2D>`

**Parameters:**
- `Node2D testNode`
- `GridTargetingState targetingState`

