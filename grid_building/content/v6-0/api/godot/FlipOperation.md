---
title: "FlipOperation"
description: "Represents an active flip operation"
weight: 20
url: "/gridbuilding/v6-0/api/godot/flipoperation/"
---

# FlipOperation

```csharp
GridBuilding.Godot.Systems.Manipulation.Managers
class FlipOperation
{
    // Members...
}
```

Represents an active flip operation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/Managers/FlipManager.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Managers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### BuildingId

```csharp
public string BuildingId { get; set; } = string.Empty;
```

### FromFlipH

```csharp
public bool FromFlipH { get; set; }
```

### FromFlipV

```csharp
public bool FromFlipV { get; set; }
```

### ToFlipH

```csharp
public bool ToFlipH { get; set; }
```

### ToFlipV

```csharp
public bool ToFlipV { get; set; }
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

