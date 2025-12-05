---
title: "IndicatorCollisionScenarioBuilder"
description: "IndicatorCollisionScenarioBuilder
Builds collision test parameters for a CollisionObject2D to enable placement indicators
to perform accurate collision checks against object geometry.
Purpose: Converts CollisionObject2D shapes into testable RectCollisionScenarioBuilder
instances for collision validation during placement operations.
Key Features:
• Creates one RectCollisionScenarioBuilder per shape owner
• Expands test areas using configurable shape_stretch_size
• Supports CollisionShape2D and CollisionPolygon2D nodes
• Comprehensive error reporting via issues array
Quick Start:
var testSetup = new IndicatorCollisionScenarioBuilder(collisionObject, Vector2(16, 16), owningNode);
if (testSetup.ValidateSetup())
{
// Use testSetup.RectCollisionTestSetups for collision testing
}
Dependencies: RectCollisionScenarioBuilder, GBGeometryUtils"
weight: 20
url: "/gridbuilding/v6-0/api/godot/indicatorcollisionscenariobuilder/"
---

# IndicatorCollisionScenarioBuilder

```csharp
GridBuilding.Godot.Systems.Placement.Utilities.RuleCheckIndicator
class IndicatorCollisionScenarioBuilder
{
    // Members...
}
```

IndicatorCollisionScenarioBuilder
Builds collision test parameters for a CollisionObject2D to enable placement indicators
to perform accurate collision checks against object geometry.
Purpose: Converts CollisionObject2D shapes into testable RectCollisionScenarioBuilder
instances for collision validation during placement operations.
Key Features:
• Creates one RectCollisionScenarioBuilder per shape owner
• Expands test areas using configurable shape_stretch_size
• Supports CollisionShape2D and CollisionPolygon2D nodes
• Comprehensive error reporting via issues array
Quick Start:
var testSetup = new IndicatorCollisionScenarioBuilder(collisionObject, Vector2(16, 16), owningNode);
if (testSetup.ValidateSetup())
{
// Use testSetup.RectCollisionTestSetups for collision testing
}
Dependencies: RectCollisionScenarioBuilder, GBGeometryUtils

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Utilities/RuleCheckIndicator/IndicatorCollisionScenarioBuilder.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Utilities.RuleCheckIndicator`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CollisionObject

```csharp
#region Properties

    /// <summary>
    /// The CollisionObject2D being analyzed for collision testing.
    /// </summary>
    public CollisionObject2D CollisionObject
    {
        get => _collisionObject;
        set
        {
            _collisionObject = value;
            if (!GodotObject.IsInstanceValid(_collisionObject))
            {
                AddIssue("Collision object is not valid.");
            }
        }
    }
```

The CollisionObject2D being analyzed for collision testing.

### OwningNode

```csharp
/// <summary>
    /// The owning Node2D that contains this collision object (e.g., the test object or scene node).
    /// This provides context about which object this collision setup belongs to.
    /// </summary>
    public Node2D OwningNode { get; set; }
```

The owning Node2D that contains this collision object (e.g., the test object or scene node).
This provides context about which object this collision setup belongs to.

### ShapeStretchSize

```csharp
/// <summary>
    /// Size to stretch collision shapes for comprehensive tile coverage.
    /// Recommended: Use your tile size (e.g., Vector2(16, 16) for 16x16 tiles).
    /// See advanced documentation for detailed sizing guidance.
    /// </summary>
    public Vector2 ShapeStretchSize { get; set; }
```

Size to stretch collision shapes for comprehensive tile coverage.
Recommended: Use your tile size (e.g., Vector2(16, 16) for 16x16 tiles).
See advanced documentation for detailed sizing guidance.

### RectCollisionTestSetups

```csharp
/// <summary>
    /// Array of RectCollisionScenarioBuilder instances, one per shape owner.
    /// Use these setups to perform collision tests for placement indicators.
    /// </summary>
    public List<RectCollisionScenarioBuilder> RectCollisionTestSetups { get; private set; }
```

Array of RectCollisionScenarioBuilder instances, one per shape owner.
Use these setups to perform collision tests for placement indicators.

### Issues

```csharp
/// <summary>
    /// Issues discovered during collision test setup.
    /// Check this array after initialization to identify configuration problems.
    /// </summary>
    public List<string> Issues { get; private set; }
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
    /// <param name="issue">The issue description</param>
    public void AddIssue(string issue)
    {
        Issues ??= new List<string>();
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
        if (RectCollisionTestSetups != null)
        {
            foreach (var testSetup in RectCollisionTestSetups)
            {
                testSetup?.FreeNodes();
            }
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
    /// <returns>True if setup is valid</returns>
    public bool ValidateSetup()
    {
        var noIssues = true;

        if (RectCollisionTestSetups == null || RectCollisionTestSetups.Count == 0)
        {
            AddIssue(
                "Test params have no RectCollisionScenarioBuilders. Collision object probably has no CollisionShape2D or CollisionPolygon2D children. Check scene for those."
            );
            noIssues = false;
        }

        return noIssues;
    }
```

Validates the collision test setup and reports any issues.
Returns true if setup is valid and ready for use, false otherwise.

**Returns:** `bool`

