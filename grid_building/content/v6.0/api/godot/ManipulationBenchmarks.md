---
title: "ManipulationBenchmarks"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/manipulationbenchmarks/"
---

# ManipulationBenchmarks

```csharp
GridBuilding.Godot.Test.Performance
class ManipulationBenchmarks
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

### BuildingMovement

```csharp
public BenchmarkResult BuildingMovement { get; set; }
```

### BuildingRotation

```csharp
public BenchmarkResult BuildingRotation { get; set; }
```

### BuildingFlipping

```csharp
public BenchmarkResult BuildingFlipping { get; set; }
```

### BuildingDemolition

```csharp
public BenchmarkResult BuildingDemolition { get; set; }
```


## Methods

### CalculateScore

```csharp
public double CalculateScore()
    {
        var results = new[] { BuildingMovement, BuildingRotation, BuildingFlipping, BuildingDemolition };
        var validResults = results.Where(r => r?.Success == true).ToArray();
        return validResults.Length > 0 ? validResults.Average(r => r.OperationsPerSecond) : 0;
    }
```

**Returns:** `double`

