---
title: "EnvironmentDiagnostics"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/environmentdiagnostics/"
---

# EnvironmentDiagnostics

```csharp
GridBuilding.Godot.Test.Helpers
class EnvironmentDiagnostics
{
    // Members...
}
```

Environment structure diagnostics

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GBTestDiagnostics.cs`  
**Namespace:** `GridBuilding.Godot.Test.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CriticalNodes

```csharp
public List<string> CriticalNodes { get; set; } = new();
```

### SceneStructure

```csharp
public Dictionary<string, object> SceneStructure { get; set; } = new();
```

### NodeHierarchy

```csharp
public List<string> NodeHierarchy { get; set; } = new();
```

### ResourceAvailability

```csharp
public Dictionary<string, bool> ResourceAvailability { get; set; } = new();
```

