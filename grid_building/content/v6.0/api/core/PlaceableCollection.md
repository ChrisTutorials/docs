---
title: "PlaceableCollection"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/placeablecollection/"
---

# PlaceableCollection

```csharp
GridBuilding.Core.Systems.Data
class PlaceableCollection
{
    // Members...
}
```

Data structure for YAML/JSON placeable configuration files.
Supports hierarchical organization, inheritance, and metadata.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Data/PlaceableCollection.cs`  
**Namespace:** `GridBuilding.Core.Systems.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Version

```csharp
public string Version { get; set; } = "1.0";
```

### Metadata

```csharp
public PlaceableMetadata Metadata { get; set; }
```

### Categories

```csharp
public Dictionary<string, PlaceableCategory> Categories { get; set; } = new();
```

### Inheritance

```csharp
/// <summary>
        /// Inheritance configuration for this collection
        /// </summary>
        public InheritanceConfig Inheritance { get; set; }
```

Inheritance configuration for this collection

### Extends

```csharp
public string? Extends { get; set; } // For configuration inheritance
```


## Methods

### GetPlaceable

```csharp
/// <summary>
        /// Gets a placeable by ID with inheritance support
        /// </summary>
        public IPlaceable? GetPlaceable(string id)
        {
            return GetPlaceableWithInheritance(id);
        }
```

Gets a placeable by ID with inheritance support

**Returns:** `IPlaceable?`

**Parameters:**
- `string id`

### GetPlaceablesByTag

```csharp
/// <summary>
        /// Gets all placeables with a specific tag
        /// </summary>
        public IEnumerable<IPlaceable> GetPlaceablesByTag(string tag)
        {
            return Categories.Values
                .SelectMany(c => c.Placeables.Values)
                .Where(p => p.Properties.ContainsKey("tags") && 
                         p.Properties["tags"] is IEnumerable<string> tags && tags.Contains(tag));
        }
```

Gets all placeables with a specific tag

**Returns:** `IEnumerable<IPlaceable>`

**Parameters:**
- `string tag`

### GetPlaceablesInCategory

```csharp
/// <summary>
        /// Gets all placeables in a category
        /// </summary>
        public IEnumerable<IPlaceable> GetPlaceablesInCategory(string categoryId)
        {
            return Categories.TryGetValue(categoryId, out var category) 
                ? category.Placeables.Values 
                : Enumerable.Empty<IPlaceable>();
        }
```

Gets all placeables in a category

**Returns:** `IEnumerable<IPlaceable>`

**Parameters:**
- `string categoryId`

### GetAllPlaceables

```csharp
/// <summary>
        /// Gets all placeables across all categories
        /// </summary>
        public IEnumerable<IPlaceable> GetAllPlaceables()
        {
            return Categories.Values.SelectMany(c => c.Placeables.Values);
        }
```

Gets all placeables across all categories

**Returns:** `IEnumerable<IPlaceable>`

### AddPlaceable

```csharp
/// <summary>
        /// Adds a placeable to a category, creating the category if needed
        /// </summary>
        public void AddPlaceable(string categoryId, IPlaceable placeable)
        {
            if (!Categories.TryGetValue(categoryId, out var category))
            {
                category = new PlaceableCategory { Id = categoryId };
                Categories[categoryId] = category;
            }

            category.Placeables[placeable.Id] = placeable;
        }
```

Adds a placeable to a category, creating the category if needed

**Returns:** `void`

**Parameters:**
- `string categoryId`
- `IPlaceable placeable`

### GetPlaceableCategory

```csharp
/// <summary>
        /// Gets the category ID for a placeable
        /// </summary>
        public string? GetPlaceableCategory(string placeableId)
        {
            foreach (var categoryKvp in Categories)
            {
                if (categoryKvp.Value.Placeables.ContainsKey(placeableId))
                {
                    return categoryKvp.Key;
                }
            }
            return null;
        }
```

Gets the category ID for a placeable

**Returns:** `string?`

**Parameters:**
- `string placeableId`

### HasPlaceable

```csharp
/// <summary>
        /// Checks if a placeable exists in the collection
        /// </summary>
        public bool HasPlaceable(string placeableId)
        {
            return GetPlaceableCategory(placeableId) != null;
        }
```

Checks if a placeable exists in the collection

**Returns:** `bool`

**Parameters:**
- `string placeableId`

### Validate

```csharp
/// <summary>
        /// Validates the collection structure and references
        /// </summary>
        public List<string> Validate()
        {
            var issues = new List<string>();

            // Validate metadata
            if (Metadata == null || string.IsNullOrWhiteSpace(Metadata.Name))
                issues.Add("Metadata.Name is required");

            // Validate categories
            foreach (var category in Categories)
            {
                if (string.IsNullOrWhiteSpace(category.Value.DisplayName))
                    issues.Add($"Category '{category.Key}' has no display name");

                // Validate placeables
                foreach (var placeable in category.Value.Placeables)
                {
                    if (string.IsNullOrWhiteSpace(placeable.Value.Name))
                        issues.Add($"Placeable '{placeable.Key}' in category '{category.Key}' has no name");

                    if (string.IsNullOrWhiteSpace(placeable.Value.FilePath))
                        issues.Add($"Placeable '{placeable.Key}' has no file path specified");

                    // Validate placement rules from Properties
                    if (placeable.Value.Properties.TryGetValue("placementRules", out var rulesObj) && 
                        rulesObj is IEnumerable<object> rules)
                    {
                        foreach (var rule in rules)
                        {
                            // Basic validation - would need more specific rule type checking
                            if (rule == null)
                                issues.Add($"Placeable '{placeable.Key}' has null placement rule");
                        }
                    }
                }
            }

            return issues;
        }
```

Validates the collection structure and references

**Returns:** `List<string>`

