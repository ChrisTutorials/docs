---
title: "ServiceDependencyInjectionTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/servicedependencyinjectiontests/"
---

# ServiceDependencyInjectionTests

```csharp
GridBuilding.Godot.Tests.Services.DI
class ServiceDependencyInjectionTests
{
    // Members...
}
```

Unit tests for pure C# dependency injection system.
Replaces InjectorSystem tests with modern DI container testing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Services/DI/ServiceDependencyInjectionTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Container_ShouldResolveRegisteredServices

```csharp
#endregion

    #region Service Resolution Tests

    [Theory]
    [InlineData(typeof(ILogger), typeof(Logger))]
    [InlineData(typeof(PerformanceProfiler), typeof(PerformanceProfiler))]
    [InlineData(typeof(GridCalculator), typeof(GridCalculator))]
    [InlineData(typeof(GeometryCache), typeof(GeometryCache))]
    [InlineData(typeof(Core.Services.DI.PlacementValidator), typeof(Core.Services.DI.PlacementValidator))]
    public void Container_ShouldResolveRegisteredServices(Type serviceType, Type expectedType)
    {
        // Act
        var service = _container.GetService(serviceType);

        // Assert
        ;
        Assert.IsType(expectedType, service);
    }
```

**Returns:** `void`

**Parameters:**
- `Type serviceType`
- `Type expectedType`

### Container_ShouldReturnSameInstanceForSingletons

