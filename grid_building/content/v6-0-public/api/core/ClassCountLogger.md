---
title: "ClassCountLogger"
description: "Utility for logging class counts and statistics for GridBuilding debugging
Provides insights into class instantiation, memory usage, and system composition"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/classcountlogger/"
---

# ClassCountLogger

```csharp
GridBuilding.Core.Logging
class ClassCountLogger
{
    // Members...
}
```

Utility for logging class counts and statistics for GridBuilding debugging
Provides insights into class instantiation, memory usage, and system composition

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Logging/ClassCountLogger.cs`  
**Namespace:** `GridBuilding.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Config

```csharp
/// <summary>
    /// Configuration for logging behavior
    /// </summary>
    public static LoggingConfig Config { get; set; } = new();
```

Configuration for logging behavior

### Statistics

```csharp
/// <summary>
    /// Statistics about logged classes
    /// </summary>
    public static ClassStatistics Statistics => CalculateStatistics();
```

Statistics about logged classes


## Methods

### RegisterInstance

```csharp
#endregion
    
    #region Class Registration
    
    /// <summary>
    /// Registers a class instance for tracking
    /// </summary>
    /// <param name="instance">Instance to track</param>
    /// <param name="category">Optional category for grouping</param>
    public static void RegisterInstance(object instance, string category = "Default")
    {
        if (instance == null) return;
        
        var className = instance.GetType().Name;
        var fullName = instance.GetType().FullName ?? className;
        
        // Update class counts
        if (!_classCounts.ContainsKey(fullName))
        {
            _classCounts[fullName] = new ClassCountInfo
            {
                ClassName = className,
                FullName = fullName,
                Category = category,
                FirstCreated = Time.GetUnixTimeFromSystem()
            };
        }
        
        _classCounts[fullName].InstanceCount++;
        _classCounts[fullName].LastCreated = Time.GetUnixTimeFromSystem();
        
        // Track instance if enabled
        if (Config.TrackIndividualInstances)
        {
            _instanceTracking[instance] = new InstanceInfo
            {
                ClassName = fullName,
                CreatedAt = Time.GetUnixTimeFromSystem(),
                Category = category
            };
        }
        
        // Log if threshold reached
        if (_classCounts[fullName].InstanceCount == Config.WarningThreshold)
        {
            GD.PrintRich($"[color=yellow]Warning: Class {className} reached {Config.WarningThreshold} instances[/color]");
        }
        
        if (_classCounts[fullName].InstanceCount == Config.CriticalThreshold)
        {
            GD.PrintRich($"[color=red]Critical: Class {className} reached {Config.CriticalThreshold} instances[/color]");
        }
    }
```

Registers a class instance for tracking

**Returns:** `void`

**Parameters:**
- `object instance`
- `string category`

### UnregisterInstance

```csharp
/// <summary>
    /// Unregisters an instance (typically when destroyed)
    /// </summary>
    /// <param name="instance">Instance to unregister</param>
    public static void UnregisterInstance(object instance)
    {
        if (instance == null) return;
        
        var fullName = instance.GetType().FullName ?? instance.GetType().Name;
        
        if (_classCounts.ContainsKey(fullName))
        {
            _classCounts[fullName].InstanceCount--;
            _classCounts[fullName].LastDestroyed = Time.GetUnixTimeFromSystem();
        }
        
        // Remove from instance tracking
        _instanceTracking.Remove(instance);
    }
```

Unregisters an instance (typically when destroyed)

**Returns:** `void`

**Parameters:**
- `object instance`

### RegisterGridBuildingClasses

```csharp
/// <summary>
    /// Registers all GridBuilding classes in the current assembly
    /// </summary>
    public static void RegisterGridBuildingClasses()
    {
        var assembly = Assembly.GetExecutingAssembly();
        var gridBuildingTypes = assembly.GetTypes()
            .Where(t => t.Namespace != null && t.Namespace.StartsWith("GridBuilding"))
            .ToList();
        
        GD.Print($"Found {gridBuildingTypes.Count} GridBuilding types");
        
        foreach (var type in gridBuildingTypes)
        {
            if (!_classCounts.ContainsKey(type.FullName!))
            {
                _classCounts[type.FullName!] = new ClassCountInfo
                {
                    ClassName = type.Name,
                    FullName = type.FullName!,
                    Category = GetCategoryFromNamespace(type.Namespace!),
                    IsAbstract = type.IsAbstract,
                    IsInterface = type.IsInterface,
                    IsEnum = type.IsEnum
                };
            }
        }
    }
```

Registers all GridBuilding classes in the current assembly

**Returns:** `void`

### LogCurrentCounts

