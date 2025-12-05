---
title: "ManipulationActionExtensions"
description: "Extension methods for ManipulationAction enum."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/manipulationactionextensions/"
---

# ManipulationActionExtensions

```csharp
GridBuilding.Core.Types
class ManipulationActionExtensions
{
    // Members...
}
```

Extension methods for ManipulationAction enum.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ManipulationAction.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ToDisplayString

```csharp
/// <summary>
    /// Converts ManipulationAction to display string.
    /// </summary>
    public static string ToDisplayString(this ManipulationAction action) => action switch
    {
        ManipulationAction.Build => "BUILD",
        ManipulationAction.Move => "MOVE",
        ManipulationAction.Rotate => "ROTATE",
        ManipulationAction.FlipH => "FLIP_H",
        ManipulationAction.FlipV => "FLIP_V",
        ManipulationAction.Demolish => "DEMOLISH",
        _ => action.ToString()
    };
```

Converts ManipulationAction to display string.

**Returns:** `string`

**Parameters:**
- `ManipulationAction action`

### IsTransformAction

```csharp
/// <summary>
    /// Returns true if this action modifies an existing object (vs creating/destroying).
    /// </summary>
    public static bool IsTransformAction(this ManipulationAction action) =>
        action == ManipulationAction.Move ||
        action == ManipulationAction.Rotate ||
        action == ManipulationAction.FlipH ||
        action == ManipulationAction.FlipV;
```

Returns true if this action modifies an existing object (vs creating/destroying).

**Returns:** `bool`

**Parameters:**
- `ManipulationAction action`

### IsCreationAction

```csharp
/// <summary>
    /// Returns true if this action creates a new object.
    /// </summary>
    public static bool IsCreationAction(this ManipulationAction action) =>
        action == ManipulationAction.Build;
```

Returns true if this action creates a new object.

**Returns:** `bool`

**Parameters:**
- `ManipulationAction action`

### IsDestructionAction

```csharp
/// <summary>
    /// Returns true if this action removes an object.
    /// </summary>
    public static bool IsDestructionAction(this ManipulationAction action) =>
        action == ManipulationAction.Demolish;
```

Returns true if this action removes an object.

**Returns:** `bool`

**Parameters:**
- `ManipulationAction action`

