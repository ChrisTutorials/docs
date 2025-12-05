---
title: "ServiceHealthStatus"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/servicehealthstatus/"
---

# ServiceHealthStatus

```csharp
GridBuilding.Core.Services.DI
class ServiceHealthStatus
{
    // Members...
}
```

Health status of a service.

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
    /// Whether the service is healthy.
    /// </summary>
    public bool IsHealthy { get; set; } = true;
```

Whether the service is healthy.

### Message

```csharp
/// <summary>
    /// Health status message.
    /// </summary>
    public string Message { get; set; } = "Service is healthy";
```

Health status message.

### Data

```csharp
/// <summary>
    /// Optional additional data about the health check.
    /// </summary>
    public Dictionary<string, object> Data { get; set; } = new();
```

Optional additional data about the health check.

### CheckTime

```csharp
/// <summary>
    /// Time when the health check was performed.
    /// </summary>
    public DateTime CheckTime { get; set; } = DateTime.UtcNow;
```

Time when the health check was performed.

