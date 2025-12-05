---
title: "CollisionProcessorInput"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/collisionprocessorinput/"
---

# CollisionProcessorInput

```csharp
GridBuilding.Core.Types
class CollisionProcessorInput
{
    // Members...
}
```

Input data for collision processing operations

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/CollisionProcessorTypes.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Position

```csharp
/// <summary>
    /// Position of the object being checked
    /// </summary>
    public Vector2I Position { get; set; }
```

Position of the object being checked

### Size

```csharp
/// <summary>
    /// Size/dimensions of the object
    /// </summary>
    public Vector2I Size { get; set; }
```

Size/dimensions of the object

### CollisionShape

```csharp
/// <summary>
    /// Collision shape or geometry data
    /// </summary>
    public object? CollisionShape { get; set; }
```

Collision shape or geometry data

### GridSize

```csharp
/// <summary>
    /// Grid size for collision detection
    /// </summary>
    public int GridSize { get; set; } = 1;
```

Grid size for collision detection

### Context

```csharp
/// <summary>
    /// Additional context data for collision processing
    /// </summary>
    public Dictionary<string, object> Context { get; set; } = new();
```

Additional context data for collision processing

