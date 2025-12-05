---
title: "ValidationSettings"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/validationsettings/"
---

# ValidationSettings

```csharp
GridBuilding.Core.Systems.Validation
class ValidationSettings
{
    // Members...
}
```

Settings for validation behavior

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/PlaceableValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IgnoreFileReferences

```csharp
/// <summary>
        /// If true, file existence checks are skipped
        /// </summary>
        public bool IgnoreFileReferences { get; set; } = false;
```

If true, file existence checks are skipped

### StrictMode

```csharp
/// <summary>
        /// If true, warnings are treated as errors
        /// </summary>
        public bool StrictMode { get; set; } = false;
```

If true, warnings are treated as errors

### MaxPlaceables

```csharp
/// <summary>
        /// Maximum number of placeables to validate (0 = unlimited)
        /// </summary>
        public int MaxPlaceables { get; set; } = 0;
```

Maximum number of placeables to validate (0 = unlimited)

