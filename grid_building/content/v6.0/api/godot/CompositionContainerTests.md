---
title: "CompositionContainerTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/compositioncontainertests/"
---

# CompositionContainerTests

```csharp
GridBuilding.Godot.Tests.Services.DI
class CompositionContainerTests
{
    // Members...
}
```

Unit tests for CompositionContainer pure C# implementation.
Tests the core DI functionality without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Services/DI/CompositionContainerTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Initialize_ShouldSetStaticInstance

```csharp
#endregion

    #region Initialization Tests

    [Fact]
    public void Initialize_ShouldSetStaticInstance()
    {
        // Act
        var container = new CompositionContainer();
        container.Initialize();

        // Assert
        ;
        
        // Cleanup
        container.Dispose();
    }
```

**Returns:** `void`

### Initialize_ShouldConfigureServices

```csharp
[Fact]
    public void Initialize_ShouldConfigureServices()
    {
        // Arrange
        var container = new CompositionContainer();

        // Act
        container.Initialize();

        // Assert - Core services should be registered
        ;
        ;
        ;
        ;

        // Cleanup
        container.Dispose();
    }
```

**Returns:** `void`

### InitializeFromTresFile_ShouldLoadConfiguration

```csharp
[Fact]
    public void InitializeFromTresFile_ShouldLoadConfiguration()
    {
        // Arrange
        var container = new CompositionContainer();
        var mockConfigPath = "res://test_config.tres";

        // Act & Assert - Should not throw even with invalid path (graceful fallback)
        container.InitializeFromTresFile(mockConfigPath);
        
        // Should still have basic services
        ;
        
        // Cleanup
        container.Dispose();
    }
```

**Returns:** `void`

### GetService_ShouldReturnRegisteredService

```csharp
#endregion

    #region Service Registration Tests

    [Fact]
    public void GetService_ShouldReturnRegisteredService()
    {
        // Act
        var profiler = _container.GetService<PerformanceProfiler>();

        // Assert
        ;
        Assert.IsType<PerformanceProfiler>(profiler);
    }
```

**Returns:** `void`

### GetService_ShouldReturnSameInstanceForSingletons

```csharp
[Fact]
    public void GetService_ShouldReturnSameInstanceForSingletons()
    {
        // Act
        var profiler1 = _container.GetService<PerformanceProfiler>();
        var profiler2 = _container.GetService<PerformanceProfiler>();

        // Assert
        ;
    }
```

**Returns:** `void`

### GetService_ShouldReturnDifferentInstancesForFactories

```csharp
[Fact]
    public void GetService_ShouldReturnDifferentInstancesForFactories()
    {
        // Act
        var calculator1 = _container.GetService<GridCalculator>();
        var calculator2 = _container.GetService<GridCalculator>();

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### GetService_ShouldThrowForUnregisteredService

```csharp
[Fact]
    public void GetService_ShouldThrowForUnregisteredService()
    {
        // Act & Assert
        Assert.Throws<ServiceNotRegisteredException>(() => 
            _container.GetService<UnregisteredService>());
    }
```

**Returns:** `void`

### IsServiceRegistered_ShouldReturnCorrectStatus

```csharp
[Fact]
    public void IsServiceRegistered_ShouldReturnCorrectStatus()
    {
        // Act & Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### GetProfiler_ShouldReturnProfilerInstance

```csharp
#endregion

    #region Performance Profiler Tests

    [Fact]
    public void GetProfiler_ShouldReturnProfilerInstance()
    {
        // Act
        var profiler = _container.GetProfiler();

        // Assert
        ;
        Assert.IsType<PerformanceProfiler>(profiler);
    }
```

**Returns:** `void`

### GetProfiler_ShouldCacheInstance

```csharp
[Fact]
    public void GetProfiler_ShouldCacheInstance()
    {
        // Act
        var profiler1 = _container.GetProfiler();
        var profiler2 = _container.GetProfiler();

        // Assert
        ;
    }
```

**Returns:** `void`

### GetGlobalProfiler_ShouldReturnInstanceWhenContainerExists

```csharp
[Fact]
    public void GetGlobalProfiler_ShouldReturnInstanceWhenContainerExists()
    {
        // Arrange
        var container = new CompositionContainer();
        container.Initialize();

        // Act
        var globalProfiler = CompositionContainer.GetGlobalProfiler();

        // Assert
        ;
        ;

        // Cleanup
        container.Dispose();
    }
```

**Returns:** `void`

### GetGlobalProfiler_ShouldReturnNullWhenNoContainer

```csharp
[Fact]
    public void GetGlobalProfiler_ShouldReturnNullWhenNoContainer()
    {
        // Arrange - Ensure no static instance
        CompositionContainer.Instance?.Dispose();

        // Act
        var globalProfiler = CompositionContainer.GetGlobalProfiler();

        // Assert
        ;
    }
```

**Returns:** `void`

### GetConfigurationLoader_ShouldReturnLoader

```csharp
#endregion

    #region Configuration Tests

    [Fact]
    public void GetConfigurationLoader_ShouldReturnLoader()
    {
        // Act
        var loader = _container.GetConfigurationLoader();

        // Assert
        ;
    }
```

**Returns:** `void`

### GetCurrentConfiguration_ShouldReturnConfiguration

```csharp
[Fact]
    public void GetCurrentConfiguration_ShouldReturnConfiguration()
    {
        // Act
        var config = _container.GetCurrentConfiguration();

        // Assert
        ;
    }
```

**Returns:** `void`

### SetResource_ShouldSetResourceReference

```csharp
#endregion

    #region Resource Composition Tests

    [Fact]
    public void SetResource_ShouldSetResourceReference()
    {
        // Arrange
        var mockResource = new MockGridBuildingResource();

        // Act
        _container.SetResource(mockResource);

        // Assert - Should not throw and resource should be stored
        ; // Test passes if no exception thrown
    }
```

**Returns:** `void`

### Dispose_ShouldClearStaticInstance

```csharp
#endregion

    #region Cleanup Tests

    [Fact]
    public void Dispose_ShouldClearStaticInstance()
    {
        // Arrange
        var container = new CompositionContainer();
        container.Initialize();
        ;

        // Act
        container.Dispose();

        // Assert
        ;
    }
```

**Returns:** `void`

### Dispose_ShouldCleanupRegistry

```csharp
[Fact]
    public void Dispose_ShouldCleanupRegistry()
    {
        // Arrange
        var container = new CompositionContainer();
        container.Initialize();

        // Act
        container.Dispose();

        // Assert - Should be able to create new container without conflicts
        var newContainer = new CompositionContainer();
        newContainer.Initialize();
        ;
        
        // Cleanup
        newContainer.Dispose();
    }
```

**Returns:** `void`

