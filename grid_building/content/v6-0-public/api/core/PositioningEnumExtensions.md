---
title: "PositioningEnumExtensions"
description: "Extension methods for positioning enums."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/positioningenumextensions/"
---

# PositioningEnumExtensions

```csharp
GridBuilding.Core.Types
class PositioningEnumExtensions
{
    // Members...
}
```

Extension methods for positioning enums.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/PositioningEnums.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ToDisplayString

```csharp
/// <summary>
    /// Converts ProjectionMethod to display string.
    /// </summary>
    public static string ToDisplayString(this ProjectionMethod method) => method switch
    {
        ProjectionMethod.Unproject => "unproject_position",
        ProjectionMethod.ScreenToWorld => "screen_to_world",
        ProjectionMethod.CameraInverse => "camera_inverse",
        ProjectionMethod.EventGlobal => "event.global_position",
        ProjectionMethod.EventPos => "event.position",
        _ => "unknown"
    };
```

Converts ProjectionMethod to display string.

**Returns:** `string`

**Parameters:**
- `ProjectionMethod method`

### ToDisplayString

```csharp
/// <summary>
    /// Converts RecenterPolicy to display string.
    /// </summary>
    public static string ToDisplayString(this RecenterPolicy policy) => policy switch
    {
        RecenterPolicy.None => "none",
        RecenterPolicy.LastShown => "last_shown",
        RecenterPolicy.ViewCenter => "view_center",
        RecenterPolicy.MouseCursor => "mouse_cursor",
        _ => "unknown"
    };
```

Converts RecenterPolicy to display string.

**Returns:** `string`

**Parameters:**
- `RecenterPolicy policy`

### ToDisplayString

```csharp
/// <summary>
    /// Converts PositionerLogMode to display string.
    /// </summary>
    public static string ToDisplayString(this PositionerLogMode mode) => mode switch
    {
        PositionerLogMode.None => "none",
        PositionerLogMode.Visibility => "visibility",
        PositionerLogMode.MouseInput => "mouse_input",
        PositionerLogMode.Positioning => "positioning",
        PositionerLogMode.StateFlow => "state_flow",
        _ => "unknown"
    };
```

Converts PositionerLogMode to display string.

**Returns:** `string`

**Parameters:**
- `PositionerLogMode mode`

