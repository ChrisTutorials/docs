---
title: "JsonPlaceableLoader"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/jsonplaceableloader/"
---

# JsonPlaceableLoader

```csharp
GridBuilding.Core.Systems.Data
class JsonPlaceableLoader
{
    // Members...
}
```

Loads placeable configurations from JSON files (secondary format)

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Data/JsonPlaceableLoader.cs`  
**Namespace:** `GridBuilding.Core.Systems.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Load

```csharp
public PlaceableCollection Load(string path)
        {
            if (!File.Exists(path))
                throw new FileNotFoundException($"JSON configuration file not found: {path}");

            try
            {
                var json = File.ReadAllText(path);
                var collection = JsonSerializer.Deserialize<PlaceableCollection>(json, _serializerOptions);
                
                if (collection == null)
                    throw new InvalidOperationException($"Failed to deserialize JSON from {path}");

                // Validate basic structure
                var issues = collection.Validate();
                if (issues.Count > 0)
                {
                    throw new InvalidOperationException(
                        $"JSON validation failed for {path}:\n" + 
                        string.Join("\n", issues));
                }

                return collection;
            }
            catch (Exception ex) when (!(ex is FileNotFoundException || ex is InvalidOperationException))
            {
                throw new InvalidOperationException($"Failed to load JSON from {path}: {ex.Message}", ex);
            }
        }
```

**Returns:** `PlaceableCollection`

**Parameters:**
- `string path`

### CanLoad

```csharp
public bool CanLoad(string path)
        {
            var extension = Path.GetExtension(path).ToLowerInvariant();
            return GetSupportedExtensions().Contains(extension);
        }
```

**Returns:** `bool`

**Parameters:**
- `string path`

### GetSupportedExtensions

```csharp
public string[] GetSupportedExtensions()
        {
            return new[] { ".json" };
        }
```

**Returns:** `string[]`

