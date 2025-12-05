---
title: "ValidationResults"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/validationresults/"
---

# ValidationResults

```csharp
GridBuilding.Godot.Tests.Core.Contexts
class ValidationResults
{
    // Members...
}
```

Validation results from placement validation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Contexts/IndicatorContext.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Contexts`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
public bool IsValid { get; }
```

### Issues

```csharp
public List<string> Issues { get; }
```


## Methods

### Success

```csharp
public static ValidationResults Success() => new(true);
```

**Returns:** `ValidationResults`

### Failure

```csharp
public static ValidationResults Failure(string issue) => new(false, new List<string> { issue });
```

**Returns:** `ValidationResults`

**Parameters:**
- `string issue`

### Failure

```csharp
public static ValidationResults Failure(List<string> issues) => new(false, issues);
```

**Returns:** `ValidationResults`

**Parameters:**
- `List<string> issues`

