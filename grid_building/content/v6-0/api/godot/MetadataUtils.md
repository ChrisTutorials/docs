---
title: "MetadataUtils"
description: "Utility methods for working with node metadata.
Provides type-safe access to common metadata operations."
weight: 20
url: "/gridbuilding/v6-0/api/godot/metadatautils/"
---

# MetadataUtils

```csharp
GridBuilding.Godot.Core.Utilities
class MetadataUtils
{
    // Members...
}
```

Utility methods for working with node metadata.
Provides type-safe access to common metadata operations.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/MetadataUtils.cs`  
**Namespace:** `GridBuilding.Godot.Core.Utilities`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### HasMetadata

```csharp
/// <summary>
    /// Checks if a metadata tag exists on a node.
    /// </summary>
    /// <param name="node">Node to check</param>
    /// <param name="metaKey">Metadata key to check for</param>
    /// <returns>True if metadata exists</returns>
    public static bool HasMetadata(Node node, string metaKey)
    {
        return node.HasMeta(metaKey);
    }
```

Checks if a metadata tag exists on a node.

**Returns:** `bool`

**Parameters:**
- `Node node`
- `string metaKey`

### GetMetadata

```csharp
/// <summary>
    /// Gets metadata value from a node.
    /// </summary>
    /// <param name="node">Node to get metadata from</param>
    /// <param name="metaKey">Metadata key</param>
    /// <param name="defaultValue">Default value if metadata doesn't exist</param>
    /// <returns>Metadata value or default</returns>
    public static Variant GetMetadata(Node node, string metaKey, Variant defaultValue = default)
    {
        return node.GetMeta(metaKey, defaultValue);
    }
```

Gets metadata value from a node.

**Returns:** `Variant`

**Parameters:**
- `Node node`
- `string metaKey`
- `Variant defaultValue`

### SetMetadata

```csharp
/// <summary>
    /// Sets metadata on a node.
    /// </summary>
    /// <param name="node">Node to set metadata on</param>
    /// <param name="metaKey">Metadata key</param>
    /// <param name="value">Metadata value</param>
    public static void SetMetadata(Node node, string metaKey, Variant value)
    {
        node.SetMeta(metaKey, value);
    }
```

Sets metadata on a node.

**Returns:** `void`

**Parameters:**
- `Node node`
- `string metaKey`
- `Variant value`

### RemoveMetadata

```csharp
/// <summary>
    /// Removes metadata from a node.
    /// </summary>
    /// <param name="node">Node to remove metadata from</param>
    /// <param name="metaKey">Metadata key to remove</param>
    /// <returns>True if metadata was removed</returns>
    public static bool RemoveMetadata(Node node, string metaKey)
    {
        if (node.HasMeta(metaKey))
        {
            node.RemoveMeta(metaKey);
            return true;
        }
        return false;
    }
```

Removes metadata from a node.

**Returns:** `bool`

**Parameters:**
- `Node node`
- `string metaKey`

### IsPreviewBuild

```csharp
/// <summary>
    /// Checks if a node is marked as a preview build.
    /// </summary>
    /// <param name="node">Node to check</param>
    /// <returns>True if node is a preview build</returns>
    public static bool IsPreviewBuild(Node node)
    {
        return HasMetadata(node, MetadataConstants.IsPreviewBuild) && 
               GetMetadata(node, MetadataConstants.IsPreviewBuild).AsBool();
    }
```

Checks if a node is marked as a preview build.

**Returns:** `bool`

**Parameters:**
- `Node node`

### IsPreview

```csharp
/// <summary>
    /// Checks if a node is marked as preview.
    /// </summary>
    /// <param name="node">Node to check</param>
    /// <returns>True if node is preview</returns>
    public static bool IsPreview(Node node)
    {
        return HasMetadata(node, MetadataConstants.IsPreview) && 
               GetMetadata(node, MetadataConstants.IsPreview).AsBool();
    }
```

Checks if a node is marked as preview.

**Returns:** `bool`

**Parameters:**
- `Node node`

### SetPreviewBuild

```csharp
/// <summary>
    /// Marks a node as a preview build.
    /// </summary>
    /// <param name="node">Node to mark</param>
    /// <param name="isPreview">Whether the node is a preview build</param>
    public static void SetPreviewBuild(Node node, bool isPreview)
    {
        SetMetadata(node, MetadataConstants.IsPreviewBuild, isPreview);
    }
```

Marks a node as a preview build.

**Returns:** `void`

**Parameters:**
- `Node node`
- `bool isPreview`

### SetPreview

```csharp
/// <summary>
    /// Marks a node as preview.
    /// </summary>
    /// <param name="node">Node to mark</param>
    /// <param name="isPreview">Whether the node is preview</param>
    public static void SetPreview(Node node, bool isPreview)
    {
        SetMetadata(node, MetadataConstants.IsPreview, isPreview);
    }
```

Marks a node as preview.

**Returns:** `void`

**Parameters:**
- `Node node`
- `bool isPreview`

### GetDisplayName

```csharp
/// <summary>
    /// Gets the display name from a node's metadata.
    /// </summary>
    /// <param name="node">Node to get display name from</param>
    /// <param name="fallbackName">Fallback name if no display name is set</param>
    /// <returns>Display name or fallback</returns>
    public static string GetDisplayName(Node node, string fallbackName = null)
    {
        if (HasMetadata(node, MetadataConstants.DisplayName))
        {
            return GetMetadata(node, MetadataConstants.DisplayName).AsString();
        }
        return fallbackName ?? node.Name;
    }
```

Gets the display name from a node's metadata.

**Returns:** `string`

**Parameters:**
- `Node node`
- `string fallbackName`

### SetDisplayName

```csharp
/// <summary>
    /// Sets the display name on a node's metadata.
    /// </summary>
    /// <param name="node">Node to set display name on</param>
    /// <param name="displayName">Display name to set</param>
    public static void SetDisplayName(Node node, string displayName)
    {
        SetMetadata(node, MetadataConstants.DisplayName, displayName);
    }
```

Sets the display name on a node's metadata.

**Returns:** `void`

**Parameters:**
- `Node node`
- `string displayName`

