---
title: "RenderingBenchmarks"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/renderingbenchmarks/"
---

# RenderingBenchmarks

```csharp
GridBuilding.Godot.Test.Performance
class RenderingBenchmarks
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GridBuildingTestPerformance.cs`  
**Namespace:** `GridBuilding.Godot.Test.Performance`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IndicatorRendering

```csharp
public BenchmarkResult IndicatorRendering { get; set; }
```

### GridRendering

```csharp
public BenchmarkResult GridRendering { get; set; }
```

### BuildingRendering

```csharp
public BenchmarkResult BuildingRendering { get; set; }
```


## Methods

### CalculateScore

```csharp
public double CalculateScore()
    {
        var results = new[] { IndicatorRendering, GridRendering, BuildingRendering };
        var validResults = results.Where(r => r?.Success == true).ToArray();
        return validResults.Length > 0 ? validResults.Average(r => r.OperationsPerSecond) : 0;
    }
```

**Returns:** `double`

