---
title: "MouseEventVisibilityResult"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/mouseeventvisibilityresult/"
---

# MouseEventVisibilityResult

```csharp
GridBuilding.Godot.Systems.GridTargeting.GridPositioner
class MouseEventVisibilityResult
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/GridPositioner/GridPositionerLogic.cs`  
**Namespace:** `GridBuilding.Godot.Systems.GridTargeting.GridPositioner`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Visible

```csharp
/// Whether the positioner should be visible.
    public bool Visible { get; set; }
```

### Reason

```csharp
/// Reason for the visibility decision.
    public string Reason { get; set; } = string.Empty;
```

