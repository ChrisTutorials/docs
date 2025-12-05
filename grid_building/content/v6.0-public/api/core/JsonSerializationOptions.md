---
title: "JsonSerializationOptions"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/jsonserializationoptions/"
---

# JsonSerializationOptions

```csharp
GridBuilding.Core.Configuration
class JsonSerializationOptions
{
    // Members...
}
```

JSON serialization options

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Configuration/PlaceableConfiguration.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### WriteIndented

```csharp
/// <summary>
        /// Whether to write indented JSON
        /// </summary>
        public bool WriteIndented { get; set; } = true;
```

Whether to write indented JSON

### PropertyNamingPolicy

```csharp
/// <summary>
        /// Property naming policy
        /// </summary>
        public string PropertyNamingPolicy { get; set; } = "camelCase";
```

Property naming policy

### IgnoreNullValues

```csharp
/// <summary>
        /// Whether to ignore null values
        /// </summary>
        public bool IgnoreNullValues { get; set; } = true;
```

Whether to ignore null values

### ConvertEnumToString

```csharp
/// <summary>
        /// Whether to convert enum to string
        /// </summary>
        public bool ConvertEnumToString { get; set; } = true;
```

Whether to convert enum to string

