---
title: "ServiceHelper"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/servicehelper/"
---

# ServiceHelper

```csharp
GridBuilding.Core.Services.DI
class ServiceHelper
{
    // Members...
}
```

Helper utilities for service resolution with enhanced error handling.
This class provides convenient methods for resolving services from the
nearest IServiceCompositionRoot with better error handling and diagnostics.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/ServiceHelper.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetRequiredService

```csharp
/// <summary>
    /// Gets a required service from the nearest IServiceCompositionRoot.
    /// Throws if the service is not available.
    /// </summary>
    /// <typeparam name="T">The service type</typeparam>
    /// <param name="node">The node requesting the service</param>
    /// <returns>The service instance</returns>
    /// <exception cref="InvalidOperationException">Thrown when service or IServiceCompositionRoot is not found</exception>
    public static T GetRequiredService<T>(IServiceContext context) where T : class
    {
        var serviceRoot = FindServiceCompositionRoot(context);
        if (serviceRoot == null)
        {
            throw new InvalidOperationException(
                $"IServiceCompositionRoot not found in hierarchy for context {context.Name}. " +
                $"Ensure a IServiceCompositionRoot exists in the parent hierarchy or at scene root.");
        }

        var service = serviceRoot.GetService<T>();
        if (service == null)
        {
            throw new InvalidOperationException(
                $"Required service {typeof(T).Name} not available. " +
                $"Check IServiceCompositionRoot configuration and service registration.");
        }

        return service;
    }
```

Gets a required service from the nearest IServiceCompositionRoot.
Throws if the service is not available.

**Returns:** `T`

**Parameters:**
- `IServiceContext context`

### GetOptionalService

```csharp
/// <summary>
    /// Gets an optional service from the nearest IServiceCompositionRoot.
    /// Returns null if the service is not available.
    /// </summary>
    /// <typeparam name="T">The service type</typeparam>
    /// <param name="node">The node requesting the service</param>
    /// <returns>The service instance or null if not found</returns>
    public static T? GetOptionalService<T>(IServiceContext context) where T : class
    {
        var serviceRoot = FindServiceCompositionRoot(context);
        return serviceRoot?.GetService<T>();
    }
```

Gets an optional service from the nearest IServiceCompositionRoot.
Returns null if the service is not available.

**Returns:** `T?`

**Parameters:**
- `IServiceContext context`

### TryGetService

```csharp
/// <summary>
    /// Attempts to get a service with detailed error information.
    /// </summary>
    /// <typeparam name="T">The service type</typeparam>
    /// <param name="node">The node requesting the service</param>
    /// <param name="service">Output service instance</param>
    /// <param name="error">Output error information</param>
    /// <returns>True if service was found, false otherwise</returns>
    public static bool TryGetService<T>(IServiceContext context, out T? service, out ServiceResolutionError? error) 
        where T : class
    {
        service = null;
        error = null;

        try
        {
            var serviceRoot = FindServiceCompositionRoot(context);
            if (serviceRoot == null)
            {
                error = new ServiceResolutionError
                {
                    ServiceType = typeof(T),
                    ErrorType = ServiceErrorType.CompositionRootNotFound,
                    Message = $"IServiceCompositionRoot not found in hierarchy for context {context.Name}",
                    NodeName = context.Name,
                    NodePath = "N/A"
                };
                return false;
            }

            service = serviceRoot.GetService<T>();
            if (service == null)
            {
                error = new ServiceResolutionError
                {
                    ServiceType = typeof(T),
                    ErrorType = ServiceErrorType.ServiceNotRegistered,
                    Message = $"Service {typeof(T).Name} not registered in IServiceCompositionRoot",
                    AvailableServices = GetAvailableServices(serviceRoot)
                };
                return false;
            }

            return true;
        }
        catch (Exception ex)
        {
            error = new ServiceResolutionError
            {
                ServiceType = typeof(T),
                ErrorType = ServiceErrorType.Exception,
                Message = $"Exception resolving service: {ex.Message}",
                Exception = ex
            };
            return false;
        }
    }
```

Attempts to get a service with detailed error information.

**Returns:** `bool`

**Parameters:**
- `IServiceContext context`
- `T? service`
- `ServiceResolutionError? error`

### GetAvailableServices

```csharp
/// <summary>
    /// Gets all available services from the nearest IServiceCompositionRoot.
    /// </summary>
    /// <param name="node">The node requesting services</param>
    /// <returns>Dictionary of service types and their availability</returns>
    public static System.Collections.Generic.Dictionary<Type, bool> GetAvailableServices(IServiceContext context)
    {
        var services = new System.Collections.Generic.Dictionary<Type, bool>();
        var serviceRoot = FindServiceCompositionRoot(context);
        
        if (serviceRoot != null)
        {
            var registry = serviceRoot.GetServiceRegistry();
            var commonServiceTypes = new[]
            {
                typeof(ILogger),
                typeof(IPlacementService),
                typeof(ISceneService),
                typeof(IPlacementValidator),
                typeof(ICollisionCalculator),
                typeof(IGridTargetingState)
            };

            foreach (var serviceType in commonServiceTypes)
            {
                var service = registry.GetService(serviceType);
                services[serviceType] = service != null;
            }
        }

        return services;
    }
```

Gets all available services from the nearest IServiceCompositionRoot.

**Returns:** `System.Collections.Generic.Dictionary<Type, bool>`

**Parameters:**
- `IServiceContext context`

### ValidateServices

```csharp
/// <summary>
    /// Validates service availability for a node.
    /// </summary>
    /// <param name="node">The node to validate</param>
    /// <param name="requiredServices">Required service types</param>
    /// <returns>Validation result with detailed issues</returns>
    public static ServiceValidationResult ValidateServices(IServiceContext context, params Type[] requiredServices)
    {
        var result = new ServiceValidationResult { IsValid = true };
        var serviceRoot = FindServiceCompositionRoot(context);

        if (serviceRoot == null)
        {
            result.IsValid = false;
            result.Issues.Add("IServiceCompositionRoot not found in node hierarchy");
            return result;
        }

        foreach (var serviceType in requiredServices)
        {
            var service = serviceRoot.GetService(serviceType);
            if (service == null)
            {
                result.IsValid = false;
                result.Issues.Add($"Required service {serviceType.Name} not available");
            }
        }

        return result;
    }
```

Validates service availability for a node.

**Returns:** `ServiceValidationResult`

**Parameters:**
- `IServiceContext context`
- `Type[] requiredServices`

