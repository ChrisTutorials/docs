---
title: "StateDiagnostics"
description: "State diagnostics"
weight: 20
url: "/gridbuilding/v6-0/api/godot/statediagnostics/"
---

# StateDiagnostics

```csharp
GridBuilding.Godot.Test.Helpers
class StateDiagnostics
{
    // Members...
}
```

State diagnostics

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GBTestDiagnostics.cs`  
**Namespace:** `GridBuilding.Godot.Test.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Issues

```csharp
public List<string> Issues { get; set; } = new();
```

### TargetingState

```csharp
public Dictionary<string, object> TargetingState { get; set; } = new();
```

### BuildingStates

```csharp
public Dictionary<string, object> BuildingStates { get; set; } = new();
```

### ManipulationState

```csharp
public Dictionary<string, object> ManipulationState { get; set; } = new();
```

### StateConsistency

```csharp
public bool StateConsistency { get; set; }
```

