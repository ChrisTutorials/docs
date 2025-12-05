---
title: "ServiceScope"
description: "Implementation of service scope for scoped services."
weight: 10
url: "/gridbuilding/v6-0/api/core/servicescope/"
---

# ServiceScope

```csharp
GridBuilding.Core.Services.DI
class ServiceScope
{
    // Members...
}
```

Implementation of service scope for scoped services.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/IServiceHealthCheck.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetService

```csharp
public T GetService<T>() where T : class
    {
        var serviceType = typeof(T);
        return (T)GetService(serviceType);
    }
```

**Returns:** `T`

### GetService

```csharp
public object GetService(Type serviceType)
    {
        if (_disposed)
        {
            throw new ObjectDisposedException(nameof(ServiceScope));
        }

        // Check if we already have a scoped instance
        if (_scopedServices.ContainsKey(serviceType))
        {
            return _scopedServices[serviceType];
        }

        // Create new scoped instance
        var instance = _registry.CreateScopedService(serviceType);
        if (instance != null)
        {
            _scopedServices[serviceType] = instance;
            
            if (instance is IDisposable disposable)
            {
                _scopedDisposables.Add(disposable);
            }
        }

        return instance;
    }
```

**Returns:** `object`

**Parameters:**
- `Type serviceType`

### Dispose

```csharp
public void Dispose()
    {
        if (!_disposed)
        {
            foreach (var disposable in _scopedDisposables)
            {
                try
                {
                    disposable.Dispose();
                }
                catch
                {
                    // Log disposal errors but don't throw
                }
            }
            
            _scopedDisposables.Clear();
            _scopedServices.Clear();
            _disposed = true;
        }
    }
```

**Returns:** `void`

