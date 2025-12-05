---
title: "ValidationDiagnostics"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/validationdiagnostics/"
---

# ValidationDiagnostics

```csharp
GridBuilding.Godot.Test.Helpers
class ValidationDiagnostics
{
    // Members...
}
```

Validation diagnostics

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

### PlacementValidation

```csharp
public Dictionary<string, object> PlacementValidation { get; set; } = new();
```

### CollisionValidation

```csharp
public Dictionary<string, object> CollisionValidation { get; set; } = new();
```

### RuleValidation

```csharp
public Dictionary<string, object> RuleValidation { get; set; } = new();
```

