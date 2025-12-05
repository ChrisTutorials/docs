---
title: "ConfigurationValidationResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/configurationvalidationresult/"
---

# ConfigurationValidationResult

```csharp
GridBuilding.Core.Validation
class ConfigurationValidationResult
{
    // Members...
}
```

Represents the result of a configuration validation.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Interfaces/IConfigurationValidator.cs`  
**Namespace:** `GridBuilding.Core.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
public bool IsValid { get; set; }
```

### Errors

```csharp
public List<string> Errors { get; set; } = new();
```

### Warnings

```csharp
public List<string> Warnings { get; set; } = new();
```

### ComponentResults

```csharp
public List<ComponentValidationResult> ComponentResults { get; set; } = new();
```

