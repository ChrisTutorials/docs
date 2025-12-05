---
title: "InheritanceOverrides"
description: "Configuration for inheritance overrides"
weight: 10
url: "/gridbuilding/v6-0/api/core/inheritanceoverrides/"
---

# InheritanceOverrides

```csharp
GridBuilding.Core.Types
class InheritanceOverrides
{
    // Members...
}
```

Configuration for inheritance overrides

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/InheritanceTypes.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ExcludedCategories

```csharp
/// <summary>
    /// Categories to explicitly exclude from inheritance
    /// </summary>
    public List<string> ExcludedCategories { get; set; } = new();
```

Categories to explicitly exclude from inheritance

### ExcludedPlaceables

```csharp
/// <summary>
    /// Placeables to explicitly exclude from inheritance
    /// </summary>
    public List<string> ExcludedPlaceables { get; set; } = new();
```

Placeables to explicitly exclude from inheritance

### ExcludedProperties

```csharp
/// <summary>
    /// Properties to exclude from inheritance
    /// </summary>
    public List<string> ExcludedProperties { get; set; } = new();
```

Properties to exclude from inheritance

### CategoryStrategies

```csharp
/// <summary>
    /// Category-specific merge strategies
    /// </summary>
    public Dictionary<string, CategoryMergeStrategy> CategoryStrategies { get; set; } = new();
```

Category-specific merge strategies

### PlaceableStrategies

```csharp
/// <summary>
    /// Placeable-specific merge strategies
    /// </summary>
    public Dictionary<string, PlaceableMergeStrategy> PlaceableStrategies { get; set; } = new();
```

Placeable-specific merge strategies

### ForceInheritance

```csharp
/// <summary>
    /// Whether to force inheritance even if conflicts exist
    /// </summary>
    public bool ForceInheritance { get; set; } = false;
```

Whether to force inheritance even if conflicts exist

### EnableLogging

```csharp
/// <summary>
    /// Whether to log inheritance operations
    /// </summary>
    public bool EnableLogging { get; set; } = false;
```

Whether to log inheritance operations


## Methods

### ExcludeCategory

```csharp
/// <summary>
    /// Adds a category to the exclusion list
    /// </summary>
    public void ExcludeCategory(string categoryName)
    {
        if (!ExcludedCategories.Contains(categoryName))
        {
            ExcludedCategories.Add(categoryName);
        }
    }
```

Adds a category to the exclusion list

**Returns:** `void`

**Parameters:**
- `string categoryName`

### ExcludePlaceable

```csharp
/// <summary>
    /// Adds a placeable to the exclusion list
    /// </summary>
    public void ExcludePlaceable(string placeableName)
    {
        if (!ExcludedPlaceables.Contains(placeableName))
        {
            ExcludedPlaceables.Add(placeableName);
        }
    }
```

Adds a placeable to the exclusion list

**Returns:** `void`

**Parameters:**
- `string placeableName`

### SetCategoryStrategy

```csharp
/// <summary>
    /// Sets the merge strategy for a specific category
    /// </summary>
    public void SetCategoryStrategy(string categoryName, CategoryMergeStrategy strategy)
    {
        CategoryStrategies[categoryName] = strategy;
    }
```

Sets the merge strategy for a specific category

**Returns:** `void`

**Parameters:**
- `string categoryName`
- `CategoryMergeStrategy strategy`

### SetPlaceableStrategy

```csharp
/// <summary>
    /// Sets the merge strategy for a specific placeable
    /// </summary>
    public void SetPlaceableStrategy(string placeableName, PlaceableMergeStrategy strategy)
    {
        PlaceableStrategies[placeableName] = strategy;
    }
```

Sets the merge strategy for a specific placeable

**Returns:** `void`

**Parameters:**
- `string placeableName`
- `PlaceableMergeStrategy strategy`

