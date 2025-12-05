---
title: "ExternalReferenceCollection"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/externalreferencecollection/"
---

# ExternalReferenceCollection

```csharp
GridBuilding.Core.Data
class ExternalReferenceCollection
{
    // Members...
}
```

Collection of external references for a placeable

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Data/ExternalPlaceableReference.cs`  
**Namespace:** `GridBuilding.Core.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### References

```csharp
/// <summary>
        /// All external references
        /// </summary>
        public Dictionary<string, ExternalPlaceableReference> References { get; set; } = new();
```

All external references


## Methods

### GetReference

```csharp
/// <summary>
        /// Gets reference by system name
        /// </summary>
        public ExternalPlaceableReference GetReference(string systemName)
        {
            return References.TryGetValue(systemName, out var reference) ? reference : null;
        }
```

Gets reference by system name

**Returns:** `ExternalPlaceableReference`

**Parameters:**
- `string systemName`

### AddOrUpdateReference

```csharp
/// <summary>
        /// Adds or updates external reference
        /// </summary>
        public void AddOrUpdateReference(ExternalPlaceableReference reference)
        {
            References[reference.SystemName] = reference;
        }
```

Adds or updates external reference

**Returns:** `void`

**Parameters:**
- `ExternalPlaceableReference reference`

### RemoveReference

```csharp
/// <summary>
        /// Removes reference by system name
        /// </summary>
        public bool RemoveReference(string systemName)
        {
            return References.Remove(systemName);
        }
```

Removes reference by system name

**Returns:** `bool`

**Parameters:**
- `string systemName`

### GetActiveReferences

```csharp
/// <summary>
        /// Gets all active references
        /// </summary>
        public IEnumerable<ExternalPlaceableReference> GetActiveReferences()
        {
            return References.Values.Where(r => r.IsActive);
        }
```

Gets all active references

**Returns:** `IEnumerable<ExternalPlaceableReference>`

