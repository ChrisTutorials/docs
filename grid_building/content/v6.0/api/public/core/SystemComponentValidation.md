---
title: "SystemComponentValidation"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/systemcomponentvalidation/"
---

# SystemComponentValidation

```csharp
GridBuilding.Core.Config
class SystemComponentValidation
{
    // Members...
}
```

System component validation result

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/ConfigurationValidator.cs`  
**Namespace:** `GridBuilding.Core.Config`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### SystemName

```csharp
public string SystemName { get; set; } = "";
```

### IsValid

```csharp
public bool IsValid { get; set; }
```

### Issues

```csharp
public List<string> Issues { get; set; } = new();
```

### Warnings

```csharp
public List<string> Warnings { get; set; } = new();
```

