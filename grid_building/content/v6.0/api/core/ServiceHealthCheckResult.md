---
title: "ServiceHealthCheckResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/servicehealthcheckresult/"
---

# ServiceHealthCheckResult

```csharp
GridBuilding.Core.Services.DI
class ServiceHealthCheckResult
{
    // Members...
}
```

Results from performing health checks on multiple services.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/IServiceHealthCheck.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsHealthy

```csharp
/// <summary>
    /// Overall health status (all services must be healthy).
    /// </summary>
    public bool IsHealthy { get; set; } = true;
```

Overall health status (all services must be healthy).

### ServiceResults

```csharp
/// <summary>
    /// Individual service health results.
    /// </summary>
    public Dictionary<string, ServiceHealthStatus> ServiceResults { get; set; } = new();
```

Individual service health results.

### UnhealthyServices

```csharp
/// <summary>
    /// List of unhealthy service names.
    /// </summary>
    public List<string> UnhealthyServices { get; set; } = new();
```

List of unhealthy service names.

### CheckTime

```csharp
/// <summary>
    /// Time when the health checks were performed.
    /// </summary>
    public DateTime CheckTime { get; set; } = DateTime.UtcNow;
```

Time when the health checks were performed.

