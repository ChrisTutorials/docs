---
title: "ManipulationTargetResult"
description: "Contains the results of a manipulation target resolution."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/manipulationtargetresult/"
---

# ManipulationTargetResult

```csharp
GridBuilding.Godot.Systems.Manipulation.Utils
struct ManipulationTargetResult
{
    // Members...
}
```

Contains the results of a manipulation target resolution.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Utils/MetadataResolver.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Manipulatable

```csharp
public Manipulatable? Manipulatable { get; set; }
```

### TargetNode

```csharp
public Node2D? TargetNode { get; set; }
```

### IsValid

```csharp
public bool IsValid => Manipulatable != null && TargetNode != null;
```

