---
title: "ValidationConfig"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/validationconfig/"
---

# ValidationConfig

```csharp
GridBuilding.Core.Types
class ValidationConfig
{
    // Members...
}
```

Configuration for validation operations

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ValidationConfig.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### StrictMode

```csharp
/// <summary>
        /// Whether to perform strict validation
        /// </summary>
        public bool StrictMode { get; set; } = false;
```

Whether to perform strict validation

### IncludeWarnings

```csharp
/// <summary>
        /// Whether to include warnings in validation results
        /// </summary>
        public bool IncludeWarnings { get; set; } = true;
```

Whether to include warnings in validation results

### MaxErrors

```csharp
/// <summary>
        /// Maximum number of errors to collect before stopping
        /// </summary>
        public int MaxErrors { get; set; } = 100;
```

Maximum number of errors to collect before stopping

### ValidatePerformance

```csharp
/// <summary>
        /// Whether to validate performance metrics
        /// </summary>
        public bool ValidatePerformance { get; set; } = false;
```

Whether to validate performance metrics

