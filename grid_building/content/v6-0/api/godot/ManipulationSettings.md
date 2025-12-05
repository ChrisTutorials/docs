---
title: "ManipulationSettings"
description: "Settings concerning moving objects within the game world.
Ported from: godot/addons/grid_building/systems/manipulation/manipulation_settings.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/manipulationsettings/"
---

# ManipulationSettings

```csharp
GridBuilding.Godot.Tests.Resources.Settings
class ManipulationSettings
{
    // Members...
}
```

Settings concerning moving objects within the game world.
Ported from: godot/addons/grid_building/systems/manipulation/manipulation_settings.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Settings/ManipulationSettings.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Resources.Settings`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### RotateIncrementDegrees

```csharp
#region Core Settings

    /// <summary>
    /// Amount to rotate objects with every step of call to left or right rotation.
    /// Range: 0.0 to 360.0
    /// </summary>
    public float RotateIncrementDegrees { get; set; } = 90.0f;
```

Amount to rotate objects with every step of call to left or right rotation.
Range: 0.0 to 360.0

### EnableDemolish

```csharp
/// <summary>
    /// Allows objects which that have a Manipulatable component
    /// with demolish enabled to be removed by the demolish manipulation function.
    /// </summary>
    public bool EnableDemolish { get; set; }
```

Allows objects which that have a Manipulatable component
with demolish enabled to be removed by the demolish manipulation function.

### DemolishWhileMoving

```csharp
/// <summary>
    /// Whether an object that is selected for moving can be demolished
    /// while it is being moved in move mode.
    /// </summary>
    public bool DemolishWhileMoving { get; set; }
```

Whether an object that is selected for moving can be demolished
while it is being moved in move mode.

### EnableRotate

```csharp
/// <summary>
    /// Allows the building system to rotate objects left and right during build mode.
    /// </summary>
    public bool EnableRotate { get; set; } = true;
```

Allows the building system to rotate objects left and right during build mode.

### EnableFlipHorizontal

```csharp
/// <summary>
    /// Allows the building system to flip objects horizontally during build mode.
    /// </summary>
    public bool EnableFlipHorizontal { get; set; } = true;
```

Allows the building system to flip objects horizontally during build mode.

### EnableFlipVertical

```csharp
/// <summary>
    /// Allows the building system to flip objects vertically during build mode.
    /// </summary>
    public bool EnableFlipVertical { get; set; } = true;
```

Allows the building system to flip objects vertically during build mode.

### ResetTransformOnManipulation

```csharp
/// <summary>
    /// Whether the transform of the manipulation target object
    /// should be reset to identity when starting a manipulation.
    /// </summary>
    public bool ResetTransformOnManipulation { get; set; }
```

Whether the transform of the manipulation target object
should be reset to identity when starting a manipulation.

### DisableLayerInManipulation

```csharp
/// <summary>
    /// Whether you want to disable a layer when a manipulation like a move
    /// starts until it is canceled or finished.
    /// </summary>
    public bool DisableLayerInManipulation { get; set; }
```

Whether you want to disable a layer when a manipulation like a move
starts until it is canceled or finished.

### DisabledPhysicsLayer

```csharp
/// <summary>
    /// Layer that you want disabled in source object during manipulation
    /// until the manipulation is finished or canceled. Range: 0-32.
    /// </summary>
    public int DisabledPhysicsLayer { get; set; }
```

Layer that you want disabled in source object during manipulation
until the manipulation is finished or canceled. Range: 0-32.

### MoveSuffix

```csharp
/// <summary>
    /// String to append to an object's move copy node name to differentiate it from the original source object.
    /// </summary>
    public string MoveSuffix { get; set; } = "";
```

String to append to an object's move copy node name to differentiate it from the original source object.

### DemolishSuccess

```csharp
#endregion

    #region Messages - Demolish

    /// <summary>
    /// Message displayed when demolish succeeds.
    /// </summary>
    public string DemolishSuccess { get; set; } = "{0} was demolished successfully.";
```

Message displayed when demolish succeeds.

### FailedNotDemolishable

```csharp
/// <summary>
    /// Message when target cannot be demolished.
    /// </summary>
    public string FailedNotDemolishable { get; set; } = "{0} is not demolishable";
