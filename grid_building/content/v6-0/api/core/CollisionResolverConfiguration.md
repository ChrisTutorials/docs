---
title: "CollisionResolverConfiguration"
description: "Enhanced collision resolver configuration with performance modes"
weight: 10
url: "/gridbuilding/v6-0/api/core/collisionresolverconfiguration/"
---

# CollisionResolverConfiguration

```csharp
GridBuilding.Core.Configuration
class CollisionResolverConfiguration
{
    // Members...
}
```

Enhanced collision resolver configuration with performance modes

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/ResolverConfigurations.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; } = "DefaultCollision";
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

### CollisionTolerance

```csharp
public float CollisionTolerance { get; set; } = 0.1f;
```

### UsePreciseCollision

```csharp
public bool UsePreciseCollision { get; set; } = true;
```

### EnableParallelProcessing

```csharp
public bool EnableParallelProcessing { get; set; } = true;
```

### ParallelProcessingThreshold

```csharp
public int ParallelProcessingThreshold { get; set; } = 10;
```

### PerformanceMode

```csharp
public CollisionPerformanceMode PerformanceMode { get; set; } = CollisionPerformanceMode.Balanced;
```


## Methods

### GetOptimalCacheSize

```csharp
/// <summary>
    /// Gets cache size based on performance mode
    /// </summary>
    public int GetOptimalCacheSize()
    {
        return PerformanceMode switch
        {
            CollisionPerformanceMode.Speed => System.Math.Min(MaxCacheSize, 500),
            CollisionPerformanceMode.Accuracy => System.Math.Max(MaxCacheSize, 2000),
            CollisionPerformanceMode.Memory => System.Math.Min(MaxCacheSize, 200),
            _ => MaxCacheSize
        };
    }
```

Gets cache size based on performance mode

**Returns:** `int`

### GetOptimalParallelThreshold

```csharp
/// <summary>
    /// Gets parallel processing threshold based on performance mode
    /// </summary>
    public int GetOptimalParallelThreshold()
    {
        return PerformanceMode switch
        {
            CollisionPerformanceMode.Speed => System.Math.Min(ParallelProcessingThreshold, 5),
            CollisionPerformanceMode.Accuracy => System.Math.Max(ParallelProcessingThreshold, 3),
            CollisionPerformanceMode.Memory => int.MaxValue, // Disable parallel processing
            _ => ParallelProcessingThreshold
        };
    }
```

Gets parallel processing threshold based on performance mode

**Returns:** `int`

### IsValid

```csharp
public bool IsValid()
    {
        return MaxCacheSize > 0 &&
               CollisionTolerance >= 0 &&
               CollisionTolerance <= 1.0f &&
               ParallelProcessingThreshold > 0 &&
               Enum.IsDefined(typeof(CollisionPerformanceMode), PerformanceMode);
    }
```

**Returns:** `bool`

### Clone

```csharp
public IResolverConfiguration Clone()
    {
        return new CollisionResolverConfiguration
        {
            Name = Name,
            Version = Version,
            IsEnabled = IsEnabled,
            Properties = new Dictionary<string, object>(Properties),
            MaxCacheSize = MaxCacheSize,
            CollisionTolerance = CollisionTolerance,
            UsePreciseCollision = UsePreciseCollision,
            EnableParallelProcessing = EnableParallelProcessing,
            ParallelProcessingThreshold = ParallelProcessingThreshold,
            PerformanceMode = PerformanceMode
        };
    }
```

**Returns:** `IResolverConfiguration`

