---
title: "ManipulationTestScenario"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/manipulationtestscenario/"
---

# ManipulationTestScenario

```csharp
GridBuilding.Godot.Test.Helpers
class ManipulationTestScenario
{
    // Members...
}
```

Test scenario for manipulation operations

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/ManipulationTestHelpers.cs`  
**Namespace:** `GridBuilding.Godot.Test.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Type

```csharp
public ManipulationScenarioType Type { get; set; }
```

### Name

```csharp
public string Name { get; set; } = string.Empty;
```

### Description

```csharp
public string Description { get; set; } = string.Empty;
```

### TestObjects

```csharp
public List<Node> TestObjects { get; set; } = new();
```

### Operations

```csharp
public List<ManipulationOperation> Operations { get; set; } = new();
```

