---
title: "PlaceableMigrationTool"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/placeablemigrationtool/"
---

# PlaceableMigrationTool

```csharp
GridBuilding.Godot.Utils
class PlaceableMigrationTool
{
    // Members...
}
```

Utility for migrating legacy Placeable resources to YAML configuration

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/Utils/PlaceableMigrationTool.cs`  
**Namespace:** `GridBuilding.Godot.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ConvertDirectoryToYaml

```csharp
/// <summary>
        /// Converts a directory of .tres files to a single YAML file
        /// </summary>
        public static void ConvertDirectoryToYaml(string resourceDir, string outputPath, string collectionName = "Migrated Placeables")
        {
            if (!DirAccess.DirExistsAbsolute(resourceDir))
            {
                GD.PrintErr($"Resource directory does not exist: {resourceDir}");
                return;
            }

            var collection = new PlaceableCollection
            {
                Metadata = new PlaceableMetadata
                {
                    Name = collectionName,
                    Description = $"Migrated from {resourceDir}",
                    Author = "Migration Tool",
                    Version = "1.0"
                }
            };

            var resourceFiles = GetResourceFiles(resourceDir);
            var convertedCount = 0;

            foreach (var filePath in resourceFiles)
            {
                try
                {
                    var resource = GD.Load<Placeable>(filePath);
                    if (resource != null)
                    {
                        var definition = ConvertResourceToDefinition(resource, filePath);
                        AddToCollection(collection, definition);
                        convertedCount++;
                    }
                }
                catch (Exception ex)
                {
                    GD.PrintErr($"Failed to convert {filePath}: {ex.Message}");
                }
            }

            // Save as YAML
            SaveCollectionAsYaml(collection, outputPath);
            
            GD.Print($"Converted {convertedCount} placeables from {resourceDir} to {outputPath}");
        }
```

Converts a directory of .tres files to a single YAML file

**Returns:** `void`

**Parameters:**
- `string resourceDir`
- `string outputPath`
- `string collectionName`

### ConvertResourceToDefinition

```csharp
/// <summary>
        /// Converts a single Placeable resource to YAML definition
        /// </summary>
        public static PlaceableDefinition ConvertResourceToDefinition(Placeable resource, string resourcePath)
        {
            var definition = new PlaceableDefinition
            {
                Id = Path.GetFileNameWithoutExtension(resourcePath),
                DisplayName = resource.DisplayName ?? Path.GetFileNameWithoutExtension(resourcePath),
                Scene = resource.PackedScene?.ResourcePath ?? "",
                Icon = resource.Icon?.ResourcePath,
                Tags = resource.Tags.Select(t => t.Name).ToArray(),
                CustomData = new Dictionary<string, object>
                {
                    ["original_resource_path"] = resourcePath,
                    ["migration_timestamp"] = DateTime.UtcNow.ToString("O")
                }
            };

            // Convert placement rules
            if (resource.PlacementRules.Count > 0)
            {
                definition.PlacementRules = resource.PlacementRules.Select(ConvertPlacementRule).ToArray();
            }

            // Convert variants if they exist (would need to be added to Placeable resource)
            // This is a placeholder for future enhancement

            return definition;
        }
```

Converts a single Placeable resource to YAML definition

**Returns:** `PlaceableDefinition`

**Parameters:**
- `Placeable resource`
- `string resourcePath`

### ValidateConvertedPlaceables

```csharp
/// <summary>
        /// Validates converted placeables against common issues
        /// </summary>
        public static List<string> ValidateConvertedPlaceables(PlaceableCollection collection)
        {
            var issues = new List<string>();

            foreach (var placeable in collection.GetAllPlaceables())
            {
                // Check for missing scene
                if (string.IsNullOrEmpty(placeable.Scene))
                    issues.Add($"Placeable '{placeable.Id}' has no scene specified");
                else if (!FileAccess.FileExists(placeable.Scene))
                    issues.Add($"Placeable '{placeable.Id}' scene file not found: {placeable.Scene}");

                // Check for missing icon
                if (!string.IsNullOrEmpty(placeable.Icon) && !FileAccess.FileExists(placeable.Icon))
                    issues.Add($"Placeable '{placeable.Id}' icon file not found: {placeable.Icon}");

                // Check for empty display name
                if (string.IsNullOrEmpty(placeable.DisplayName))
                    issues.Add($"Placeable '{placeable.Id}' has no display name");

                // Check for invalid placement rules
                foreach (var rule in placeable.PlacementRules ?? Array.Empty<PlacementRule>())
                {
                    if (string.IsNullOrEmpty(rule.Type))
                        issues.Add($"Placeable '{placeable.Id}' has placement rule with no type");
                }
            }

            return issues;
        }
```

Validates converted placeables against common issues

**Returns:** `List<string>`

**Parameters:**
- `PlaceableCollection collection`

