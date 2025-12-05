---
title: "SystemsDiagnostics"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/systemsdiagnostics/"
---

# SystemsDiagnostics

```csharp
GridBuilding.Godot.Test.Helpers
class SystemsDiagnostics
{
    // Members...
}
```

GridBuilding systems diagnostics

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

### InjectorSystem

```csharp
public Dictionary<string, object> InjectorSystem { get; set; } = new();
```

### CompositionContainer

```csharp
public Dictionary<string, object> CompositionContainer { get; set; } = new();
```

### SystemStatus

```csharp
public Dictionary<string, bool> SystemStatus { get; set; } = new();
```

### PlacementSystem

```csharp
public Dictionary<string, object> PlacementSystem { get; set; } = new();
```

### ManipulationSystem

```csharp
public Dictionary<string, object> ManipulationSystem { get; set; } = new();
```

### IndicatorSystem

```csharp
public Dictionary<string, object> IndicatorSystem { get; set; } = new();
```

