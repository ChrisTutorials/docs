---
title: "CacheMetrics"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/cachemetrics/"
---

# CacheMetrics

```csharp
GridBuilding.Core.Interfaces
class CacheMetrics
{
    // Members...
}
```

Cache performance metrics.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Interfaces/ICache.cs`  
**Namespace:** `GridBuilding.Core.Interfaces`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Hits

```csharp
/// <summary>
    /// Total number of cache hits.
    /// </summary>
    public int Hits { get; set; }
```

Total number of cache hits.

### Misses

```csharp
/// <summary>
    /// Total number of cache misses.
    /// </summary>
    public int Misses { get; set; }
```

Total number of cache misses.

### Evictions

```csharp
/// <summary>
    /// Total number of evictions due to cache size limits.
    /// </summary>
    public int Evictions { get; set; }
```

Total number of evictions due to cache size limits.

### Cleanups

```csharp
/// <summary>
    /// Total number of cache cleanups.
    /// </summary>
    public int Cleanups { get; set; }
```

Total number of cache cleanups.

### HitRatio

```csharp
/// <summary>
    /// Cache hit ratio (0.0 to 1.0).
    /// </summary>
    public float HitRatio => Hits + Misses > 0 ? (float)Hits / (Hits + Misses) : 0.0f;
```

Cache hit ratio (0.0 to 1.0).


## Methods

### Reset

```csharp
/// <summary>
    /// Resets all metrics to zero.
    /// </summary>
    public void Reset()
    {
        Hits = 0;
        Misses = 0;
        Evictions = 0;
        Cleanups = 0;
    }
```

Resets all metrics to zero.

**Returns:** `void`

