---
title: "MemoryBenchmarkResult"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/memorybenchmarkresult/"
---

# MemoryBenchmarkResult

```csharp
GridBuilding.Godot.Test.Performance
class MemoryBenchmarkResult
{
    // Members...
}
```

Memory benchmark result

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GridBuildingTestPerformance.cs`  
**Namespace:** `GridBuilding.Godot.Test.Performance`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### InitialMemory

```csharp
public long InitialMemory { get; set; }
```

### FinalMemory

```csharp
public long FinalMemory { get; set; }
```

### MemoryAllocated

```csharp
public long MemoryAllocated { get; set; }
```

### MemoryReclaimed

```csharp
public long MemoryReclaimed { get; set; }
```

### MemoryLeaked

```csharp
public long MemoryLeaked { get; set; }
```

### ObjectsAllocated

```csharp
public int ObjectsAllocated { get; set; }
```

### Success

```csharp
public bool Success { get; set; }
```