```csharp
[Theory]
    [InlineData(typeof(ILogger))]
    [InlineData(typeof(PerformanceProfiler))]
    public void Container_ShouldReturnSameInstanceForSingletons(Type serviceType)
    {
        // Act
        var service1 = _container.GetService(serviceType);
        var service2 = _container.GetService(serviceType);

        // Assert
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `Type serviceType`

### Container_ShouldReturnDifferentInstancesForFactories

```csharp
[Theory]
    [InlineData(typeof(GridCalculator))]
    [InlineData(typeof(GeometryCache))]
    [InlineData(typeof(Core.Services.DI.PlacementValidator))]
    public void Container_ShouldReturnDifferentInstancesForFactories(Type serviceType)
    {
        // Act
        var service1 = _container.GetService(serviceType);
        var service2 = _container.GetService(serviceType);

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `Type serviceType`

### Container_ShouldThrowForUnregisteredService

```csharp
[Fact]
    public void Container_ShouldThrowForUnregisteredService()
    {
        // Act & Assert
        Assert.Throws<ServiceNotRegisteredException>(() => 
            _container.GetService<UnregisteredTestService>());
    }
```

**Returns:** `void`

### Container_ShouldManageScopedServicesCorrectly

```csharp
#endregion

    #region Service Lifecycle Tests

    [Fact]
    public void Container_ShouldManageScopedServicesCorrectly()
    {
        // Act
        var validator1 = _container.GetService<Core.Services.DI.PlacementValidator>();
        var validator2 = _container.GetService<Core.Services.DI.PlacementValidator>();

        // Assert - Scoped services should be different instances
        ;
        ;
        ;
    }
```

**Returns:** `void`

### Container_ShouldValidateRequiredServices

```csharp
[Theory]
    [InlineData(typeof(ILogger), true)]
    [InlineData(typeof(PerformanceProfiler), true)]
    [InlineData(typeof(GridCalculator), true)]
    [InlineData(typeof(UnregisteredTestService), false)]
    public void Container_ShouldValidateRequiredServices(Type serviceType, bool shouldBeRegistered)
    {
        // Act
        var isRegistered = _container.IsServiceRegistered(serviceType);

        // Assert
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `Type serviceType`
- `bool shouldBeRegistered`

### Container_ShouldValidateMultipleRequiredServices

```csharp
[Theory]
    [InlineData(typeof(ILogger), typeof(PerformanceProfiler), typeof(GridCalculator))]
    [InlineData(typeof(GridCalculator), typeof(GeometryCache), typeof(Core.Services.DI.PlacementValidator))]
    public void Container_ShouldValidateMultipleRequiredServices(Type service1, Type service2, Type service3)
    {
        // Act & Assert - Should not throw for registered services
        _container.ValidateServices(service1, service2, service3);
    }
```

**Returns:** `void`

**Parameters:**
- `Type service1`
- `Type service2`
- `Type service3`

### Container_ShouldProvideFastServiceResolution

```csharp
#endregion

    #region Performance Tests

    [Fact]
    public void Container_ShouldProvideFastServiceResolution()
    {
        // Arrange
        var stopwatch = System.Diagnostics.Stopwatch.StartNew();

        // Act
        for (int i = 0; i < 1000; i++)
        {
            var service = _container.GetService<ILogger>();
            ;
        }

        stopwatch.Stop();

        // Assert - Should resolve 1000 services quickly
        ;
    }
```

**Returns:** `void`

### Container_ShouldReuseProfilerInstance

```csharp
[Fact]
    public void Container_ShouldReuseProfilerInstance()
    {
        // Act
        var profiler1 = _container.GetProfiler();
        var profiler2 = _container.GetProfiler();
        var globalProfiler = CompositionContainer.GetGlobalProfiler();

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### Container_ShouldIntegrateWithConfiguration

```csharp
#endregion

    #region Configuration Integration Tests

    [Fact]
    public void Container_ShouldIntegrateWithConfiguration()
    {
        // Act
        var configLoader = _container.GetConfigurationLoader();
        var config = _container.GetCurrentConfiguration();

        // Assert
        ;
        ;
        Assert.NotEmpty(config.ConfigurationId);
    }
```

**Returns:** `void`

### Container_ShouldApplyConfigurationToServices

```csharp
[Fact]
    public void Container_ShouldApplyConfigurationToServices()
    {
        // Act
        var config = _container.GetCurrentConfiguration();
        var profiler = _container.GetProfiler();

        // Assert
        ;
    }
```

**Returns:** `void`

### Container_ShouldHandleCircularDependencies

```csharp
#endregion

    #region Error Handling Tests

    [Fact]
    public void Container_ShouldHandleCircularDependencies()
    {
        // Arrange - Register services that could cause circular dependencies
        // (In our current implementation, this shouldn't be possible with factory pattern)

        // Act & Assert - Should not hang or throw unexpected exceptions
        var service1 = _container.GetService<GridCalculator>();
        var service2 = _container.GetService<GeometryCache>();

        ;
        ;
    }
```

**Returns:** `void`

### Container_ShouldHandleNullServiceGracefully

```csharp
[Fact]
    public void Container_ShouldHandleNullServiceGracefully()
    {
        // Arrange - This tests error handling for null service returns
        // (Our implementation prevents null returns from factories)

        // Act
        var service = _container.GetService<ILogger>();

        // Assert
        ;
    }
```

**Returns:** `void`

### Container_ShouldSupportMultiplayerScopedServices

```csharp
#endregion

    #region Multiplayer Safety Tests

    [Fact]
    public void Container_ShouldSupportMultiplayerScopedServices()
    {
        // Act
        var buildingService1 = _container.GetService<BuildingService>();
        var buildingService2 = _container.GetService<BuildingService>();

        // Assert - Building services should be scoped (different instances for multiplayer safety)
        ;
        ;
        ;
    }
```

**Returns:** `void`

### Container_ShouldMaintainSingletonsAcrossMultiplayerContexts

```csharp
[Fact]
    public void Container_ShouldMaintainSingletonsAcrossMultiplayerContexts()
    {
        // Act
        var logger1 = _container.GetService<ILogger>();
        var logger2 = _container.GetService<ILogger>();

        // Assert - Singletons should be same across contexts
        ;
    }
```

**Returns:** `void`

### Container_ShouldCleanupProperly

```csharp
#endregion

    #region Cleanup Tests

    [Fact]
    public void Container_ShouldCleanupProperly()
    {
        // Arrange
        var container = new CompositionContainer();
        container.Initialize();

        // Act
        container.Dispose();

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### Container_ShouldAllowRecreationAfterDispose

```csharp
[Fact]
    public void Container_ShouldAllowRecreationAfterDispose()
    {
        // Arrange
        var container1 = new CompositionContainer();
        container1.Initialize();
        container1.Dispose();

        // Act
        var container2 = new CompositionContainer();
        container2.Initialize();

        // Assert
        ;
        ;

        // Cleanup
        container2.Dispose();
    }
```

**Returns:** `void`

