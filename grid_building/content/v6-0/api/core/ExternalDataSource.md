---
title: "ExternalDataSource"
description: "External data source configuration"
weight: 10
url: "/gridbuilding/v6-0/api/core/externaldatasource/"
---

# ExternalDataSource

```csharp
GridBuilding.Core.Configuration
class ExternalDataSource
{
    // Members...
}
```

External data source configuration

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Configuration/PlaceableConfiguration.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
/// <summary>
        /// Unique identifier for this source
        /// </summary>
        public string Id { get; set; } = string.Empty;
```

Unique identifier for this source

### Name

```csharp
/// <summary>
        /// Source name
        /// </summary>
        public string Name { get; set; } = string.Empty;
```

Source name

### Type

```csharp
/// <summary>
        /// Source type (file, api, database, etc.)
        /// </summary>
        public string Type { get; set; } = string.Empty;
```

Source type (file, api, database, etc.)

### Location

```csharp
/// <summary>
        /// Source location/path
        /// </summary>
        public string Location { get; set; } = string.Empty;
```

Source location/path

### Format

```csharp
/// <summary>
        /// Data format (json, toml, xml, etc.)
        /// </summary>
        public string Format { get; set; } = "json";
```

Data format (json, toml, xml, etc.)

### Enabled

```csharp
/// <summary>
        /// Whether this source is enabled
        /// </summary>
        public bool Enabled { get; set; } = true;
```

Whether this source is enabled

### Priority

```csharp
/// <summary>
        /// Priority for loading (lower = higher priority)
        /// </summary>
        public int Priority { get; set; } = 100;
```

Priority for loading (lower = higher priority)

### Properties

```csharp
/// <summary>
        /// Additional configuration properties
        /// </summary>
        public Dictionary<string, object> Properties { get; set; } = new();
```

Additional configuration properties

### LastSynced

```csharp
/// <summary>
        /// Last sync timestamp
        /// </summary>
        public DateTime LastSynced { get; set; } = DateTime.MinValue;
```

Last sync timestamp

### SyncIntervalMinutes

```csharp
/// <summary>
        /// Sync interval in minutes
        /// </summary>
        public int SyncIntervalMinutes { get; set; } = 60;
```

Sync interval in minutes

