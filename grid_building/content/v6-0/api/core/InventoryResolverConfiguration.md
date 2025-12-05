---
title: "InventoryResolverConfiguration"
description: "Inventory resolver configuration"
weight: 10
url: "/gridbuilding/v6-0/api/core/inventoryresolverconfiguration/"
---

# InventoryResolverConfiguration

```csharp
GridBuilding.Core.Configuration
class InventoryResolverConfiguration
{
    // Members...
}
```

Inventory resolver configuration

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/ResolverConfigurations.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; } = "DefaultInventory";
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
public int MaxCacheSize { get; set; } = 500;
```

### CacheExpirationMinutes

```csharp
public int CacheExpirationMinutes { get; set; } = 5;
```

### EnableAsyncResolution

```csharp
public bool EnableAsyncResolution { get; set; } = true;
```

### AsyncThreshold

```csharp
public int AsyncThreshold { get; set; } = 5;
```

### MaxInventorySize

```csharp
public int MaxInventorySize { get; set; } = 1000;
```

### EnableStacking

```csharp
public bool EnableStacking { get; set; } = true;
```

### MaxStackSize

```csharp
public int MaxStackSize { get; set; } = 999;
```

### EnableAutoSort

```csharp
public bool EnableAutoSort { get; set; } = false;
```

### ValidationMode

```csharp
public InventoryValidationMode ValidationMode { get; set; } = InventoryValidationMode.Strict;
```


## Methods

### IsValid

```csharp
public bool IsValid()
    {
        return MaxCacheSize > 0 &&
               CacheExpirationMinutes > 0 &&
               AsyncThreshold > 0 &&
               MaxInventorySize > 0 &&
               MaxStackSize > 0 &&
               Enum.IsDefined(typeof(InventoryValidationMode), ValidationMode);
    }
```

**Returns:** `bool`

### Clone

```csharp
public IResolverConfiguration Clone()
    {
        return new InventoryResolverConfiguration
        {
            Name = Name,
            Version = Version,
            IsEnabled = IsEnabled,
            Properties = new Dictionary<string, object>(Properties),
            MaxCacheSize = MaxCacheSize,
            CacheExpirationMinutes = CacheExpirationMinutes,
            EnableAsyncResolution = EnableAsyncResolution,
            AsyncThreshold = AsyncThreshold,
            MaxInventorySize = MaxInventorySize,
            EnableStacking = EnableStacking,
            MaxStackSize = MaxStackSize,
            EnableAutoSort = EnableAutoSort,
            ValidationMode = ValidationMode
        };
    }
```

**Returns:** `IResolverConfiguration`

