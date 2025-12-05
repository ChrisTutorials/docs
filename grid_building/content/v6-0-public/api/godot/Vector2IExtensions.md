---
title: "Vector2IExtensions"
description: "Extension methods for converting between Godot and Core Vector2I types."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/vector2iextensions/"
---

# Vector2IExtensions

```csharp
GridBuilding.Godot.Extensions
class Vector2IExtensions
{
    // Members...
}
```

Extension methods for converting between Godot and Core Vector2I types.

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
    /// Converts a Godot Vector2I to Core Vector2I.
    /// </summary>
    public static Vector2I ToCore(this Godot.Vector2I godotVector)
    {
        return new Vector2I(godotVector.X, godotVector.Y);
    }
```

Converts a Godot Vector2I to Core Vector2I.

**Returns:** `Vector2I`

**Parameters:**
- `Godot.Vector2I godotVector`

### ToGodot

```csharp
/// <summary>
    /// Converts a Core Vector2I to Godot Vector2I.
    /// </summary>
    public static Godot.Vector2I ToGodot(this Vector2I coreVector)
    {
        return new Godot.Vector2I(coreVector.X, coreVector.Y);
    }
```

Converts a Core Vector2I to Godot Vector2I.

**Returns:** `Godot.Vector2I`

**Parameters:**
- `Vector2I coreVector`

