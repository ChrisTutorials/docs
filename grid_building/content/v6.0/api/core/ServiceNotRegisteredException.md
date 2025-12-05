---
title: "ServiceNotRegisteredException"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/servicenotregisteredexception/"
---

# ServiceNotRegisteredException

```csharp
GridBuilding.Core.Services.DI
class ServiceNotRegisteredException
{
    // Members...
}
```

Exception thrown when a requested service is not registered in the service registry.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/GridBuildingServiceExceptions.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ServiceType

```csharp
public Type ServiceType { get; }
```

