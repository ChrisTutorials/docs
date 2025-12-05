---
title: "DragPathSettings"
description: "Settings for drag path calculation"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/dragpathsettings/"
---

# DragPathSettings

```csharp
GridBuilding.Core.Systems.Geometry
class DragPathSettings
{
    // Members...
}
```

Settings for drag path calculation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/DragPathCalculator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### EnableSmoothing

```csharp
public bool EnableSmoothing { get; set; } = true;
```

### SmoothingTension

```csharp
public float SmoothingTension { get; set; } = 0.5f;
```

### MinimumPointDistance

```csharp
public float MinimumPointDistance { get; set; } = 5.0f;
```

### MinimumPoints

```csharp
public int MinimumPoints { get; set; } = 2;
```

### MinimumDistance

```csharp
public float MinimumDistance { get; set; } = 10.0f;
```

### MaximumDuration

```csharp
public float MaximumDuration { get; set; } = 5.0f; // seconds
```

