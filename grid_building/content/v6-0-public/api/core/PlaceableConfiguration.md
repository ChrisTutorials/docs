---
title: "PlaceableConfiguration"
description: "Configuration for placeable loading and external integration"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/placeableconfiguration/"
---

# PlaceableConfiguration

```csharp
GridBuilding.Core.Configuration
class PlaceableConfiguration
{
    // Members...
}
```

Configuration for placeable loading and external integration

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Configuration/PlaceableConfiguration.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Placeables

```csharp
/// <summary>
        /// Dictionary of all placeables
        /// </summary>
        public Dictionary<string, PlaceableDefinition> Placeables { get; set; } = new();
```

Dictionary of all placeables

### ExternalSources

```csharp
/// <summary>
        /// External data sources for loading placeables
        /// </summary>
        public List<ExternalDataSource> ExternalSources { get; set; } = new();
```

External data sources for loading placeables

### InventoryMappings

```csharp
/// <summary>
        /// Inventory system mappings
        /// </summary>
        public Dictionary<string, string> InventoryMappings { get; set; } = new();
```

Inventory system mappings

### DatabaseConfig

```csharp
/// <summary>
        /// Database compatibility settings
        /// </summary>
        public DatabaseConfiguration DatabaseConfig { get; set; } = new();
```

Database compatibility settings

### SerializationConfig

```csharp
/// <summary>
        /// Serialization settings
        /// </summary>
        public SerializationConfiguration SerializationConfig { get; set; } = new();
```

Serialization settings

### IntegrationConfig

```csharp
/// <summary>
        /// External system integration settings
        /// </summary>
        public ExternalIntegrationConfig IntegrationConfig { get; set; } = new();
```

External system integration settings

