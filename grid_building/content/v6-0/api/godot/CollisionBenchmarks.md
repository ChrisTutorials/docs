---
title: "CollisionBenchmarks"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/collisionbenchmarks/"
---

# CollisionBenchmarks

```csharp
GridBuilding.Godot.Test.Performance
class CollisionBenchmarks
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

### CollisionDetection

```csharp
public BenchmarkResult CollisionDetection { get; set; }
```

### CollisionProcessing

```csharp
public BenchmarkResult CollisionProcessing { get; set; }
```

### TileCalculations

```csharp
public BenchmarkResult TileCalculations { get; set; }
```

### GeometryOperations

```csharp
public BenchmarkResult GeometryOperations { get; set; }
```


## Methods

### CalculateScore

```csharp
public double CalculateScore()
    {
        var results = new[] { CollisionDetection, CollisionProcessing, TileCalculations, GeometryOperations };
        var validResults = results.Where(r => r?.Success == true).ToArray();
        return validResults.Length > 0 ? validResults.Average(r => r.OperationsPerSecond) : 0;
    }
```

**Returns:** `double`

