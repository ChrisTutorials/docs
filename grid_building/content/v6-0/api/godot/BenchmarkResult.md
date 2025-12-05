---
title: "BenchmarkResult"
description: "Benchmark result"
weight: 20
url: "/gridbuilding/v6-0/api/godot/benchmarkresult/"
---

# BenchmarkResult

```csharp
GridBuilding.Godot.Test.Performance
class BenchmarkResult
{
    // Members...
}
```

Benchmark result

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GridBuildingTestPerformance.cs`  
**Namespace:** `GridBuilding.Godot.Test.Performance`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### OperationName

```csharp
public string OperationName { get; set; }
```

### ExecutionTime

```csharp
public TimeSpan ExecutionTime { get; set; }
```

### OperationsCompleted

```csharp
public int OperationsCompleted { get; set; }
```

### Success

```csharp
public bool Success { get; set; }
```

### Iterations

```csharp
public int Iterations { get; set; }
```

### OperationsPerSecond

```csharp
public double OperationsPerSecond => ExecutionTime.TotalSeconds > 0 ? OperationsCompleted / ExecutionTime.TotalSeconds : 0;
```

