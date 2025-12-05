---
title: "ValidatorCacheStatistics"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/validatorcachestatistics/"
---

# ValidatorCacheStatistics

```csharp
GridBuilding.Core.Systems.Validation
class ValidatorCacheStatistics
{
    // Members...
}
```

Validator cache statistics

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/IValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
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

### TotalValidations

```csharp
public long TotalValidations { get; init; }
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
public double HitRatio => TotalValidations > 0 ? (double)CacheHits / TotalValidations : 0.0f;
```

### AverageValidationTime

```csharp
public TimeSpan AverageValidationTime { get; init; }
```

