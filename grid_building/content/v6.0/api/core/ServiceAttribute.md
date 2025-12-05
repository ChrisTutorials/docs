---
title: "ServiceAttribute"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/serviceattribute/"
---

# ServiceAttribute

```csharp
GridBuilding.Core.Services.DI
class ServiceAttribute
{
    // Members...
}
```

Attribute for automatic service registration and configuration.
This attribute enables automatic service discovery and registration
in ServiceCompositionRoot, reducing manual registration code.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/ServiceAttribute.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Scope

```csharp
/// <summary>
    /// The service lifetime scope.
    /// </summary>
    public ServiceScopeLevel Scope { get; set; } = ServiceScopeLevel.Global;
```

The service lifetime scope.

### AutoRegister

```csharp
/// <summary>
    /// Whether this service should be automatically registered.
    /// </summary>
    public bool AutoRegister { get; set; } = true;
```

Whether this service should be automatically registered.

### Priority

```csharp
/// <summary>
    /// Priority for service registration (lower = earlier).
    /// </summary>
    public int Priority { get; set; } = 0;
```

Priority for service registration (lower = earlier).

### ServiceInterface

```csharp
/// <summary>
    /// Optional service interface type.
    /// If specified, service will be registered under this interface.
    /// </summary>
    public Type? ServiceInterface { get; set; }
```

Optional service interface type.
If specified, service will be registered under this interface.

### Name

```csharp
/// <summary>
    /// Optional service name for named service registration.
    /// </summary>
    public string? Name { get; set; }
```

Optional service name for named service registration.

### Lazy

```csharp
/// <summary>
    /// Whether this service should be lazy-loaded.
    /// </summary>
    public bool Lazy { get; set; } = false;
```

Whether this service should be lazy-loaded.

### Dependencies

```csharp
/// <summary>
    /// Service dependencies that should be available before registration.
    /// </summary>
    public Type[] Dependencies { get; set; } = Array.Empty<Type>();
```

Service dependencies that should be available before registration.

