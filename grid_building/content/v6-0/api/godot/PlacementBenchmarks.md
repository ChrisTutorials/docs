---
title: "PlacementBenchmarks"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/placementbenchmarks/"
---

# PlacementBenchmarks

```csharp
GridBuilding.Godot.Test.Performance
class PlacementBenchmarks
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

### BuildingPlacement

```csharp
public BenchmarkResult BuildingPlacement { get; set; }
```

### IndicatorUpdates

```csharp
public BenchmarkResult IndicatorUpdates { get; set; }
```

### ValidationChecks

```csharp
public BenchmarkResult ValidationChecks { get; set; }
```

### ScenarioCreation

```csharp
public BenchmarkResult ScenarioCreation { get; set; }
```


## Methods

### CalculateScore

```csharp
public double CalculateScore()
    {
        var results = new[] { BuildingPlacement, IndicatorUpdates, ValidationChecks, ScenarioCreation };
        var validResults = results.Where(r => r?.Success == true).ToArray();
        return validResults.Length > 0 ? validResults.Average(r => r.OperationsPerSecond) : 0;
    }
```

**Returns:** `double`

