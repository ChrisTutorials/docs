---
title: "MockManipulationState"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/mockmanipulationstate/"
---

# MockManipulationState

```csharp
GridBuilding.Godot.Tests.Helpers
class MockManipulationState
{
    // Members...
}
```

Mock implementation of ManipulationState.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/MockGBCompositionContainer.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Data

```csharp
public ManipulationData? Data { get; set; }
```

### Manipulator

```csharp
public Node2D? Manipulator { get; set; }
```

### ManipulationParent

```csharp
public Node2D? ManipulationParent { get; set; } = new();
```


## Methods

### GetData

```csharp
public ManipulationData? GetData() => Data;
```

**Returns:** `ManipulationData?`

### GetManipulator

```csharp
public Node2D? GetManipulator() => Manipulator;
```

**Returns:** `Node2D?`

### GetManipulationParent

```csharp
public Node2D? GetManipulationParent() => ManipulationParent;
```

**Returns:** `Node2D?`

### ValidateSetup

```csharp
public bool ValidateSetup() => Data != null && Data.Source != null;
```

**Returns:** `bool`

### ClearData

```csharp
public void ClearData() => Data = null;
```

**Returns:** `void`

