---
title: "GodotServiceLocator"
description: "Godot-specific service locator that bridges Core services with Godot nodes.
Provides dependency injection without requiring inheritance."
weight: 20
url: "/gridbuilding/v6-0/api/godot/godotservicelocator/"
---

# GodotServiceLocator

```csharp
GridBuilding.Godot.Services
class GodotServiceLocator
{
    // Members...
}
```

Godot-specific service locator that bridges Core services with Godot nodes.
Provides dependency injection without requiring inheritance.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Services/GodotServiceLocator.cs`  
**Namespace:** `GridBuilding.Godot.Services`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Instance

```csharp
public static GodotServiceLocator Instance => _instance ?? throw new InvalidOperationException("ServiceLocator not initialized");
```


## Methods

### _Ready

```csharp
#endregion

    #region Initialization
    public override void _Ready()
    {
        if (_instance == null)
        {
            _instance = this;
            RegisterCoreServices();
            RegisterGodotServices();
        }
        else if (_instance != this)
        {
            GD.PrintErr("Multiple ServiceLocator instances detected. Destroying duplicate.");
            QueueFree();
        }
    }
```

**Returns:** `void`

### RegisterService

```csharp
/// <summary>
    /// Registers a service with the service locator.
    /// </summary>
    /// <typeparam name="TInterface">Service interface type</typeparam>
    /// <typeparam name="TImplementation">Service implementation type</typeparam>
    public void RegisterService<TInterface, TImplementation>() 
        where TInterface : class 
        where TImplementation : class, TInterface, new()
    {
        var service = new TImplementation();
        _godotServices[typeof(TInterface)] = service;
        
        // Also register with core ServiceRegistry if needed
        _serviceRegistry.RegisterSingleton<TInterface>(service);
    }
```

Registers a service with the service locator.

**Returns:** `void`

### RegisterService

```csharp
/// <summary>
    /// Registers a service instance.
    /// </summary>
    /// <typeparam name="TInterface">Service interface type</typeparam>
    /// <param name="service">Service instance</param>
    public void RegisterService<TInterface>(TInterface service) where TInterface : class
    {
        _godotServices[typeof(TInterface)] = service;
        _serviceRegistry.RegisterSingleton<TInterface>(service);
    }
```

Registers a service instance.

**Returns:** `void`

**Parameters:**
- `TInterface service`

### GetService

```csharp
#endregion

    #region Service Resolution
    /// <summary>
    /// Gets a service of the specified type.
    /// </summary>
    /// <typeparam name="T">Service type</typeparam>
    /// <returns>Service instance</returns>
    public T GetService<T>() where T : class
    {
        var serviceType = typeof(T);
        
        if (_godotServices.TryGetValue(serviceType, out var service))
        {
            return (T)service;
        }
        
        throw new InvalidOperationException($"Service {serviceType.Name} not registered");
    }
```

Gets a service of the specified type.

**Returns:** `T`

### TryGetService

```csharp
/// <summary>
    /// Tries to get a service of the specified type.
    /// </summary>
    /// <typeparam name="T">Service type</typeparam>
    /// <param name="service">Service instance or null</param>
    /// <returns>True if service was found</returns>
    public bool TryGetService<T>(out T? service) where T : class
    {
        var serviceType = typeof(T);
        
        if (_godotServices.TryGetValue(serviceType, out var serviceObj))
        {
            service = (T)serviceObj;
            return true;
        }
        
        service = null;
        return false;
    }
```

Tries to get a service of the specified type.

**Returns:** `bool`

**Parameters:**
- `T? service`

### _ExitTree

```csharp
#endregion

    #region Cleanup
    public override void _ExitTree()
    {
        if (_instance == this)
        {
            _instance = null;
        }
        
        // Dispose services
        if (_serviceRegistry is IDisposable disposableRegistry)
        {
            disposableRegistry.Dispose();
        }
        
        base._ExitTree();
    }
```

**Returns:** `void`

