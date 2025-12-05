---
title: "SequenceConstraints"
description: "Constraints and requirements for sequences"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/sequenceconstraints/"
---

# SequenceConstraints

```csharp
GridBuilding.Core.Data
class SequenceConstraints
{
    // Members...
}
```

Constraints and requirements for sequences

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/PlaceableSequence.cs`  
**Namespace:** `GridBuilding.Core.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### MinimumGridSize

```csharp
/// <summary>
        /// Minimum grid size required
        /// </summary>
        public Rect2I MinimumGridSize { get; set; }
```

Minimum grid size required

### MaximumSize

```csharp
/// <summary>
        /// Maximum sequence size
        /// </summary>
        public Rect2I MaximumSize { get; set; }
```

Maximum sequence size

### TerrainTypes

```csharp
/// <summary>
        /// Required terrain types
        /// </summary>
        public string[] TerrainTypes { get; set; } = Array.Empty<string>();
```

Required terrain types

### RequiredNearby

```csharp
/// <summary>
        /// Required nearby placeables
        /// </summary>
        public string[] RequiredNearby { get; set; } = Array.Empty<string>();
```

Required nearby placeables

### MaxCount

```csharp
/// <summary>
        /// Maximum placement count
        /// </summary>
        public int MaxCount { get; set; } = -1; // -1 = unlimited
```

Maximum placement count

### RequiresWater

```csharp
/// <summary>
        /// Whether sequence requires water access
        /// </summary>
        public bool RequiresWater { get; set; } = false;
```

Whether sequence requires water access

### RequiresPower

```csharp
/// <summary>
        /// Whether sequence requires power connection
        /// </summary>
        public bool RequiresPower { get; set; } = false;
```

Whether sequence requires power connection

### MinimumDistanceFromSame

```csharp
/// <summary>
        /// Minimum distance from same sequence type
        /// </summary>
        public int MinimumDistanceFromSame { get; set; } = 0;
```

Minimum distance from same sequence type

### ResourceRequirements

```csharp
/// <summary>
        /// Resource requirements for entire sequence
        /// </summary>
        public Dictionary<string, int> ResourceRequirements { get; set; } = new();
```

Resource requirements for entire sequence

