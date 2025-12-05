---
title: "BenchmarkOptions"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/benchmarkoptions/"
---

# BenchmarkOptions

```csharp
GridBuilding.Godot.Test.Performance
class BenchmarkOptions
{
    // Members...
}
```

Benchmark configuration options

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GridBuildingTestPerformance.cs`  
**Namespace:** `GridBuilding.Godot.Test.Performance`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### RunPlacementBenchmarks

```csharp
public bool RunPlacementBenchmarks { get; set; } = true;
```

### RunManipulationBenchmarks

```csharp
public bool RunManipulationBenchmarks { get; set; } = true;
```

### RunCollisionBenchmarks

```csharp
public bool RunCollisionBenchmarks { get; set; } = true;
```

### RunRenderingBenchmarks

```csharp
public bool RunRenderingBenchmarks { get; set; } = true;
```

### RunMemoryBenchmarks

```csharp
public bool RunMemoryBenchmarks { get; set; } = true;
```

### Iterations

```csharp
public int Iterations { get; set; } = 100;
```

### Timeout

```csharp
public TimeSpan Timeout { get; set; } = TimeSpan.FromSeconds(30);
```

