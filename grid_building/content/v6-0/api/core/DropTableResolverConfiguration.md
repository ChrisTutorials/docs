---
title: "DropTableResolverConfiguration"
description: "Drop table resolver configuration"
weight: 10
url: "/gridbuilding/v6-0/api/core/droptableresolverconfiguration/"
---

# DropTableResolverConfiguration

```csharp
GridBuilding.Core.Configuration
class DropTableResolverConfiguration
{
    // Members...
}
```

Drop table resolver configuration

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/ResolverConfigurations.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; } = "DefaultDropTable";
```

### Version

```csharp
public string Version { get; set; } = "1.0.0";
```

### IsEnabled

```csharp
public bool IsEnabled { get; set; } = true;
```

### Properties

```csharp
public Dictionary<string, object> Properties { get; set; } = new();
```

### MaxCacheSize

```csharp
public int MaxCacheSize { get; set; } = 2000;
```

### CacheExpirationMinutes

```csharp
public int CacheExpirationMinutes { get; set; } = 15;
```

### EnableAsyncResolution

```csharp
public bool EnableAsyncResolution { get; set; } = false;
```

### UseDeterministicRandom

```csharp
public bool UseDeterministicRandom { get; set; } = true;
```

### RandomSeed

```csharp
public int RandomSeed { get; set; } = 12345;
```

### MaxDropsPerTable

```csharp
public int MaxDropsPerTable { get; set; } = 50;
```

### RarityWeightMultiplier

```csharp
public double RarityWeightMultiplier { get; set; } = 1.0;
```


## Methods

### IsValid

```csharp
public bool IsValid()
    {
        return MaxCacheSize > 0 &&
               CacheExpirationMinutes > 0 &&
               MaxDropsPerTable > 0 &&
               RarityWeightMultiplier > 0;
    }
```

**Returns:** `bool`

### Clone

```csharp
public IResolverConfiguration Clone()
    {
        return new DropTableResolverConfiguration
        {
            Name = Name,
            Version = Version,
            IsEnabled = IsEnabled,
            Properties = new Dictionary<string, object>(Properties),
            MaxCacheSize = MaxCacheSize,
            CacheExpirationMinutes = CacheExpirationMinutes,
            EnableAsyncResolution = EnableAsyncResolution,
            UseDeterministicRandom = UseDeterministicRandom,
            RandomSeed = RandomSeed,
            MaxDropsPerTable = MaxDropsPerTable,
            RarityWeightMultiplier = RarityWeightMultiplier
        };
    }
```

**Returns:** `IResolverConfiguration`

