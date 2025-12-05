---
title: "ExternalIntegrationConfig"
description: "External integration configuration"
weight: 10
url: "/gridbuilding/v6-0/api/core/externalintegrationconfig/"
---

# ExternalIntegrationConfig

```csharp
GridBuilding.Core.Configuration
class ExternalIntegrationConfig
{
    // Members...
}
```

External integration configuration

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Configuration/PlaceableConfiguration.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Enabled

```csharp
/// <summary>
        /// Whether external integration is enabled
        /// </summary>
        public bool Enabled { get; set; } = true;
```

Whether external integration is enabled

### TimeoutMs

```csharp
/// <summary>
        /// Timeout for external operations in milliseconds
        /// </summary>
        public int TimeoutMs { get; set; } = 5000;
```

Timeout for external operations in milliseconds

### RetryAttempts

```csharp
/// <summary>
        /// Retry attempts for external operations
        /// </summary>
        public int RetryAttempts { get; set; } = 3;
```

Retry attempts for external operations

### CacheExternalData

```csharp
/// <summary>
        /// Whether to cache external data
        /// </summary>
        public bool CacheExternalData { get; set; } = true;
```

Whether to cache external data

### CacheDurationMinutes

```csharp
/// <summary>
        /// Cache duration in minutes
        /// </summary>
        public int CacheDurationMinutes { get; set; } = 30;
```

Cache duration in minutes

### SupportedInventorySystems

```csharp
/// <summary>
        /// Supported inventory systems
        /// </summary>
        public List<string> SupportedInventorySystems { get; set; } = new() 
        { 
            "default", "inventory_v2", "advanced_inventory", "mod_inventory" 
        };
```

Supported inventory systems

### SupportedDatabaseTypes

```csharp
/// <summary>
        /// Supported database types
        /// </summary>
        public List<string> SupportedDatabaseTypes { get; set; } = new() 
        { 
            "sqlite", "postgresql", "mysql", "mongodb" 
        };
```

Supported database types

