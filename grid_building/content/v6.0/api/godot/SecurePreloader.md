---
title: "SecurePreloader"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/securepreloader/"
---

# SecurePreloader

```csharp
GridBuilding.Godot.Security
class SecurePreloader
{
    // Members...
}
```

Provides secure preload operations with path validation.
This class ensures that resource and script preloads are performed safely
by validating paths and preventing potential security vulnerabilities.
Ported from: godot/addons/grid_building/core/security/secure_preloader.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Infrastructure/SecurePreloader.cs`  
**Namespace:** `GridBuilding.Godot.Security`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SecurePreload

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Securely preloads a resource with path validation
    /// </summary>
    /// <param name="path">The resource path to preload</param>
    /// <param name="allowedBase">Optional base path that the resource must be within</param>
    /// <returns>The preloaded resource or null if validation fails</returns>
    public static Resource? SecurePreload(string path, string allowedBase = "")
    {
        // Validate the path first
        if (!ValidatePreloadPath(path, allowedBase))
        {
            GD.PushError($"Secure preload failed: Invalid path - {path.Truncate(50)}...");
            return null;
        }

        // Attempt to preload the resource
        try
        {
            var result = GD.Load<Resource>(path);
            if (result == null)
            {
                GD.PushError($"Secure preload failed: Resource not found or invalid - {Path.GetFileName(path)}");
            }

            return result;
        }
        catch (Exception ex)
        {
            GD.PushError($"Secure preload failed: Exception loading {path} - {ex.Message}");
            return null;
        }
    }
```

Securely preloads a resource with path validation

**Returns:** `Resource?`

**Parameters:**
- `string path`
- `string allowedBase`

### SecurePreloadScript

```csharp
/// <summary>
    /// Securely preloads a script with path validation
    /// </summary>
    /// <param name="path">The script path to preload</param>
    /// <param name="allowedBase">Optional base path that the script must be within</param>
    /// <returns>The preloaded script or null if validation fails</returns>
    public static Script? SecurePreloadScript(string path, string allowedBase = "")
    {
        // Validate the path first
        if (!ValidatePreloadPath(path, allowedBase))
        {
            GD.PushError($"Secure script preload failed: Invalid path - {path.Truncate(50)}...");
            return null;
        }

        // Attempt to preload the script
        try
        {
            var result = GD.Load<Script>(path);
            if (result == null)
            {
                GD.PushError($"Secure script preload failed: Script not found or invalid - {Path.GetFileName(path)}");
            }

            return result;
        }
        catch (Exception ex)
        {
            GD.PushError($"Secure script preload failed: Exception loading {path} - {ex.Message}");
            return null;
        }
    }
```

Securely preloads a script with path validation

**Returns:** `Script?`

**Parameters:**
- `string path`
- `string allowedBase`

### SecurePreloadScene

```csharp
/// <summary>
    /// Securely preloads a packed scene with path validation
    /// </summary>
    /// <param name="path">The scene path to preload</param>
    /// <param name="allowedBase">Optional base path that the scene must be within</param>
    /// <returns>The preloaded packed scene or null if validation fails</returns>
    public static PackedScene? SecurePreloadScene(string path, string allowedBase = "")
    {
        // Validate the path first
        if (!ValidatePreloadPath(path, allowedBase))
        {
            GD.PushError($"Secure scene preload failed: Invalid path - {path.Truncate(50)}...");
            return null;
        }

        // Attempt to preload the scene
        try
        {
            var result = GD.Load<PackedScene>(path);
            if (result == null)
            {
                GD.PushError($"Secure scene preload failed: Scene not found or invalid - {Path.GetFileName(path)}");
            }

            return result;
        }
        catch (Exception ex)
        {
            GD.PushError($"Secure scene preload failed: Exception loading {path} - {ex.Message}");
            return null;
        }
    }
```

Securely preloads a packed scene with path validation

**Returns:** `PackedScene?`

**Parameters:**
- `string path`
- `string allowedBase`

### SecurePreloadTexture

```csharp
/// <summary>
    /// Securely preloads a texture with path validation
    /// </summary>
    /// <param name="path">The texture path to preload</param>
    /// <param name="allowedBase">Optional base path that the texture must be within</param>
    /// <returns>The preloaded texture or null if validation fails</returns>
    public static Texture2D? SecurePreloadTexture(string path, string allowedBase = "")
    {
        // Validate the path first
        if (!ValidatePreloadPath(path, allowedBase))
        {
            GD.PushError($"Secure texture preload failed: Invalid path - {path.Truncate(50)}...");
            return null;
        }

        // Attempt to preload the texture
        try
        {
            var result = GD.Load<Texture2D>(path);
            if (result == null)
            {
                GD.PushError($"Secure texture preload failed: Texture not found or invalid - {Path.GetFileName(path)}");
            }

            return result;
        }
        catch (Exception ex)
        {
            GD.PushError($"Secure texture preload failed: Exception loading {path} - {ex.Message}");
            return null;
        }
    }
```

Securely preloads a texture with path validation

**Returns:** `Texture2D?`

**Parameters:**
- `string path`
- `string allowedBase`