```

Message when target cannot be demolished.

### DemolishAlreadyDeleted

```csharp
/// <summary>
    /// Message when demolish target was already deleted.
    /// </summary>
    public string DemolishAlreadyDeleted { get; set; } = "Target of demolish_data {0} was already deleted.";
```

Message when demolish target was already deleted.

### MoveStarted

```csharp
#endregion

    #region Messages - Move

    /// <summary>
    /// Message when move action starts.
    /// </summary>
    public string MoveStarted { get; set; } = "Moving {0}";
```

Message when move action starts.

### MoveSuccess

```csharp
/// <summary>
    /// Message displayed when move succeeds.
    /// </summary>
    public string MoveSuccess { get; set; } = "{0} moved to new location successfully.";
```

Message displayed when move succeeds.

### FailedToStartMove

```csharp
/// <summary>
    /// Message when move fails to start.
    /// </summary>
    public string FailedToStartMove { get; set; } = "{0} was unable to start move successfully.";
```

Message when move fails to start.

### NoMoveTarget

```csharp
/// <summary>
    /// Message when there is no move target.
    /// </summary>
    public string NoMoveTarget { get; set; } = "There is no target to move.";
```

Message when there is no move target.

### FailedPlacementInvalid

```csharp
/// <summary>
    /// Message when placement at target location is invalid.
    /// </summary>
    public string FailedPlacementInvalid { get; set; } = "Cannot place {0} here.";
```

Message when placement at target location is invalid.

### AllSucceeded

```csharp
#endregion

    #region Messages - Validation

    /// <summary>
    /// Message when all placement rules succeed.
    /// </summary>
    public string AllSucceeded { get; set; } = "All placement rules succeeded validation.";
```

Message when all placement rules succeed.

### FailedToSetupRules

```csharp
/// <summary>
    /// Message when rule setup fails.
    /// </summary>
    public string FailedToSetupRules { get; set; } = "One or more rules failed to setup correctly.";
```

Message when rule setup fails.

### TargetNotRotatable

```csharp
#endregion

    #region Messages - Rotate

    /// <summary>
    /// Message when target cannot be rotated.
    /// </summary>
    public string TargetNotRotatable { get; set; } = "{0} cannot be rotated.";
```

Message when target cannot be rotated.

### TargetNotFlippableHorizontally

```csharp
#endregion

    #region Messages - Flip

    /// <summary>
    /// Message when target cannot be flipped horizontally.
    /// </summary>
    public string TargetNotFlippableHorizontally { get; set; } = "{0} target cannot be flipped horizontally.";
```

Message when target cannot be flipped horizontally.

### TargetNotFlippableVertically

```csharp
/// <summary>
    /// Message when target cannot be flipped vertically.
    /// </summary>
    public string TargetNotFlippableVertically { get; set; } = "{0} target cannot be flipped vertically.";
```

Message when target cannot be flipped vertically.

### InvalidData

```csharp
#endregion

    #region Messages - General Failures

    /// <summary>
    /// Message when manipulation data is invalid.
    /// </summary>
    public string InvalidData { get; set; } = "{0} is not valid. Cannot move object";
```

Message when manipulation data is invalid.

### FailedManipulationStateInvalid

```csharp
/// <summary>
    /// Message when manipulation state validation fails.
    /// </summary>
    public string FailedManipulationStateInvalid { get; set; } =
        "Manipulation state failed to validate. Check warnings for possible missing properties.";
```

Message when manipulation state validation fails.

### FailedObjectNotManipulatable

```csharp
/// <summary>
    /// Message when object is not manipulatable.
    /// </summary>
    public string FailedObjectNotManipulatable { get; set; } = "{0} is not manipulatable.";
```

Message when object is not manipulatable.

### FailedRootNotAssigned

```csharp
/// <summary>
    /// Message when root node is not assigned.
    /// </summary>
    public string FailedRootNotAssigned { get; set; } = "{0}'s root has not been assigned";
```

Message when root node is not assigned.

### FailedRootNotNode2D

```csharp
/// <summary>
    /// Message when root is not a Node2D.
    /// </summary>
    public string FailedRootNotNode2D { get; set; } = "{0}'s root is not a Node2D";
