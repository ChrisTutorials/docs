---
title: "SystemValidationResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/systemvalidationresult/"
---

# SystemValidationResult

```csharp
GridBuilding.Core.Results
class SystemValidationResult
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Common/Types/ValidationResults.cs`  
**Namespace:** `GridBuilding.Core.Results`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
public bool IsValid { get; set; } = true;
```

### Results

```csharp
public List<ValidationResult> Results { get; set; } = new();
```

