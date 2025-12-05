---
title: "PerformanceTestResult"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/performancetestresult/"
---

# PerformanceTestResult

```csharp
GridBuilding.Godot.Tests.Environments
class PerformanceTestResult
{
    // Members...
}
```

Performance test result

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/CollisionTestEnvironment.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Environments`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Success

```csharp
public bool Success { get; set; }
```

### Message

```csharp
public string Message { get; set; } = "";
```

### Iterations

```csharp
public int Iterations { get; set; }
```

### AverageTimeMs

```csharp
public double AverageTimeMs { get; set; }
```

### MinTimeMs

```csharp
public double MinTimeMs { get; set; }
```

### MaxTimeMs

```csharp
public double MaxTimeMs { get; set; }
```

