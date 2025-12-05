---
title: "ServiceRegistry"
description: "Core service registry - pure C# implementation with no Godot dependencies.
Supports singleton, factory, and scoped service patterns for cross-platform compatibility.
Enhanced with lifetime management, health checks, and validation."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/serviceregistry/"
---

# ServiceRegistry

```csharp
GridBuilding.Core.Services.DI
class ServiceRegistry
{
    // Members...
}
```

Core service registry - pure C# implementation with no Godot dependencies.
Supports singleton, factory, and scoped service patterns for cross-platform compatibility.
Enhanced with lifetime management, health checks, and validation.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/ServiceRegistry.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### RegisterSingleton

```csharp
/// <summary>
    /// Registers a singleton service instance that will be shared across all requests.
    /// Use sparingly - primarily for infrastructure and read-only services.
    /// </summary>
    /// <typeparam name="TService">Service interface type</typeparam>
    /// <typeparam name="TImplementation">Implementation type</typeparam>
    /// <param name="instance">Service instance</param>
    public void RegisterSingleton<TService, TImplementation>(TImplementation instance) 
        where TService : class 
        where TImplementation : class, TService
    {
        var serviceType = typeof(TService);
        
        if (_singletons.ContainsKey(serviceType))
        {
            throw new ServiceRegistrationException($"Singleton service {serviceType.Name} is already registered");
        }

        _singletons[serviceType] = instance;
        _lifetimes[serviceType] = ServiceLifetime.Singleton;
        
        // Track disposable services for cleanup
        if (instance is IDisposable disposable)
        {
            _disposables.Add(disposable);
        }

        // Register health check if service supports it
        if (instance is IServiceHealthCheck healthCheck)
        {
            _healthChecks.Add(healthCheck);
        }
    }
```

Registers a singleton service instance that will be shared across all requests.
Use sparingly - primarily for infrastructure and read-only services.

**Returns:** `void`

**Parameters:**
- `TImplementation instance`

### RegisterSingleton

```csharp
/// <summary>
    /// Registers a singleton service instance that will be shared across all requests.
    /// Use sparingly - primarily for infrastructure and read-only services.
    /// </summary>
    /// <typeparam name="T">Service type</typeparam>
    /// <param name="instance">Service instance</param>
    public void RegisterSingleton<T>(T instance) where T : class
    {
        var serviceType = typeof(T);
        
        if (_singletons.ContainsKey(serviceType))
        {
            throw new ServiceRegistrationException($"Singleton service {serviceType.Name} is already registered");
        }

        _singletons[serviceType] = instance;
        _lifetimes[serviceType] = ServiceLifetime.Singleton;
        
        // Track disposable services for cleanup
        if (instance is IDisposable disposable)
        {
            _disposables.Add(disposable);
        }

        // Register health check if service supports it
        if (instance is IServiceHealthCheck healthCheck)
        {
            _healthChecks.Add(healthCheck);
        }
    }
```

Registers a singleton service instance that will be shared across all requests.
Use sparingly - primarily for infrastructure and read-only services.

**Returns:** `void`

**Parameters:**
- `T instance`

### RegisterFactory

```csharp
/// <summary>
    /// Registers a factory function for stateless services that can be safely shared.
    /// Creates a new instance on each request but uses the same factory function.
    /// </summary>
    /// <typeparam name="T">Service type</typeparam>
    /// <param name="factory">Factory function</param>
    public void RegisterFactory<T>(Func<T> factory) where T : class
    {
        var serviceType = typeof(T);
        
        if (_factories.ContainsKey(serviceType) || _scopedFactories.ContainsKey(serviceType))
        {
            throw new ServiceRegistrationException($"Factory service {serviceType.Name} is already registered");
        }

        _factories[serviceType] = () => factory();
        _lifetimes[serviceType] = ServiceLifetime.Transient;
    }
```

Registers a factory function for stateless services that can be safely shared.
Creates a new instance on each request but uses the same factory function.

**Returns:** `void`

**Parameters:**
- `Func<T> factory`

### RegisterScoped

