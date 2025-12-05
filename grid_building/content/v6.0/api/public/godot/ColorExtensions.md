---
title: "ColorExtensions"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/colorextensions/"
---

# ColorExtensions

```csharp
GridBuilding.Godot.Extensions
class ColorExtensions
{
    // Members...
}
```

Extension methods for converting between Godot and Core Color types.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Extensions/Vector2IExtensions.cs`  
**Namespace:** `GridBuilding.Godot.Extensions`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ToCore

```csharp
/// <summary>
    /// Converts a Godot Color to Core Color.
    /// </summary>
    public static Color ToCore(this Godot.Color godotColor)
    {
        return new Color(godotColor.R, godotColor.G, godotColor.B, godotColor.A);
    }
```

Converts a Godot Color to Core Color.

**Returns:** `Color`

**Parameters:**
- `Godot.Color godotColor`

### ToGodot

```csharp
/// <summary>
    /// Converts a Core Color to Godot Color.
    /// </summary>
    public static Godot.Color ToGodot(this Color coreColor)
    {
        return new Godot.Color(coreColor.R, coreColor.G, coreColor.B, coreColor.A);
    }
```

Converts a Core Color to Godot Color.

**Returns:** `Godot.Color`

**Parameters:**
- `Color coreColor`

