---
title: "PlaceableConfigurationLoader"
description: "Configuration loader and validator"
weight: 10
url: "/gridbuilding/v6-0/api/core/placeableconfigurationloader/"
---

# PlaceableConfigurationLoader

```csharp
GridBuilding.Core.Configuration
class PlaceableConfigurationLoader
{
    // Members...
}
```

Configuration loader and validator

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Configuration/PlaceableConfiguration.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### LoadFromJson

```csharp
/// <summary>
        /// Loads configuration from JSON file
        /// </summary>
        public static Result<PlaceableConfiguration> LoadFromJson(string filePath)
        {
            try
            {
                if (!System.IO.File.Exists(filePath))
                    return Result<PlaceableConfiguration>.Failure($"Configuration file not found: {filePath}");

                var json = System.IO.File.ReadAllText(filePath);
                var serializer = new Serialization.PlaceableSerializer();
                var config = new PlaceableConfiguration();

                // For now, create a basic configuration
                // In a full implementation, this would use proper JSON deserialization
                return Result<PlaceableConfiguration>.Success(config);
            }
            catch (Exception ex)
            {
                return Result<PlaceableConfiguration>.Failure($"Failed to load configuration: {ex.Message}");
            }
        }
```

Loads configuration from JSON file

**Returns:** `Result<PlaceableConfiguration>`

**Parameters:**
- `string filePath`

### ValidateConfiguration

```csharp
/// <summary>
        /// Validates configuration
        /// </summary>
        public static Result<bool> ValidateConfiguration(PlaceableConfiguration config)
        {
            try
            {
                if (config == null)
                    return Result<bool>.Failure("Configuration is null");

                if (config.Placeables == null)
                    return Result<bool>.Failure("Placeables dictionary is null");

                if (config.ExternalSources == null)
                    return Result<bool>.Failure("External sources list is null");

                // Validate external sources
                foreach (var source in config.ExternalSources)
                {
                    if (string.IsNullOrEmpty(source.Id))
                        return Result<bool>.Failure("External source has no ID");

                    if (string.IsNullOrEmpty(source.Type))
                        return Result<bool>.Failure("External source has no type");
                }

                return Result<bool>.Success(true);
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"Configuration validation failed: {ex.Message}");
            }
        }
```

Validates configuration

**Returns:** `Result<bool>`

**Parameters:**
- `PlaceableConfiguration config`

