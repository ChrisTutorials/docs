---
title: "ServiceHealthAttribute"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/servicehealthattribute/"
---

# ServiceHealthAttribute

```csharp
GridBuilding.Core.Services.DI
class ServiceHealthAttribute
{
    // Members...
}
```

Attribute for service health monitoring.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/ServiceAttribute.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CheckIntervalSeconds

```csharp
/// <summary>
    /// Health check interval in seconds.
    /// </summary>
    public int CheckIntervalSeconds { get; set; } = 30;
```

Health check interval in seconds.

### EnableMonitoring

```csharp
/// <summary>
    /// Whether to enable automatic health monitoring.
    /// </summary>
    public bool EnableMonitoring { get; set; } = true;
```

Whether to enable automatic health monitoring.

### MaxResponseTimeMs

```csharp
/// <summary>
    /// Maximum allowed response time in milliseconds.
    /// </summary>
    public int MaxResponseTimeMs { get; set; } = 1000;
```

Maximum allowed response time in milliseconds.

### HealthCheckMethod

```csharp
/// <summary>
    /// Custom health check method name.
    /// </summary>
    public string? HealthCheckMethod { get; set; }
```

Custom health check method name.