```csharp
/// <summary>
    /// Registers a scoped service factory for per-player or per-session instances.
    /// Creates a new instance on each request, ensuring isolation in multiplayer scenarios.
    /// </summary>
    /// <typeparam name="T">Service type</typeparam>
    /// <param name="factory">Factory function</param>
    public void RegisterScoped<T>(Func<T> factory) where T : class
    {
        var serviceType = typeof(T);
        
        if (_factories.ContainsKey(serviceType) || _scopedFactories.ContainsKey(serviceType))
        {
            throw new ServiceRegistrationException($"Scoped service {serviceType.Name} is already registered");
        }

        _scopedFactories[serviceType] = () => factory();
        _lifetimes[serviceType] = ServiceLifetime.Scoped;
    }
```

Registers a scoped service factory for per-player or per-session instances.
Creates a new instance on each request, ensuring isolation in multiplayer scenarios.

**Returns:** `void`

**Parameters:**
- `Func<T> factory`

### GetService

```csharp
/// <summary>
    /// Gets a service instance with automatic resolution based on registration type.
    /// Singleton: Returns the shared instance
    /// Factory: Creates new instance using factory function
    /// Scoped: Creates new instance using scoped factory
    /// </summary>
    /// <typeparam name="T">Service type</typeparam>
    /// <returns>Service instance</returns>
    /// <exception cref="ServiceNotRegisteredException">Thrown when service is not registered</exception>
    public T GetService<T>() where T : class
    {
        var serviceType = typeof(T);

        // Check singleton services first
        if (_singletons.TryGetValue(serviceType, out var singletonInstance))
        {
            return (T)singletonInstance;
        }

        // Check factory services
        if (_factories.TryGetValue(serviceType, out var factory))
        {
            try
            {
                return (T)factory();
            }
            catch (Exception ex)
            {
                throw new ServiceRegistrationException($"Factory for {serviceType.Name} failed to create instance", ex);
            }
        }

        // Check scoped services
        if (_scopedFactories.TryGetValue(serviceType, out var scopedFactory))
        {
            try
            {
                return (T)scopedFactory();
            }
            catch (Exception ex)
            {
                throw new ServiceRegistrationException($"Scoped factory for {serviceType.Name} failed to create instance", ex);
            }
        }

        throw new ServiceNotRegisteredException(serviceType);
    }
```

Gets a service instance with automatic resolution based on registration type.
Singleton: Returns the shared instance
Factory: Creates new instance using factory function
Scoped: Creates new instance using scoped factory

**Returns:** `T`

### IsRegistered

```csharp
/// <summary>
    /// Checks if a service is registered.
    /// </summary>
    /// <typeparam name="T">Service type</typeparam>
    /// <returns>True if service is registered, false otherwise</returns>
    public bool IsRegistered<T>() where T : class
    {
        var serviceType = typeof(T);
        return _singletons.ContainsKey(serviceType) || 
               _factories.ContainsKey(serviceType) || 
               _scopedFactories.ContainsKey(serviceType);
    }
```

Checks if a service is registered.

**Returns:** `bool`

### GetAllSingletons

```csharp
/// <summary>
    /// Gets all registered singleton services for debugging or testing purposes.
    /// </summary>
    /// <returns>Dictionary of singleton services</returns>
    public Dictionary<Type, object> GetAllSingletons()
    {
        return new Dictionary<Type, object>(_singletons);
    }
```

Gets all registered singleton services for debugging or testing purposes.

**Returns:** `Dictionary<Type, object>`

### ValidateServices

```csharp
/// <summary>
    /// Validates that critical services are properly registered.
    /// Call this after service configuration is complete.
    /// </summary>
    /// <param name="requiredServices">List of required service types</param>
    /// <exception cref="InvalidOperationException">Thrown when required services are missing</exception>
    public void ValidateServices(params Type[] requiredServices)
    {
        var missingServices = new List<Type>();

        foreach (var serviceType in requiredServices)
        {
            if (!IsRegistered(serviceType))
            {
                missingServices.Add(serviceType);
            }
        }

        if (missingServices.Count > 0)
        {
            var missingNames = string.Join(", ", missingServices.Select(t => t.Name));
            throw new InvalidOperationException($"Critical services not registered: {missingNames}");
        }
    }
```

Validates that critical services are properly registered.
Call this after service configuration is complete.

**Returns:** `void`

**Parameters:**
- `Type[] requiredServices`

### GetServiceLifetime

