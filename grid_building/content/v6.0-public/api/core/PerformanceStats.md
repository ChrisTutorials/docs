---
title: "PerformanceStats"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/performancestats/"
---

# PerformanceStats

```csharp
GridBuilding.Core.Services.DI
class PerformanceStats
{
    // Members...
}
```

Performance statistics for a timed operation.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/PerformanceProfiler.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### OperationName

```csharp
public string OperationName { get; set; } = string.Empty;
```

### Count

```csharp
public int Count { get; set; }
```

### TotalMs

```csharp
public long TotalMs { get; set; }
```

### AverageMs

```csharp
public double AverageMs { get; set; }
```

### MinMs

```csharp
public long MinMs { get; set; }
```

### MaxMs

```csharp
public long MaxMs { get; set; }
```


## Methods

### ToString

```csharp
public override string ToString()
    {
        return $"{OperationName}: {Count} calls, Avg={AverageMs:F2}ms, Min={MinMs}ms, Max={MaxMs}ms, Total={TotalMs}ms";
    }
```

**Returns:** `string`

