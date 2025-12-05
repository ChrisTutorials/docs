---
title: "ServiceInterfaceAttribute"
description: "Attribute for marking service interfaces.
This attribute helps identify service interfaces for automatic
discovery and validation."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/serviceinterfaceattribute/"
---

# ServiceInterfaceAttribute

```csharp
GridBuilding.Core.Services.DI
class ServiceInterfaceAttribute
{
    // Members...
}
```

Attribute for marking service interfaces.
This attribute helps identify service interfaces for automatic
discovery and validation.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/ServiceAttribute.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Description

```csharp
/// <summary>
    /// Optional description of the service interface.
    /// </summary>
    public string? Description { get; set; }
```

Optional description of the service interface.

### SingleImplementation

```csharp
/// <summary>
    /// Whether this interface should have exactly one implementation.
    /// </summary>
    public bool SingleImplementation { get; set; } = true;
```

Whether this interface should have exactly one implementation.

### DefaultImplementation

```csharp
/// <summary>
    /// Default implementation type (if any).
    /// </summary>
    public Type? DefaultImplementation { get; set; }
```

Default implementation type (if any).

