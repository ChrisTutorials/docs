---
title: "Constants"
description: "DEPRECATED: Use domain-specific constant classes instead.
This facade exists for backward compatibility only."
weight: 20
url: "/gridbuilding/v6-0/api/godot/constants/"
---

# Constants

```csharp
GridBuilding.Godot.Core
class Constants
{
    // Members...
}
```

DEPRECATED: Use domain-specific constant classes instead.
This facade exists for backward compatibility only.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Constants.cs`  
**Namespace:** `GridBuilding.Godot.Core`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### COLLISIONS_CHECK_RULE_PATH

```csharp
#endregion

    #region Resources (use ResourcePaths)

    [Obsolete("Use ResourcePaths.CollisionsCheckRule")]
    public static Resource COLLISIONS_CHECK_RULE_PATH => ResourcePaths.CollisionsCheckRule;
```

### TILEMAP_BOUNDS_RULE_PATH

```csharp
[Obsolete("Use ResourcePaths.TilemapBoundsRule")]
    public static Resource TILEMAP_BOUNDS_RULE_PATH => ResourcePaths.TilemapBoundsRule;
```

### RUNTIME_ANALYZER_THEME_ALT1_PATH

```csharp
[Obsolete("Use ThemeConstants.RuntimeAnalyzerThemeAlt1")]
    public static Resource RUNTIME_ANALYZER_THEME_ALT1_PATH => ThemeConstants.RuntimeAnalyzerThemeAlt1;
```

### RUNTIME_ANALYZER_THEME_ALT2_PATH

```csharp
[Obsolete("Use ThemeConstants.RuntimeAnalyzerThemeAlt2")]
    public static Resource RUNTIME_ANALYZER_THEME_ALT2_PATH => ThemeConstants.RuntimeAnalyzerThemeAlt2;
```

### PLACEABLE_UI_THEME

```csharp
[Obsolete("Use ThemeConstants.PlaceableUiTheme")]
    public static Theme PLACEABLE_UI_THEME => ThemeConstants.PlaceableUiTheme;
```


## Methods

### HasMetadata

```csharp
#endregion

    #region Helper Methods (use MetadataUtils)

    [Obsolete("Use MetadataUtils.HasMetadata")]
    public static bool HasMetadata(Node node, string metaKey) => MetadataUtils.HasMetadata(node, metaKey);
```

**Returns:** `bool`

**Parameters:**
- `Node node`
- `string metaKey`

### GetMetadata

```csharp
[Obsolete("Use MetadataUtils.GetMetadata")]
    public static Variant GetMetadata(Node node, string metaKey, Variant defaultValue = default) 
        => MetadataUtils.GetMetadata(node, metaKey, defaultValue);
```

**Returns:** `Variant`

**Parameters:**
- `Node node`
- `string metaKey`
- `Variant defaultValue`

### SetMetadata

```csharp
[Obsolete("Use MetadataUtils.SetMetadata")]
    public static void SetMetadata(Node node, string metaKey, Variant value) 
        => MetadataUtils.SetMetadata(node, metaKey, value);
```

**Returns:** `void`

**Parameters:**
- `Node node`
- `string metaKey`
- `Variant value`

### RemoveMetadata

```csharp
[Obsolete("Use MetadataUtils.RemoveMetadata")]
    public static bool RemoveMetadata(Node node, string metaKey) => MetadataUtils.RemoveMetadata(node, metaKey);
```

**Returns:** `bool`

**Parameters:**
- `Node node`
- `string metaKey`

### IsPreviewBuild

```csharp
[Obsolete("Use MetadataUtils.IsPreviewBuild")]
    public static bool IsPreviewBuild(Node node) => MetadataUtils.IsPreviewBuild(node);
```

**Returns:** `bool`

**Parameters:**
- `Node node`

### IsPreview

```csharp
[Obsolete("Use MetadataUtils.IsPreview")]
    public static bool IsPreview(Node node) => MetadataUtils.IsPreview(node);
```

**Returns:** `bool`

**Parameters:**
- `Node node`

### SetPreviewBuild

```csharp
[Obsolete("Use MetadataUtils.SetPreviewBuild")]
    public static void SetPreviewBuild(Node node, bool isPreview) => MetadataUtils.SetPreviewBuild(node, isPreview);
```

**Returns:** `void`

**Parameters:**
- `Node node`
- `bool isPreview`

### SetPreview

```csharp
[Obsolete("Use MetadataUtils.SetPreview")]
    public static void SetPreview(Node node, bool isPreview) => MetadataUtils.SetPreview(node, isPreview);
```

**Returns:** `void`

**Parameters:**
- `Node node`
- `bool isPreview`

### GetDisplayName

```csharp
[Obsolete("Use MetadataUtils.GetDisplayName")]
    public static string GetDisplayName(Node node, string fallbackName = null) 
        => MetadataUtils.GetDisplayName(node, fallbackName);
```

**Returns:** `string`

**Parameters:**
- `Node node`
- `string fallbackName`

### SetDisplayName

```csharp
[Obsolete("Use MetadataUtils.SetDisplayName")]
    public static void SetDisplayName(Node node, string displayName) 
        => MetadataUtils.SetDisplayName(node, displayName);
```

**Returns:** `void`

**Parameters:**
- `Node node`
- `string displayName`