```csharp
#endregion
    
    #region Logging and Reporting
    
    /// <summary>
    /// Logs current class counts
    /// </summary>
    public static void LogCurrentCounts()
    {
        GD.Print("=== GridBuilding Class Counts ===");
        
        var sortedCounts = _classCounts
            .Where(kvp => kvp.Value.InstanceCount > 0)
            .OrderByDescending(kvp => kvp.Value.InstanceCount)
            .ToList();
        
        foreach (var kvp in sortedCounts)
        {
            var info = kvp.Value;
            GD.Print($"{info.ClassName}: {info.InstanceCount} instances ({info.Category})");
        }
        
        GD.Print($"Total classes with instances: {sortedCounts.Count}");
        GD.Print($"Total instances: {sortedCounts.Sum(kvp => kvp.Value.InstanceCount)}");
    }
```

Logs current class counts

**Returns:** `void`

### LogDetailedStatistics

```csharp
/// <summary>
    /// Logs detailed statistics
    /// </summary>
    public static void LogDetailedStatistics()
    {
        var stats = CalculateStatistics();
        
        GD.Print("=== Detailed Class Statistics ===");
        GD.Print($"Total Classes Registered: {stats.TotalClassesRegistered}");
        GD.Print($"Classes with Instances: {stats.ClassesWithInstances}");
        GD.Print($"Total Instances: {stats.TotalInstances}");
        GD.Print($"Average Instances per Class: {stats.AverageInstancesPerClass:F2}");
        
        GD.Print("\n=== By Category ===");
        foreach (var category in stats.ByCategory.OrderByDescending(kvp => kvp.Value.TotalInstances))
        {
            GD.Print($"{category.Key}: {category.Value.TotalInstances} instances, {category.Value.ClassCount} classes");
        }
        
        GD.Print("\n=== Top Classes by Instance Count ===");
        foreach (var classInfo in stats.TopClassesByInstanceCount.Take(10))
        {
            GD.Print($"{classInfo.ClassName}: {classInfo.InstanceCount} instances");
        }
        
        if (stats.MemoryEstimate > 0)
        {
            GD.Print($"\nEstimated Memory Usage: {stats.MemoryEstimate / 1024.0 / 1024.0:F2} MB");
        }
    }
```

Logs detailed statistics

**Returns:** `void`

### LogClassHierarchy

```csharp
/// <summary>
    /// Logs class hierarchy information
    /// </summary>
    public static void LogClassHierarchy()
    {
        GD.Print("=== GridBuilding Class Hierarchy ===");
        
        var assembly = Assembly.GetExecutingAssembly();
        var gridBuildingTypes = assembly.GetTypes()
            .Where(t => t.Namespace != null && t.Namespace.StartsWith("GridBuilding"))
            .OrderBy(t => t.FullName)
            .ToList();
        
        foreach (var type in gridBuildingTypes)
        {
            var modifiers = string.Empty;
            if (type.IsAbstract) modifiers += "abstract ";
            if (type.IsInterface) modifiers += "interface ";
            if (type.IsEnum) modifiers += "enum ";
            if (type.IsSealed) modifiers += "sealed ";
            
            var baseType = type.BaseType?.Name ?? "Object";
            var instanceCount = _classCounts.TryGetValue(type.FullName!, out var info) ? info.InstanceCount : 0;
            
            GD.Print($"{modifiers}{type.Name} : {baseType} ({instanceCount} instances)");
        }
    }
```

Logs class hierarchy information

**Returns:** `void`

### GenerateReport

```csharp
/// <summary>
    /// Generates a comprehensive report
    /// </summary>
    public static string GenerateReport()
    {
        var stats = CalculateStatistics();
        var report = "=== GridBuilding Class Count Report ===\n\n";
        
        report += $"Generated: {System.DateTime.Now:yyyy-MM-dd HH:mm:ss}\n";
        report += $"Total Classes Registered: {stats.TotalClassesRegistered}\n";
        report += $"Classes with Instances: {stats.ClassesWithInstances}\n";
        report += $"Total Instances: {stats.TotalInstances}\n";
        report += $"Average Instances per Class: {stats.AverageInstancesPerClass:F2}\n\n";
        
        report += "=== By Category ===\n";
        foreach (var category in stats.ByCategory.OrderByDescending(kvp => kvp.Value.TotalInstances))
        {
            report += $"{category.Key}: {category.Value.TotalInstances} instances, {category.Value.ClassCount} classes\n";
        }
        
        report += "\n=== Top Classes by Instance Count ===\n";
        foreach (var classInfo in stats.TopClassesByInstanceCount.Take(20))
        {
            report += $"{classInfo.ClassName}: {classInfo.InstanceCount} instances\n";
        }
        
        if (stats.MemoryEstimate > 0)
        {
            report += $"\nEstimated Memory Usage: {stats.MemoryEstimate / 1024.0 / 1024.0:F2} MB\n";
        }
        
        report += "\n=== Configuration ===\n";
        report += $"Warning Threshold: {Config.WarningThreshold}\n";
        report += $"Critical Threshold: {Config.CriticalThreshold}\n";
        report += $"Track Individual Instances: {Config.TrackIndividualInstances}\n";
        report += $"Auto Register: {Config.AutoRegister}\n";
        
        return report;
    }
```

Generates a comprehensive report

**Returns:** `string`

### ExportToCSV

