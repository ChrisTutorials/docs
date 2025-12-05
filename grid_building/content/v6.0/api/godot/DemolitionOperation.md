---
title: "DemolitionOperation"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/demolitionoperation/"
---

# DemolitionOperation

```csharp
GridBuilding.Godot.Systems.Manipulation.Managers
class DemolitionOperation
{
    // Members...
}
```

Represents an active demolition operation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/Managers/DemolishManager.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Managers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### BuildingId

```csharp
public string BuildingId { get; set; } = string.Empty;
```

### Position

```csharp
public Vector2I Position { get; set; }
```

### StartTime

```csharp
public global::Godot.Collections.Dictionary StartTime { get; set; } = new();
```

### Duration

```csharp
public float Duration { get; set; } = 2.0f;
```

### ElapsedTime

```csharp
public float ElapsedTime { get; set; }
```

### EffectInstance

```csharp
public Node? EffectInstance { get; set; }
```

