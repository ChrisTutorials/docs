---
title: "ExternalPlaceableReference"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/externalplaceablereference/"
---

# ExternalPlaceableReference

```csharp
GridBuilding.Core.Data
class ExternalPlaceableReference
{
    // Members...
}
```

External system references for placeables

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Data/ExternalPlaceableReference.cs`  
**Namespace:** `GridBuilding.Core.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ExternalId

```csharp
/// <summary>
        /// Unique identifier in external system
        /// </summary>
        public string ExternalId { get; set; } = string.Empty;
```

Unique identifier in external system

### SystemName

```csharp
/// <summary>
        /// Name of the external system
        /// </summary>
        public string SystemName { get; set; } = string.Empty;
```

Name of the external system

### SystemVersion

```csharp
/// <summary>
        /// System version compatibility
        /// </summary>
        public string SystemVersion { get; set; } = string.Empty;
```

System version compatibility

### MappingData

```csharp
/// <summary>
        /// Mapping data for cross-system compatibility
        /// </summary>
        public Dictionary<string, object> MappingData { get; set; } = new();
```

Mapping data for cross-system compatibility

### LastSynced

```csharp
/// <summary>
        /// Last synchronization timestamp
        /// </summary>
        public DateTime LastSynced { get; set; } = DateTime.UtcNow;
```

Last synchronization timestamp

### IsActive

```csharp
/// <summary>
        /// Whether this reference is active
        /// </summary>
        public bool IsActive { get; set; } = true;
```

Whether this reference is active

### Metadata

```csharp
/// <summary>
        /// Additional metadata
        /// </summary>
        public Dictionary<string, string> Metadata { get; set; } = new();
```

Additional metadata

