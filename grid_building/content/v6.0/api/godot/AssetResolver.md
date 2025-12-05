---
title: "AssetResolver"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/assetresolver/"
---

# AssetResolver

```csharp
GridBuilding.Godot.Data
class AssetResolver
{
    // Members...
}
```

Utility class for resolving and loading assets.
Ported from: godot/addons/grid_building/shared/utils/asset_resolver.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Data/AssetResolver.cs`  
**Namespace:** `GridBuilding.Godot.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### LoadPlaceablesWithResult

```csharp
/// <summary>
    /// Loads placeables from a folder with detailed results.
    /// </summary>
    /// <param name="folderPath">Path to the folder containing placeables</param>
    /// <returns>LoadPlaceablesResult with detailed information</returns>
    public static LoadPlaceablesResult LoadPlaceablesWithResult(string folderPath)
    {
        var result = new LoadPlaceablesResult();

        // Basic implementation - check if folder exists
        if (!DirAccess.DirExistsAbsolute(folderPath))
        {
            result.Errors.Add($"Folder does not exist: {folderPath}");
            return result;
        }

        // For now, this is a placeholder implementation
        // In a full implementation, this would scan the folder for placeable assets
        result.Warnings.Add("AssetResolver.LoadPlaceablesWithResult is not fully implemented yet");
        
        return result;
    }
```

Loads placeables from a folder with detailed results.

**Returns:** `LoadPlaceablesResult`

**Parameters:**
- `string folderPath`

### LoadPlaceables

```csharp
/// <summary>
    /// Loads placeables from a folder (simple version for backward compatibility).
    /// </summary>
    /// <param name="folderPath">Path to the folder containing placeables</param>
    /// <returns>Array of loaded placeables</returns>
    public static global::Godot.Collections.Array<Godot.Node> LoadPlaceables(string folderPath)
    {
        return LoadPlaceablesFromFolder(folderPath);
    }
```

Loads placeables from a folder (simple version for backward compatibility).

**Returns:** `global::Godot.Collections.Array<Godot.Node>`

**Parameters:**
- `string folderPath`

### LoadPlaceablesFromFolder

```csharp
/// <summary>
    /// Loads placeables from a folder (backward compatibility method).
    /// </summary>
    /// <param name="folderPath">Path to the folder containing placeables</param>
    /// <returns>Array of loaded placeables</returns>
    public static global::Godot.Collections.Array<Godot.Node> LoadPlaceablesFromFolder(string folderPath)
    {
        var result = new global::Godot.Collections.Array<Godot.Node>();
        
        // Basic implementation - check if folder exists
        if (!DirAccess.DirExistsAbsolute(folderPath))
        {
            GD.PrintErr($"Folder does not exist: {folderPath}");
            return result;
        }

        // For now, this is a placeholder implementation
        GD.Print("AssetResolver.LoadPlaceablesFromFolder is not fully implemented yet");
        
        return result;
    }
```

Loads placeables from a folder (backward compatibility method).

**Returns:** `global::Godot.Collections.Array<Godot.Node>`

**Parameters:**
- `string folderPath`

