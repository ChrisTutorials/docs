---
title: "BuildingModeExtensions"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/buildingmodeextensions/"
---

# BuildingModeExtensions

```csharp
GridBuilding.Core.Types
class BuildingModeExtensions
{
    // Members...
}
```

Extension methods for BuildingMode enum.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/BuildingMode.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ToDisplayString

```csharp
/// <summary>
    /// Converts BuildingMode to display string.
    /// </summary>
    public static string ToDisplayString(this BuildingMode mode) => mode switch
    {
        BuildingMode.Off => "OFF",
        BuildingMode.Info => "INFO",
        BuildingMode.Build => "BUILD",
        BuildingMode.Move => "MOVE",
        BuildingMode.Demolish => "DEMOLISH",
        _ => mode.ToString()
    };
```

Converts BuildingMode to display string.

**Returns:** `string`

**Parameters:**
- `BuildingMode mode`

### IsManipulationMode

```csharp
/// <summary>
    /// Returns true if the mode allows manipulation of objects.
    /// </summary>
    public static bool IsManipulationMode(this BuildingMode mode) =>
        mode == BuildingMode.Move || mode == BuildingMode.Demolish;
```

Returns true if the mode allows manipulation of objects.

**Returns:** `bool`

**Parameters:**
- `BuildingMode mode`

### IsActiveMode

```csharp
/// <summary>
    /// Returns true if the mode is an active building/editing mode.
    /// </summary>
    public static bool IsActiveMode(this BuildingMode mode) =>
        mode != BuildingMode.Off;
```

Returns true if the mode is an active building/editing mode.

**Returns:** `bool`

**Parameters:**
- `BuildingMode mode`

