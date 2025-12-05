---
title: "RotationOperation"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/rotationoperation/"
---

# RotationOperation

```csharp
GridBuilding.Godot.Systems.Manipulation.Managers
class RotationOperation
{
    // Members...
}
```

Represents an active rotation operation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/Managers/RotateManager.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Managers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### BuildingId

```csharp
public string BuildingId { get; set; } = string.Empty;
```

### FromRotation

```csharp
public float FromRotation { get; set; }
```

### ToRotation

```csharp
public float ToRotation { get; set; }
```

### StartTime

```csharp
public global::Godot.Collections.Dictionary StartTime { get; set; } = new();
```

### Duration

```csharp
public float Duration { get; set; } = 0.3f;
```

### ElapsedTime

```csharp
public float ElapsedTime { get; set; }
```

