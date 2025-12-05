---
title: "ValidationPerformance"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/validationperformance/"
---

# ValidationPerformance

```csharp
GridBuilding.Core.Common.Types
class ValidationPerformance
{
    // Members...
}
```

Performance metrics for validation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Common/Types/SystemValidationResult.cs`  
**Namespace:** `GridBuilding.Core.Common.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TotalTimeMs

```csharp
/// <summary>
        /// Total validation time in milliseconds
        /// </summary>
        public long TotalTimeMs { get; set; }
```

Total validation time in milliseconds

### MemoryUsedBytes

```csharp
/// <summary>
        /// Memory used during validation in bytes
        /// </summary>
        public long MemoryUsedBytes { get; set; }
```

Memory used during validation in bytes

### ItemsValidated

```csharp
/// <summary>
        /// Number of items validated
        /// </summary>
        public int ItemsValidated { get; set; }
```

Number of items validated

### AverageTimePerItemMs

```csharp
/// <summary>
        /// Average time per item in milliseconds
        /// </summary>
        public double AverageTimePerItemMs => ItemsValidated > 0 ? (double)TotalTimeMs / ItemsValidated : 0;
```

Average time per item in milliseconds

