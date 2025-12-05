---
title: "ManipulationModeExtensions"
description: "Extension methods for ManipulationMode enum"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/manipulationmodeextensions/"
---

# ManipulationModeExtensions

```csharp
GridBuilding.Core.Types
class ManipulationModeExtensions
{
    // Members...
}
```

Extension methods for ManipulationMode enum

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ManipulationMode.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### AllowsPlacement

```csharp
/// <summary>
    /// Returns true if this mode allows building placement
    /// </summary>
    public static bool AllowsPlacement(this ManipulationMode mode) =>
        mode == ManipulationMode.Place;
```

Returns true if this mode allows building placement

**Returns:** `bool`

**Parameters:**
- `ManipulationMode mode`

### AllowsRemoval

```csharp
/// <summary>
    /// Returns true if this mode allows building removal
    /// </summary>
    public static bool AllowsRemoval(this ManipulationMode mode) =>
        mode == ManipulationMode.Remove;
```

Returns true if this mode allows building removal

**Returns:** `bool`

**Parameters:**
- `ManipulationMode mode`

### AllowsMovement

```csharp
/// <summary>
    /// Returns true if this mode allows building movement
    /// </summary>
    public static bool AllowsMovement(this ManipulationMode mode) =>
        mode == ManipulationMode.Move;
```

Returns true if this mode allows building movement

**Returns:** `bool`

**Parameters:**
- `ManipulationMode mode`

### AllowsModification

```csharp
/// <summary>
    /// Returns true if this mode allows building modification
    /// </summary>
    public static bool AllowsModification(this ManipulationMode mode) =>
        mode == ManipulationMode.Edit;
```

Returns true if this mode allows building modification

**Returns:** `bool`

**Parameters:**
- `ManipulationMode mode`

### AllowsSelection

```csharp
/// <summary>
    /// Returns true if this mode allows selection
    /// </summary>
    public static bool AllowsSelection(this ManipulationMode mode) =>
        mode == ManipulationMode.Select || mode == ManipulationMode.Inspect;
```

Returns true if this mode allows selection

**Returns:** `bool`

**Parameters:**
- `ManipulationMode mode`

### GetDisplayName

```csharp
/// <summary>
    /// Gets the display name for this mode
    /// </summary>
    public static string GetDisplayName(this ManipulationMode mode) =>
        mode switch
        {
            ManipulationMode.None => "None",
            ManipulationMode.Place => "Place",
            ManipulationMode.Remove => "Remove",
            ManipulationMode.Move => "Move",
            ManipulationMode.Edit => "Edit",
            ManipulationMode.Select => "Select",
            ManipulationMode.Inspect => "Inspect",
            ManipulationMode.Resize => "Resize",
            ManipulationMode.Rotate => "Rotate",
            ManipulationMode.Paint => "Paint",
            _ => "Unknown"
        };
```

Gets the display name for this mode

**Returns:** `string`

**Parameters:**
- `ManipulationMode mode`

