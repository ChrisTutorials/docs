---
title: "SerializationConfiguration"
description: "Serialization configuration"
weight: 10
url: "/gridbuilding/v6-0/api/core/serializationconfiguration/"
---

# SerializationConfiguration

```csharp
GridBuilding.Core.Configuration
class SerializationConfiguration
{
    // Members...
}
```

Serialization configuration

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Configuration/PlaceableConfiguration.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DefaultFormat

```csharp
/// <summary>
        /// Default serialization format
        /// </summary>
        public string DefaultFormat { get; set; } = "json";
```

Default serialization format

### IncludeExternalReferences

```csharp
/// <summary>
        /// Whether to include external references in serialization
        /// </summary>
        public bool IncludeExternalReferences { get; set; } = true;
```

Whether to include external references in serialization

### IncludeTimestamps

```csharp
/// <summary>
        /// Whether to include timestamps in serialization
        /// </summary>
        public bool IncludeTimestamps { get; set; } = true;
```

Whether to include timestamps in serialization

### JsonOptions

```csharp
/// <summary>
        /// JSON serialization options
        /// </summary>
        public JsonSerializationOptions JsonOptions { get; set; } = new();
```

JSON serialization options

### TomlOptions

```csharp
/// <summary>
        /// TOML serialization options
        /// </summary>
        public TomlSerializationOptions TomlOptions { get; set; } = new();
```

TOML serialization options

