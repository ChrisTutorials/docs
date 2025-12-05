---
title: "ValidationResult"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/validationresult/"
---

# ValidationResult

```csharp
GridBuilding.Godot.Systems.Manipulation.Utils
class ValidationResult
{
    // Members...
}
```

Represents the result of a validation operation.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Utils/Validation.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
/// <summary>
    /// Whether the validation passed.
    /// </summary>
    public bool IsValid { get; }
```

Whether the validation passed.

### ErrorMessage

```csharp
/// <summary>
    /// Error message if validation failed.
    /// </summary>
    public string ErrorMessage { get; }
```

Error message if validation failed.


## Methods

### Success

```csharp
/// <summary>
    /// Creates a successful validation result.
    /// </summary>
    public static ValidationResult Success()
    {
        return new ValidationResult(true, string.Empty);
    }
```

Creates a successful validation result.

**Returns:** `ValidationResult`

### Failure

```csharp
/// <summary>
    /// Creates a failed validation result with an error message.
    /// </summary>
    public static ValidationResult Failure(string errorMessage)
    {
        return new ValidationResult(false, errorMessage);
    }
```

Creates a failed validation result with an error message.

**Returns:** `ValidationResult`

**Parameters:**
- `string errorMessage`