```

Message when root is not a Node2D.

### FailedNoTargetObject

```csharp
/// <summary>
    /// Message when there is no target object.
    /// </summary>
    public string FailedNoTargetObject { get; set; } = "There is no target object.";
```

Message when there is no target object.

### TargetNotManipulatable

```csharp
/// <summary>
    /// Message when target is not manipulatable.
    /// </summary>
    public string TargetNotManipulatable { get; set; } = "Target is not manipulatable.";
```

Message when target is not manipulatable.

### UnsupportedNodeType

```csharp
/// <summary>
    /// Message for unsupported node types.
    /// </summary>
    public string UnsupportedNodeType { get; set; } = "Unsupported node type {0}";
```

Message for unsupported node types.


## Methods

### GetEditorIssues

```csharp
#endregion

    #region Validation

    /// <summary>
    /// Returns an array of issues found during editor validation.
    /// </summary>
    public List<string> GetEditorIssues()
    {
        var issues = new List<string>();

        // Validate all messages are non-empty
        if (string.IsNullOrEmpty(DemolishSuccess))
            issues.Add("ManipulationSettings: Demolish success message is empty.");
        if (string.IsNullOrEmpty(FailedNotDemolishable))
            issues.Add("ManipulationSettings: Failed not demolishable message is empty.");
        if (string.IsNullOrEmpty(DemolishAlreadyDeleted))
            issues.Add("ManipulationSettings: Demolish already deleted message is empty.");
        if (string.IsNullOrEmpty(MoveStarted))
            issues.Add("ManipulationSettings: Move started message is empty.");
        if (string.IsNullOrEmpty(MoveSuccess))
            issues.Add("ManipulationSettings: Move success message is empty.");
        if (string.IsNullOrEmpty(FailedToStartMove))
            issues.Add("ManipulationSettings: Failed to start move message is empty.");
        if (string.IsNullOrEmpty(NoMoveTarget))
            issues.Add("ManipulationSettings: No move target message is empty.");
        if (string.IsNullOrEmpty(FailedPlacementInvalid))
            issues.Add("ManipulationSettings: Failed placement invalid message is empty.");
        if (string.IsNullOrEmpty(TargetNotRotatable))
            issues.Add("ManipulationSettings: Target not rotatable message is empty.");
        if (string.IsNullOrEmpty(TargetNotFlippableHorizontally))
            issues.Add("ManipulationSettings: Target not flippable horizontally message is empty.");
        if (string.IsNullOrEmpty(TargetNotFlippableVertically))
            issues.Add("ManipulationSettings: Target not flippable vertically message is empty.");
        if (string.IsNullOrEmpty(InvalidData))
            issues.Add("ManipulationSettings: Invalid data message is empty.");
        if (string.IsNullOrEmpty(FailedManipulationStateInvalid))
            issues.Add("ManipulationSettings: Failed manipulation state invalid message is empty.");
        if (string.IsNullOrEmpty(FailedObjectNotManipulatable))
            issues.Add("ManipulationSettings: Failed object not manipulatable message is empty.");
        if (string.IsNullOrEmpty(FailedRootNotAssigned))
            issues.Add("ManipulationSettings: Failed root not assigned message is empty.");
        if (string.IsNullOrEmpty(FailedRootNotNode2D))
            issues.Add("ManipulationSettings: Failed root not Node2D message is empty.");
        if (string.IsNullOrEmpty(FailedNoTargetObject))
            issues.Add("ManipulationSettings: Failed no target object message is empty.");
        if (string.IsNullOrEmpty(TargetNotManipulatable))
            issues.Add("ManipulationSettings: Target not manipulatable message is empty.");
        if (string.IsNullOrEmpty(UnsupportedNodeType))
            issues.Add("ManipulationSettings: Unsupported node type message is empty.");

        return issues;
    }
```

Returns an array of issues found during editor validation.

**Returns:** `List<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Returns an array of issues found during runtime validation.
    /// </summary>
    public List<string> GetRuntimeIssues()
    {
        var issues = new List<string>();
        issues.AddRange(GetEditorIssues());
        return issues;
    }
```

Returns an array of issues found during runtime validation.

**Returns:** `List<string>`

