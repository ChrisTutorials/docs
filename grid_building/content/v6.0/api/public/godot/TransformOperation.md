---
title: "TransformOperation"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/transformoperation/"
---

# TransformOperation

```csharp
GridBuilding.Godot.Systems.Manipulation.Handlers
class TransformOperation
{
    // Members...
}
```

Represents an active transform operation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/Handlers/ManipulationTransformHandler.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Handlers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Type

```csharp
public string Type { get; set; } = string.Empty;
```

### BuildingId

```csharp
public string BuildingId { get; set; } = string.Empty;
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

### Progress

```csharp
public float Progress { get; set; }
```

