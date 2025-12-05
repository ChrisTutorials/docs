---
title: "ComponentValidationResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/componentvalidationresult/"
---

# ComponentValidationResult

```csharp
GridBuilding.Core.Validation
class ComponentValidationResult
{
    // Members...
}
```

Represents the result of a component validation.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Interfaces/IConfigurationValidator.cs`  
**Namespace:** `GridBuilding.Core.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ComponentName

```csharp
public string ComponentName { get; set; } = string.Empty;
```

### IsValid

```csharp
public bool IsValid { get; set; }
```

### Issues

```csharp
public List<string> Issues { get; set; } = new();
```

