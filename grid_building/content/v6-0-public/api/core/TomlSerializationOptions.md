---
title: "TomlSerializationOptions"
description: "TOML serialization options"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/tomlserializationoptions/"
---

# TomlSerializationOptions

```csharp
GridBuilding.Core.Configuration
class TomlSerializationOptions
{
    // Members...
}
```

TOML serialization options

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Configuration/PlaceableConfiguration.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IncludeComments

```csharp
/// <summary>
        /// Whether to include comments
        /// </summary>
        public bool IncludeComments { get; set; } = true;
```

Whether to include comments

### DateTimeFormat

```csharp
/// <summary>
        /// Date/time format
        /// </summary>
        public string DateTimeFormat { get; set; } = "yyyy-MM-ddTHH:mm:ssZ";
```

Date/time format

### SortKeys

```csharp
/// <summary>
        /// Whether to sort keys alphabetically
        /// </summary>
        public bool SortKeys { get; set; } = true;
```

Whether to sort keys alphabetically

