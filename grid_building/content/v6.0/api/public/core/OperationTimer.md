---
title: "OperationTimer"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/operationtimer/"
---

# OperationTimer

```csharp
GridBuilding.Core.Services.DI
class OperationTimer
{
    // Members...
}
```

Internal timer class that automatically records timing when disposed.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/PerformanceProfiler.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Dispose

```csharp
public void Dispose()
        {
            if (!_disposed)
            {
                _stopwatch.Stop();
                _profiler.RecordTiming(_operationName, _stopwatch.ElapsedMilliseconds);
                _disposed = true;
            }
        }
```

**Returns:** `void`

