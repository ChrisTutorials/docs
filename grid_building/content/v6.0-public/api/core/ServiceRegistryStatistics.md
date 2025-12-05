---
title: "ServiceRegistryStatistics"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/serviceregistrystatistics/"
---

# ServiceRegistryStatistics

```csharp
GridBuilding.Core.Services.DI
class ServiceRegistryStatistics
{
    // Members...
}
```

Statistics about the service registry.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/IServiceHealthCheck.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### SingletonCount

```csharp
/// <summary>
    /// Number of singleton services.
    /// </summary>
    public int SingletonCount { get; set; }
```

Number of singleton services.

### FactoryCount

```csharp
/// <summary>
    /// Number of factory services.
    /// </summary>
    public int FactoryCount { get; set; }
```

Number of factory services.

### ScopedFactoryCount

```csharp
/// <summary>
    /// Number of scoped factory services.
    /// </summary>
    public int ScopedFactoryCount { get; set; }
```

Number of scoped factory services.

### DisposableCount

```csharp
/// <summary>
    /// Number of disposable services.
    /// </summary>
    public int DisposableCount { get; set; }
```

Number of disposable services.

### HealthCheckCount

```csharp
/// <summary>
    /// Number of health check services.
    /// </summary>
    public int HealthCheckCount { get; set; }
```

Number of health check services.

### RegisteredTypes

```csharp
/// <summary>
    /// List of all registered service types.
    /// </summary>
    public List<Type> RegisteredTypes { get; set; } = new();
```

List of all registered service types.

### TotalServices

```csharp
/// <summary>
    /// Total number of registered services.
    /// </summary>
    public int TotalServices => RegisteredTypes.Count;
```

Total number of registered services.

