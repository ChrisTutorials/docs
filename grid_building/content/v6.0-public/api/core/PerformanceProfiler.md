---
title: "PerformanceProfiler"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/performanceprofiler/"
---

# PerformanceProfiler

```csharp
GridBuilding.Core.Services.DI
class PerformanceProfiler
{
    // Members...
}
```

Performance profiler for tracking service execution times and system metrics.
Provides timing capabilities for performance monitoring and optimization.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/PerformanceProfiler.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ActiveTimerCount

```csharp
/// <summary>
    /// Gets the number of operations being currently timed.
    /// </summary>
    public int ActiveTimerCount
    {
        get
        {
            lock (_lock)
            {
                return _activeTimers.Count;
            }
        }
    }
```

Gets the number of operations being currently timed.


## Methods

### StartTiming

```csharp
/// <summary>
    /// Starts timing a named operation.
    /// </summary>
    /// <param name="operationName">Name of the operation to time</param>
    /// <returns>Disposable that will stop timing when disposed</returns>
    public IDisposable StartTiming(string operationName)
    {
        return new OperationTimer(this, operationName);
    }
```

Starts timing a named operation.

**Returns:** `IDisposable`

**Parameters:**
- `string operationName`

### GetStats

```csharp
/// <summary>
    /// Gets statistics for a specific operation.
    /// </summary>
    /// <param name="operationName">Name of the operation</param>
    /// <returns>Performance statistics or null if operation not found</returns>
    public PerformanceStats? GetStats(string operationName)
    {
        lock (_lock)
        {
            if (!_timings.ContainsKey(operationName))
                return null;

            var timings = _timings[operationName];
            if (timings.Count == 0)
                return null;

            return new PerformanceStats
            {
                OperationName = operationName,
                Count = timings.Count,
                TotalMs = timings.Sum(),
                AverageMs = timings.Average(),
                MinMs = timings.Min(),
                MaxMs = timings.Max()
            };
        }
    }
```

Gets statistics for a specific operation.

**Returns:** `PerformanceStats?`

**Parameters:**
- `string operationName`

### GetAllStats

```csharp
/// <summary>
    /// Gets statistics for all recorded operations.
    /// </summary>
    /// <returns>Dictionary of operation names to performance statistics</returns>
    public Dictionary<string, PerformanceStats> GetAllStats()
    {
        lock (_lock)
        {
            var result = new Dictionary<string, PerformanceStats>();
            foreach (var operationName in _timings.Keys)
            {
                var stats = GetStats(operationName);
                if (stats != null)
                {
                    result[operationName] = stats;
                }
            }
            return result;
        }
    }
```

Gets statistics for all recorded operations.

**Returns:** `Dictionary<string, PerformanceStats>`

### Clear

```csharp
/// <summary>
    /// Clears all recorded timing data.
    /// </summary>
    public void Clear()
    {
        lock (_lock)
        {
            _timings.Clear();
            _activeTimers.Clear();
        }
    }
```

Clears all recorded timing data.

**Returns:** `void`

### Dispose

```csharp
public void Dispose()
    {
        lock (_lock)
        {
            foreach (var timer in _activeTimers.Values)
            {
                timer.Stop();
            }
            _activeTimers.Clear();
            _timings.Clear();
        }
    }
```

**Returns:** `void`

