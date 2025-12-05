---
title: "DragPathStatistics"
description: "Statistics about a drag path"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/dragpathstatistics/"
---

# DragPathStatistics

```csharp
GridBuilding.Core.Systems.Geometry
class DragPathStatistics
{
    // Members...
}
```

Statistics about a drag path

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/DragPathCalculator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### PointCount

```csharp
public int PointCount { get; set; }
```

### TotalDistance

```csharp
public float TotalDistance { get; set; }
```

### Duration

```csharp
public TimeSpan Duration { get; set; }
```

### AverageSpeed

```csharp
public float AverageSpeed { get; set; }
```

### Smoothness

```csharp
public float Smoothness { get; set; } // 0-1, higher is smoother
```

### Direction

```csharp
public Vector2 Direction { get; set; } // Primary direction
```

