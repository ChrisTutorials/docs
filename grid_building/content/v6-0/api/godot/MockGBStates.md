---
title: "MockGBStates"
description: "Mock implementation of States."
weight: 20
url: "/gridbuilding/v6-0/api/godot/mockgbstates/"
---

# MockGBStates

```csharp
GridBuilding.Godot.Tests.Helpers
class MockGBStates
{
    // Members...
}
```

Mock implementation of States.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/MockGBCompositionContainer.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Targeting

```csharp
public MockTargetingState? Targeting { get; set; } = new();
```

### Manipulation

```csharp
public MockManipulationState? Manipulation { get; set; } = new();
```


## Methods

### GetTargeting

```csharp
public MockTargetingState? GetTargeting() => Targeting;
```

**Returns:** `MockTargetingState?`

### GetManipulation

```csharp
public MockManipulationState? GetManipulation() => Manipulation;
```

**Returns:** `MockManipulationState?`

