---
title: "ServiceDependencyAttribute"
description: "Attribute for service dependency requirements.
This attribute can be used to specify dependencies for services
that cannot be automatically determined."
weight: 10
url: "/gridbuilding/v6-0/api/core/servicedependencyattribute/"
---

# ServiceDependencyAttribute

```csharp
GridBuilding.Core.Services.DI
class ServiceDependencyAttribute
{
    // Members...
}
```

Attribute for service dependency requirements.
This attribute can be used to specify dependencies for services
that cannot be automatically determined.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/ServiceAttribute.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DependencyType

```csharp
/// <summary>
    /// The required dependency type.
    /// </summary>
    public Type DependencyType { get; set; }
```

The required dependency type.

### Optional

```csharp
/// <summary>
    /// Whether this dependency is optional.
    /// </summary>
    public bool Optional { get; set; } = false;
```

Whether this dependency is optional.

### Name

```csharp
/// <summary>
    /// Optional dependency name for named dependencies.
    /// </summary>
    public string? Name { get; set; }
```

Optional dependency name for named dependencies.

