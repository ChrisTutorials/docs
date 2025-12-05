---
title: "ValidationOptions"
description: "Validation options"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/validationoptions/"
---

# ValidationOptions

```csharp
GridBuilding.Core.Systems.Validation
class ValidationOptions
{
    // Members...
}
```

Validation options

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/IValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### StopOnFirstError

```csharp
/// <summary>
        /// Whether to stop validation on first error
        /// </summary>
        public bool StopOnFirstError { get; set; } = false;
```

Whether to stop validation on first error

### IncludeWarnings

```csharp
/// <summary>
        /// Whether to include warnings in results
        /// </summary>
        public bool IncludeWarnings { get; set; } = true;
```

Whether to include warnings in results

### MaxErrors

```csharp
/// <summary>
        /// Maximum number of errors to collect
        /// </summary>
        public int MaxErrors { get; set; } = 100;
```

Maximum number of errors to collect

### Recursive

```csharp
/// <summary>
        /// Whether to validate recursively
        /// </summary>
        public bool Recursive { get; set; } = true;
```

Whether to validate recursively

### TimeoutMs

```csharp
/// <summary>
        /// Validation timeout in milliseconds
        /// </summary>
        public int TimeoutMs { get; set; } = 5000;
```

Validation timeout in milliseconds

