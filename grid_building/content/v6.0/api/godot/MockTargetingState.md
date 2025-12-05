---
title: "MockTargetingState"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/mocktargetingstate/"
---

# MockTargetingState

```csharp
GridBuilding.Godot.Tests.Helpers
class MockTargetingState
{
    // Members...
}
```

Mock implementation of TargetingState.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/MockGBCompositionContainer.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Target

```csharp
public Node2D? Target { get; set; }
```

### TargetPosition

```csharp
public Vector2 TargetPosition { get; set; }
```


## Methods

### GetTarget

```csharp
public Node2D? GetTarget() => Target;
```

**Returns:** `Node2D?`

### GetTargetPosition

```csharp
public Vector2 GetTargetPosition() => TargetPosition;
```

**Returns:** `Vector2`

### Clear

```csharp
public void Clear()
    {
        Target = null;
        TargetPosition = Vector2.Zero;
    }
```

**Returns:** `void`

