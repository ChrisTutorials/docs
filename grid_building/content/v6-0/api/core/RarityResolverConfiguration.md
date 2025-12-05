---
title: "RarityResolverConfiguration"
description: "Rarity resolver configuration"
weight: 10
url: "/gridbuilding/v6-0/api/core/rarityresolverconfiguration/"
---

# RarityResolverConfiguration

```csharp
GridBuilding.Core.Configuration
class RarityResolverConfiguration
{
    // Members...
}
```

Rarity resolver configuration

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/ResolverConfigurations.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; } = "DefaultRarity";
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
public int MaxCacheSize { get; set; } = 100;
```

### CacheExpirationMinutes

```csharp
public int CacheExpirationMinutes { get; set; } = 120;
```

### EnableRarityModifiers

```csharp
public bool EnableRarityModifiers { get; set; } = true;
```

### MaxModifierStack

```csharp
public int MaxModifierStack { get; set; } = 10;
```

### BaseDropChanceMultiplier

```csharp
public double BaseDropChanceMultiplier { get; set; } = 1.0;
```

### LegendaryDropChanceCap

```csharp
public double LegendaryDropChanceCap { get; set; } = 0.05;
```


## Methods

### IsValid

```csharp
public bool IsValid()
    {
        return MaxCacheSize > 0 &&
               CacheExpirationMinutes > 0 &&
               MaxModifierStack > 0 &&
               BaseDropChanceMultiplier > 0 &&
               LegendaryDropChanceCap >= 0 &&
               LegendaryDropChanceCap <= 1.0;
    }
```

**Returns:** `bool`

### Clone

```csharp
public IResolverConfiguration Clone()
    {
        return new RarityResolverConfiguration
        {
            Name = Name,
            Version = Version,
            IsEnabled = IsEnabled,
            Properties = new Dictionary<string, object>(Properties),
            MaxCacheSize = MaxCacheSize,
            CacheExpirationMinutes = CacheExpirationMinutes,
            EnableRarityModifiers = EnableRarityModifiers,
            MaxModifierStack = MaxModifierStack,
            BaseDropChanceMultiplier = BaseDropChanceMultiplier,
            LegendaryDropChanceCap = LegendaryDropChanceCap
        };
    }
```

**Returns:** `IResolverConfiguration`

