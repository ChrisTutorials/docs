---
title: "RectCollisionScenarioBuilder"
description: "Area2D setup for collision shape testing with rectangle shapes.
Ported from: godot/addons/grid_building/systems/placement/utilities/rect_collision_scenario_builder.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/rectcollisionscenariobuilder/"
---

# RectCollisionScenarioBuilder

```csharp
GridBuilding.Godot.Systems.Placement.Utilities
class RectCollisionScenarioBuilder
{
    // Members...
}
```

Area2D setup for collision shape testing with rectangle shapes.
Ported from: godot/addons/grid_building/systems/placement/utilities/rect_collision_scenario_builder.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Utilities/RectCollisionScenarioBuilder.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Utilities`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ShapeOwner

```csharp
#endregion

    #region Properties

    /// <summary>
    /// The Node2D that owns the shapes being tested
    /// </summary>
    public Node2D ShapeOwner { get; private set; }
```

The Node2D that owns the shapes being tested

### Shapes

```csharp
/// <summary>
    /// Array of shapes to be tested
    /// </summary>
    public GDCollections.Array<Shape2D> Shapes { get; private set; }
```

Array of shapes to be tested

### Area2D

```csharp
/// <summary>
    /// Testing area for collision detection
    /// </summary>
    public Area2D? Area2D { get; private set; }
```

Testing area for collision detection

### CollisionShape

```csharp
/// <summary>
    /// Collision shape for the testing area
    /// </summary>
    public CollisionShape2D? CollisionShape { get; private set; }
```

Collision shape for the testing area

### RectShape

```csharp
/// <summary>
    /// Rectangle shape used for testing
    /// </summary>
    public RectangleShape2D? RectShape { get; private set; }
```

Rectangle shape used for testing

### DebugMode

```csharp
/// <summary>
    /// Debug mode flag for development visualization
    /// </summary>
    public bool DebugMode { get; set; } = true;
```

Debug mode flag for development visualization


## Methods

### FreeNodes

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Frees all testing nodes created during setup
    /// </summary>
    public void FreeNodes()
    {
        if (CollisionShape != null && IsInstanceValid(CollisionShape))
        {
            CollisionShape.QueueFree();
            CollisionShape = null;
        }

        if (Area2D != null && IsInstanceValid(Area2D))
        {
            Area2D.QueueFree();
            Area2D = null;
        }
    }
```

Frees all testing nodes created during setup

**Returns:** `void`

