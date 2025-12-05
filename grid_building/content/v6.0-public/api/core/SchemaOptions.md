---
title: "SchemaOptions"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/schemaoptions/"
---

# SchemaOptions

```csharp
GridBuilding.Core.Integration
class SchemaOptions
{
    // Members...
}
```

Options for schema generation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Integration/DatabaseSchemaGenerator.cs`  
**Namespace:** `GridBuilding.Core.Integration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IncludeExternalReferences

```csharp
/// <summary>
        /// Whether to include external references in schema
        /// </summary>
        public bool IncludeExternalReferences { get; set; } = true;
```

Whether to include external references in schema

### IncludeTags

```csharp
/// <summary>
        /// Whether to include tags in schema
        /// </summary>
        public bool IncludeTags { get; set; } = true;
```

Whether to include tags in schema

### IncludeIndexes

```csharp
/// <summary>
        /// Whether to include indexes
        /// </summary>
        public bool IncludeIndexes { get; set; } = true;
```

Whether to include indexes

### Version

```csharp
/// <summary>
        /// Schema version
        /// </summary>
        public int Version { get; set; } = 1;
```

Schema version

### CustomOptions

```csharp
/// <summary>
        /// Additional custom options
        /// </summary>
        public Dictionary<string, object> CustomOptions { get; set; } = new();
```

Additional custom options

