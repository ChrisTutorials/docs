---
title: "CacheStats"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/cachestats/"
---

# CacheStats

```csharp
GridBuilding.Core.Services.DI
class CacheStats
{
    // Members...
}
```

Cache statistics for monitoring cache performance.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/GeometryCache.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TotalEntries

```csharp
public int TotalEntries { get; set; }
```

### ActiveEntries

```csharp
public int ActiveEntries { get; set; }
```

### ExpiredEntries

```csharp
public int ExpiredEntries { get; set; }
```


## Methods

### ToString

```csharp
public override string ToString()
    {
        return $"Total: {TotalEntries}, Active: {ActiveEntries}, Expired: {ExpiredEntries}";
    }
```

**Returns:** `string`

