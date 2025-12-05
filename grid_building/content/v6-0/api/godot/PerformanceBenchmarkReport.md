---
title: "PerformanceBenchmarkReport"
description: "Performance benchmark report"
weight: 20
url: "/gridbuilding/v6-0/api/godot/performancebenchmarkreport/"
---

# PerformanceBenchmarkReport

```csharp
GridBuilding.Godot.Test.Performance
class PerformanceBenchmarkReport
{
    // Members...
}
```

Performance benchmark report

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GridBuildingTestPerformance.cs`  
**Namespace:** `GridBuilding.Godot.Test.Performance`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### StartTime

```csharp
public DateTime StartTime { get; set; }
```

### EndTime

```csharp
public DateTime EndTime { get; set; }
```

### Duration

```csharp
public TimeSpan Duration { get; set; }
```

### Success

```csharp
public bool Success { get; set; }
```

### ErrorMessage

```csharp
public string ErrorMessage { get; set; } = string.Empty;
```

### Environment

```csharp
public Node Environment { get; set; }
```

### Options

```csharp
public BenchmarkOptions Options { get; set; }
```

### SystemInfo

```csharp
public SystemInfo SystemInfo { get; set; }
```

### InitialMemoryUsage

```csharp
public long InitialMemoryUsage { get; set; }
```

### PlacementBenchmarks

```csharp
public PlacementBenchmarks PlacementBenchmarks { get; set; }
```

### ManipulationBenchmarks

```csharp
public ManipulationBenchmarks ManipulationBenchmarks { get; set; }
```

### CollisionBenchmarks

```csharp
public CollisionBenchmarks CollisionBenchmarks { get; set; }
```

### RenderingBenchmarks

```csharp
public RenderingBenchmarks RenderingBenchmarks { get; set; }
```

### MemoryBenchmarks

```csharp
public MemoryBenchmarks MemoryBenchmarks { get; set; }
```

### OverallScore

```csharp
public double OverallScore { get; private set; }
```

### PerformanceGrade

```csharp
public string PerformanceGrade { get; private set; }
```


## Methods

### CalculateResults

```csharp
public void CalculateResults()
    {
        // Calculate overall performance metrics
        OverallScore = CalculateOverallScore();
        PerformanceGrade = CalculatePerformanceGrade();
    }
```

**Returns:** `void`

