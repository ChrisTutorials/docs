---
title: "GridBuildingTestPerformance"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/gridbuildingtestperformance/"
---

# GridBuildingTestPerformance

```csharp
GridBuilding.Godot.Test.Performance
class GridBuildingTestPerformance
{
    // Members...
}
```

C# implementation of GridBuildingTestPerformance for performance testing and benchmarking
Provides comprehensive performance analysis and benchmarking capabilities for GridBuilding systems
Ported from: godot/addons/grid_building/test/grid_building/performance/grid_building_test_performance.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GridBuildingTestPerformance.cs`  
**Namespace:** `GridBuilding.Godot.Test.Performance`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### RunPerformanceBenchmarks

```csharp
#endregion

    #region Performance Benchmarking

    /// <summary>
    /// Runs comprehensive performance benchmarks for GridBuilding systems
    /// </summary>
    /// <param name="testEnvironment">Environment to benchmark</param>
    /// <param name="options">Benchmark options</param>
    /// <returns>Performance benchmark report</returns>
    public static PerformanceBenchmarkReport RunPerformanceBenchmarks(
        Node testEnvironment,
        BenchmarkOptions options = null)
    {
        options ??= new BenchmarkOptions();
        
        var report = new PerformanceBenchmarkReport
        {
            StartTime = DateTime.Now,
            Environment = testEnvironment,
            Options = options,
            SystemInfo = GatherSystemInfo()
        };

        try
        {
            // Initialize performance tracking
            if (PerformanceConfig.EnableMemoryTracking)
            {
                GC.Collect();
                GC.WaitForPendingFinalizers();
                GC.Collect();
                report.InitialMemoryUsage = GC.GetTotalMemory(false);
            }

            // Run placement benchmarks
            if (options.RunPlacementBenchmarks)
            {
                report.PlacementBenchmarks = RunPlacementBenchmarks(testEnvironment, options);
            }

            // Run manipulation benchmarks
            if (options.RunManipulationBenchmarks)
            {
                report.ManipulationBenchmarks = RunManipulationBenchmarks(testEnvironment, options);
            }

            // Run collision benchmarks
            if (options.RunCollisionBenchmarks)
            {
                report.CollisionBenchmarks = RunCollisionBenchmarks(testEnvironment, options);
            }

            // Run rendering benchmarks
            if (options.RunRenderingBenchmarks)
            {
                report.RenderingBenchmarks = RunRenderingBenchmarks(testEnvironment, options);
            }

            // Run memory benchmarks
            if (options.RunMemoryBenchmarks && PerformanceConfig.EnableMemoryTracking)
            {
                report.MemoryBenchmarks = RunMemoryBenchmarks(testEnvironment, options);
            }

            // Calculate overall results
            report.CalculateResults();
            report.EndTime = DateTime.Now;
            report.Duration = report.EndTime - report.StartTime;
            report.Success = true;

            LogMessage(LogLevel.Info, $"Performance benchmarks completed in {report.Duration.TotalMilliseconds:F2}ms");
        }
        catch (Exception ex)
        {
            report.Success = false;
            report.ErrorMessage = ex.Message;
            report.EndTime = DateTime.Now;
            report.Duration = report.EndTime - report.StartTime;

            LogMessage(LogLevel.Error, $"Performance benchmarks failed: {ex.Message}");
        }

        return report;
    }
```

Runs comprehensive performance benchmarks for GridBuilding systems

**Returns:** `PerformanceBenchmarkReport`

**Parameters:**
- `Node testEnvironment`
- `BenchmarkOptions options`

