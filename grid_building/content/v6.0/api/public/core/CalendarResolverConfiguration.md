---
title: "CalendarResolverConfiguration"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/calendarresolverconfiguration/"
---

# CalendarResolverConfiguration

```csharp
GridBuilding.Core.Configuration
class CalendarResolverConfiguration
{
    // Members...
}
```

Calendar resolver configuration

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/ResolverConfigurations.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; } = "DefaultCalendar";
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
public int MaxCacheSize { get; set; } = 1000;
```

### CacheExpirationMinutes

```csharp
public int CacheExpirationMinutes { get; set; } = 30;
```

### EnableAsyncResolution

```csharp
public bool EnableAsyncResolution { get; set; } = true;
```

### AsyncThreshold

```csharp
public int AsyncThreshold { get; set; } = 10;
```

### SupportedCalendarSystems

```csharp
public List<CalendarSystem> SupportedCalendarSystems { get; set; } = new List<CalendarSystem>();
```

### DefaultCalendarSystem

```csharp
public CalendarSystem DefaultCalendarSystem { get; set; } = CalendarSystem.Gregorian;
```


## Methods

### IsValid

```csharp
public bool IsValid()
    {
        return MaxCacheSize > 0 &&
               CacheExpirationMinutes > 0 &&
               AsyncThreshold > 0 &&
               SupportedCalendarSystems.Count > 0 &&
               Enum.IsDefined(typeof(CalendarSystem), DefaultCalendarSystem);
    }
```

**Returns:** `bool`

### Clone

```csharp
public IResolverConfiguration Clone()
    {
        return new CalendarResolverConfiguration
        {
            Name = Name,
            Version = Version,
            IsEnabled = IsEnabled,
            Properties = new Dictionary<string, object>(Properties),
            MaxCacheSize = MaxCacheSize,
            CacheExpirationMinutes = CacheExpirationMinutes,
            EnableAsyncResolution = EnableAsyncResolution,
            AsyncThreshold = AsyncThreshold,
            SupportedCalendarSystems = new List<CalendarSystem>(SupportedCalendarSystems),
            DefaultCalendarSystem = DefaultCalendarSystem
        };
    }
```

**Returns:** `IResolverConfiguration`

