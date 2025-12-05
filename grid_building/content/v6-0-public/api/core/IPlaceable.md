---
title: "IPlaceable"
description: "Common interface for all placeable implementations.
<para>
Provides a contract that both engine-agnostic (POCS) and engine-specific
implementations must follow, enabling interchangeability while maintaining
clean separation between core logic and engine-specific functionality.
</para>
<para>
Implementation pattern:
- Core.Placeable: Pure C# implementation for UI and logic
- Godot.GodotPlaceableWrapper: Wraps core + adds Godot-specific methods
- Future engines can add their own wrappers
</para>"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/iplaceable/"
---

# IPlaceable

```csharp
GridBuilding.Core.Interfaces
interface IPlaceable
{
    // Members...
}
```

Common interface for all placeable implementations.
<para>
Provides a contract that both engine-agnostic (POCS) and engine-specific
implementations must follow, enabling interchangeability while maintaining
clean separation between core logic and engine-specific functionality.
</para>
<para>
Implementation pattern:
- Core.Placeable: Pure C# implementation for UI and logic
- Godot.GodotPlaceableWrapper: Wraps core + adds Godot-specific methods
- Future engines can add their own wrappers
</para>

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Interfaces/IPlaceable.cs`  
**Namespace:** `GridBuilding.Core.Interfaces`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.

