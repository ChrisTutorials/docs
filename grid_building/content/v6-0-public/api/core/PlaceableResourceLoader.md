---
title: "PlaceableResourceLoader"
description: "Handles loading and validation of placeable resources
Pure C# implementation without Godot dependencies"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/placeableresourceloader/"
---

# PlaceableResourceLoader

```csharp
GridBuilding.Core.Types
class PlaceableResourceLoader
{
    // Members...
}
```

Handles loading and validation of placeable resources
Pure C# implementation without Godot dependencies

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/PlaceableResourceLoader.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### HasValidResourceReference

```csharp
/// <summary>
        /// Validates that a placeable has proper resource reference
        /// </summary>
        /// <param name="placeable">The placeable to validate</param>
        /// <returns>True if the placeable has valid resource reference</returns>
        public static bool HasValidResourceReference(Placeable placeable)
        {
            if (placeable == null)
                return false;
                
            return !string.IsNullOrEmpty(placeable.FilePath) || 
                   !string.IsNullOrEmpty(placeable.ResourceUid);
        }
```

Validates that a placeable has proper resource reference

**Returns:** `bool`

**Parameters:**
- `Placeable placeable`

### GetResourceIdentifier

```csharp
/// <summary>
        /// Gets the resource identifier (path or UID) for a placeable
        /// </summary>
        /// <param name="placeable">The placeable</param>
        /// <returns>Resource identifier or empty string if invalid</returns>
        public static string GetResourceIdentifier(Placeable placeable)
        {
            if (placeable == null)
                return string.Empty;
                
            return !string.IsNullOrEmpty(placeable.FilePath) ? 
                   placeable.FilePath : 
                   placeable.ResourceUid ?? string.Empty;
        }
```

Gets the resource identifier (path or UID) for a placeable

**Returns:** `string`

**Parameters:**
- `Placeable placeable`

### UsesFilePath

```csharp
/// <summary>
        /// Determines if the resource identifier is a file path or UID
        /// </summary>
        /// <param name="placeable">The placeable</param>
        /// <returns>True if using file path, false if using UID</returns>
        public static bool UsesFilePath(Placeable placeable)
        {
            if (placeable == null)
                return false;
                
            return !string.IsNullOrEmpty(placeable.FilePath);
        }
```

Determines if the resource identifier is a file path or UID

**Returns:** `bool`

**Parameters:**
- `Placeable placeable`

### CreateFromFile

```csharp
/// <summary>
        /// Creates a placeable with file path reference
        /// </summary>
        /// <param name="id">Unique identifier</param>
        /// <param name="name">Display name</param>
        /// <param name="filePath">Engine-agnostic path to the resource file (e.g., "buildings/house.tscn")</param>
        /// <returns>Configured placeable</returns>
        public static Placeable CreateFromFile(string id, string name, string filePath)
        {
            return new Placeable
            {
                Id = id,
                Name = name,
                FilePath = filePath,
                IsValid = true
            };
        }
```

Creates a placeable with file path reference

**Returns:** `Placeable`

**Parameters:**
- `string id`
- `string name`
- `string filePath`

### CreateFromUid

```csharp
/// <summary>
        /// Creates a placeable with UID reference
        /// </summary>
        /// <param name="id">Unique identifier</param>
        /// <param name="name">Display name</param>
        /// <param name="resourceUid">Godot resource UID</param>
        /// <returns>Configured placeable</returns>
        public static Placeable CreateFromUid(string id, string name, string resourceUid)
        {
            return new Placeable
            {
                Id = id,
                Name = name,
                ResourceUid = resourceUid,
                IsValid = true
            };
        }
```

Creates a placeable with UID reference

**Returns:** `Placeable`

**Parameters:**
- `string id`
- `string name`
- `string resourceUid`

