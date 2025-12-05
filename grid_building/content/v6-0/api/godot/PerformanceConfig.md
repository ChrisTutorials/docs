---
title: "PerformanceConfig"
description: "Configuration for performance testing behavior"
weight: 20
url: "/gridbuilding/v6-0/api/godot/performanceconfig/"
---

# PerformanceConfig

```csharp
GridBuilding.Godot.Test.Performance
class PerformanceConfig
{
    // Members...
}
```

Configuration for performance testing behavior

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GridBuildingTestPerformance.cs`  
**Namespace:** `GridBuilding.Godot.Test.Performance`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### EnableDetailedProfiling

```csharp
public static bool EnableDetailedProfiling { get; set; } = true;
```

### EnableMemoryTracking

```csharp
public static bool EnableMemoryTracking { get; set; } = true;
```

### EnableFrameTimeAnalysis

```csharp
public static bool EnableFrameTimeAnalysis { get; set; } = true;
```

### BenchmarkIterations

```csharp
public static int BenchmarkIterations { get; set; } = 100;
```

### PerformanceTimeout

```csharp
public static TimeSpan PerformanceTimeout { get; set; } = TimeSpan.FromSeconds(30);
```

### MinimumLogLevel

```csharp
public static LogLevel MinimumLogLevel { get; set; } = LogLevel.Info;
```

