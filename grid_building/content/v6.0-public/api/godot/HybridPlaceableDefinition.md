---
title: "HybridPlaceableDefinition"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/hybridplaceabledefinition/"
---

# HybridPlaceableDefinition

```csharp
GridBuilding.Godot.Resources
class HybridPlaceableDefinition
{
    // Members...
}
```

Hybrid Resource Definition that supports both data-driven and Resource-based configurations
Provides backward compatibility while encouraging the superior data-driven approach
Converts to PlaceableCollection at runtime

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Base/HybridPlaceableDefinition.cs`  
**Namespace:** `GridBuilding.Godot.Resources`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ConfigurationPath

```csharp
#region Configuration Detection

        /// <summary>
        /// Path to YAML configuration file (preferred approach)
        /// </summary>
        [Export(PropertyHint.File, "*.yaml,*.yml,*.json")]
        public string ConfigurationPath
        {
            get => _configPath;
            set
            {
                _configPath = value;
                _isDataDriven = !string.IsNullOrEmpty(value);
                UpdatePlaceableCollection();
            }
        }
```

Path to YAML configuration file (preferred approach)

### LegacyPlaceables

```csharp
/// <summary>
        /// Legacy Resource array approach (for backward compatibility)
        /// </summary>
        [Export] public global::Godot.Collections.Array<Placeable> LegacyPlaceables { get; set; } = new();
```

Legacy Resource array approach (for backward compatibility)


## Methods

### GetPlaceableCollection

```csharp
#region Public API

        /// <summary>
        /// Gets the loaded placeable collection
        /// </summary>
        public PlaceableCollection GetPlaceableCollection()
        {
            if (_placeableCollection == null)
                UpdatePlaceableCollection();

            return _placeableCollection ?? throw new InvalidOperationException("Failed to load placeable collection");
        }
```

Gets the loaded placeable collection

**Returns:** `PlaceableCollection`

### GetAllPlaceables

```csharp
/// <summary>
        /// Gets all placeables from the collection
        /// </summary>
        public IEnumerable<PlaceableDefinition> GetAllPlaceables()
        {
            return GetPlaceableCollection().GetAllPlaceables();
        }
```

Gets all placeables from the collection

**Returns:** `IEnumerable<PlaceableDefinition>`

### GetPlaceablesByTag

```csharp
/// <summary>
        /// Gets placeables by tag
        /// </summary>
        public IEnumerable<PlaceableDefinition> GetPlaceablesByTag(string tag)
        {
            return GetPlaceableCollection().GetPlaceablesByTag(tag);
        }
```

Gets placeables by tag

**Returns:** `IEnumerable<PlaceableDefinition>`

**Parameters:**
- `string tag`

### GetPlaceablesInCategory

```csharp
/// <summary>
        /// Gets placeables in a category
        /// </summary>
        public IEnumerable<PlaceableDefinition> GetPlaceablesInCategory(string categoryId)
        {
            return GetPlaceableCollection().GetPlaceablesInCategory(categoryId);
        }
```

Gets placeables in a category

**Returns:** `IEnumerable<PlaceableDefinition>`

**Parameters:**
- `string categoryId`

### GetPlaceable

```csharp
/// <summary>
        /// Gets a specific placeable by ID
        /// </summary>
        public PlaceableDefinition? GetPlaceable(string id)
        {
            return GetPlaceableCollection().GetPlaceable(id);
        }
```

Gets a specific placeable by ID

**Returns:** `PlaceableDefinition?`

**Parameters:**
- `string id`

### IsDataDriven

```csharp
/// <summary>
        /// Checks if this definition is using data-driven configuration
        /// </summary>
        public bool IsDataDriven() => _isDataDriven;
```

Checks if this definition is using data-driven configuration

**Returns:** `bool`

### Validate

```csharp
/// <summary>
        /// Validates the current configuration
        /// </summary>
        public List<string> Validate()
        {
            var issues = new List<string>();

            if (_isDataDriven)
            {
                if (string.IsNullOrEmpty(_configPath))
                    issues.Add("ConfigurationPath is empty but data-driven mode is enabled");
                else if (!FileAccess.FileExists(_configPath))
                    issues.Add($"Configuration file not found: {_configPath}");
            }
            else
            {
                if (LegacyPlaceables.Count == 0)
                    issues.Add("No legacy placeables configured and no data-driven path specified");
            }

            // Validate the loaded collection
            if (_placeableCollection != null)
                issues.AddRange(_placeableCollection.Validate());

            return issues;
        }
```

Validates the current configuration

**Returns:** `List<string>`

### ToYaml

```csharp
#endregion

        #region Conversion Utilities

        /// <summary>
        /// Converts this definition to YAML format
        /// </summary>
        public string ToYaml()
        {
            // YAML functionality disabled - YamlDotNet dependency removed
            return "// YAML serialization disabled - YamlDotNet dependency removed";
            
            /*
            var collection = GetPlaceableCollection();
            
            var serializer = new YamlDotNet.Serialization.SerializerBuilder()
                .WithNamingConvention(YamlDotNet.Serialization.NamingConventions.CamelCaseNamingConvention.Instance)
                .Build();

            return serializer.Serialize(collection);
            */
        }
```

Converts this definition to YAML format

**Returns:** `string`

### SaveAsYaml

```csharp
/// <summary>
        /// Saves this definition as a YAML file
        /// </summary>
        public void SaveAsYaml(string path)
        {
            var yaml = ToYaml();
            
            using var file = FileAccess.Open(path, FileAccess.ModeFlags.Write);
            if (file != null)
            {
                file.StoreString(yaml);
                file.Close();
                GD.Print($"Saved placeable collection as YAML: {path}");
            }
            else
            {
                GD.PrintErr($"Failed to save YAML file: {path}");
            }
        }
```

Saves this definition as a YAML file

**Returns:** `void`

**Parameters:**
- `string path`

### ConvertLegacyToYaml

```csharp
/// <summary>
        /// Converts legacy resources to YAML and updates the configuration path
        /// </summary>
        public void ConvertLegacyToYaml(string yamlPath)
        {
            if (_isDataDriven)
            {
                GD.PrintWarn("Already using data-driven configuration, no legacy resources to convert");
                return;
            }

            if (LegacyPlaceables.Count == 0)
            {
                GD.PrintWarn("No legacy resources to convert");
                return;
            }

            // Convert and save
            SaveAsYaml(yamlPath);
            
            // Update to use YAML configuration
            ConfigurationPath = yamlPath;
            
            GD.Print($"Converted {LegacyPlaceables.Count} legacy resources to YAML: {yamlPath}");
        }
```

Converts legacy resources to YAML and updates the configuration path

**Returns:** `void`

**Parameters:**
- `string yamlPath`

