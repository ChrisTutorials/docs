---
title: "ClassStatistics"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/classstatistics/"
---

# ClassStatistics

```csharp
GridBuilding.Core.Logging
class ClassStatistics
{
    // Members...
}
```

Statistics about logged classes

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Logging/ClassCountLogger.cs`  
**Namespace:** `GridBuilding.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TotalClassesRegistered

```csharp
public int TotalClassesRegistered { get; set; }
```

### ClassesWithInstances

```csharp
public int ClassesWithInstances { get; set; }
```

### TotalInstances

```csharp
public int TotalInstances { get; set; }
```

### AverageInstancesPerClass

```csharp
public double AverageInstancesPerClass { get; set; }
```

### ByCategory

```csharp
public Dictionary<string, CategoryStats> ByCategory { get; set; } = new();
```

### TopClassesByInstanceCount

```csharp
public List<ClassCountInfo> TopClassesByInstanceCount { get; set; } = new();
```

### MemoryEstimate

```csharp
public long MemoryEstimate { get; set; }
```

