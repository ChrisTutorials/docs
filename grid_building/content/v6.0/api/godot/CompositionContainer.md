---
title: "CompositionContainer"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/compositioncontainer/"
---

# CompositionContainer

```csharp
GridBuilding.Godot.Services.DI
class CompositionContainer
{
    // Members...
}
```

CompositionContainer - pure C# service container with optional Godot Resource composition.
Provides Godot integration while keeping core DI logic completely independent of Godot.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Services/DI/CompositionContainer.cs`  
**Namespace:** `GridBuilding.Godot.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Instance

```csharp
/// <summary>
    /// Static reference to the main container for global access.
    /// Set when the container is initialized.
    /// </summary>
    public static CompositionContainer? Instance { get; private set; }
```

Static reference to the main container for global access.
Set when the container is initialized.


## Methods

### Initialize

```csharp
/// <summary>
    /// Initializes the container and configures all services.
    /// Call this when setting up the DI system.
    /// </summary>
    public void Initialize()
    {
        Instance = this; // Set static reference for global access
        ConfigureServices();
        ValidateServices();
        
        // Initialize configuration loader
        _configLoader = new ConfigurationLoader(this);
    }
```

Initializes the container and configures all services.
Call this when setting up the DI system.

**Returns:** `void`

### InitializeFromTresFile

```csharp
/// <summary>
    /// Initializes the container with configuration from an existing .tres file.
    /// Maintains compatibility with existing game projects.
    /// </summary>
    /// <param name="gbContainerPath">Path to GBCompositionContainer .tres file</param>
    public void InitializeFromTresFile(string gbContainerPath)
    {
        Initialize();
        
        if (_configLoader != null)
        {
            _configLoader.LoadFromTresFile(gbContainerPath);
        }
    }
```

Initializes the container with configuration from an existing .tres file.
Maintains compatibility with existing game projects.

**Returns:** `void`

**Parameters:**
- `string gbContainerPath`

### GetConfigurationLoader

```csharp
/// <summary>
    /// Gets the configuration loader for managing game configurations.
    /// </summary>
    public ConfigurationLoader? GetConfigurationLoader()
    {
        return _configLoader;
    }
```

Gets the configuration loader for managing game configurations.

**Returns:** `ConfigurationLoader?`

### GetCurrentConfiguration

```csharp
/// <summary>
    /// Gets the current active game configuration.
    /// </summary>
    public Core.Configuration.IGameConfiguration? GetCurrentConfiguration()
    {
        return _configLoader?.GetCurrentConfiguration();
    }
```

Gets the current active game configuration.

**Returns:** `Core.Configuration.IGameConfiguration?`

### SetResource

```csharp
/// <summary>
    /// Optional: Set a Godot resource for integration with Godot's resource system.
    /// This is composition, not inheritance - the core remains pure C#.
    /// </summary>
    public void SetResource(IGridBuildingResource resource)
    {
        _resource = resource;
    }
```

Optional: Set a Godot resource for integration with Godot's resource system.
This is composition, not inheritance - the core remains pure C#.

**Returns:** `void`

**Parameters:**
- `IGridBuildingResource resource`

### GetService

```csharp
#region Enhanced Service Access

    /// <summary>
    /// Gets a service from the registry with type safety.
    /// </summary>
    public T GetService<T>() where T : class
    {
        try
        {
            return _registry.GetService<T>();
        }
        catch (ServiceNotRegisteredException ex)
        {
            GD.PrintErr($"Service not found: {ex.Message}");
            throw;
        }
        catch (ServiceRegistrationException ex)
        {
            GD.PrintErr($"Service registration error: {ex.Message}");
            throw;
        }
    }
```

Gets a service from the registry with type safety.

**Returns:** `T`

### IsServiceRegistered

```csharp
/// <summary>
    /// Checks if a service is registered.
    /// </summary>
    public bool IsServiceRegistered<T>() where T : class
    {
        return _registry.IsRegistered<T>();
    }
```

Checks if a service is registered.

**Returns:** `bool`

### GetProfiler

```csharp
/// <summary>
    /// Gets the PerformanceProfiler for performance monitoring and metrics.
    /// Essential for plugin developers and system optimization.
    /// </summary>
    public PerformanceProfiler GetProfiler()
    {
        if (_profiler == null)
        {
            _profiler = GetService<PerformanceProfiler>();
        }
        return _profiler;
    }
```

Gets the PerformanceProfiler for performance monitoring and metrics.
Essential for plugin developers and system optimization.

**Returns:** `PerformanceProfiler`

### GetGlobalProfiler

```csharp
/// <summary>
    /// Static accessor for the PerformanceProfiler from anywhere in the codebase.
    /// Returns null if container is not initialized.
    /// </summary>
    public static PerformanceProfiler? GetGlobalProfiler()
    {
        return Instance?.GetProfiler();
    }
```

Static accessor for the PerformanceProfiler from anywhere in the codebase.
Returns null if container is not initialized.

**Returns:** `PerformanceProfiler?`

### GetContexts

```csharp
#endregion

    #region Backward Compatibility

    public SystemsContext GetContexts()
    {
        if (_contexts == null)
        {
            _contexts = GetService<SystemsContext>();
        }
        return _contexts;
    }
```

**Returns:** `SystemsContext`

### GetLogger

```csharp
public Logger GetLogger()
    {
        if (_logger == null)
        {
            _logger = GetService<Logger>();
        }
        return _logger;
    }
```

**Returns:** `Logger`

### GetTargetingState

```csharp
#endregion

    #region State Accessors (Placeholder impls)

    public GridTargetingState GetTargetingState()
    {
        // return GetStates().Targeting;
        return null!; // Placeholder
    }
```

**Returns:** `GridTargetingState`

### GetManipulationState

```csharp
public object GetManipulationState()
    {
        // return GetStates().Manipulation;
        return null!; // Placeholder
    }
```

**Returns:** `object`

### GetDebugSettings

```csharp
#endregion

    #region Settings Accessors

    public DebugSettings? GetDebugSettings()
    {
        // if (Config?.Settings?.Debug != null) return Config.Settings.Debug;
        return null;
    }
```

**Returns:** `DebugSettings?`

### GetPlacementRules

```csharp
public global::Godot.Collections.Array<PlacementRule> GetPlacementRules()
    {
        // if (Config?.Settings?.PlacementRules != null) ...
        return new global::Godot.Collections.Array<PlacementRule>();
    }
```

**Returns:** `global::Godot.Collections.Array<PlacementRule>`

### GetIndicatorContext

```csharp
public IndicatorContext GetIndicatorContext()
    {
        return GetContexts().Indicator;
    }
```

**Returns:** `IndicatorContext`

### GetTemplates

```csharp
public dynamic GetTemplates()
    {
        return null!; // Placeholder for dynamic or specific type
    }
```

**Returns:** `dynamic`

### Dispose

```csharp
#endregion

    /// <summary>
    /// Disposes the container and cleans up all resources.
    /// Call this when shutting down the DI system.
    /// </summary>
    public void Dispose()
    {
        Instance = null; // Clear static reference
        _registry?.Dispose();
        _resource = null;
    }
```

Disposes the container and cleans up all resources.
Call this when shutting down the DI system.

**Returns:** `void`

