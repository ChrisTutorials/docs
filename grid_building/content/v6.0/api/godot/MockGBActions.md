---
title: "MockGBActions"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/mockgbactions/"
---

# MockGBActions

```csharp
GridBuilding.Godot.Tests.Helpers
class MockGBActions
{
    // Members...
}
```

Mock implementation of Actions.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/MockGBCompositionContainer.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### RotateLeft

```csharp
public ManipulationAction RotateLeft { get; set; } = ManipulationAction.ROTATE_LEFT;
```

### RotateRight

```csharp
public ManipulationAction RotateRight { get; set; } = ManipulationAction.ROTATE_RIGHT;
```

### FlipHorizontal

```csharp
public ManipulationAction FlipHorizontal { get; set; } = ManipulationAction.FLIP_HORIZONTAL;
```

### FlipVertical

```csharp
public ManipulationAction FlipVertical { get; set; } = ManipulationAction.FLIP_VERTICAL;
```


## Methods

### ValidateAction

```csharp
public Godot.Collections.Array<string> ValidateAction(ManipulationAction action)
    {
        return new Godot.Collections.Array<string>(); // No issues in mock
    }
```

**Returns:** `Godot.Collections.Array<string>`

**Parameters:**
- `ManipulationAction action`

### GetRuntimeIssues

```csharp
public Godot.Collections.Array<string> GetRuntimeIssues()
    {
        return new Godot.Collections.Array<string>(); // No issues in mock
    }
```

**Returns:** `Godot.Collections.Array<string>`

