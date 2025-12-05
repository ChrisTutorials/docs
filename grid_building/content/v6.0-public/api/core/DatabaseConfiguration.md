---
title: "DatabaseConfiguration"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/databaseconfiguration/"
---

# DatabaseConfiguration

```csharp
GridBuilding.Core.Configuration
class DatabaseConfiguration
{
    // Members...
}
```

Database configuration for placeable persistence

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Configuration/PlaceableConfiguration.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DatabaseType

```csharp
/// <summary>
        /// Database type (sqlite, postgresql, mysql, etc.)
        /// </summary>
        public string DatabaseType { get; set; } = "sqlite";
```

Database type (sqlite, postgresql, mysql, etc.)

### ConnectionString

```csharp
/// <summary>
        /// Connection string
        /// </summary>
        public string ConnectionString { get; set; } = string.Empty;
```

Connection string

### TableName

```csharp
/// <summary>
        /// Table name for placeables
        /// </summary>
        public string TableName { get; set; } = "placeables";
```

Table name for placeables

### AutoCreateSchema

```csharp
/// <summary>
        /// Whether to auto-create schema
        /// </summary>
        public bool AutoCreateSchema { get; set; } = true;
```

Whether to auto-create schema

### MigrationStrategy

```csharp
/// <summary>
        /// Migration strategy
        /// </summary>
        public string MigrationStrategy { get; set; } = "incremental";
```

Migration strategy

### IndexedColumns

```csharp
/// <summary>
        /// Index configuration
        /// </summary>
        public List<string> IndexedColumns { get; set; } = new() { "id", "category", "created_at" };
```

Index configuration

