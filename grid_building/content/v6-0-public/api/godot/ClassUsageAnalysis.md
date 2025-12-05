---
title: "ClassUsageAnalysis"
description: "Analysis of class usage patterns over time"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/classusageanalysis/"
---

# ClassUsageAnalysis

```csharp
GridBuilding.Godot.Core.Logging
class ClassUsageAnalysis
{
    // Members...
}
```

Analysis of class usage patterns over time

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Infrastructure/ClassCountLogger.cs`  
**Namespace:** `GridBuilding.Godot.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Success

```csharp
public bool Success { get; set; }
```

### Message

```csharp
public string Message { get; set; } = string.Empty;
```

### ReportCount

```csharp
public int ReportCount { get; set; }
```

### TimeRange

```csharp
public TimeSpan TimeRange { get; set; }
```

### TotalClassGrowth

```csharp
public int TotalClassGrowth { get; set; }
```

### CoreClassGrowth

```csharp
public int CoreClassGrowth { get; set; }
```

### GodotClassGrowth

```csharp
public int GodotClassGrowth { get; set; }
```

### AverageAnalysisDuration

```csharp
public TimeSpan AverageAnalysisDuration { get; set; }
```

