---
title: "ServiceResolutionError"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/serviceresolutionerror/"
---

# ServiceResolutionError

```csharp
GridBuilding.Core.Services.DI
class ServiceResolutionError
{
    // Members...
}
```

Error information for service resolution failures.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/ServiceHelper.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ServiceType

```csharp
public Type ServiceType { get; set; }
```

### ErrorType

```csharp
public ServiceErrorType ErrorType { get; set; }
```

### Message

```csharp
public string Message { get; set; } = string.Empty;
```

### NodeName

```csharp
public string? NodeName { get; set; }
```

### NodePath

```csharp
public string? NodePath { get; set; }
```

### AvailableServices

```csharp
public System.Collections.Generic.List<string>? AvailableServices { get; set; }
```

### Exception

```csharp
public Exception? Exception { get; set; }
```


## Methods

### ToString

```csharp
public override string ToString()
    {
        return $"[{ErrorType}] {Message}";
    }
```

**Returns:** `string`

