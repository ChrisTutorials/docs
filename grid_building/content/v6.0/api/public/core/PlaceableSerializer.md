---
title: "PlaceableSerializer"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/placeableserializer/"
---

# PlaceableSerializer

```csharp
GridBuilding.Core.Serialization
class PlaceableSerializer
{
    // Members...
}
```

Handles JSON/TOML serialization with external system support

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Serialization/PlaceableSerializer.cs`  
**Namespace:** `GridBuilding.Core.Serialization`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ToJson

```csharp
/// <summary>
        /// Serializes placeable to JSON with JsonHelper integration
        /// </summary>
        public Result<string> ToJson(PlaceableDefinition placeable)
        {
            try
            {
                // Use JsonHelper per memory policy
                var json = JsonSerializer.Serialize(placeable, _jsonOptions);
                return Result<string>.Success(json);
            }
            catch (Exception ex)
            {
                return Result<string>.Failure($"JSON serialization failed: {ex.Message}");
            }
        }
```

Serializes placeable to JSON with JsonHelper integration

**Returns:** `Result<string>`

**Parameters:**
- `PlaceableDefinition placeable`

### FromJson

```csharp
/// <summary>
        /// Deserializes placeable from JSON with JsonHelper integration
        /// </summary>
        public Result<PlaceableDefinition> FromJson(string json)
        {
            try
            {
                // Use JsonHelper per memory policy
                var placeable = JsonSerializer.Deserialize<PlaceableDefinition>(json, _jsonOptions);
                if (placeable == null)
                    return Result<PlaceableDefinition>.Failure("Deserialized placeable is null");

                return Result<PlaceableDefinition>.Success(placeable);
            }
            catch (Exception ex)
            {
                return Result<PlaceableDefinition>.Failure($"JSON deserialization failed: {ex.Message}");
            }
        }
```

Deserializes placeable from JSON with JsonHelper integration

**Returns:** `Result<PlaceableDefinition>`

**Parameters:**
- `string json`

### ToToml

```csharp
/// <summary>
        /// Serializes placeable to TOML format
        /// </summary>
        public Result<string> ToToml(PlaceableDefinition placeable)
        {
            try
            {
                var tomlBuilder = new System.Text.StringBuilder();
                
                // Basic properties
                tomlBuilder.AppendLine($"id = \"{EscapeTomlString(placeable.Id)}\"");
                tomlBuilder.AppendLine($"name = \"{EscapeTomlString(placeable.Name)}\"");
                tomlBuilder.AppendLine($"description = \"{EscapeTomlString(placeable.Description)}\"");
                tomlBuilder.AppendLine($"category = \"{placeable.Category}\"");
                tomlBuilder.AppendLine($"can_rotate = {placeable.CanRotate.ToString().ToLower()}");
                tomlBuilder.AppendLine($"can_mirror = {placeable.CanMirror.ToString().ToLower()}");
                
                // Size
                tomlBuilder.AppendLine("[size]");
                tomlBuilder.AppendLine($"x = {placeable.Size.X}");
                tomlBuilder.AppendLine($"y = {placeable.Size.Y}");
                tomlBuilder.AppendLine($"width = {placeable.Size.Width}");
                tomlBuilder.AppendLine($"height = {placeable.Size.Height}");

                // Resource costs
                if (placeable.ResourceCost.Count > 0)
                {
                    tomlBuilder.AppendLine("[resource_cost]");
                    foreach (var cost in placeable.ResourceCost)
                    {
                        tomlBuilder.AppendLine($"{cost.Key} = {cost.Value}");
                    }
                }

                // Tags
                if (placeable.Tags.Count > 0)
                {
                    tomlBuilder.AppendLine("tags = [");
                    for (int i = 0; i < placeable.Tags.Count; i++)
                    {
                        tomlBuilder.AppendLine($"  \"{EscapeTomlString(placeable.Tags[i])}\"{(i < placeable.Tags.Count - 1 ? "," : "")}");
                    }
                    tomlBuilder.AppendLine("]");
                }

                // External references
                if (placeable.ExternalReferences.References.Count > 0)
                {
                    tomlBuilder.AppendLine("[external_references]");
                    foreach (var reference in placeable.ExternalReferences.GetActiveReferences())
                    {
                        tomlBuilder.AppendLine($"[external_references.{reference.SystemName}]");
                        tomlBuilder.AppendLine($"external_id = \"{EscapeTomlString(reference.ExternalId)}\"");
                        tomlBuilder.AppendLine($"system_version = \"{EscapeTomlString(reference.SystemVersion)}\"");
                        tomlBuilder.AppendLine($"last_synced = \"{reference.LastSynced:yyyy-MM-ddTHH:mm:ssZ}\"");
                        tomlBuilder.AppendLine($"is_active = {reference.IsActive.ToString().ToLower()}");
                    }
                }

                // Timestamps
                tomlBuilder.AppendLine($"created_at = \"{placeable.CreatedAt:yyyy-MM-ddTHH:mm:ssZ}\"");
                tomlBuilder.AppendLine($"updated_at = \"{placeable.UpdatedAt:yyyy-MM-ddTHH:mm:ssZ}\"");
                tomlBuilder.AppendLine($"version = {placeable.Version}");

                return Result<string>.Success(tomlBuilder.ToString());
            }
            catch (Exception ex)
            {
                return Result<string>.Failure($"TOML serialization failed: {ex.Message}");
            }
        }
