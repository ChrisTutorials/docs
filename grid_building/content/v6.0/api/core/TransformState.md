---
title: "TransformState"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/transformstate/"
---

# TransformState

```csharp
GridBuilding.Core.Services.Manipulation
class TransformState
{
    // Members...
}
```

Represents the complete transform state of an object

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Manipulation/ManipulationTransformHandler.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Position

```csharp
public Vector2 Position { get; set; }
```

### Rotation

```csharp
public float Rotation { get; set; } // In degrees
```

### Scale

```csharp
public Vector2 Scale { get; set; }
```


## Methods

### Clone

```csharp
/// <summary>
            /// Creates a deep copy of this transform state
            /// </summary>
            public TransformState Clone()
            {
                return new TransformState(Position, Rotation, Scale);
            }
```

Creates a deep copy of this transform state

**Returns:** `TransformState`

### ToString

```csharp
public override string ToString()
            {
                return $"Transform(Pos: {Position}, Rot: {Rotation}°, Scale: {Scale})";
            }
```

**Returns:** `string`