```csharp
/// <summary>
    /// Exports data to CSV format
    /// </summary>
    public static string ExportToCSV()
    {
        var csv = "ClassName,FullName,Category,InstanceCount,IsAbstract,IsInterface,IsEnum,FirstCreated,LastCreated\n";
        
        foreach (var info in _classCounts.Values.OrderBy(i => i.Category).ThenBy(i => i.ClassName))
        {
            csv += $"\"{info.ClassName}\",\"{info.FullName}\",\"{info.Category}\",{info.InstanceCount},";
            csv += $"{info.IsAbstract},{info.IsInterface},{info.IsEnum},";
            csv += $"{info.FirstCreated},{info.LastCreated}\n";
        }
        
        return csv;
    }
```

Exports data to CSV format

**Returns:** `string`

### AnalyzeForIssues

```csharp
#endregion
    
    #region Analysis and Diagnostics
    
    /// <summary>
    /// Analyzes for potential issues
    /// </summary>
    public static List<string> AnalyzeForIssues()
    {
        var issues = new List<string>();
        
        // Check for high instance counts
        var highInstanceClasses = _classCounts.Values
            .Where(info => info.InstanceCount >= Config.WarningThreshold)
            .OrderByDescending(info => info.InstanceCount)
            .ToList();
        
        if (highInstanceClasses.Count > 0)
        {
            issues.Add($"Found {highInstanceClasses.Count} classes with high instance counts:");
            foreach (var info in highInstanceClasses.Take(5))
            {
                issues.Add($"  - {info.ClassName}: {info.InstanceCount} instances");
            }
        }
        
        // Check for potential memory leaks (classes with many instances but no recent destructions)
        var potentialLeaks = _classCounts.Values
            .Where(info => info.InstanceCount > 100 && 
                         info.LastDestroyed < info.LastCreated - 60) // No destructions in last minute
            .ToList();
        
        if (potentialLeaks.Count > 0)
        {
            issues.Add($"Found {potentialLeaks.Count} classes with potential memory leaks:");
            foreach (var info in potentialLeaks)
            {
                issues.Add($"  - {info.ClassName}: {info.InstanceCount} instances, last destroyed {Time.GetUnixTimeFromSystem() - info.LastDestroyed}s ago");
            }
        }
        
        // Check for zero instance classes (might indicate unused code)
        var zeroInstanceClasses = _classCounts.Values
            .Where(info => !info.IsAbstract && !info.IsInterface && info.InstanceCount == 0)
            .ToList();
        
        if (zeroInstanceClasses.Count > 0)
        {
            issues.Add($"Found {zeroInstanceClasses.Count} concrete classes with zero instances:");
            foreach (var info in zeroInstanceClasses.Take(10))
            {
                issues.Add($"  - {info.ClassName} ({info.Category})");
            }
        }
        
        return issues;
    }
```

Analyzes for potential issues

**Returns:** `List<string>`

### FindClassesByPattern

```csharp
/// <summary>
    /// Finds classes by pattern
    /// </summary>
    public static List<ClassCountInfo> FindClassesByPattern(string pattern)
    {
        return _classCounts.Values
            .Where(info => info.ClassName.Contains(pattern, System.StringComparison.OrdinalIgnoreCase) ||
                          info.FullName.Contains(pattern, System.StringComparison.OrdinalIgnoreCase) ||
                          info.Category.Contains(pattern, System.StringComparison.OrdinalIgnoreCase))
            .ToList();
    }
```

Finds classes by pattern

**Returns:** `List<ClassCountInfo>`

**Parameters:**
- `string pattern`

### GetClassesByCategory

```csharp
/// <summary>
    /// Gets classes by category
    /// </summary>
    public static List<ClassCountInfo> GetClassesByCategory(string category)
    {
        return _classCounts.Values
            .Where(info => info.Category.Equals(category, System.StringComparison.OrdinalIgnoreCase))
            .ToList();
    }
```

Gets classes by category

**Returns:** `List<ClassCountInfo>`

**Parameters:**
- `string category`

### ClearAllData

```csharp
#endregion
    
    #region Management
    
    /// <summary>
    /// Clears all tracking data
    /// </summary>
    public static void ClearAllData()
    {
        _classCounts.Clear();
        _instanceTracking.Clear();
    }
```

Clears all tracking data

**Returns:** `void`

### ResetInstanceCounts

```csharp
/// <summary>
    /// Resets instance counts to zero
    /// </summary>
    public static void ResetInstanceCounts()
    {
        foreach (var info in _classCounts.Values)
        {
            info.InstanceCount = 0;
            info.LastCreated = 0;
            info.LastDestroyed = 0;
        }
        
        _instanceTracking.Clear();
    }
```

Resets instance counts to zero

**Returns:** `void`

### Initialize

```csharp
/// <summary>
    /// Initializes the logger with default settings
    /// </summary>
    public static void Initialize()
    {
        if (Config.AutoRegister)
        {
            RegisterGridBuildingClasses();
        }
    }
```

Initializes the logger with default settings

**Returns:** `void`

