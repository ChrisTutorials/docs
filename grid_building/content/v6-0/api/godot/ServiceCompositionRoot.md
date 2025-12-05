---
title: "ServiceCompositionRoot"
description: "Composition root for Enhanced Service Registry Pattern.
This class serves as the central point for registering and configuring
all services in the GridBuilding system. It follows the composition
root pattern to ensure proper dependency injection and service lifetime
management.
## Architecture:
- Registers core services (pure C# business logic)
- Registers Godot services (engine-specific operations)
- Sets up service lifetimes and dependencies
- Provides global service registry access
## Service Categories:
- Core Services: Pure C# logic, testable without Godot
- Godot Services: Engine-specific operations and presentation
- Infrastructure Services: Logging, validation, diagnostics"
weight: 20
url: "/gridbuilding/v6-0/api/godot/servicecompositionroot/"
---

# ServiceCompositionRoot

```csharp
GridBuilding.Godot.Bootstrap
class ServiceCompositionRoot
{
    // Members...
}
```

Composition root for Enhanced Service Registry Pattern.
This class serves as the central point for registering and configuring
all services in the GridBuilding system. It follows the composition
root pattern to ensure proper dependency injection and service lifetime
management.
## Architecture:
- Registers core services (pure C# business logic)
- Registers Godot services (engine-specific operations)
- Sets up service lifetimes and dependencies
- Provides global service registry access
## Service Categories:
- Core Services: Pure C# logic, testable without Godot
- Godot Services: Engine-specific operations and presentation
- Infrastructure Services: Logging, validation, diagnostics

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Bootstrap/ServiceCompositionRoot.cs`  
**Namespace:** `GridBuilding.Godot.Bootstrap`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsInitialized

```csharp
#endregion

    #region Public API
    /// <summary>
    /// Gets whether the service composition root is properly initialized.
    /// </summary>
    public bool IsInitialized => _isInitialized;
```

Gets whether the service composition root is properly initialized.


## Methods

### _Ready

```csharp
#endregion

    #region Godot Lifecycle
    /// <summary>
    /// Called when the node enters the scene tree.
    /// Initializes all services and registers them with the ServiceRegistry.
    /// </summary>
    public override void _Ready()
    {
        try
        {
            GD.Print("Initializing ServiceCompositionRoot...");
            
            // Initialize the service registry
            InitializeServices();
            
            // Make registry available globally
            SetupGlobalRegistry();
            
            _isInitialized = true;
            GD.Print("ServiceCompositionRoot initialized successfully");
        }
        catch (Exception ex)
        {
            GD.PrintErr($"Failed to initialize ServiceCompositionRoot: {ex.Message}");
            throw;
        }
    }
```

Called when the node enters the scene tree.
Initializes all services and registers them with the ServiceRegistry.

**Returns:** `void`

### _ExitTree

```csharp
/// <summary>
    /// Called when the node is about to leave the scene tree.
    /// Cleans up all registered services.
    /// </summary>
    public override void _ExitTree()
    {
        try
        {
            GD.Print("Cleaning up ServiceCompositionRoot...");
            
            if (_serviceRegistry != null)
            {
                _serviceRegistry.Dispose();
                _serviceRegistry = null;
            }
            
            _isInitialized = false;
            GD.Print("ServiceCompositionRoot cleaned up successfully");
        }
        catch (Exception ex)
        {
            GD.PrintErr($"Error during ServiceCompositionRoot cleanup: {ex.Message}");
        }
    }
```

Called when the node is about to leave the scene tree.
Cleans up all registered services.

**Returns:** `void`

### GetServiceRegistry

```csharp
/// <summary>
    /// Gets the service registry for manual service access.
    /// </summary>
    /// <returns>The service registry instance</returns>
    public ServiceRegistry GetServiceRegistry()
    {
        return _serviceRegistry ?? throw new InvalidOperationException("Service registry not initialized");
    }
```

Gets the service registry for manual service access.

**Returns:** `ServiceRegistry`

### GetService

```csharp
/// <summary>
    /// Gets a service of the specified type from the registry.
    /// </summary>
    /// <typeparam name="T">The service type</typeparam>
    /// <returns>The service instance or null if not found</returns>
    public T? GetService<T>() where T : class
    {
        if (!_isInitialized)
        {
            GD.PrintErr("ServiceCompositionRoot not initialized");
            return null;
        }
        
        return _serviceRegistry.GetService<T>();
    }
```

Gets a service of the specified type from the registry.

**Returns:** `T?`

### GetRequiredService

```csharp
/// <summary>
    /// Gets a service of the specified type, throwing if not found.
    /// </summary>
    /// <typeparam name="T">The service type</typeparam>
    /// <returns>The service instance</returns>
    /// <exception cref="InvalidOperationException">Thrown when service is not available</exception>
    public T GetRequiredService<T>() where T : class
    {
        var service = GetService<T>();
        if (service == null)
        {
            throw new InvalidOperationException($"Required service {typeof(T).Name} not available");
        }
        return service;
    }
```

Gets a service of the specified type, throwing if not found.

**Returns:** `T`

### GetServiceScope

```csharp
/// <summary>
    /// Gets the service scope type for this composition root.
    /// </summary>
    /// <returns>The service scope (Global, Player, Scene, etc.)</returns>
    public ServiceScope GetServiceScope()
    {
        // Determine scope based on position in scene tree
        var parent = GetParent();
        
        if (parent == null || parent == GetTree().Root)
            return ServiceScope.Global;
            
        if (parent.Name.ToString().StartsWith("Player"))
            return ServiceScope.Player;
            
        if (parent.Name.ToString().StartsWith("Scene"))
            return ServiceScope.Scene;
            
        // Default to session scope
        return ServiceScope.Session;
    }
```

Gets the service scope type for this composition root.

**Returns:** `ServiceScope`

### GetPlayerId

```csharp
/// <summary>
    /// Gets the player ID if this is a player-scoped service root.
    /// </summary>
    /// <returns>Player ID or null if not player-scoped</returns>
    public int? GetPlayerId()
    {
        if (GetServiceScope() != ServiceScope.Player)
            return null;
            
        var parent = GetParent();
        if (parent != null && int.TryParse(parent.Name.ToString().Replace("Player", ""), out var playerId))
        {
            return playerId;
        }
        
        return null;
    }
```

Gets the player ID if this is a player-scoped service root.

**Returns:** `int?`

### GetDiagnosticInfo

```csharp
/// <summary>
    /// Gets diagnostic information about all registered services.
    /// </summary>
    /// <returns>Diagnostic information string</returns>
    public string GetDiagnosticInfo()
    {
        if (!_isInitialized)
            return "ServiceCompositionRoot not initialized";
        
        var info = new System.Text.StringBuilder();
        info.AppendLine("=== Service Registry Diagnostics ===");
        info.AppendLine($"Initialized: {_isInitialized}");
        info.AppendLine($"Total Services: {_serviceRegistry?.GetServiceCount() ?? 0}");
        
        // Add service health checks
        var healthIssues = GetServiceHealthIssues();
        if (healthIssues.Count > 0)
        {
            info.AppendLine("Health Issues:");
            foreach (var issue in healthIssues)
            {
                info.AppendLine($"  - {issue}");
            }
        }
        else
        {
            info.AppendLine("All services healthy");
        }
        
        return info.ToString();
    }
```

Gets diagnostic information about all registered services.

**Returns:** `string`

### GetServiceHealthIssues

```csharp
/// <summary>
    /// Gets health issues from all registered services.
    /// </summary>
    /// <returns>List of health issue descriptions</returns>
    public System.Collections.Generic.List<string> GetServiceHealthIssues()
    {
        var issues = new System.Collections.Generic.List<string>();
        
        if (!_isInitialized)
        {
            issues.Add("ServiceCompositionRoot not initialized");
            return issues;
        }
        
        // Check placement service health
        var placementService = GetService<IPlacementService>();
        if (placementService != null)
        {
            issues.AddRange(placementService.GetValidationIssues());
        }
        else
        {
            issues.Add("IPlacementService not available");
        }
        
        // Check scene service health
        var sceneService = GetService<ISceneService>();
        if (sceneService != null)
        {
            issues.AddRange(sceneService.GetValidationIssues());
        }
        else
        {
            issues.Add("ISceneService not available");
        }
        
        return issues;
    }
```

Gets health issues from all registered services.

**Returns:** `System.Collections.Generic.List<string>`

### GetGlobalRegistry

```csharp
#endregion

    #region Static Access
    /// <summary>
    /// Gets the global service registry instance.
    /// </summary>
    /// <returns>Service registry or null if not available</returns>
    public static ServiceRegistry? GetGlobalRegistry()
    {
        var sceneTree = Engine.GetMainLoop() as SceneTree;
        if (sceneTree?.Root == null)
            return null;
            
        return sceneTree.Root.GetNode<ServiceRegistry>(SERVICE_REGISTRY_NAME);
    }
```

Gets the global service registry instance.

**Returns:** `ServiceRegistry?`

### GetGlobalService

```csharp
/// <summary>
    /// Gets a service of the specified type from the global registry.
    /// </summary>
    /// <typeparam name="T">The service type</typeparam>
    /// <returns>The service instance or null if not found</returns>
    public static T? GetGlobalService<T>() where T : class
    {
        var registry = GetGlobalRegistry();
        return registry?.GetService<T>();
    }
```

Gets a service of the specified type from the global registry.

**Returns:** `T?`

