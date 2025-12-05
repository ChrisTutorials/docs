---
title: "DragPathResult"
description: "Result of a completed drag path calculation"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/dragpathresult/"
---

# DragPathResult

```csharp
GridBuilding.Core.Systems.Geometry
class DragPathResult
{
    // Members...
}
```

Result of a completed drag path calculation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/DragPathCalculator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Success

```csharp
public bool Success { get; set; }
```

### IsValid

```csharp
public bool IsValid { get; set; }
```

### RawPoints

```csharp
public Vector2[] RawPoints { get; set; } = Array.Empty<Vector2>();
```

### SmoothedPoints

```csharp
public Vector2[] SmoothedPoints { get; set; } = Array.Empty<Vector2>();
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

### PointCount

```csharp
public int PointCount { get; set; }
```

