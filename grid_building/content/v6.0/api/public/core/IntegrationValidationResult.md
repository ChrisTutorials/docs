---
title: "IntegrationValidationResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/integrationvalidationresult/"
---

# IntegrationValidationResult

```csharp
GridBuilding.Core.Types
class IntegrationValidationResult
{
    // Members...
}
```

Result of integration validation between systems

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/IntegrationValidationResult.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
/// <summary>
        /// Whether integration is valid
        /// </summary>
        public bool IsValid { get; set; }
```

Whether integration is valid

### Errors

```csharp
/// <summary>
        /// List of integration errors
        /// </summary>
        public List<string> Errors { get; set; } = new List<string>();
```

List of integration errors

### Warnings

```csharp
/// <summary>
        /// List of integration warnings
        /// </summary>
        public List<string> Warnings { get; set; } = new List<string>();
```

List of integration warnings

### Summary

```csharp
/// <summary>
        /// Integration summary message
        /// </summary>
        public string Summary { get; set; } = string.Empty;
```

Integration summary message

