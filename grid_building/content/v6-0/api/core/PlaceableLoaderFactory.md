---
title: "PlaceableLoaderFactory"
description: "Factory for creating appropriate placeable loaders based on file format"
weight: 10
url: "/gridbuilding/v6-0/api/core/placeableloaderfactory/"
---

# PlaceableLoaderFactory

```csharp
GridBuilding.Core.Systems.Data
class PlaceableLoaderFactory
{
    // Members...
}
```

Factory for creating appropriate placeable loaders based on file format

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Data/PlaceableLoaderFactory.cs`  
**Namespace:** `GridBuilding.Core.Systems.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetLoader

```csharp
/// <summary>
        /// Gets the appropriate loader for the specified file
        /// </summary>
        public IPlaceableLoader GetLoader(string path)
        {
            var extension = Path.GetExtension(path).ToLowerInvariant();
            
            if (_loaders.TryGetValue(extension, out var loader))
                return loader;

            throw new NotSupportedException($"No loader available for file extension: {extension}");
        }
```

Gets the appropriate loader for the specified file

**Returns:** `IPlaceableLoader`

**Parameters:**
- `string path`

### Load

```csharp
/// <summary>
        /// Loads a placeable collection using the appropriate loader
        /// </summary>
        public PlaceableCollection Load(string path)
        {
            var loader = GetLoader(path);
            return loader.Load(path);
        }
```

Loads a placeable collection using the appropriate loader

**Returns:** `PlaceableCollection`

**Parameters:**
- `string path`

### IsSupported

```csharp
/// <summary>
        /// Checks if a file format is supported
        /// </summary>
        public bool IsSupported(string path)
        {
            var extension = Path.GetExtension(path).ToLowerInvariant();
            return _loaders.ContainsKey(extension);
        }
```

Checks if a file format is supported

**Returns:** `bool`

**Parameters:**
- `string path`

### GetSupportedExtensions

```csharp
/// <summary>
        /// Gets all supported file extensions
        /// </summary>
        public string[] GetSupportedExtensions()
        {
            return _loaders.Keys.Distinct().ToArray();
        }
```

Gets all supported file extensions

**Returns:** `string[]`

