---
title: "ConfigurationValidationResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/configurationvalidationresult/"
---

# ConfigurationValidationResult

```csharp
GridBuilding.Core.Types
class ConfigurationValidationResult
{
    // Members...
}
```

Result of configuration validation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ConfigurationValidationResult.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
/// <summary>
        /// Whether validation passed
        /// </summary>
        public bool IsValid { get; set; }
```

Whether validation passed

### Errors

```csharp
/// <summary>
        /// List of validation errors
        /// </summary>
        public List<string> Errors { get; set; } = new List<string>();
```

List of validation errors

### Warnings

```csharp
/// <summary>
        /// List of validation warnings
        /// </summary>
        public List<string> Warnings { get; set; } = new List<string>();
```

List of validation warnings

### Summary

```csharp
/// <summary>
        /// Validation summary message
        /// </summary>
        public string Summary { get; set; } = string.Empty;
```

Validation summary message

