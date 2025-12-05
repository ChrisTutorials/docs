---
title: "ServiceValidationResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/servicevalidationresult/"
---

# ServiceValidationResult

```csharp
GridBuilding.Core.Services.DI
class ServiceValidationResult
{
    // Members...
}
```

Result of service validation.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/ServiceHelper.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
public bool IsValid { get; set; }
```

### Issues

```csharp
public System.Collections.Generic.List<string> Issues { get; set; } = new();
```