```csharp
/// <summary>
    /// Gets the service lifetime for a registered service type.
    /// </summary>
    /// <typeparam name="T">Service type</typeparam>
    /// <returns>Service lifetime</returns>
    public ServiceLifetime GetServiceLifetime<T>() where T : class
    {
        var serviceType = typeof(T);
        return _lifetimes.GetValueOrDefault(serviceType, ServiceLifetime.Transient);
    }
```

Gets the service lifetime for a registered service type.

**Returns:** `ServiceLifetime`

### PerformHealthChecks

```csharp
/// <summary>
    /// Performs health checks on all registered services that support health monitoring.
    /// </summary>
    /// <returns>Health check results</returns>
    public ServiceHealthCheckResult PerformHealthChecks()
    {
        var result = new ServiceHealthCheckResult();
        
        foreach (var healthCheck in _healthChecks)
        {
            try
            {
                var checkResult = healthCheck.CheckHealth();
                result.ServiceResults.Add(healthCheck.GetType().Name, checkResult);
                
                if (!checkResult.IsHealthy)
                {
                    result.UnhealthyServices.Add(healthCheck.GetType().Name);
                }
            }
            catch (Exception ex)
            {
                result.ServiceResults.Add(healthCheck.GetType().Name, 
                    new ServiceHealthStatus { IsHealthy = false, Message = ex.Message });
                result.UnhealthyServices.Add(healthCheck.GetType().Name);
            }
        }
        
        result.IsHealthy = !result.UnhealthyServices.Any();
        return result;
    }
```

Performs health checks on all registered services that support health monitoring.

**Returns:** `ServiceHealthCheckResult`

### ValidateServices

```csharp
/// <summary>
    /// Validates all registered services for proper configuration.
    /// </summary>
    /// <returns>Validation result</returns>
    public ValidationResult ValidateServices()
    {
        var result = new ValidationResult();
        
        // Check for circular dependencies in singleton services
        foreach (var singletonType in _singletons.Keys)
        {
            ValidateServiceDependencies(singletonType, new HashSet<Type>(), result);
        }
        
        // Validate that critical services are registered
        var criticalServices = new[] { typeof(ILogger), typeof(ICompositionContainer) };
        foreach (var criticalService in criticalServices)
        {
            if (!IsRegistered(criticalService))
            {
                result.AddError($"Critical service {criticalService.Name} is not registered");
            }
        }
        
        return result;
    }
```

Validates all registered services for proper configuration.

**Returns:** `ValidationResult`

### CreateScope

```csharp
/// <summary>
    /// Creates a new scope for scoped services (useful for multiplayer isolation).
    /// </summary>
    /// <returns>Service scope instance</returns>
    public IServiceScope CreateScope()
    {
        return new ServiceScope(this);
    }
```

Creates a new scope for scoped services (useful for multiplayer isolation).

**Returns:** `IServiceScope`

### GetStatistics

```csharp
/// <summary>
    /// Gets service statistics for monitoring and debugging.
    /// </summary>
    /// <returns>Service registry statistics</returns>
    public ServiceRegistryStatistics GetStatistics()
    {
        return new ServiceRegistryStatistics
        {
            SingletonCount = _singletons.Count,
            FactoryCount = _factories.Count,
            ScopedFactoryCount = _scopedFactories.Count,
            DisposableCount = _disposables.Count,
            HealthCheckCount = _healthChecks.Count,
            RegisteredTypes = _singletons.Keys
                .Concat(_factories.Keys)
                .Concat(_scopedFactories.Keys)
                .ToList()
        };
    }
```

Gets service statistics for monitoring and debugging.

**Returns:** `ServiceRegistryStatistics`

### Clear

```csharp
/// <summary>
    /// Clears all registered services and disposes of disposable instances.
    /// Use this for cleanup during testing or when restarting the service registry.
    /// </summary>
    public void Clear()
    {
        DisposeAll();
        _singletons.Clear();
        _factories.Clear();
        _scopedFactories.Clear();
        _lifetimes.Clear();
        _healthChecks.Clear();
    }
```

Clears all registered services and disposes of disposable instances.
Use this for cleanup during testing or when restarting the service registry.

**Returns:** `void`

### Dispose

```csharp
/// <summary>
    /// Disposes all disposable services and clears the registry.
    /// </summary>
    public void Dispose()
    {
        DisposeAll();
        Clear();
    }
```

Disposes all disposable services and clears the registry.

**Returns:** `void`

