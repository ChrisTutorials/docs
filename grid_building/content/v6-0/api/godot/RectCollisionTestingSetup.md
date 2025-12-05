---
title: "RectCollisionTestingSetup"
description: "Rectangle collision testing setup.
Ported from: godot/addons/grid_building/systems/placement/utilities/rect_collision_scenario_builder.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/rectcollisiontestingsetup/"
---

# RectCollisionTestingSetup

```csharp
GridBuilding.Godot.Systems.Placement.Processors
class RectCollisionTestingSetup
{
    // Members...
}
```

Rectangle collision testing setup.
Ported from: godot/addons/grid_building/systems/placement/utilities/rect_collision_scenario_builder.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Processors/CollisionMapper.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Processors`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ShapeOwner

```csharp
/// <summary>
    /// The Node2D that owns the collision shapes (CollisionShape2D or CollisionPolygon2D)
    /// </summary>
    public Node2D ShapeOwner { get; set; }
```

The Node2D that owns the collision shapes (CollisionShape2D or CollisionPolygon2D)

### Shapes

```csharp
/// <summary>
    /// Array of Shape2D instances owned by the ShapeOwner
    /// </summary>
    public List<Shape2D> Shapes { get; set; } = new();
```

Array of Shape2D instances owned by the ShapeOwner

### TestingRect

```csharp
/// <summary>
    /// Testing rectangle for collision scenarios
    /// </summary>
    public Rect2 TestingRect { get; set; }
```

Testing rectangle for collision scenarios

### TestingArea

```csharp
/// <summary>
    /// Optional testing area for runtime collision validation (matches GDScript Area2D)
    /// </summary>
    public Area2D? TestingArea { get; set; }
```

Optional testing area for runtime collision validation (matches GDScript Area2D)

### TestingCollisionShape

```csharp
/// <summary>
    /// Optional collision shape for testing (matches GDScript CollisionShape2D)
    /// </summary>
    public CollisionShape2D? TestingCollisionShape { get; set; }
```

Optional collision shape for testing (matches GDScript CollisionShape2D)

### Issues

```csharp
/// <summary>
    /// Issues discovered during setup validation
    /// </summary>
    public List<string> Issues { get; set; } = new();
```

Issues discovered during setup validation


## Methods

### Validate

```csharp
/// <summary>
    /// Validates the setup and returns any issues
    /// </summary>
    public List<string> Validate()
    {
        var issues = new List<string>();

        if (ShapeOwner == null)
            issues.Add("shape_owner is missing from setup");
        else if (!ShapeOwner.IsInsideTree())
            issues.Add("shape_owner must be a valid Node2D in the scene tree");

        if (Shapes == null || Shapes.Count == 0)
            issues.Add("shapes array is missing or empty");
        
        if (TestingRect.Size.X <= 0 || TestingRect.Size.Y <= 0)
            issues.Add("testing_rect must have positive size");

        return issues;
    }
```

Validates the setup and returns any issues

**Returns:** `List<string>`

### FreeTestingNodes

```csharp
/// <summary>
    /// Frees testing nodes created during setup
    /// </summary>
    public void FreeTestingNodes()
    {
        TestingArea?.QueueFree();
        TestingCollisionShape?.QueueFree();
        TestingArea = null;
        TestingCollisionShape = null;
    }
```

Frees testing nodes created during setup

**Returns:** `void`

