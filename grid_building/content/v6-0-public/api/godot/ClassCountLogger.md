---
title: "ClassCountLogger"
description: "C# implementation of ClassCountLogger for debugging and analysis
Provides class counting and analysis capabilities for GridBuilding systems
Ported from: godot/addons/grid_building/core/logging/gb_class_count_logger.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/classcountlogger/"
---

# ClassCountLogger

```csharp
GridBuilding.Godot.Core.Logging
class ClassCountLogger
{
    // Members...
}
```

C# implementation of ClassCountLogger for debugging and analysis
Provides class counting and analysis capabilities for GridBuilding systems
Ported from: godot/addons/grid_building/core/logging/gb_class_count_logger.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Infrastructure/ClassCountLogger.cs`  
**Namespace:** `GridBuilding.Godot.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CountGridBuildingClasses

```csharp
#endregion

    #region Class Counting

    /// <summary>
    /// Counts and logs all GridBuilding classes in the current scene
    /// </summary>
    /// <param name="root">Root node to start counting from</param>
    /// <returns>Class count report</returns>
    public static ClassCountReport CountGridBuildingClasses(Node root = null)
    {
        if (!LoggingConfig.EnableClassCounting)
            return new ClassCountReport { Success = false, Message = "Class counting is disabled" };

        var report = new ClassCountReport
        {
            StartTime = DateTime.Now,
            RootNode = root ?? ((Engine.GetMainLoop() as SceneTree)?.CurrentScene)
        };

        try
        {
            // Count classes by category
            report.CoreClasses = CountClassesByType(report.RootNode, "GridBuilding.Core");
            report.GodotClasses = CountClassesByType(report.RootNode, "GridBuilding.Godot");
            report.TestClasses = CountClassesByType(report.RootNode, "GridBuilding.Test");
            
            // Count specific system classes
            report.SystemClasses = CountSystemClasses(report.RootNode);
            
            // Analyze class distribution
            report.ClassDistribution = AnalyzeClassDistribution(report);
            
            // Generate insights
            report.Insights = GenerateClassInsights(report);
            
            report.EndTime = DateTime.Now;
            report.Duration = report.EndTime - report.StartTime;
            report.Success = true;

            // Log the report
            LogClassCountReport(report);

            return report;
        }
        catch (Exception ex)
        {
            report.Success = false;
            report.Message = ex.Message;
            report.EndTime = DateTime.Now;
            report.Duration = report.EndTime - report.StartTime;

            GD.PrintErr($"ClassCountLogger failed: {ex.Message}");
            return report;
        }
    }
```

Counts and logs all GridBuilding classes in the current scene

**Returns:** `ClassCountReport`

**Parameters:**
- `Node root`

### TrackPerformance

```csharp
#endregion

    #region Performance Tracking

    /// <summary>
    /// Tracks class creation/deletion performance
    /// </summary>
    /// <param name="operation">Operation being tracked</param>
    /// <param name="className">Class being operated on</param>
    /// <returns>Performance tracker</returns>
    public static ClassPerformanceTracker TrackPerformance(string operation, string className)
    {
        if (!LoggingConfig.EnablePerformanceTracking)
            return new ClassPerformanceTracker { Enabled = false };

        return new ClassPerformanceTracker
        {
            Enabled = true,
            Operation = operation,
            ClassName = className,
            StartTime = DateTime.Now
        };
    }
```

Tracks class creation/deletion performance

**Returns:** `ClassPerformanceTracker`

**Parameters:**
- `string operation`
- `string className`

### AnalyzeUsagePatterns

```csharp
#endregion

    #region Analysis Methods

    /// <summary>
    /// Analyzes class usage patterns over time
    /// </summary>
    /// <param name="reports">Collection of historical reports</param>
    /// <returns>Usage pattern analysis</returns>
    public static ClassUsageAnalysis AnalyzeUsagePatterns(IEnumerable<ClassCountReport> reports)
    {
        var reportList = reports.ToList();
        if (reportList.Count < 2)
        {
            return new ClassUsageAnalysis
            {
                Success = false,
                Message = "Insufficient data for analysis (need at least 2 reports)"
            };
        }

        var analysis = new ClassUsageAnalysis
        {
            Success = true,
            ReportCount = reportList.Count,
            TimeRange = reportList.Last().StartTime - reportList.First().StartTime
        };

        // Calculate growth trends
        var firstReport = reportList.First();
        var lastReport = reportList.Last();

        analysis.TotalClassGrowth = lastReport.ClassDistribution.TotalClasses - firstReport.ClassDistribution.TotalClasses;
        analysis.CoreClassGrowth = lastReport.ClassDistribution.TotalCoreClasses - firstReport.ClassDistribution.TotalCoreClasses;
        analysis.GodotClassGrowth = lastReport.ClassDistribution.TotalGodotClasses - firstReport.ClassDistribution.TotalGodotClasses;

        // Calculate average duration
        analysis.AverageAnalysisDuration = TimeSpan.FromTicks(
            (long)reportList.Average(r => r.Duration.Ticks));

        return analysis;
    }
```

Analyzes class usage patterns over time

**Returns:** `ClassUsageAnalysis`

**Parameters:**
- `IEnumerable<ClassCountReport> reports`

