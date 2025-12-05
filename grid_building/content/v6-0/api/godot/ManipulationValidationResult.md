---
title: "ManipulationValidationResult"
description: "Result of manipulation operation validation"
weight: 20
url: "/gridbuilding/v6-0/api/godot/manipulationvalidationresult/"
---

# ManipulationValidationResult

```csharp
GridBuilding.Godot.Test.Helpers
class ManipulationValidationResult
{
    // Members...
}
```

Result of manipulation operation validation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/ManipulationTestHelpers.cs`  
**Namespace:** `GridBuilding.Godot.Test.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Operation

```csharp
public ManipulationOperation Operation { get; set; }
```

### IsValid

```csharp
public bool IsValid { get; set; }
```

### ErrorMessage

```csharp
public string ErrorMessage { get; set; } = string.Empty;
```

