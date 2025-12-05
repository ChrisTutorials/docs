---
title: "GodotServiceBridge"
description: "Bridge service for Godot-specific dependencies.
Provides access to Godot Engine features while maintaining pure C# core."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/godotservicebridge/"
---

# GodotServiceBridge

```csharp
GridBuilding.Godot.Services.DI
class GodotServiceBridge
{
    // Members...
}
```

Bridge service for Godot-specific dependencies.
Provides access to Godot Engine features while maintaining pure C# core.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Services/DI/GodotServiceBridge.cs`  
**Namespace:** `GridBuilding.Godot.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### SceneTree

```csharp
/// <summary>
    /// Gets the current scene tree if available.
    /// </summary>
    public SceneTree? SceneTree => _sceneTree;
```

Gets the current scene tree if available.

### RootNode

```csharp
/// <summary>
    /// Gets the root node if available.
    /// </summary>
    public Node? RootNode => _rootNode;
```

Gets the root node if available.

### IsGodotAvailable

```csharp
/// <summary>
    /// Gets whether Godot Engine is available.
    /// </summary>
    public bool IsGodotAvailable => _isGodotAvailable;
```

Gets whether Godot Engine is available.


## Methods

### InjectDependencies

```csharp
/// <summary>
    /// Injects dependencies into this service.
    /// </summary>
    /// <param name="container">Composition container</param>
    public void InjectDependencies(ICompositionContainer container)
    {
        _container = container;
        InitializeGodotBridge();
    }
```

Injects dependencies into this service.

**Returns:** `void`

**Parameters:**
- `ICompositionContainer container`

### ValidateDependencies

```csharp
/// <summary>
    /// Validates the service dependencies.
    /// </summary>
    /// <param name="container">Composition container</param>
    /// <returns>Validation result</returns>
    public ValidationResult ValidateDependencies(ICompositionContainer container)
    {
        var result = new ValidationResult();
        
        if (container == null)
        {
            result.AddError("Container cannot be null");
        }

        if (!_isGodotAvailable)
        {
            result.AddWarning("Godot Engine not available - running in pure C# mode");
        }

        return result;
    }
```

Validates the service dependencies.

**Returns:** `ValidationResult`

**Parameters:**
- `ICompositionContainer container`

### CheckHealth

```csharp
/// <summary>
    /// Checks the health of the Godot bridge service.
    /// </summary>
    /// <returns>Health status</returns>
    public ServiceHealthStatus CheckHealth()
    {
        var status = new ServiceHealthStatus();
        
        if (_isGodotAvailable)
        {
            status.Message = "Godot bridge is healthy";
            status.Data["SceneTreeAvailable"] = _sceneTree != null;
            status.Data["RootNodeAvailable"] = _rootNode != null;
            status.Data["EngineVersion"] = Engine.GetVersionInfo()["string"].AsString();
        }
        else
        {
            status.IsHealthy = false;
            status.Message = "Godot Engine not available";
        }

        return status;
    }
```

Checks the health of the Godot bridge service.

**Returns:** `ServiceHealthStatus`

### GetNode

```csharp
/// <summary>
    /// Gets a Godot node by path if available.
    /// </summary>
    /// <param name="path">Node path</param>
    /// <returns>Node or null if not found</returns>
    public Node? GetNode(string path)
    {
        if (!_isGodotAvailable || _rootNode == null)
        {
            return null;
        }

        try
        {
            return _rootNode.GetNode(path);
        }
        catch
        {
            return null;
        }
    }
```

Gets a Godot node by path if available.

**Returns:** `Node?`

**Parameters:**
- `string path`

### GetNode

```csharp
/// <summary>
    /// Gets a Godot node by type if available.
    /// </summary>
    /// <typeparam name="T">Node type</typeparam>
    /// <returns>Node or null if not found</returns>
    public T? GetNode<T>() where T : class
    {
        if (!_isGodotAvailable || _rootNode == null)
        {
            return null;
        }

        try
        {
            return _rootNode.GetNode<T>(NodePath.FromString("../" + typeof(T).Name));
        }
        catch
        {
            return null;
        }
    }
```

Gets a Godot node by type if available.

**Returns:** `T?`

### LoadResource

```csharp
/// <summary>
    /// Loads a Godot resource if available.
    /// </summary>
    /// <param name="path">Resource path</param>
    /// <returns>Resource or null if not found</returns>
    public Resource? LoadResource(string path)
    {
        if (!_isGodotAvailable)
        {
            return null;
        }

        try
        {
            return GD.Load(path);
        }
        catch
        {
            return null;
        }
    }
```

Loads a Godot resource if available.

**Returns:** `Resource?`

**Parameters:**
- `string path`

### CreateNode

```csharp
/// <summary>
    /// Creates a Godot node instance if available.
    /// </summary>
    /// <typeparam name="T">Node type</typeparam>
    /// <returns>Node instance or null if Godot not available</returns>
    public T? CreateNode<T>() where T : Node, new()
    {
        if (!_isGodotAvailable)
        {
            return null;
        }

        try
        {
            return new T();
        }
        catch
        {
            return null;
        }
    }
```

Creates a Godot node instance if available.

**Returns:** `T?`

### CallGodotStaticMethod

```csharp
/// <summary>
    /// Calls a Godot static method if available.
    /// </summary>
    /// <param name="methodName">Method name</param>
    /// <param name="args">Method arguments</param>
    /// <returns>Result or null if not available</returns>
    public object? CallGodotStaticMethod(string methodName, params object[] args)
    {
        if (!_isGodotAvailable)
        {
            return null;
        }

        try
        {
            // This is a simplified approach - in practice you'd use reflection
            // or specific Godot API calls based on the method name
            return methodName switch
            {
                "Print" => GD.Print(string.Join(" ", args)),
                "PrintErr" => GD.PrintErr(string.Join(" ", args)),
                "Load" => args.Length > 0 ? GD.Load(args[0].ToString()) : null,
                "Randf" => GD.Randf(),
                "Randi" => GD.Randi(),
                _ => null
            };
        }
        catch
        {
            return null;
        }
    }
```

Calls a Godot static method if available.

**Returns:** `object?`

**Parameters:**
- `string methodName`
- `object[] args`

### GetEngineInfo

```csharp
/// <summary>
    /// Gets engine information.
    /// </summary>
    /// <returns>Engine information dictionary</returns>
    public Dictionary<string, object> GetEngineInfo()
    {
        var info = new Dictionary<string, object>();
        
        if (_isGodotAvailable)
        {
            var versionInfo = Engine.GetVersionInfo();
            info["Version"] = versionInfo["string"].AsString();
            info["Major"] = versionInfo["major"].AsInt32();
            info["Minor"] = versionInfo["minor"].AsInt32();
            info["Patch"] = versionInfo["patch"].AsInt32();
            info["Hash"] = versionInfo["hash"].AsString();
        }
        else
        {
            info["Version"] = "Pure C# Mode";
            info["GodotAvailable"] = false;
        }

        return info;
    }
```

Gets engine information.

**Returns:** `Dictionary<string, object>`

