---
title: "CalculatorCacheStatistics"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/calculatorcachestatistics/"
---

# CalculatorCacheStatistics

```csharp
GridBuilding.Core.Services
class CalculatorCacheStatistics
{
    // Members...
}
```

Calculator cache statistics

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/ICalculator.cs`  
**Namespace:** `GridBuilding.Core.Services`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CacheSize

```csharp
public int CacheSize { get; init; }
```

### CacheCapacity

```csharp
public int CacheCapacity { get; init; }
```

### TotalCalculations

```csharp
public long TotalCalculations { get; init; }
```

### CacheHits

```csharp
public long CacheHits { get; init; }
```

### CacheMisses

```csharp
public long CacheMisses { get; init; }
```

### HitRatio

```csharp
public double HitRatio => TotalCalculations > 0 ? (double)CacheHits / TotalCalculations : 0.0;
```

