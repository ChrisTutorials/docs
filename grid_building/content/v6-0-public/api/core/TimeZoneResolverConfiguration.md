---
title: "TimeZoneResolverConfiguration"
description: "Time zone resolver configuration"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/timezoneresolverconfiguration/"
---

# TimeZoneResolverConfiguration

```csharp
GridBuilding.Core.Configuration
class TimeZoneResolverConfiguration
{
    // Members...
}
```

Time zone resolver configuration

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/ResolverConfigurations.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; } = "DefaultTimeZone";
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
public int CacheExpirationMinutes { get; set; } = 60;
```

### PreloadCommonTimeZones

```csharp
public bool PreloadCommonTimeZones { get; set; } = true;
```

### EnableAsyncResolution

```csharp
public bool EnableAsyncResolution { get; set; } = false;
```

### FallbackTimeZone

```csharp
public string FallbackTimeZone { get; set; } = "UTC";
```


## Methods

### IsValid

```csharp
public bool IsValid()
    {
        return MaxCacheSize > 0 &&
               CacheExpirationMinutes > 0 &&
               !string.IsNullOrEmpty(FallbackTimeZone);
    }
```

**Returns:** `bool`

### Clone

```csharp
public IResolverConfiguration Clone()
    {
        return new TimeZoneResolverConfiguration
        {
            Name = Name,
            Version = Version,
            IsEnabled = IsEnabled,
            Properties = new Dictionary<string, object>(Properties),
            MaxCacheSize = MaxCacheSize,
            CacheExpirationMinutes = CacheExpirationMinutes,
            PreloadCommonTimeZones = PreloadCommonTimeZones,
            EnableAsyncResolution = EnableAsyncResolution,
            FallbackTimeZone = FallbackTimeZone
        };
    }
```

**Returns:** `IResolverConfiguration`

