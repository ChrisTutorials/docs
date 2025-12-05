---
title: "PlaceableResourceHandler"
description: "Godot-side handler for loading placeable resources
Bridges Core Placeable definitions with Godot resource loading"
weight: 20
url: "/gridbuilding/v6-0/api/godot/placeableresourcehandler/"
---

# PlaceableResourceHandler

```csharp
GridBuilding.Godot.Resources
class PlaceableResourceHandler
{
    // Members...
}
```

Godot-side handler for loading placeable resources
Bridges Core Placeable definitions with Godot resource loading

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Resources/PlaceableResourceHandler.cs`  
**Namespace:** `GridBuilding.Godot.Resources`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### LoadPlaceableResource

```csharp
/// <summary>
        /// Loads the Godot resource for a placeable
        /// </summary>
        /// <param name="placeable">The core placeable definition</param>
        /// <returns>The loaded Godot resource or null if failed</returns>
        public static Resource? LoadPlaceableResource(Placeable placeable)
        {
            if (placeable == null || !PlaceableResourceLoader.HasValidResourceReference(placeable))
                return null;
                
            string resourcePath = GetGodotResourcePath(placeable);
            
            if (string.IsNullOrEmpty(resourcePath))
                return null;
                
            return GD.Load(resourcePath);
        }
```

Loads the Godot resource for a placeable

**Returns:** `Resource?`

**Parameters:**
- `Placeable placeable`

### LoadPlaceableScene

```csharp
/// <summary>
        /// Loads the Godot scene for a placeable
        /// </summary>
        /// <param name="placeable">The core placeable definition</param>
        /// <returns>The loaded PackedScene or null if failed</returns>
        public static PackedScene? LoadPlaceableScene(Placeable placeable)
        {
            var resource = LoadPlaceableResource(placeable);
            return resource as PackedScene;
        }
```

Loads the Godot scene for a placeable

**Returns:** `PackedScene?`

**Parameters:**
- `Placeable placeable`

### InstantiatePlaceable

```csharp
/// <summary>
        /// Instantiates a placeable scene
        /// </summary>
        /// <param name="placeable">The core placeable definition</param>
        /// <returns>The instantiated Node or null if failed</returns>
        public static Node? InstantiatePlaceable(Placeable placeable)
        {
            var scene = LoadPlaceableScene(placeable);
            return scene?.Instantiate();
        }
```

Instantiates a placeable scene

**Returns:** `Node?`

**Parameters:**
- `Placeable placeable`

### ValidatePlaceableResource

```csharp
/// <summary>
        /// Validates that a placeable resource exists and is loadable
        /// </summary>
        /// <param name="placeable">The placeable to validate</param>
        /// <returns>True if the resource exists and can be loaded</returns>
        public static bool ValidatePlaceableResource(Placeable placeable)
        {
            if (placeable == null)
                return false;
                
            string resourcePath = GetGodotResourcePath(placeable);
            
            if (string.IsNullOrEmpty(resourcePath))
                return false;
                
            return ResourceLoader.Exists(resourcePath);
        }
```

Validates that a placeable resource exists and is loadable

**Returns:** `bool`

**Parameters:**
- `Placeable placeable`

### CreateFromGodotResource

```csharp
/// <summary>
        /// Creates a Core Placeable from a Godot resource
        /// </summary>
        /// <param name="resourcePath">Path to the Godot resource (with or without res://)</param>
        /// <param name="id">Optional ID (defaults to resource name)</param>
        /// <returns>Core Placeable definition with engine-agnostic path</returns>
        public static Placeable CreateFromGodotResource(string resourcePath, string? id = null)
        {
            if (string.IsNullOrEmpty(resourcePath) || !ResourceLoader.Exists(resourcePath))
                return new Placeable { IsValid = false };
                
            // Convert Godot res:// path to engine-agnostic path for Core layer
            string engineAgnosticPath = resourcePath.StartsWith("res://") ? 
                                       resourcePath.Substring(6) : // Remove "res://" prefix
                                       resourcePath;
            
            string resourceId = id ?? engineAgnosticPath.GetFile().GetBaseName();
            string resourceName = resourceId;
            
            return PlaceableResourceLoader.CreateFromFile(resourceId, resourceName, engineAgnosticPath);
        }
```

Creates a Core Placeable from a Godot resource

**Returns:** `Placeable`

**Parameters:**
- `string resourcePath`
- `string? id`

