---
title: "ExternalDataLoader"
description: "Generic data loader for external placeable data sources"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/externaldataloader/"
---

# ExternalDataLoader

```csharp
GridBuilding.Core.Integration
class ExternalDataLoader
{
    // Members...
}
```

Generic data loader for external placeable data sources

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Integration/ExternalDataLoader.cs`  
**Namespace:** `GridBuilding.Core.Integration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### LoadFromSource

```csharp
/// <summary>
        /// Loads placeable from external data source
        /// </summary>
        public Result<PlaceableDefinition> LoadFromSource(string sourcePath, string format = "auto")
        {
            try
            {
                if (!File.Exists(sourcePath))
                    return Result<PlaceableDefinition>.Failure($"Source file not found: {sourcePath}");

                var data = File.ReadAllText(sourcePath);
                
                // Auto-detect format if not specified
                if (format == "auto")
                {
                    format = DetectFormat(sourcePath, data);
                }

                if (!_formatLoaders.TryGetValue(format, out var loader))
                {
                    return Result<PlaceableDefinition>.Failure($"Format not supported: {format}");
                }

                var placeable = loader(data);
                if (placeable.Success)
                {
                    // Add external reference to source
                    placeable.Value.ExternalReferences.AddOrUpdateReference(new ExternalPlaceableReference
                    {
                        ExternalId = Path.GetFileNameWithoutExtension(sourcePath),
                        SystemName = "file_loader",
                        SystemVersion = "1.0",
                        MappingData = new Dictionary<string, object>
                        {
                            ["source_path"] = sourcePath,
                            ["format"] = format,
                            ["loaded_at"] = DateTime.UtcNow
                        }
                    });
                }

                return placeable;
            }
            catch (Exception ex)
            {
                return Result<PlaceableDefinition>.Failure($"Failed to load from source: {ex.Message}");
            }
        }
```

Loads placeable from external data source

**Returns:** `Result<PlaceableDefinition>`

**Parameters:**
- `string sourcePath`
- `string format`

### LoadCollectionFromSource

```csharp
/// <summary>
        /// Loads multiple placeables from a collection file
        /// </summary>
        public Result<PlaceableCollection> LoadCollectionFromSource(string sourcePath, string format = "auto")
        {
            try
            {
                if (!File.Exists(sourcePath))
                    return Result<PlaceableCollection>.Failure($"Source file not found: {sourcePath}");

                var data = File.ReadAllText(sourcePath);
                
                // Auto-detect format if not specified
                if (format == "auto")
                {
                    format = DetectFormat(sourcePath, data);
                }

                switch (format.ToLower())
                {
                    case "json":
                        return LoadJsonCollection(data, sourcePath);
                    
                    case "toml":
                        return LoadTomlCollection(data, sourcePath);
                    
                    default:
                        return Result<PlaceableCollection>.Failure($"Collection format not supported: {format}");
                }
            }
            catch (Exception ex)
            {
                return Result<PlaceableCollection>.Failure($"Failed to load collection from source: {ex.Message}");
            }
        }
```

Loads multiple placeables from a collection file

**Returns:** `Result<PlaceableCollection>`

**Parameters:**
- `string sourcePath`
- `string format`

### ValidateExternalData

```csharp
/// <summary>
        /// Validates external data format
        /// </summary>
        public Result<bool> ValidateExternalData(string data, string format)
        {
            try
            {
                if (!_formatLoaders.TryGetValue(format, out var loader))
                {
                    return Result<bool>.Failure($"Format not supported: {format}");
                }

                var result = loader(data);
                return Result<bool>.Success(result.Success);
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"Validation failed: {ex.Message}");
            }
        }
```

Validates external data format

**Returns:** `Result<bool>`

**Parameters:**
- `string data`
- `string format`

### RegisterFormatLoader

```csharp
/// <summary>
        /// Registers a custom format loader
        /// </summary>
        public Result<bool> RegisterFormatLoader(string format, Func<string, Result<PlaceableDefinition>> loader)
        {
            try
            {
                if (string.IsNullOrEmpty(format))
                    return Result<bool>.Failure("Format cannot be null or empty");

                if (loader == null)
                    return Result<bool>.Failure("Loader cannot be null");

                _formatLoaders[format] = loader;
                return Result<bool>.Success(true);
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"Failed to register format loader: {ex.Message}");
            }
        }
```

Registers a custom format loader

**Returns:** `Result<bool>`

**Parameters:**
- `string format`
- `Func<string, Result<PlaceableDefinition>> loader`

### GetSupportedFormats

```csharp
/// <summary>
        /// Gets supported formats
        /// </summary>
        public IEnumerable<string> GetSupportedFormats()
        {
            return _formatLoaders.Keys;
        }
```

Gets supported formats

**Returns:** `IEnumerable<string>`

### LoadFromMultipleSources

```csharp
/// <summary>
        /// Loads placeables from multiple sources
        /// </summary>
        public Result<PlaceableCollection> LoadFromMultipleSources(IEnumerable<string> sourcePaths)
        {
            try
            {
                var collection = new PlaceableCollection();
                var errors = new List<string>();

                foreach (var sourcePath in sourcePaths)
                {
                    var result = LoadCollectionFromSource(sourcePath);
                    if (result.Success)
                    {
                        foreach (var placeable in result.Value.GetAllPlaceables())
                        {
                            collection.Add(placeable);
                        }
                    }
                    else
                    {
                        errors.Add($"{sourcePath}: {result.Error}");
                    }
                }

                if (errors.Any())
                {
                    return Result<PlaceableCollection>.Failure(
                        $"Failed to load some sources: {string.Join(", ", errors)}");
                }

                return Result<PlaceableCollection>.Success(collection);
            }
            catch (Exception ex)
            {
                return Result<PlaceableCollection>.Failure($"Failed to load from multiple sources: {ex.Message}");
            }
        }
```

Loads placeables from multiple sources

**Returns:** `Result<PlaceableCollection>`

**Parameters:**
- `IEnumerable<string> sourcePaths`

