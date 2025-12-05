---
title: "MemoryBenchmarks"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/memorybenchmarks/"
---

# MemoryBenchmarks

```csharp
GridBuilding.Godot.Test.Performance
class MemoryBenchmarks
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

### AllocationPatterns

```csharp
public MemoryBenchmarkResult AllocationPatterns { get; set; }
```

### GarbageCollection

```csharp
public MemoryBenchmarkResult GarbageCollection { get; set; }
```

### MemoryLeaks

```csharp
public MemoryBenchmarkResult MemoryLeaks { get; set; }
```


## Methods

### CalculateScore

```csharp
public double CalculateScore()
    {
        var results = new[] { AllocationPatterns, GarbageCollection, MemoryLeaks };
        var validResults = results.Where(r => r?.Success == true).ToArray();
        return validResults.Length > 0 ? validResults.Average(r => 1.0) : 0; // Memory tests are pass/fail
    }
```

**Returns:** `double`