```

Serializes placeable to TOML format

**Returns:** `Result<string>`

**Parameters:**
- `PlaceableDefinition placeable`

### FromToml

```csharp
/// <summary>
        /// Deserializes placeable from TOML format
        /// </summary>
        public Result<PlaceableDefinition> FromToml(string toml)
        {
            try
            {
                var placeable = new PlaceableDefinition();
                
                // Simple TOML parsing (basic implementation)
                var lines = toml.Split('\n', StringSplitOptions.RemoveEmptyEntries);
                
                foreach (var line in lines)
                {
                    var trimmed = line.Trim();
                    if (string.IsNullOrEmpty(trimmed) || trimmed.StartsWith("#"))
                        continue;

                    if (trimmed.Contains('='))
                    {
                        var parts = trimmed.Split('=', 2);
                        if (parts.Length == 2)
                        {
                            var key = parts[0].Trim();
                            var value = parts[1].Trim().Trim('"');
                            
                            switch (key)
                            {
                                case "id":
                                    placeable.Id = value;
                                    break;
                                case "name":
                                    placeable.Name = value;
                                    break;
                                case "description":
                                    placeable.Description = value;
                                    break;
                                case "category":
                                    if (Enum.TryParse<PlaceableCategory>(value, true, out var category))
                                        placeable.Category = category;
                                    break;
                                case "can_rotate":
                                    placeable.CanRotate = bool.Parse(value);
                                    break;
                                case "can_mirror":
                                    placeable.CanMirror = bool.Parse(value);
                                    break;
                                case "version":
                                    placeable.Version = int.Parse(value);
                                    break;
                            }
                        }
                    }
                }

                return Result<PlaceableDefinition>.Success(placeable);
            }
            catch (Exception ex)
            {
                return Result<PlaceableDefinition>.Failure($"TOML deserialization failed: {ex.Message}");
            }
        }
```

Deserializes placeable from TOML format

**Returns:** `Result<PlaceableDefinition>`

**Parameters:**
- `string toml`

### FromExternalSource

```csharp
/// <summary>
        /// Loads placeable from external data source
        /// </summary>
        public Result<PlaceableDefinition> FromExternalSource(IPlaceableDataProvider provider, string id)
        {
            try
            {
                if (!provider.IsAvailable())
                    return Result<PlaceableDefinition>.Failure("External provider not available");

                return provider.GetPlaceable(id);
            }
            catch (Exception ex)
            {
                return Result<PlaceableDefinition>.Failure($"External source loading failed: {ex.Message}");
            }
        }
```

Loads placeable from external data source

**Returns:** `Result<PlaceableDefinition>`

**Parameters:**
- `IPlaceableDataProvider provider`
- `string id`

### ValidateExternalCompatibility

```csharp
/// <summary>
        /// Validates external data compatibility
        /// </summary>
        public Result<bool> ValidateExternalCompatibility(string externalData, string format = "json")
        {
            try
            {
                switch (format.ToLower())
                {
                    case "json":
                        var jsonResult = FromJson(externalData);
                        return Result<bool>.Success(jsonResult.Success);
                    
                    case "toml":
                        var tomlResult = FromToml(externalData);
                        return Result<bool>.Success(tomlResult.Success);
                    
                    default:
                        return Result<bool>.Failure($"Unsupported format: {format}");
                }
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"External validation failed: {ex.Message}");
            }
        }
```

Validates external data compatibility

**Returns:** `Result<bool>`

**Parameters:**
- `string externalData`
- `string format`

### CollectionToJson

```csharp
/// <summary>
        /// Serializes placeable collection to JSON
        /// </summary>
        public Result<string> CollectionToJson(PlaceableCollection collection)
        {
            try
            {
                var placeables = collection.GetAllPlaceables();
                var json = JsonSerializer.Serialize(placeables, _jsonOptions);
                return Result<string>.Success(json);
            }
            catch (Exception ex)
            {
                return Result<string>.Failure($"Collection JSON serialization failed: {ex.Message}");
            }
        }
```

Serializes placeable collection to JSON

**Returns:** `Result<string>`

**Parameters:**
- `PlaceableCollection collection`

### CollectionFromJson

```csharp
/// <summary>
        /// Deserializes placeable collection from JSON
        /// </summary>
        public Result<PlaceableCollection> CollectionFromJson(string json)
        {
            try
            {
                var placeables = JsonSerializer.Deserialize<List<PlaceableDefinition>>(json, _jsonOptions);
                var collection = new PlaceableCollection();
                
                if (placeables != null)
                {
                    foreach (var placeable in placeables)
                    {
                        collection.Add(placeable);
                    }
                }

                return Result<PlaceableCollection>.Success(collection);
            }
            catch (Exception ex)
            {
                return Result<PlaceableCollection>.Failure($"Collection JSON deserialization failed: {ex.Message}");
            }
        }
```

Deserializes placeable collection from JSON

**Returns:** `Result<PlaceableCollection>`

**Parameters:**
- `string json`

