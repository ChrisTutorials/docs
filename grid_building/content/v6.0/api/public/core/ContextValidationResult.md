---
title: "ContextValidationResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/contextvalidationresult/"
---

# ContextValidationResult

```csharp
GridBuilding.Core.Config
class ContextValidationResult
{
    // Members...
}
```

Context validation result

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/ConfigurationValidator.cs`  
**Namespace:** `GridBuilding.Core.Config`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

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

### PlacementContextValidation

```csharp
public ContextComponentValidation? PlacementContextValidation { get; set; }
```

### TargetingContextValidation

```csharp
public ContextComponentValidation? TargetingContextValidation { get; set; }
```

### CollisionContextValidation

```csharp
public ContextComponentValidation? CollisionContextValidation { get; set; }
```

### BuildingContextValidation

```csharp
public ContextComponentValidation? BuildingContextValidation { get; set; }
```

