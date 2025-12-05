---
title: "ManipulationOperation"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/manipulationoperation/"
---

# ManipulationOperation

```csharp
GridBuilding.Godot.Test.Helpers
class ManipulationOperation
{
    // Members...
}
```

Individual manipulation operation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/ManipulationTestHelpers.cs`  
**Namespace:** `GridBuilding.Godot.Test.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Type

```csharp
public ManipulationOperationType Type { get; set; }
```

### TargetId

```csharp
public string TargetId { get; set; } = string.Empty;
```

### FromPosition

```csharp
public Vector2I FromPosition { get; set; }
```

### ToPosition

```csharp
public Vector2I ToPosition { get; set; }
```

### FromRotation

```csharp
public float FromRotation { get; set; }
```

### ToRotation

```csharp
public float ToRotation { get; set; }
```

### ExpectedResult

```csharp
public ManipulationOperationResult ExpectedResult { get; set; }
```

