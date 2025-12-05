---
title: "PerformanceMeasurement"
description: "Performance measurement context for timing operations and tracking memory usage."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/performancemeasurement/"
---

# PerformanceMeasurement

```csharp
GridBuilding.Godot.Core.Diagnostics
class PerformanceMeasurement
{
    // Members...
}
```

Performance measurement context for timing operations and tracking memory usage.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Logging/Diagnostics.cs`  
**Namespace:** `GridBuilding.Godot.Core.Diagnostics`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### OperationName

```csharp
public string OperationName { get; }
```

### ElapsedMilliseconds

```csharp
public long ElapsedMilliseconds => _stopwatch.ElapsedMilliseconds;
```

### MemoryAllocated

```csharp
public long MemoryAllocated => GC.GetTotalMemory(false) - _startMemory;
```


## Methods

### Dispose

```csharp
public void Dispose()
    {
        _stopwatch.Stop();
    }
```

**Returns:** `void`

